# CPAN::Maker::Bootstrapper 2.0.10 Release Notes

**Released:** Sun Jul 19 2026  
**Author:** Rob Lauer <rclauer@gmail.com>

---

## Overview

This release introduces automatic intra-project dependency tracking
via a new `deps.mk` mechanism, adds a `create-deps` CLI command,
improves the install workflow with better output handling and error
reporting, and fixes several LLM-related bugs around token truncation
warnings, token formatting, and unexported function references.

---

## New Features

### Intra-Project Dependency Tracking (`deps.mk`)

A new `deps.mk` file and supporting infrastructure automatically
tracks build-time dependencies between generated `.pm` files within a
project. This eliminates the class of build failures caused by Make
attempting to syntax-check a module before its dependencies have been
built.

- **`Makefile`**: Added a `deps.mk` recipe that invokes `cmb
  create-deps` to generate intra-project dependency edges
  automatically.
- **`lib/CPAN/Maker/Bootstrapper/Role/CreateDeps.pm.in`**: New role
  implementing the `create-deps` command.
- **`cpan-maker-bootstrapper.yml`**: Registered the new `create-deps` command.

### Safe `deps.mk` Inclusion in `perl.mk`

`deps.mk` has a self-remake rule that requires built `.pm` files to
exist. GNU Make checks whether included makefiles are up to date
*before* running the requested goal — including `clean` — which
previously caused `make clean` to build every `.pm` file and then
immediately delete them.

`deps.mk` is now conditionally included, skipped when the goal is
`clean` or `distclean`:

```makefile
ifeq ($(filter clean distclean,$(MAKECMDGOALS)),)
-include deps.mk
endif
```

`project.mk` remains unconditionally included because it may contain
`clean-local::` hooks that must run during `make clean`.

### `SKIP_TESTS` Flag in `Makefile`

The top-level `Makefile` now respects a `SKIP_TESTS` environment
variable, passing `--skip-tests` to `cpan-maker` when set. This is
particularly useful during project import when running the test suite
is not yet meaningful:

```sh
SKIP_TESTS=1 make
```

---

## Improvements

### Syntax Checking Decoupled from Linting (`perl.mk`)

`SYNTAX_CHECKING` is now evaluated independently of the `LINT`
flag. Previously, syntax checking was suppressed whenever `LINT=off`
was set, which was often surprising. Syntax checking now has its own
independent control:

```makefile
# Before
syntax_on  = $(if $(lint_off),,$(filter-out off,...))

# After
syntax_on = $(filter-out off,...)
```

To disable syntax checking independently:
```sh
make SYNTAX_CHECKING=off
```

### Improved Install Output and Error Reporting (`Installer.pm`)

The `cmd_install` method received several quality-of-life improvements:

- **`tee` output**: `STDOUT` and `STDERR` are now piped through `tee`
  during the `make` invocation, so build output is visible in real
  time *and* written to log files simultaneously.
- **`NO_ECHO` and `SYNTAX_CHECKING` overrides**: These environment
  variables are now forwarded to the inner `make` invocation only when
  explicitly set by the caller, rather than being unconditionally
  overridden.
- **Improved error messages**: On build failure, a clearer message is
  printed. Users are informed that `--debug` can be used to preserve
  the temporary installation directory for diagnosis.
- **`_tail_file` helper**: A new (currently unused) `_tail_file`
  utility method has been added for future diagnostic use.

### New Dependency: `Module::ScanDeps::Static`

`Module::ScanDeps::Static >= 1.8.1` has been added as an explicit
runtime dependency in both `requires` and `cpanfile`. This module is
used by the `create-deps` command and the `make requires` / `make
test-requires` scanning targets.

---

## Bug Fixes

### `_fmt_tokens` Incorrect Output for Sub-Million Token Counts (`LLM::Utils`)

The token formatter previously returned a bare number with a `K`
suffix appended as a string for counts below 1,000,000, but did not
perform the division:

