# CPAN::Maker::Bootstrapper 2.3.0 Release Notes

**Released:** 2026-08-20

---

## Overview

Version 2.3.0 is a feature and improvement release that introduces
strict/lenient variable substitution control for `resolve-vars`,
smarter handling of template placeholders in POD and comments, cleaner
build dependency isolation, and several build system refinements. The
release also updates runtime dependencies.

---

## What's New

### `resolve-vars`: Strict Mode and POD/Comment Awareness

The `resolve-vars` command now supports a `--strict` / `--no-strict`
option (default: `--strict`) that controls how unresolved `@TOKEN@`
placeholders in source code are handled.

- **`--strict` (default):** A placeholder found in code with no value
  in the environment or `--vars-file` is a **fatal error**. The build
  stops.
- **`--no-strict`:** A missing placeholder produces a **warning** and
  the literal token is left in place rather than being substituted
  with an empty string.

Crucially, placeholders that appear **only inside POD blocks or `#`
comments** are now excluded from the missing-value check entirely,
regardless of strict mode. This allows you to document a token in your
POD (e.g. `@BUILD_DATE@`) without triggering a build error when that
token has no value.

Substitution behavior has also improved: any placeholder without a
value — whether in POD, a comment, or (in `--no-strict` mode)
unresolved code — is now left **literal** (`@TOKEN@`) in the output
rather than being blanked out.

See [`--strict`, `--no-strict`](#options) and
[`resolve-vars`](#commands) in the documentation for full details.

### Git Metadata Exposed in Module

`CPAN::Maker::Bootstrapper` now exports two new package variables:

```perl
our $GIT_SHA   = '@GIT_SHA@';
our $GIT_DIRTY = '@GIT_DIRTY@';
```

These are stamped at build time via the template system, giving you
access to the exact commit and dirty state of the build from within
the module.

The `Makefile` has also been corrected to use the `$(GIT)` variable
(rather than a bare `git`) when computing `GIT_SHA` and `GIT_DIRTY`,
ensuring the configured Git binary is used consistently. A missing
`echo` in the `GIT_DIRTY` fallback has also been fixed.

---

## Build System Changes

### Conditional `local/` Dependency in `perl.mk`

The order-only prerequisite on the `local/` directory for `.pm` and
`.pl` pattern rules is now **conditional on `SYNTAX_CHECKING` being
enabled**. When syntax checking is off, the `local/` directory is no
longer an implicit dependency, avoiding unnecessary work and potential
errors on systems without a CPAN installer.

```makefile
LOCAL_PREREQ := $(if $(syntax_on),local)

%.pm: %.pm.in | $(LOCAL_PREREQ)
%.pl: %.pl.in | $(LOCAL_PREREQ)
```

### Build Dependency Isolation (`builder`)

The `install_deps` function in `builder` has been renamed to
`install_build_deps` and significantly refactored:

- **Build-time and run-time dependencies are now strictly separated.**
  The builder no longer installs run-time `requires` into the global
  Perl path; it installs only the minimal set of build tools.
- Build dependencies are now written to a separate
  **`cpanfile.build`** file, keeping the project's `cpanfile` (used by
  end-user installs) clean.
- Projects are now **required to provide a `build-requires` file**
  containing at least `CPAN::Maker::Bootstrapper`. If the file is
  absent or missing the entry, `builder` warns and creates/patches it
  automatically.
- `local/lib/perl5` is now exported as `PERL5LIB` before running
  `make`, ensuring the hermetic local library is available during the
  build.

### `buildspec.yml` Generation

The `buildspec.yml` recipe now correctly calls `gen-vars` to write a
`.vars` sidecar file and cleans it up via `trap`. The `resolve-vars`
invocation no longer passes template vars as positional arguments (it
now reads them from the `.vars` file, consistent with all other
template rules).

### `MIN_PERL_VERSION` Added to `TEMPLATE_VARS`

`MIN_PERL_VERSION` is now included in `TEMPLATE_VARS`, making it
available as an `@MIN_PERL_VERSION@` token in `.pm.in` and `.pl.in`
source files.

---

## Dependency Changes

### Added

| Module | Version | Notes |
|---|---|---|
| `CPAN::Maker` | 2.0.9 | Now a direct runtime dependency |

### Removed

| Module | Notes |
|---|---|
| `CLI::Simple::Constants` | No longer a direct dependency |
| `CLI::Simple::Utils` | No longer a direct dependency |

---

## Bug Fixes

- **`GIT_DIRTY` fallback:** Added missing `echo` to the fallback
  command so `GIT_DIRTY` correctly reports `unknown` when `git
  describe` fails, rather than silently producing an empty value.
- **`resolve-vars` blank substitution:** Unresolved placeholders are
  no longer replaced with an empty string; they are preserved
  literally as `@TOKEN@`.

---

## Documentation Updates

- The `resolve-vars` command now has full POD documentation, including
  the `--strict`/`--no-strict` semantics and POD/comment exclusion
  behaviour.
- The `--strict`, `--no-strict` option is documented in the `OPTIONS`
  section.
- The quick-start bootstrap example has been updated to include
  `SYNTAX_CHECKING=off` alongside `LINT=off` and `SKIP_TESTS=1`, and
  the description of each flag has been clarified.

---

## Upgrading

Run the following to upgrade and refresh your project's managed build
files:

```bash
cpanm CPAN::Maker::Bootstrapper
make update
```

Projects using CI via `builder` should also update their
`build-requires` file to ensure `CPAN::Maker::Bootstrapper` is listed:

```
CPAN::Maker::Bootstrapper
```

Review `git diff` after `make update` to confirm the changes before committing.
