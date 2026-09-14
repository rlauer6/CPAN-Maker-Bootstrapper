# Release Notes: CPAN::Maker::Bootstrapper 2.3.2

**Released:** Mon Sep 14 2026  
**Author:** Rob Lauer &lt;rclauer@gmail.com&gt;

---

## Overview

Version 2.3.2 is a focused quality and reliability release. It
introduces a new `provides` command, significantly overhauls the
`extra-files` command to support regeneration and removal in addition
to insertion, hardens error handling throughout the `Installer` role
by replacing bare `die` calls with `croak`, and fixes several build
system correctness issues.

---

## New Features

### New `provides` Command

A new `provides` command (backed by
`CPAN::Maker::Bootstrapper::Role::Provides`) is now registered in
`cpan-maker-bootstrapper.yml`. This command enumerates the modules
provided by the current distribution and is used by the build system
to filter out self-provided modules from the test dependency scan,
preventing circular or spurious entries in `test-requires`.

### New Role: `CPAN::Maker::Role::ModuleUtils`

The main `CPAN::Maker::Bootstrapper` package now composes
`CPAN::Maker::Role::ModuleUtils`, required as a dependency at version
2.0.10. The module load and role composition order has been updated to
ensure correct initialization.

### New `bootstrap.mk` Include

A new managed Makefile include, `.includes/bootstrap.mk`, has been
added to the distribution. It is listed in `MANIFEST`,
`buildspec.yml`, and `.includes/update.mk`, and is conditionally
included by the project `Makefile`. Projects updated via `make update`
will receive this file automatically.

---

## Improvements

### `extra-files` Command Overhaul (`Role::ExtraFiles`)

The `cmd_extra-files` method has been substantially rewritten:

- **No-argument form**: Calling `cmb extra-files` with no arguments
  now emits all source files represented by `buildspec.yml`. This is
  the form used by the `Makefile` to regenerate the `extra-files`
  target directly from `buildspec.yml` rather than relying on a
  separate file.
- **Removal support**: Files may now be removed from either the root
  or share sections by prefixing the filename with `-`. Removals are
  idempotent — the file need not exist on disk.
- **Duplicate share section merging**: Multiple `share:` sections in
  `buildspec.yml` are now folded into a single canonical section.
- **Atomic write with rollback**: `buildspec.yml` is backed up before
  writing and restored automatically if the write fails.
- **Version exported**: The role now exports `$VERSION`.

### `Makefile` Build System Improvements

- `PACKAGE_VERSION` is now a defined make variable (equal to
  `VERSION`) and is exported alongside `MODULE_NAME` for use as
  template variables in `.pm.in` files.
- `PERL5LIB` is explicitly set to include `$(pwd)/local/lib/perl5`
  when invoking `cpan-maker`, ensuring local dependencies are
  available during the build.
- The `provides` target is new: it builds the project's Perl modules
  (with syntax checking off) and then runs `cmb provides` to generate
  a `provides` file.
- `test-requires.raw` now depends on `provides` and uses `comm -23` to
  filter out modules the distribution itself provides, preventing them
  from appearing in `test-requires`.
- The `extra-files` target is now generated directly by `cmb
  extra-files` from `buildspec.yml`. The `extra-files.mk` target is
  derived from `extra-files`. Including `extra-files.mk` is now
  guarded by `ifeq ($(BOOTSTRAP_BUILD),)` to prevent issues during
  bootstrapped builds.
- The `provides` file is no longer listed in `CLEANFILES` (it is kept
  between builds to avoid repeatedly resolving `.pm` files).
- The `$(MODULE_PATH).in` recipe now calls `gen-vars-file` before the
  `NO_ECHO` block to ensure the vars file is available.
- `-include .includes/bootstrap.mk` has been added.

### `Installer` Role Hardening (`Role::Installer`)

- All internal `die` calls have been replaced with `croak` (from
  `Carp`), giving callers accurate stack traces.