```perl
# Before (wrong - returned raw count with literal 'K' appended)
return "${n}K" if $n < 1_000_000;

# After (correct - divides by 1,000 before formatting)
return sprintf( '%dK', $n / 1_000 ) if $n < 1_000_000;
```

### `_fmt_tokens` Not Exported — Called via Full Package Name (`LLM::Models`)

`_fmt_tokens` is not exported from `LLM::Utils`. `_show_models` was
calling it as a bare function, which would fail at runtime. The call
sites have been updated to use the fully-qualified package name:

```perl
# Before
my $context = _fmt_tokens( $m->{max_input_tokens} );

# After
my $context = CPAN::Maker::Bootstrapper::Role::LLM::Utils::_fmt_tokens( $m->{max_input_tokens} );
```

The required `use CPAN::Maker::Bootstrapper::Role::LLM::Utils` statement has also been added to `Models.pm.in`.

### LLM Response Truncation Warnings

Both `cmd_release_notes` (in `ReleaseNotes.pm`) and `_cmd_review` (in
`Reviewer.pm`) now warn the user when the LLM response was truncated
due to hitting the `max_tokens` limit:

```
WARNING: response was truncated (hit max_tokens). Increase --max-tokens for a complete response.
```

### Raw Response Printed on LLM Error (`ReleaseNotes.pm`)

`cmd_release_notes` previously checked only `!defined $content` before
falling back to printing the raw response. The check has been
tightened to also handle cases where `$content` is defined but
contains no text:

```perl
# Before
if ( !defined $content ) { ... }

# After
if ( !$content || !$content->text ) { ... }
```

### Default `max_tokens` Increased for Code Review (`Reviewer.pm`)

The default `max_tokens` for `_cmd_review` has been increased from
`4096` to `8192` to reduce the likelihood of truncated reviews on
moderately sized modules.

---

## Configuration and Template Changes

### `buildspec.yml.tmpl`: Key Normalisation

The `pm_module` key in `buildspec.yml.tmpl` has been renamed to
`pm-module` (hyphen instead of underscore) for consistency with the
hyphenated key convention used elsewhere in `buildspec.yml`:

```yaml
# Before
path:
  pm_module: lib

# After
path:
  pm-module: lib
```

---

## Changed Files Summary

| File | Change |
|---|---|
| `.includes/perl.mk` | Decouple syntax checking from lint flag; guard `deps.mk` include against `clean`/`distclean` |
| `Makefile` | Add `SKIP_TESTS` support; add `deps.mk` remake recipe |
| `cpan-maker-bootstrapper.yml` | Register `create-deps` command |
| `lib/CPAN/Maker/Bootstrapper/Role/CreateDeps.pm.in` | **New** — implements `create-deps` command |
| `lib/CPAN/Maker/Bootstrapper/Role/Installer.pm.in` | `tee` output; env var forwarding; improved error reporting; `_tail_file` helper |
| `lib/CPAN/Maker/Bootstrapper/Role/LLM/Models.pm.in` | Fix unexported `_fmt_tokens` call |
| `lib/CPAN/Maker/Bootstrapper/Role/LLM/ReleaseNotes.pm.in` | Print raw response on error; warn on truncation |
| `lib/CPAN/Maker/Bootstrapper/Role/LLM/Reviewer.pm.in` | Increase default `max_tokens` to 8192; warn on truncation |
| `lib/CPAN/Maker/Bootstrapper/Role/LLM/Utils.pm.in` | Fix `_fmt_tokens` for sub-million token counts |
| `buildspec.yml.tmpl` | `pm_module` → `pm-module` |
| `requires` / `cpanfile` | Add `Module::ScanDeps::Static 1.8.1` |
| `VERSION` | Bumped to `2.0.10` |

---

## Upgrade Notes

- Run `make update` in existing projects to pull in the updated
  `perl.mk` with the `deps.mk` guard and the decoupled syntax-checking
  behaviour.
- If you use `make clean` in projects with many modules, you will
  notice that `.pm` files are no longer spuriously rebuilt before
  being deleted.
- Install `Module::ScanDeps::Static >= 1.8.1` if not already present:
  `cpanm Module::ScanDeps::Static`
