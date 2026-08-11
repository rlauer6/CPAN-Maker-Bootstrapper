# Release Notes: CPAN::Maker::Bootstrapper 2.2.0

## Overview

Version 2.2.0 introduces **hermetic builds** as the headline feature —
syntax checking now runs in an isolated environment using a
project-local dependency library (`local/lib/perl5`), ensuring that
undeclared dependencies are caught at build time on your machine
rather than at install time on someone else's. This release also
replaces the old `sed`-based token substitution with a new `cmb
resolve-vars` command, adds a `make repo` target for GitHub repository
creation, and includes a number of build-system robustness
improvements.

---

## New Features

### Hermetic Syntax Checking

Syntax checking (`perl -wc`) now runs with `PERL5LIB` explicitly
cleared, checking modules only against `lib/` and the new
project-local library at `local/lib/perl5`. This prevents a module
from passing a syntax check on your machine due to a dependency that
happens to be installed in your environment but is not declared in
`requires`.

```makefile
PERLINCLUDE ?= -I lib -I local/lib/perl5
```

A dependency that compiles locally but is missing from `requires` will
now fail the build immediately rather than surfacing as a surprise
during CI or a clean install.

### Local Dependency Library (`local/`)

The build now automatically installs declared dependencies into a
project-local library before building modules. `cpm` is preferred (for
multi-mirror support); `carton` is also supported.

```bash
make local   # installs requires/recommends/suggests into local/lib/perl5
```

This step runs automatically as a prerequisite of the module build — a
normal `make` installs dependencies first, then syntax-checks against
them. A new managed include file, `.includes/local.mk`, implements
this target.

### `cmb resolve-vars` Command

A new `resolve-vars` command replaces the previous `sed`-based token
substitution across all pattern rules. This is a correctness change, not
just a convenience:

- **Fail-loud on missing values.** `sed` substituted an empty string for
  any token it couldn't resolve, silently producing a malformed module
  that failed later — at compile or runtime. `resolve-vars` instead stops
  the build and names any unresolved `@TOKEN@`, so a missing or misdeclared
  variable is caught immediately. (This is the same defect class that let a
  blank `@GIT_HASH@` ship undetected in earlier tooling.)
- **Safe values.** Because substitution is a hash lookup rather than a
  regex, values containing quotes, ampersands, slashes, or spaces are
  handled verbatim — no escaping, no delimiter collisions.
- **Project-extensible tokens.** `sed` had a fixed set of substitutions
  hardcoded into every pattern rule. `resolve-vars` reads its values from a
  `.vars` sidecar (written by the new `gen-vars-file` make function) built
  from the project's `TEMPLATE_VARS` list, so a project can declare its own
  `@TOKEN@`s without touching the build rules.

The token grammar is uppercase-only (`@[A-Z0-9_]+@`), so it never
false-matches real Perl (`@ISA`, `@_`).

```bash
cmb resolve-vars template.pm.in > output.pm
```

The `--vars-file` option is available for specifying an external variables file.

### `make repo` Target

A new `repo` target in `.includes/git.mk` creates a GitHub repository
via `gha-aws` (from `GitHub::Actions::AWS`):

```bash
make repo REPO=my-new-repo [PUBLIC=1] [REPO_DESCRIPTION="description..."]
```

### `TEMPLATE_VARS` and Git Metadata Variables

The Makefile now defines a `TEMPLATE_VARS` list and exposes additional variables for use in templates:

- `PACKAGE_VERSION` — alias for `VERSION`
- `GIT_SHA` — current HEAD SHA
- `GIT_DIRTY` — dirty-tree description
- `GIT_USER` — alias for `GITHUB_USER`

### `extra-files.mk` for Extra-File Dependency Tracking

A new `extra-files.mk` (generated from `buildspec.yml`) causes the
distribution tarball to be rebuilt whenever any extra distribution
file changes. `extra-files.mk` is now included at the end of the
`Makefile` and added to `CLEANFILES` and `.gitignore`.

---

## Improvements

### Build System

- **Version bumps now run `make clean` first** — `make release`, `make
  minor`, and `make major` all call `clean` before bumping the
  version, preventing stale artifacts from surviving into the new
  version's build.