- **Module name fabrication**: If `--module` is not provided but
  `--installdir` is, the module name is now derived from the basename
  of the install directory (with hyphens converted to `::`
  separators).
- **`LINT` environment variable forwarding**: `LINT` is now passed
  through to the `make` invocation when present in the environment.
- **`build-mirrors` propagation**: If a `build-mirrors` file exists in
  the calling directory (`$pwd`), it is copied into the temporary
  build directory automatically.
- **`_create_install_dir`**: `make_path` success is now verified; an
  error is raised if the directory cannot be created. File removal on
  `--force` has been extracted into a dedicated
  `_remove_existing_files` method.
- **`_validate_module`**: Module path recognition has been refined to
  use an anchored match (`(?:\A|/)\Q$module_path\E\z`), reducing false
  positives. The method now returns `"lib/$module_name"` when no
  import paths are specified (stub creation path) rather than
  returning the bare module name.
- **`_import_files`**: Added `info`-level logging for packages being
  installed, path creation, and file copy operations to aid
  diagnostics.
- **`_find_primary_package`**: Added debug-level `Dumper` logging of
  the resolution state.
- **`_create_dirs`**: Directory creation failure now uses `croak`.

### `builder` CI Script Fix

`install_build_deps` previously used `>` (overwrite) when appending
`CPAN::Maker::Bootstrapper` to an existing `build-requires` file. This
has been corrected to `>>` (append), preserving any existing entries
in the file.

### `modulino.tmpl` Variable Name Fix

The shell variable `MODULE_NAME` inside `modulino.tmpl` has been
renamed to `MODULINO_MODULE_NAME` to avoid conflicts with the
`MODULE_NAME` make variable that may be set or modified in the calling
environment.

---

## Dependency Changes

Two new required dependencies have been added:

| Module | Minimum Version |
|---|---|
| `CPAN::Maker::Role::ModuleUtils` | 2.0.10 |
| `CPAN::Maker::Role::Provides` | 0 (any) |

Both `cpanfile` and `requires` have been updated accordingly.

---

## Files Changed

| File | Change |
|---|---|
| `VERSION` | Bumped to `2.3.2` |
| `ChangeLog` | Updated |
| `README.md` | Regenerated |
| `Makefile` | See build system improvements above |
| `builder` | Fixed `>>` append bug in `install_build_deps` |
| `buildspec.yml` | Added `.includes/bootstrap.mk` to `extra-files` |
| `cpan-maker-bootstrapper.yml` | Added `provides` command mapping |
| `cpanfile` | Added `CPAN::Maker::Role::ModuleUtils` and `::Provides` |
| `requires` | Likewise |
| `lib/CPAN/Maker/Bootstrapper.pm.in` | Added `Role::ModuleUtils`; fixed role/parent load order |
| `lib/CPAN/Maker/Bootstrapper/Role/ExtraFiles.pm.in` | Major rewrite; see above |
| `lib/CPAN/Maker/Bootstrapper/Role/Installer.pm.in` | `die` → `croak`; new features; see above |
| `lib/CPAN/Maker/Bootstrapper/Role/Provides.pm.in` | **New file** |
| `modulino.tmpl` | Renamed `MODULE_NAME` → `MODULINO_MODULE_NAME` |
| `MANIFEST` | Added `bootstrap.mk` |
| `.includes/update.mk` | Added `bootstrap.mk` to `MANAGED_FILES` |
| `.includes/bootstrap.mk` | **New file** |

---

## Upgrade Notes

- Run `make update` in existing projects to receive `bootstrap.mk` and
  the updated `Makefile` and `.includes/` files.
- The `provides` file is now a persistent build artifact (not cleaned
  by `make clean`). This is intentional — it avoids re-resolving
  module paths on every build.
- Projects that call `cmb extra-files` with no arguments will now get
  a flat file list from `buildspec.yml` on stdout. Adjust any scripts
  that depended on the previous no-argument behavior (which previously
  errored).
