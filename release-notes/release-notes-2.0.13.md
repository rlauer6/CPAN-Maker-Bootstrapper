# CPAN::Maker::Bootstrapper 2.0.13 Release Notes

**Released:** 2026-07-25  
**Author:** Rob Lauer &lt;rclauer@gmail.com&gt;

---

## Overview

This release significantly refactors the dependency scanning pipeline,
streamlines the build system, improves CI/Docker support, adds two new
`cmb` commands (`critique` and `filter`), and hardens optional-module
loading throughout the LLM subsystem by converting eager `use`
statements to lazy `require` calls.

---

## New Features

### New Commands: `critique` and `filter`

Two new commands have been registered in `cpan-maker-bootstrapper.yml`:

- **`critique`** — dispatches to
  `CPAN::Maker::Bootstrapper::Role::Critic`. Provides a standalone
  perlcritic interface via `cmb`.
- **`filter`** — dispatches to
  `CPAN::Maker::Bootstrapper::Role::Filter`. Implements the
  skip/pin/preserve reconciliation logic that was previously embedded
  as a Perl heredoc inside the `Makefile`. The filter logic is now a
  first-class `cmb` command, making it independently testable and
  reusable.

A new `--file-list|-L` option has been added to support these commands.

### Three-Tier Dependency Scanning

The build system now produces three dependency tiers in a single scan pass:

- **`requires`** — runtime dependencies (unchanged semantics)
- **`recommends`** — soft dependencies not wrapped in `eval`
- **`suggests`** — optional dependencies wrapped in `eval`

Each tier now has a corresponding `.raw` intermediate file
(`requires.raw`, `recommends.raw`, `suggests.raw`,
`test-requires.raw`) produced by `scandeps-static` with the `--raw`,
`--filter`, `--requires-file`, `--recommends-file`, and
`--suggests-file` flags. A generic `%: %.raw` pattern rule then
applies the `cmb filter` reconciliation step (skip list + previous
run + pin preservation) when `SCAN=on`.

The `buildspec.yml` template now includes `recommends` and `suggests` dependency sections.

### `cpanfile` Now Combines All Three Tiers

The `cpanfile` target is now built from three intermediate files —
`cpanfile.requires`, `cpanfile.suggests`, and `cpanfile.recommends` —
each produced by `cpan-maker create-cpanfile --dependency-type <tier>`
and then concatenated. This replaces the previous single-call approach
that only handled `requires` and `test-requires`.

### `make update` Now Merges `.gitignore`

The `post-update` target in `.includes/update.mk` now detects an
existing `.gitignore` and merges any entries from the bootstrapper's
canonical `gitignore` that are not already present, preserving all
project-local entries. This is additive-only; no existing entries are
removed.

### `MIN_PERL_VERSION_FLAG` Read from `buildspec.yml`

The Makefile now reads `min-perl-version` directly from
`buildspec.yml` at make-expansion time using `dnk get`, producing a
`-m <version>` flag passed to `scandeps-static`. Previously this
required a `perl -MYAML::Tiny` invocation inline in the scan recipe.

### `PERLCRITIC_SEVERITY` and `PERLCRITIC_THEME` Variables

`perl.mk` now exposes two new make variables (defaulting to severity
`5` and theme `pbp`) that are passed explicitly to every `perlcritic`
invocation, including per-file sentinel rules and the standalone `make
critic` target:

```makefile
PERLCRITIC_SEVERITY ?= 5
PERLCRITIC_THEME    ?= pbp
```

Override per-run with `make PERLCRITIC_SEVERITY=3` or set in `project.mk`.

### `make release-notes` Uses `cmb`

`.includes/release-notes.mk` now invokes `cmb release-notes` instead
of the deprecated `bootstrapper release-notes`.

---

## Build System Changes

### `Makefile`

| Item | Change |
|---|---|
| `MD_UTILS` | Renamed to `markdown-render` (from `md-utils.pl`) |
| `SCANDEPS` | Renamed to `scandeps-static` (from `scandeps-static.pl`) |
| `README.md` recipe | No longer exits on missing POD (`\|\| true` appended) |
| `scan-deps` macro | **Removed** — replaced by `.raw` file targets |
| `filter-requires` macro | **Removed** — logic moved to `cmb filter` |
| `requires` / `test-requires` / `recommends` / `suggests` | Now thin stubs that declare source-file dependencies; the `.raw → %` pattern rule does the actual work |
| `DEPS` | Now includes `recommends` and `suggests` |
| `CLEANFILES` | Now includes `*.raw` |

### `make build-ci`

The Docker invocation now mounts the current project directory into
the container (`-v "$(pwd):/$(basename $(pwd))"`) so the builder can
operate on the already-checked-out tree rather than cloning from a
remote URL. The `REPO` environment variable is set from `git remote
get-url origin` and passed into the container.

### `builder`

- Skips `git clone` if the target directory already exists.
- Skips `git checkout` if `.git` is already present (i.e., mounted working tree).
- Passes `CMB_VERSION_DRIFT=ignore` and `NO_ECHO=` to `make` so CI builds are not blocked by drift checks and produce full output.
- Default `cpm` installer string updated (note: contains a typo
  `--no-prebuilt--show-build-log-on-failure` — the space between flags
  is missing; this will be corrected in a follow-up patch).

---

## Lazy Loading / Optional Module Hardening

