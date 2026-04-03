# CPAN::Maker::Bootstrapper 1.0.1 Release Notes

**Release Date:** 2026-04-03

## Overview

Adds `--stub` and `--basedir` options, automatic module name derivation
from a custom stub file, and a guard against regenerating `.pm.in` files
that already exist. Makefile recipes are silenced with `@` throughout and
dependency scanning is now conditional via `CPAN_MAKER_SCAN`. POD updated
throughout to reflect all new options and conventions.

---

## New Features

### `--stub` option

A new `--stub|-s` option controls which module template is used to generate
the initial `.pm.in` source file. Three forms are accepted:

- **Omitted** — uses the default plain class stub (`class-module.pm.tmpl`),
  the same behavior as 1.0.0.
- **`cli`** — uses the CLI stub (`cli-module.pm.tmpl`), which inherits from
  `CLI::Simple` and includes a skeleton `main`, `init`, and placeholder
  command. Replaces the previous `CLI_MODULE=1` environment variable approach.
- **A file path** — uses the specified file directly as the stub. This allows
  bootstrapping a project around an existing module or a custom template.

### Automatic module name derivation from stub path

When `--stub` is a file path and `--module` is not provided, the bootstrapper
reads the first `package` declaration from the stub file and compares it
against the stub's path (converted to `::` notation). If they match, the
package name is used as the module name automatically:

```
cpan-maker.sh --stub $HOME/git/Log/Log4perl/Appender/Cloudwatch.pm
# derives MODULE_NAME=Log::Log4perl::Appender::Cloudwatch
```

If the package name and path do not match, the command dies with a clear
error rather than silently using the wrong module name.

### `--basedir` option

A new `--basedir|-b` option specifies the root directory under which new
projects are created. When `--installdir` is not provided, the project
directory is derived as `$basedir/$project-name`.

`--basedir` can also be set permanently in your global git config:

```
git config --global cpan-maker.basedir $HOME/git
```

The bootstrapper reads this value via the new `cpan_maker_basedir` method
on `CPAN::Maker::GitConfigReader`.

### Guard against `.pm.in` regeneration

The `$(MODULE_PATH).in` Makefile target now checks whether the file already
exists before running the `sed` substitution:

```makefile
$(MODULE_PATH).in: module.pm.tmpl
    @mkdir -p $(dirname $@); \
    test -e $@ || sed -e ... < $< > $@
```

This prevents the stub from being overwritten if `module.pm.tmpl` is
removed and `make` is re-run after development has begun.

### Conditional dependency scanning (`CPAN_MAKER_SCAN`)

The `requires` and `test-requires` targets now respect a `CPAN_MAKER_SCAN`
variable (default: `ON`). Set it to any other value to skip the
`scandeps-static.pl` scan, which is useful for large projects where a full
rescan on every build would add significant overhead:

```
make CPAN_MAKER_SCAN=OFF
```

---

## Changes

### `CPAN::Maker::Bootstrapper` (`lib/CPAN/Maker/Bootstrapper.pm.in`)

- `choose` imported from `CLI::Simple::Utils` — used in `cmd_install` to
  resolve the `STUB=` make argument cleanly across all three stub cases
- `init` — validates and sets `basedir` from option or git config
- `_find_package_name` — new private function; reads the first `package`
  declaration from a file
- `_init_git_config` — now also reads `cpan_maker_basedir` from git config
  when `--basedir` is not provided on the command line
- `cmd_install` — module name derivation from stub path; `--installdir`
  replaces `--install-dir`; `Makefile` existence check now tests the correct
  install directory rather than the current working directory; `choose {}`
  block resolves `STUB=` argument; `$pwd` variable removed (was unused)
- `main` — `--stub|-s`, `--basedir|-b` added to option specs;
  `--install-dir` renamed to `--installdir`

### `CPAN::Maker::GitConfigReader`

- `cpan_maker_basedir` — new method; reads `[cpan-maker] basedir` from
  `.gitconfig`
- `user_github` — renamed from `github_user` for naming consistency with
  `user_name` and `user_email`

### Makefile

- All recipe commands silenced with `@`
- `CPAN_MAKER_SCAN ?= ON` added
- `requires` and `test-requires` targets now depend on `$(SOURCE_FILES)` and
  `$(TESTS)` respectively for correct incremental builds
- `requires` and `test-requires` recipes wrapped in `CPAN_MAKER_SCAN` guard
- `module.pm.tmpl` target simplified — now accepts `STUB=` directly rather
  than computing the template path internally
- `$(MODULE_PATH).in` target — `test -e $@` guard prevents regeneration of
  existing stubs
- `STUB=` argument passed through from `cmd_install` via `system make`

### `release-notes.mk`

- Changed from comparing tagged versions to comparing staged changes against
  the last tag (`git diff --staged`), making `make release-notes` usable
  before tagging a new release

### POD

- `SETUP` section added — documents `user.github` and `cpan-maker.basedir`
  git config options
- `WORKFLOW` — step 3 added covering addition of new components; steps
  renumbered accordingly
- `INSTALLED PROJECT FILES` — `.in` file convention explained; `E<64>` used
  for `@` in `@PACKAGE_VERSION@` to prevent sed substitution during the
  bootstrapper's own build
- `THE PROJECT MAKEFILE` — description updated to reflect stub-based module
  name derivation; `CPAN_MAKER_SCAN` documented
- `OPTIONS` — `--basedir`, `--stub` documented; `--module` updated to
  describe automatic derivation from stub path; `--install-dir` renamed to
  `--installdir`

---

## Upgrade Notes

The `--install-dir` option has been renamed to `--installdir`. Update any
scripts or aliases that use the old name.

The `CLI_MODULE=1` environment variable approach for selecting the CLI stub
is replaced by `--stub cli`. The old approach no longer works.
