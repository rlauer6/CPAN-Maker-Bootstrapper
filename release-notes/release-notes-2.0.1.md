# CPAN::Maker::Bootstrapper 2.0.1 Release Notes

## Overview

This release completes the CI/CD story introduced in 2.0.0. The
`builder` script (formerly `build-github`) is now a first-class
Bootstrapper asset - installed via `make workflow`, configurable via
declarative project files, and runnable locally with `make build-ci`.
`YAML::XS` is replaced throughout with `YAML::Tiny`, reducing the
dependency footprint significantly.

---

## What's New

**`make workflow` - install CI assets in one step**

Running `make workflow` copies `builder` and
`.github/workflows/build.yml` from the Bootstrapper's share directory
into your project and merges the Bootstrapper's `build-requires` into
your own. Once installed, commit all three files:

```bash
git add builder build-requires .github/workflows/build.yml
```

**`make build-ci` - run your GitHub Actions build locally**

Runs the full CI build inside a fresh Docker container - identical to
what GitHub Actions will run - and tees output to a timestamped log
file. No approximation, no mocking. Accepts overrides for the base
image, branch, builder script, and installer:

```bash
make build-ci                                      # default
make build-ci DOCKER_BUILD_IMAGE=debian:bookworm   # different base image
make build-ci INSTALLER=cpm                        # use cpm instead of cpanm
make build-ci BRANCH=my-feature                    # test a feature branch
```

**`make update-available` - check for Bootstrapper updates**

Checks whether a newer version of `CPAN::Maker::Bootstrapper` is
available on CPAN and reports the result. Runs automatically as part
of the default `make` target so you are always informed at build time.

**`builder` - declarative, configurable CI script**

The `builder` script (renamed from `build-github`) ships as a
Bootstrapper share asset and supports both `cpanm` and `cpm` as
installers via the `INSTALLER` environment variable. Build behavior is
controlled entirely by committed project files - no edits to the
script required for common customizations:

| File | Controls |
|---|---|
| `build-requires` | Perl build-time dependencies |
| `build-apt-deps` | System library dependencies |
| `build-mirrors` | CPAN mirror list (DarkPAN support) |
| `.perltidyrc` / `.perlcriticrc` | Linting - present enables, absent skips |

`builder` is now included in `extra-files` so it is distributed as
part of the Bootstrapper tarball and available via `make workflow` in
downstream projects.

---

## Changes

**`YAML::XS` replaced by `YAML::Tiny` throughout**

`YAML::XS` has been removed from `requires`, `build-requires`, and
`Role::Installer`. `YAML::Tiny` is an adequate substitute for the
straightforward YAML this project produces and avoids pulling in
`libyaml` as a system dependency. `build-requires` also drops
`Text::CSV_XS`, which was no longer needed.

**`build-github` renamed to `builder`**

The script is no longer GitHub-specific. It supports any runner that
can execute a bash script in a container, and the GitHub coupling was
entirely in the name and comments. The `BUILDER` Makefile variable
defaults to `builder`.

**GitHub Actions workflow hardened**

The distributed `build.yml` now pre-installs `git` before the
checkout step (required for `actions/checkout` to create a proper
`.git` directory in a bare Debian container) and configures
`safe.directory` to prevent Git ownership errors in containerized
environments. The `dev` branch is added to the push trigger alongside
`main`.

**Makefile fixes**

Template targets (`test.t.tmpl`, `buildspec.yml.tmpl`) now handle a
missing share directory gracefully - `|| true` prevents `set -e`
from aborting the build and the `chmod` is applied to the correct
target. The `scan-deps` function switches from `YAML` to `YAML::Tiny`
for reading `buildspec.yml`. `LOG_LEVEL` is now passed to
`make-cpan-dist.pl` and is overridable from the command line.

**Release notes consolidated under `release-notes/`**

All historical release notes moved from the project root into a
`release-notes/` subdirectory.

---

## Dependencies

**Removed:** `YAML::XS`, `Text::CSV_XS`

**Added:** `YAML::Tiny 1.76`, `File::ShareDir`, `File::ShareDir::Install`

**Pinned:** `CPAN::Maker` to `1.9.0`
