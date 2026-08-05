# Release Notes: CPAN::Maker::Bootstrapper 2.1.0

## Overview

Version 2.1.0 is a feature release that builds on the
dependency-scanning and build-system overhaul completed in
2.0.12–2.0.14. This release introduces bash-completion support,
extracts the modulino recipe into its own managed include file, adds
dry-run support to the `release-notes` command, supports custom
release-notes prompts, improves the `make help` display, and cleans up
several internal inconsistencies.

---

## Changes in 2.1.0

### New Features

#### Bash Completion Support
- Added `.includes/bash-completion.mk` — a new managed include file
  providing shell tab-completion support for `cmb` and `make`
  targets. Included automatically from the project `Makefile`.

#### Modulino Recipe Extracted
- The `modulino` recipe has been moved from the main `Makefile` into a
  dedicated managed include file `.includes/modulino.mk`. The
  `Makefile` now simply includes it.
- Both `modulino.mk` and `bash-completion.mk` are added to `MANIFEST`, `buildspec.yml`, and `update.mk`'s `MANAGED_FILES` list so they are distributed and kept up to date by `make update`.

#### Custom Release-Notes Prompt
- `cmd_release_notes` now checks for a `.prompts/release-notes.prompt`
  file before falling back to the built-in prompt text. Projects can
  supply a custom prompt to tailor the LLM output without modifying
  source code.

#### Dry-Run Mode for `release-notes`
- `make release-notes` now honours a `DRYRUN` environment variable,
  passing `--dryrun` to `cmb release-notes` when set.
- `cmd_release_notes` returns early (without submitting to the LLM)
  when `--dryrun` is active. All document-assembly steps are skipped,
  making it safe to test artifact generation without incurring API
  costs.

#### `--dryrun` / `dryrun` Alias
- Added `dryrun` as a command-line alias for `--dry-run` in
  `cpan-maker-bootstrapper.yml`.

### Build System

#### `make help` Now Uses a Pager
- The `help` target in `.includes/help.mk` writes its output to a
  temporary file and pipes it through `$PAGER` (falling back to
  `less`, then `more`, then `cat`). This prevents the help text from
  scrolling off the screen on projects with many targets.
- Updated variable listing: added `SYNTAX_CHECKING=OFF` and
  `SKIP_TESTS=1`; removed the now-redundant `MODULINO_NAME` and
  `MODULE_NAME=A::B` entries.

#### `release-notes.mk` Comment Fix
- The `.PHONY` / comment ordering in `.includes/release-notes.mk` was
  corrected so the `##` help comment is properly picked up by `make
  help`.

#### `update.mk` Ordering Fix
- `make update` now rewrites `Makefile` *after* all other managed
  files have been updated (previously the Makefile was rewritten
  first, which could leave a partially-updated state if subsequent
  steps failed).

#### `project.mk` Simplified
- Removed the inter-module dependency recipes for
  `lib/CPAN/Maker/Bootstrapper/Role/LLM/Annotator.pm`,
  `lib/CPAN/Maker/Bootstrapper.pm`, and the `$(ROLES)` find-files
  call. These are now generated automatically by `deps.mk` (introduced
  in 2.0.10 / 2.0.13).

### Module Changes

#### `_loadASCIITable` => `_load_ASCIITable`
- Renamed the lazy-loader helper to use the correct snake_case
  convention across all callers:
  - `Role::LLM::Annotator`
  - `Role::LLM::Models`
  - `Role::LLM::Reviewer` (four call sites)

#### `Role::LLM::ReleaseNotes`
- Added `choose` to the `CLI::Simple::Utils` import list (required by
  the new prompt-selection logic).
- All `$llm->document(...)` and `$llm->text(...)` calls are now
  guarded by `if !$self->get_dryrun`, so no LLM objects are
  constructed in dry-run mode.

#### `cpan-maker-bootstrapper.yml`
- Formatting: `critique` command entry re-aligned to match the column
  width of other entries.
- Added `alias.options.dryrun: dry-run` so `--dryrun` is accepted as a
  synonym for `--dry-run`.

### Dependencies

- The `requires` file has been cleared of its explicit list; runtime
  dependencies are now fully managed through the scanned
  `requires`/`recommends`/`suggests` pipeline established in
  2.0.12–2.0.13.

---

## Changes in 2.0.12 – 2.0.14

### 2.0.14

**Build System**
- `requires.raw`, `recommends.raw`, `suggests.raw`, and `test-requires.raw` declared as `.INTERMEDIATE` targets so Make removes them automatically after use.
- `cpanfile.requires`, `cpanfile.suggests`, `cpanfile.recommends` likewise declared `.INTERMEDIATE`.
- `check-syntax` and `update-available` removed from the `$(TARBALL)` prerequisite list (`update-available` is now an order-only prerequisite via `|`).
- `deps.mk` self-remake rule simplified — no longer needs to translate file names.

---

### 2.0.13

**Build System — Major Dependency Scanning Overhaul**
- Replaced inline `scan-deps` and `filter-requires` make macros with
  calls to external `scandeps-static` (renamed from
  `scandeps-static.pl`) and new `cmb filter` command.
- Added separate `requires.raw`, `recommends.raw`, `suggests.raw`, and
  `test-requires.raw` intermediate targets — a single scan now
  produces all three dependency tiers at once.
