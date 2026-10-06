# CPAN::Maker::Bootstrapper 2.4.0 Release Notes

## Overview

This release significantly expands the CI integration framework,
enhances the import workflow with new safety features and dry-run
support, and refines the build system's handling of quality gates and
dependency scanning.

## New Features

### Improved Project Import

The `--import` workflow has been substantially enhanced:

- **Module name inference from import directory**: when a single
  import path is supplied, the module name is now derived from
  the directory name (e.g., `Foo-Bar/` implies `Foo::Bar`),
  removing the requirement to always specify `--module`.
- **Dry-run mode**: use `--dry-run` to preview the full import
  plan — file classifications, source paths, and destinations —
  without creating any files or running the build.
- **Project tarball output**: `--project-tarball` creates a
  self-contained `Foo-Bar-cmb.tar.gz` archive of the generated
  bootstrapper project rather than installing into a directory.
- **Import destination safety**: the bootstrapper now refuses to
  install into a directory that is beneath or equal to an import
  root, preventing the generated project from contaminating the
  source being imported.
- **Path exclusions**: `--exclude` omits directories beneath an
  import root; `.git`, `.hg`, and `.svn` are always excluded
  automatically.
- **Expanded test file recognition**: files beneath `t/`,
  `xt/author/`, `xt/release/`, and `xt/smoke/` are preserved in
  place rather than reclassified as modules or scripts. Change
  logs (`ChangeLog`, `Changes`, etc.) are also preserved.
- **Import build policy**: the import build now defaults to
  `SCAN=on SYNTAX_CHECKING=on LINT=off`, and these defaults
  can be overridden via environment variables.

### Expanded Test Targets

A new `.includes/test.mk` include adds structured support for
extended test suites:

- `make test-author` — runs `xt/author/`
- `make test-release` — runs `xt/release/`
- `make test-smoke` — runs `xt/smoke/`
- `make test-all` — runs all of the above plus `t/`
- `AUTHOR_TESTING`, `RELEASE_TESTING`, `AUTOMATED_TESTING`
  variables enable the extended suites within `make test`

All extended test directories are created automatically when the
target is invoked. Each target uses a double-colon rule and may
be extended in `project.mk`.

### CI Lifecycle Hooks and `builder.env`

The `builder` script now supports a structured build lifecycle:

```
builder.env → builder-pre → make → builder-post
```

- **`builder.env`**: a project-local environment file loaded by
  `builder` before the build; ships with sensible CI defaults
  (`CMB_VERSION_DRIFT=ignore`).
- **`builder-pre` / `builder-post`**: Makefile hooks (empty
  double-colon targets) that projects may extend in `project.mk`
  for CI-specific setup and post-build work.
- **`builder` no longer clones repositories**: it operates on an
  existing project directory, accepting the path as an optional
  argument (defaults to the current working directory). Source
  acquisition is now the caller's responsibility.
- **`make build-ci`** has been moved to `.includes/builder.mk`
  and updated to mount and copy the current working tree rather
  than cloning.

### New Commands

- **`dist-file`**: copies a file from a distribution's root or
  `share/` directory to STDOUT.
- **`show-defaults`**: prints resolved default option values after
  applying configuration and runtime defaults.

### Syntax Checking Refactored as Sentinel Files

Syntax and POD checking are now tracked via `.checked` sentinel
files, decoupled from module generation. The `.pm` and `.pl`
pattern rules no longer perform inline syntax checking; instead,
`%.pm.checked` and `%.pl.checked` sentinels gate the tarball
build when `SYNTAX_CHECKING` is enabled. `deps.mk` is only
generated when syntax checking is on.

### Linting Gate Controls Updated

`PERLTIDY` and `PERLCRITIC` (the tool binaries) now gate the lint
tools rather than `PERLTIDYRC` and `PERLCRITICRC`. Profile
variables configure the tools but do not enable or disable them.
Both tools now work without a profile file, using defaults when
none is specified.

### `CMB_VERSION_DRIFT` Now Case-Insensitive with Validation

The `CMB_UPDATE_CHECK` and `CMB_VERSION_DRIFT` variables are now
lowercased internally via a new `lc` make function, and invalid
values produce an explicit error rather than silently falling
through.

### `$MAX_TOKENS` Constant

A `$MAX_TOKENS` constant (8192) has been added to
`CPAN::Maker::Bootstrapper::Constants` and is now set as the
default in `init` when no value is configured, removing the
previously hard-coded inline default in the reviewer role.

## Build System Changes

- Build system CI and test targets extracted into new managed
  includes: `.includes/builder.mk` and `.includes/test.mk`.
- `DARKPAN_REQUIRES` logic now uses the lowercase `darkpan_requires_on`
  sentinel; generated darkpan files are no longer added to
  `extra-files.skip` automatically.
- `provides` target now depends directly on `.pm.in` files rather
  than triggering a full module build.
- `make local` now creates the `local/` directory if absent before
  touching the sentinel file.
- The `extra-files` git tracking check is skipped when `GIT` is
  not available or `.git` is absent.
- `deps.mk` is now added to `.gitignore` / `gitignore`.
- `PUBLISH` recipe updated: `make` step removed before `make test`;
  `PAUSE_USER`/`PAUSE_PASSWORD` are exported and validated before
  unpacking the tarball. `pre-publish` and `post-publish`
  double-colon hooks added.
- GitHub Actions workflow updated to `actions/checkout@v7` and
  `CMB_VERSION_DRIFT=ignore` set in the container environment.

## Bug Fixes and Minor Improvements

- Fixed a typo ("typo" → "disposition", "cosst" → "cost",
  "instatiates" → "initializes") in POD/documentation.
- `ConfigReader` now exposes a `config_file` accessor and saves
  the resolved path; `_init_config` sets `config` to the resolved
  file path (or `undef`) rather than the raw accessor value.
- `Provides` role no longer depends on `CPAN::Maker::Role::Provides`;
  uses `File::Find` directly against `.pm.in` files.
- `update.mk`: fixed broken `addprefix` call in `INCLUDES_FILES`;
  `post-update` now errors if a managed file is missing from the
  distribution rather than silently skipping.
- `local.mk` mode line added; `mkdir -p local` added before
  `touch local/.installed`.

---

**Commit message**: Expand import workflow with dry-run, project
tarball, and path exclusion support; add structured CI lifecycle
hooks and extended test targets; decouple syntax checking into
sentinel files.
