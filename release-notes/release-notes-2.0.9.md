# CPAN::Maker::Bootstrapper 2.0.9 Release Notes

**Released:** Fri Jul 17 2026  
**Author:** Rob Lauer \<rclauer@gmail.com\>

---

## Overview

Version 2.0.9 introduces automatic drift and update detection on every
build, giving developers immediate feedback when their project's
managed files fall out of sync with the installed bootstrapper or when
a newer version is available on CPAN. This release also adds
`NO_COLOR` support, fixes several shell quoting and recipe echo
issues, and updates `buildspec.yml.tmpl` to use hyphenated keys in
place of deprecated underscored ones.

---

## New Features

### Automatic Drift and Update Checks

Every build now runs two pre-flight checks automatically — no need to
remember `make check-upgrade`:

1. **CPAN update check** — queries MetaCPAN to detect whether a newer
   `CPAN::Maker::Bootstrapper` is published than the one installed
   locally.
2. **Local drift check** — compares the project's managed files
   (`Makefile`, `.includes/*.mk`) against MD5 checksums from the
   currently installed bootstrapper to detect files that have drifted
   from the installed version.

These checks are independent: the installed bootstrapper can be fully
current while a given project still needs `make update`, or vice
versa.

Two new variables (configurable in `config.mk`) control the strictness
of these checks:

| Variable | Values | Default | Description |
|---|---|---|---|
| `CMB_UPDATE_CHECK` | `on` \| `off` | `on` | Set to `off` to skip the MetaCPAN lookup (useful in CI or offline environments) |
| `CMB_VERSION_DRIFT` | `fail` \| `warn` \| `ignore` | `fail` | Controls build behaviour when managed files have drifted from the installed bootstrapper |

When `CMB_VERSION_DRIFT=fail` (the default), a drifted project **stops
the build** with an actionable error message. Set to `warn` to print a
warning and continue, or `ignore` to skip the check entirely.

### `cmb_md5sums.txt` Checksum File

A new `cmb_md5sums.txt` file is generated and shipped as a share file
with the distribution. It contains MD5 checksums of `Makefile` and all
`.includes/*.mk` files and is used by the drift check at build
time. The file is excluded from version control via `.gitignore` and
is added to `CLEANFILES`.

### `NO_COLOR` Support

The `TARBALL` build recipe now passes `--color` to `cpan-maker` by
default. Set `NO_COLOR=1` on the `make` command line (or in
`config.mk`) to suppress colour output from the logger.

```bash
make NO_COLOR=1
```

---

## Changes

### `Makefile`

- Added `NO_COLOR` variable (default empty; set to any value to
  disable colour logging).
- Added `CMB_UPDATE_CHECK` and `CMB_VERSION_DRIFT` variables with
  defaults `on` and `fail` respectively.
- Added `update-available` to `DEPS` so drift/update checks run on
  every build as a prerequisite.
- `DEPS` now uses `+=` instead of `=` to allow `project.mk` to extend the dependency list.
- Colour logging is now the default for the `cpan-maker` invocation in
  the `TARBALL` recipe.
- Added `cmb_md5sums.txt` to `CLEANFILES`.
- Corrected `BOOTSTRAPPER_VERSION` detection to use
  `CPAN::Maker::Bootstrapper->VERSION` (instance method form).

### `.includes/update.mk`

- `update-available` target now supports the new `CMB_UPDATE_CHECK` and `CMB_VERSION_DRIFT` flags.
- When `CMB_UPDATE_CHECK=on`, a newer CPAN version triggers a
  `WARNING:` message prompting `make upgrade`.
- When `CMB_VERSION_DRIFT` is not `ignore`, MD5 checksums of local
  managed files are compared against the installed bootstrapper's
  `cmb_md5sums.txt`. Behaviour on mismatch is controlled by the
  variable (`fail` / `warn` / `ignore`).
- All recipes now use `$(NO_ECHO)` prefix for consistent verbosity
  control.

### `.includes/git.mk`

- The `git` target recipe now uses `$(NO_ECHO)` and chains commands
  with `;` and `\` for correct shell execution.
- `NO_COMMIT=1` support now correctly checks `$$NO_COMMIT` (shell
  variable) to prevent the initial commit when requested.
- `git init` output is suppressed (`>/dev/null`).

### `buildspec.yml.tmpl`

- Replaced deprecated underscore-separated keys with hyphenated
  equivalents:
  - `pm_module` → `pm-module`
  - `test_requires` → `test-requires`
  - `exe_files` → `exe-files`

### `buildspec.yml`

- Added `cmb_md5sums.txt` to the `share:` section of `extra-files` so
  it is distributed and installed with the package.

### `gitignore` (template)

- Added `buildspec.yml.current` to the ignore list.

### `project.mk`

- Added `cmb_md5sums.txt` to `DEPS` and `CLEANFILES`.
- Added `MK_FILES` variable (wildcard over `.includes/*.mk`).
- Added `cmb_md5sums.txt` recipe: generates MD5 checksums of
  `Makefile` and all `.includes/*.mk` files.

---

## Documentation Updates

### New Section: "Automatic Drift and Update Checks"

Added to both the POD source (`lib/CPAN/Maker/Bootstrapper.pm.in`) and
the generated `README.md`. Documents the two independent pre-build
checks, explains how drift occurs, describes the two controlling
variables, and provides guidance for CI/offline use.

### New FAQ Entry: "Why does my build say it has drifted from the installed bootstrapper?"

Replaces the previous FAQ entry *"make update overwrote something I changed in a managed file"* (which is preserved inline) with a clearer, more prominent entry explaining the two causes of drift and the fix (`make update`), with a reference to `CMB_VERSION_DRIFT` for users who need a non-fatal check.

---

## Bug Fixes

- Fixed `NO_COMMIT` check in `git.mk` — was testing `$NO_COMMIT` (make
  variable, always empty at shell time) instead of `$$NO_COMMIT`
  (shell variable).
- Fixed missing `$(NO_ECHO)` prefix on several `post-update` and
  `update` recipes in `update.mk`, which caused recipes to echo
  commands unconditionally regardless of the `NO_ECHO` setting.

---

## Upgrade Notes

After installing 2.0.9, run `make update` in each of your existing
projects to pull in the updated `Makefile`, `.includes/update.mk`,
`.includes/git.mk`, and to generate the initial
`cmb_md5sums.txt`. Without this step, existing projects will report a
drift warning (or error, depending on `CMB_VERSION_DRIFT`) on the next
build.

```bash
cpanm CPAN::Maker::Bootstrapper
cd ~/git/your-project
make update
git diff          # review managed file changes
git add -u && git commit -m 'Update bootstrapper managed files to 2.0.9'
```

If you are not yet ready to update all projects, add the following to
each project's `config.mk` to downgrade the check from a hard failure
to a warning:

```makefile
CMB_VERSION_DRIFT = warn
```
