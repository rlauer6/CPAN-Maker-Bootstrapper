# CPAN::Maker::Bootstrapper 2.0.7 Release Notes

**Released:** 2026-07-14

## Overview

This release focuses on robustness improvements to the installer,
colorized logging, improved error handling, and a number of refactors
and fixes across the LLM toolchain. Dependency requirements have been
bumped for `CLI::Simple` and `CPAN::Maker`.

---

## What's New

### Colorized Logging

The bootstrapper now uses
`Log::Log4perl::Appender::ScreenColoredLevels` by default, providing
color-coded log output:

| Level | Color      |
|-------|------------|
| DEBUG | Magenta    |
| INFO  | Green      |
| WARN  | Yellow     |
| ERROR | Red        |
| FATAL | Bold Red   |
| TRACE | Bold White |

Color output can be disabled with `--no-color`. If `Term::ANSIColor`
is not available, color is automatically disabled. Color is now **on
by default**.

### New `--color|--no-color` Option

Color output is now a first-class option. Use `--no-color` to suppress
it:

```bash
cmb --no-color --module My::Module
```

### New `--debug|-d` Option

A new `--debug` flag has been added. When set, temporary build
directories are **not** removed on exit, making it easier to diagnose
installation failures.

### New `Text::ASCIITable::FixANSI` Module

A new helper module `Text::ASCIITable::FixANSI` has been introduced to
support proper ANSI color rendering inside ASCII table output used by
the `annotate` command.

---

## Improvements

### Installer (`cmd_install`) — Major Refactor

The installer has been substantially refactored for clarity,
correctness, and better error reporting:

- **Fatal errors are now sent to the logger** rather than raising bare
  `die` calls, providing consistent log output.
- **Errors return `$FAILURE`** rather than dying, allowing callers to
  handle failures gracefully.
- **Previously installed files are removed before re-installation** to
  avoid permission errors when overwriting an existing project (with
  `--force`). Specifically, `Makefile`, `buildspec.yml`, and
  `.includes/*` are removed.
- **`buildspec.yml` is now created with `0644` permissions.**
- **The `NO_ECHO` environment variable** is now passed through to the
  `make` invocation during install.
- **Version and copyright banner** is now logged at startup.

Three private helper methods have been extracted from `cmd_install`:

| Method | Purpose |
|---|---|
| `_validate_module` | Validates the module name and checks import paths |
| `_create_install_dir` | Resolves and creates the install directory |
| `_create_default_config` | Writes the initial `config.mk` |

The generated `config.mk` now also includes `LINT ?= on` in addition
to `SYNTAX_CHECKING`, `SCAN`, and `MODULE_NAME`.

The post-install next-steps banner has been expanded to include links to documentation and the GitHub project.

### Annotation Workflow

- **`cmd_annotate`**: The review file is no longer rewritten if no
  annotations were applied (avoids unnecessary file I/O and timestamp
  churn).
- **`_annotate`**: Now returns `undef` (rather than the review object)
  when no annotations are present, allowing callers to skip the file
  write.
- **`_show_annotations`**: Color lookup now falls back to `'white'`
  for any severity or disposition not present in `$COLORS`, preventing
  errors from unknown values.
- **`_finalize_annotations`**: Switched from `JSON::PP` to `JSON`.

### LLM Reviewer

- **`_get_latest_review`**: The `--history` guard has been removed;
  the latest review file is always loaded when available. Switched
  from `JSON::PP` to `JSON`.
- **`_cmd_review`**: All JSON encoding/decoding now uses `JSON`
  instead of `JSON::PP`. The file content for code review is now read
  via `slurp` before being passed to `_strip_pod`, fixing a call-site
  bug.
- **`_strip_pod`**: Now accepts invocation as either a plain function
  or an instance method, and handles both scalar content and scalar
  references.

### Constants

Two new entries have been added to `$COLORS` and `$DISPOSITIONS`:

- **`informational`** severity color (`white`)
- **`'-'`** disposition (used for unannotated findings) — mapped to
  `white` in `$COLORS` and added to `$DISPOSITIONS`

### CLI Module Template (`cli-module.pm.tmpl`)

- `caller or __PACKAGE__->main` is now `caller or exit
  __PACKAGE__->main` — correctly propagating the exit code from
  `main`.
- `default_options => {}` has been added to the `__PACKAGE__->new(...)` call.
- `L<CLI::Simple>` has been added to the SEE ALSO section.

### Class Module Template (`class-module.pm.tmpl`)

- Minor whitespace fix: `our $VERSION ='...'` → `our $VERSION = '...'`
  (space after `=`).

### Initialization (`Role::Init`)

- `get_import` is now initialized to an empty array ref `[]` when not
  set, preventing downstream errors when no import paths are
  specified.
- Color availability check now correctly captures the return value of
  the `eval` block and sets `color` to `undef` (false) when
  `Term::ANSIColor` is unavailable.

---

## Dependency Updates

| Module | Previous | New |
|---|---|---|
| `CLI::Simple` | 2.0.0 | **2.0.14** |
| `CPAN::Maker` | 1.9.0 | **2.0.1** |

---

## Bug Fixes

- Fixed an issue where `cmd_install` would die without logging when
  the stub file was not found.
- Fixed `_strip_pod` not being callable as an instance method
  (impacted `_cmd_review`).
- Fixed potential permission errors when reinstalling into an existing
  project directory by removing managed files before copying.
- Fixed `buildspec.yml` being created without world-readable
  permissions in some environments.

---

## Documentation

- POD has been updated throughout `CPAN::Maker::Bootstrapper` with
  corrections, formatting improvements, and new sections covering
  `--color|--no-color` and `--debug`.
- Several long command-line examples in the POD have been reformatted
  to single lines for readability.
- The `installdir` synopsis example has been corrected: `~/git` → `~/git/My-Module`.
- Copyright notice added to the LICENSE section.
- Version reference in POD is now dynamically substituted via
  `@PACKAGE_VERSION@`.

---

## Internal / Build

- `buildspec.yml` permissions are now explicitly set to `0644` in the
  `Makefile`.
- `project.mk` now declares the build dependency of `Annotator.pm` on
  `Text::ASCIITable::FixANSI.pm`.
- `release-notes.md` symlink updated to point to
  `release-notes-2.0.7.md`.