- Added a shared `%: %.raw` pattern rule that reconciles fresh scan
  output against history (skip list + previous run) via `cmb filter`.
- Added `recommends` and `suggests` dependency files and corresponding
  targets; `buildspec.yml.tmpl` updated to include them.
- `cpanfile` is now built from three intermediate files
  (`cpanfile.requires`, `cpanfile.suggests`, `cpanfile.recommends`)
  rather than a single combined step.
- `deps.mk` now depends on source `.pm.in`/`.pl.in` files instead of
  built `.pm` targets, eliminating forced rebuilds on `make clean`.
- `deps.mk` is now included unconditionally (the `clean`/`distclean` guard is removed).
- Added `MIN_PERL_VERSION_FLAG` read from `buildspec.yml`
  automatically.
- `README.md` generation no longer exits on missing POD (`|| true`).
- Renamed `MD_UTILS` tool reference from `md-utils.pl` to `markdown-render`.

**perlcritic Customisation**
- Added `PERLCRITIC_SEVERITY` (default: `5`) and `PERLCRITIC_THEME`
  (default: `pbp`) make variables.
- Both variables are now passed to all `perlcritic` invocations;
  findings are written to both the console and the `.crit` sentinel
  file via `tee`.

**New `cmb` Commands**
- `critique` — new command backed by
  `CPAN::Maker::Bootstrapper::Role::Critic`.
- `filter` — new command backed by
  `CPAN::Maker::Bootstrapper::Role::Filter`.
- Added `--file-list` (`-L`) option.

**Module Changes**
- `CPAN::Maker::Bootstrapper`: removed explicit `Log::Log4perl`
  configuration block; now uses `CLI::Simple`'s built-in color support
  (`use_log4perl` with `color => $TRUE`); removed `init_logger`
  override.
- `Role::LLM::Annotator`, `Role::LLM::Models`, `Role::LLM::Reviewer`,
  `Role::LLM::Utils`: `Text::ASCIITable` and `Term::ANSIColor` are now
  lazy-loaded via a new `_load_ASCIITable` helper.
- `Role::LLM::Utils::_check_llm`: switched to `eval { } or do { }`
  pattern for cleaner error trapping.
- `Role::ExtraFiles::cmd_extra_files`: fixed to avoid duplicate
  entries when adding files to `buildspec.yml`.
- `Git::ReleaseDiffs::new`: `Git::Raw` is now loaded with `eval`/`or
  die` rather than a bare `require`, giving a clear error message if
  not installed.
- `Text::ASCIITable::FixANSI`: `Text::ASCIITable` is now lazy-loaded
  inside `BEGIN`.

**CI / builder**
- `builder` now mounts the project directory into Docker and builds
  from it directly.
- Uses `--no-prebuilt` with `cpm`.
- Sets `CMB_VERSION_DRIFT=ignore` so CI builds are not blocked by drift checks.
- Improved branch detection and checkout logic.

**`make update`**
- Now merges any missing entries from the bootstrapper's `gitignore`
  template into the project's `.gitignore` (preserving existing
  entries).
- Makefile is now rewritten *after* all other updates complete
  (ordering fix, also present in 2.1.0 for the bootstrapper project
  itself).

**Dependencies**
- `CLI::Simple` bumped to `2.1.1`; `CLI::Simple::Constants` and `CLI::Simple::Utils` pinned at `2.1.1`.
- `Module::ScanDeps::Static` bumped to `1.9.2`.
- `Pod::Extract` pinned at `1.0.2`.
- Optional dependencies (`Git::Raw`, `LLM::API`, `Perl::Critic`,
  `Term::ANSIColor`) moved from `requires`/`recommends` to a new
  `suggests` file.

---

### 2.0.12

**Build System**
- Templating and syntax-checking are recombined into a single step in
  `perl.mk` (previously split into separate sentinel phases). The
  chicken-and-egg problem with `deps.mk` is now resolved by making
  `deps.mk` depend on `.pm.in`/`.pl.in` source files rather than built
  `.pm` targets.
- Syntax checks now correctly target the built file (`$@`) rather than
  the source (`$<`).
- Added new `make package` target: runs `make clean` followed by a
  full build with `LINT=on SCAN=on`.

**Dependency Scanning**
- `create-deps` command now finds both `.pm.in` and `.pl.in` files
  (previously `.pm.in` only).
- `cmd_create_deps` can now generate dependency recipes for one or
  more specific files rather than always all files.
- `Module::ScanDeps::Static` is now lazy-loaded in `find_deps`.

**Dependencies**
- Added `Module::ScanDeps::Static 1.9.0` to `requires`.

**Other**
- Added new `config.mk` file.
- Added `install` target to `project.mk`.
- Fixed typo in `test-requires.skip` (`CPAN::Maker::Bootstrappe` → `CPAN::Maker::Bootstrapper`).

---

## Upgrade Notes

- Run `make update` in all projects using `CPAN::Maker::Bootstrapper`
  to receive `bash-completion.mk`, `modulino.mk`, and the updated
  `help.mk`, `release-notes.mk`, and `update.mk`.
- If you have a hand-edited `modulino` recipe in your project
  `Makefile`, remove it — it is now fully managed via
  `.includes/modulino.mk`.
- To use a custom release-notes prompt, create
  `.prompts/release-notes.prompt` in your project root.