- **`deps.mk` is now guarded against empty output** — the recipe uses
  a temp file and only replaces `deps.mk` if the new content is
  non-empty, preventing an accidental empty `deps.mk` from wiping
  intra-project dependency edges.
- **`find-files` excludes temporary files** — Emacs lock files (`#*`,
  `.#*`), backup files (`*~`, `*.bak`) are now excluded from source
  file discovery. This prevent scanning of temporary files that could
  potentially break the build.
- **`SOURCE_FILES_IN` variable** — Raw `.pm.in`/`.pl.in` paths are now
  tracked separately. Dependency scanning (`requires`, `recommends`,
  `suggests`) and `deps.mk` regeneration now depend on the `.in`
  source files directly rather than on the built `.pm`/`.pl` targets,
  eliminating a class of spurious rebuilds.
- **`module.pm.tmpl` intermediate target removed** — The stub module
  generation no longer goes through an intermediate `module.pm.tmpl`
  file; `cmb resolve-vars` is called directly.
- **`INSTALLER` renamed to `DOCKER_CPAN_INSTALLER`** — The variable
  controlling the CPAN installer used inside `make build-ci` Docker
  builds has been renamed to avoid collision with the new
  `CPAN_INSTALLER` variable that selects `cpm` or `carton` for local
  builds.

### New Make Variables

| Variable | Purpose |
|---|---|
| `CPM` | Path to `cpm` if installed |
| `CARTON` | Path to `carton` if installed |
| `CPAN_INSTALLER` | Resolved to `cpm` or `carton` (whichever is found first) |
| `GITHUB_ACTIONS` | Path to `gha-aws` if installed |
| `GIT_SHA` | Current git HEAD SHA |
| `GIT_DIRTY` | Git dirty-tree description |

### `builder` Script

- Fixed a branch-checkout logic inversion: `builder` now only attempts
  `git checkout` when a `.git` directory is present (the condition was
  previously negated).
- Removed the hard error when `REPO` is not specified and the working
  directory is not a git repository — `builder` can now be run against
  a pre-mounted project directory without requiring a clone URL.

### `cpan-maker-bootstrapper.yml`

- New command entry: `resolve-vars` → `CPAN::Maker::Bootstrapper::Role::ResolveVars`
- New option: `--vars-file`

### `buildspec.yml`

- `.includes/local.mk` added to the list of share files included in the distribution.

### `.gitignore` / `gitignore`

- Added `extra-files.mk` and `local/` to both ignore files.

---

## Bug Fixes

- **`cmd_create_deps` now correctly handles `.pl` targets** — The
  regular expression used to derive generated file names from
  `.pm.in`/`.pl.in` source paths has been corrected to handle both
  `.pm` and `.pl` extensions.

---

## New Dependencies

- `Log::Log4perl` added to `requires` and `cpanfile` (sticky entry `+Log::Log4perl 0`).

---

## New Files

| File | Description |
|---|---|
| `.includes/local.mk` | Managed makefile include implementing the `local` target |
| `lib/CPAN/Maker/Bootstrapper/Role/ResolveVars.pm.in` | New role implementing the `resolve-vars` command |

---

## Documentation

- New sections added to the POD and `README.md`:
  - **The local dependency library** — explains hermetic syntax
    checking, how `local/` is populated, and when to use the `+`
    sticky prefix for runtime-only dependencies.
  - **build-mirrors** — documents per-entry `mirror=`, `url=`, and
    `dist=` qualifiers in `requires`/`suggests`/`recommends`.
- **PREREQUISITES** updated to list `cpm` or `carton` as required tools for hermetic checking (soft prerequisites).
- **CAVEATS** updated: `.pm`/`.pl` generation now references `cmb
  resolve-vars` rather than `sed`.
- **FAQ** — "My build is failing with a module not found error" gains
  a third cause: the module is a real dependency not installed in
  `local/`, which is the hermetic check working as intended.

---

## Upgrade Notes

Run `make update` in any project using a previous version of
`CPAN::Maker::Bootstrapper` to pick up the new managed files,
including `.includes/local.mk` and the updated
`.includes/perl.mk`. After updating, a normal `make` will attempt to
install declared dependencies into `local/` before syntax-checking. If
neither `cpm` nor `carton` is available, set `SYNTAX_CHECKING=off` in
`config.mk` to bypass the hermetic check until an installer is
available.
