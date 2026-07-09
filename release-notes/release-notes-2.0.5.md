# CPAN::Maker::Bootstrapper 2.0.5 Release Notes

**Released:** Thu Jul 9, 2026
**Author:** Rob Lauer <rclauer@gmail.com>

---

## Overview

This release improves the `cmd_install` routine in the `Installer`
role with two key enhancements: validation that the target module is
resolvable within the configured import paths, and automatic
generation of a default `config.mk` file for new projects. Two new
dependencies have also been added.

---

## What's New

### Installer: Module Import Path Validation

The `cmd_install` command in
`CPAN::Maker::Bootstrapper::Role::Installer` now verifies that the
module the project is based on can actually be found somewhere within
the configured import paths before proceeding with installation.

- Uses `File::Find` to search all configured import paths for the
  module
- Raises a clear error (`ERROR: <ModuleName> not found in import
  paths.`) if the module cannot be located, preventing silent failures
  during project setup
- Logs the resolved module location at `info` level when found

### Installer: Automatic `config.mk` Generation

After a successful build, `cmd_install` now creates a default
`config.mk` file in the project directory. This file provides sensible
starting defaults for the new project's build configuration:

```makefile
SYNTAX_CHECKING ?= on
SCAN            ?= on
MODULE_NAME     ?= <YourModuleName>
```

### Makefile: Optional `config.mk` Include

The top-level `Makefile` now supports an optional `config.mk` file via
a `-include config.mk` directive, allowing per-project build variable
overrides without modifying the managed `Makefile`.

---

## New Dependencies

| Module | Minimum Version |
|---|---|
| `Git::Raw` | 0 |
| `IO::Scalar` | 2.113 |

These have been added to both `cpanfile` and `requires`.

---

## Files Changed

| File | Change |
|---|---|
| `lib/CPAN/Maker/Bootstrapper/Role/Installer.pm.in` | Added import path validation and `config.mk` generation in `cmd_install` |
| `Makefile` | Added `-include config.mk` support |
| `cpanfile` | Added `Git::Raw` and `IO::Scalar` dependencies |
| `requires` | Added `Git::Raw` and `IO::Scalar` dependencies |
| `VERSION` | Bumped to `2.0.5` |

---

## Upgrade Notes

- No breaking changes. Existing projects are unaffected.
- Projects bootstrapped with this version will automatically receive a
  `config.mk` stub — review and commit it as appropriate for your
  project.
- Ensure `Git::Raw` and `IO::Scalar` are installed before upgrading:
  `cpanm Git::Raw IO::Scalar`