All LLM-subsystem modules that previously loaded optional or heavy
dependencies at compile time with `use` now defer loading to the point
of first use with `require`. This means installing
`CPAN::Maker::Bootstrapper` no longer fails if `LLM::API`, `Git::Raw`,
`Term::ANSIColor`, or `Text::ASCIITable` are absent.

| Module | Change |
|---|---|
| `Role::LLM::Annotator` | `Term::ANSIColor`, `Text::ASCIITable`, `Text::ASCIITable::FixANSI` now lazy-loaded via new `_load_ASCIITable` helper |
| `Role::LLM::Models` | `Text::ASCIITable` now lazy-loaded |
| `Role::LLM::Reviewer` | `Text::ASCIITable` now lazy-loaded in `cmd_code_review`, `cmd_pod_review`, `cmd_code_finding`, `cmd_pod_finding` |
| `Role::LLM::Utils` | `Text::ASCIITable` lazy-loaded in `_pre_submission_report` and `_print_token_usage`; `LLM::API` load failure now uses `or do { die ... }` pattern |
| `Role::CreateDeps` | `Module::ScanDeps::Static` now lazy-loaded in `find_deps` |
| `Git::ReleaseDiffs` | `Git::Raw` now loaded via `eval { require Git::Raw; 1 } or do { die ... }` with a clear error message |
| `Text::ASCIITable::FixANSI` | `Text::ASCIITable` moved from `use` to `require` inside `BEGIN` |
| `Bootstrapper.pm` | Removed hand-rolled Log4perl configuration; now delegates to `CLI::Simple`'s built-in color logging via `use_log4perl(color => $TRUE, info_color => 'white')`. The `init_logger` override is removed. |

---

## Dependency Changes

### `requires` (runtime, pinned)

| Module | Old Version | New Version |
|---|---|---|
| `CLI::Simple` | 2.0.14 | **2.1.1** |
| `CLI::Simple::Constants` | *(via skip list)* | **2.1.1** (now explicit) |
| `CLI::Simple::Utils` | *(via skip list)* | **2.1.1** (now explicit) |
| `IO::Interactive` | *(absent)* | **1.027** (new) |
| `Module::Metadata` | 0 | **1.000038** |
| `Module::ScanDeps::Static` | 1.9.0 | **1.9.2** |
| `Pod::Extract` | *(was sticky `+`)* | **1.0.2** |
| `Role::Tiny` | 0 | **2.002004** |
| `CPAN::Maker` | 2.0.1 (sticky) | **removed** from requires |
| `Markdown::Render` | 0 (sticky) | **removed** from requires |
| `Pod::Markdown` | 0 (sticky) | **removed** from requires |
| `Text::Markdown::Discount` | 0 | **removed** from requires |

### `suggests` (new tier — previously `recommends`)

| Module | Version |
|---|---|
| `Git::Raw` | 0.90 |
| `LLM::API` | 1.0.1 |
| `Perl::Critic` | 1.156 |
| `Term::ANSI::Color` | *(any)* |

### `requires.skip`

Removed. The entries it contained (`CLI::Simple::Constants`, `CLI::Simple::Utils`, `LLM::API`, `Git::Raw`) are now either promoted to `requires` directly or moved to `suggests`.

### `test-requires.skip`

Fixed typo: `CPAN::Maker::Bootstrappe` → `CPAN::Maker::Bootstrapper`.

---

## Bug Fixes

- `Git::ReleaseDiffs->new` now dies with a clear, actionable message
  when `Git::Raw` is not installed, rather than propagating a raw
  `require` failure.
- `_check_llm` in `Role::LLM::Utils` now uses the `or do { die }`
  idiom, ensuring the error message is always displayed rather than
  being silently swallowed in certain eval contexts.
- `_fmt_tokens` in `Role::LLM::Utils` reformatted to avoid an implicit
  return of `undef` when `$n >= 1_000_000`.
- `make critic` target: the `check-syntax` dependency is now correctly
  listed (was previously calling bare `$(MAKE)` without specifying the
  target).

---

## Files Changed

```
.gitignore
.includes/perl.mk
.includes/release-notes.mk
.includes/update.mk
ChangeLog
Makefile
README.md
VERSION
builder
buildspec.yml.tmpl
cpan-maker-bootstrapper.yml
cpanfile
deps.mk
gitignore
lib/CPAN/Maker/Bootstrapper.pm.in
lib/CPAN/Maker/Bootstrapper/Role/Critic.pm.in       (new)
lib/CPAN/Maker/Bootstrapper/Role/CreateDeps.pm.in
lib/CPAN/Maker/Bootstrapper/Role/Filter.pm.in       (new)
lib/CPAN/Maker/Bootstrapper/Role/LLM/Annotator.pm.in
lib/CPAN/Maker/Bootstrapper/Role/LLM/Models.pm.in
lib/CPAN/Maker/Bootstrapper/Role/LLM/Reviewer.pm.in
lib/CPAN/Maker/Bootstrapper/Role/LLM/Utils.pm.in
lib/Git/ReleaseDiffs.pm.in
lib/Text/ASCIITable/FixANSI.pm.in
recommends
requires
requires.skip                                        (deleted)
test-requires.skip
```

---

## Upgrade Notes

Users of projects scaffolded with an earlier bootstrapper version should run:

```bash
make update
```

after installing 2.0.13 to pull the updated `Makefile`, `perl.mk`,
`release-notes.mk`, and `update.mk` into their projects. Review the
diff carefully — the `requires`/`suggests`/`recommends` split and the
removal of the inline `filter-requires` macro are the most significant
structural changes that may require attention in projects with custom
`project.mk` override.s
