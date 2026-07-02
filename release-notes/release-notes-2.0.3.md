# CPAN::Maker::Bootstrapper 2.0.3 Release Notes

## Overview

This is a maintenance release focused on improving robustness when
optional tools are not installed, refactoring the build toolchain to
use the newer `cpan-maker` command, and adding LLM utility role
support to the core bootstrapper module.

---

## What's New

### `CPAN::Maker::Bootstrapper` Module

- Added the `Role::LLM::Utils` role to the core bootstrapper module,
  enabling LLM utility functionality by default.

### `cpan-maker-bootstrapper.yml`

- Added `llm` as a new setter/getter in `extra_options`, supporting
  expanded LLM configuration.

### `class-module.pm.tmpl`

- Added a `<your description here>` placeholder in the `=head1 NAME`
  POD section to guide authors in providing a module description from
  the start.

---

## Changes

### Build Toolchain: `MAKE_CPAN_DIST` → `CPAN_MAKER`

The `make-cpan-dist.pl` script reference has been replaced throughout
the `Makefile` with the `cpan-maker` command, reflecting the updated
toolchain.

### Graceful Handling of Missing Optional Tools

The build system now detects whether optional tools are installed
before attempting to use them, rather than failing silently or with
cryptic errors:

| Tool | Behaviour when missing |
|---|---|
| `perltidy` | `tidy_on` is disabled; tidiness checks are skipped |
| `perlcritic` | `critic_on` is disabled; critic checks are skipped |
| `scandeps-static.pl` | `SCAN` is forced to `OFF` |
| `podextract` | A clear error message is emitted with installation instructions |
| `Markdown::Render` (`md-utils.pl`) | A warning is issued; `README.md` generation falls back gracefully |

Previously, `perltidy` and `perlcritic` checks were enabled based
solely on whether a configuration file path was set. They are now also
gated on whether the respective binary is present on `PATH`.

### `Makefile` Improvements

- **`cpanfile` generation** refactored to use `cpan-maker
  create-cpanfile` instead of inline shell scripting.
- **Git config reads** (`GIT_NAME`, `GIT_EMAIL`, `GITHUB_USER`) now
  redirect `stderr` to `/dev/null`, suppressing noise when git global
  config is not set.
- **`CPAN::Maker::Bootstrapper` presence check**: The `Makefile` now
  emits a fatal error with installation instructions if the
  bootstrapper itself is not installed.
- **`MODULE_PATH`** dependency on `module.pm.tmpl` changed from
  order-only (`|`) to a normal prerequisite.
- **`PODEXTRACT`** variable definition deduplicated; it was previously
  defined in both `perl.mk` and `Makefile`.
- **Default goal** changed from `all` to `$(TARBALL)` for more precise
  dependency tracking.
- **`DEPS`** variable moved earlier in the `Makefile` for clarity.
- **`buildspec.yml`** recipe: removed the unused `@EXTRA_FILES@`
  substitution token.
- **`module.pm.tmpl`**: Now attempts to locate the shared template via
  `File::ShareDir` before falling back to an empty file.
- Fixed a shell variable expansion bug in `MODULE_NAME` derivation (`$(pwd)` → `$$(pwd)`).

### `perl.mk` Improvements

- Removed the duplicated `PODEXTRACT` variable definition (now defined
  only in `Makefile`).
- Fixed a `diff` redirect bug in the `.pl` tidiness check:
  `2>/dev/null 2>&1` corrected to `2>/dev/null`.
- Removed an erroneous `-M"$$module"` flag from the `check_syntax_pl`
  snippet (script syntax checking does not require a module to be
  loaded).

### `README.md` Generation

- Both `README.md` generation paths (from POD and from `README.md.in`)
  now check for the presence of `md-utils.pl` and `pod2markdown`
  before invoking them.
- If tools are missing, a descriptive warning is printed and
  generation is skipped (or the input is copied verbatim) rather than
  failing the build.

### `cpanfile`

- Dependencies sorted alphabetically for consistency.

---

## Bug Fixes

- Fixed `diff` command in `.pl.tdy` sentinel rule using duplicate
  redirect (`2>/dev/null 2>&1` → `2>/dev/null`).
- Fixed `MODULE_NAME` derivation where `$(pwd)` was not properly
  shell-expanded in `make` context.
- Corrected `check_syntax_pl` which incorrectly attempted to load a
  module (`-M"$$module"`) when checking `.pl` script syntax.

---

## Upgrade Notes

Run `make update` in existing projects to refresh the managed build
system files in `.includes/`. Review changes with `git diff` before
committing.

If you are using `make-cpan-dist.pl` directly in any custom
`project.mk` rules, update those references to use `cpan-maker`
instead.
