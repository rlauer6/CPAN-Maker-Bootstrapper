## CPAN::Maker::Bootstrapper 1.0.3

*Released Tue Apr 14 2026*

### New Features

**`--import` option** — import existing Perl modules and scripts into
a new distribution without starting from scratch. Pass one or more
directories containing `.pm` or `.pl` files and they will be copied
into the project as `.pm.in` / `.pl.in` files with directory structure
preserved. Package names are validated against file paths during
import. Multiple paths are supported:

```
cpan-maker-bootstrapper --module Foo::Bar -I ~/foo-bar/lib -I ~/foo-bar/bin
```

Note that `--import` and `--stub` are mutually exclusive.

**`--resources` option** — automatically generate a `resources.yml`
file populated with GitHub URLs for the bugtracker, repository, and
homepage. The file is appended to `buildspec.yml` during the
build. Currently supports `github` as the only provider:

```
cpan-maker-bootstrapper --module Foo::Bar --resources github
```

**`--config` option** — specify an alternative INI-format
configuration file instead of the default `~/.gitconfig`. Useful for
users without git or who want a separate CPAN-Maker-specific config:

```
cpan-maker-bootstrapper --module Foo::Bar --config ~/.cpan-makerrc
```

**`make git`** — new target distributed via `git.mk` that initializes
a git repository, stages the recommended project artifacts, renames
the branch to `main`, and makes an initial "BigBang" commit.

**`make help`** — new target distributed via `help.mk` that displays
all available targets with descriptions and a summary of key
variables.

**`make modulino MODULINO_NAME=Foo::Bar`** — the `modulino` target now
accepts a `MODULINO_NAME` variable to generate a wrapper for a module
other than the primary `MODULE_NAME`.

### Improvements

- `README.md` generation now supports two modes: if `README.md.in`
  exists it is processed through `md-utils.pl`; otherwise POD is
  converted via `pod2markdown` with an auto-generated table of
  contents prepended
- `CPAN::Maker::GitConfigReader` renamed to
  `CPAN::Maker::ConfigReader` to reflect that it now reads any
  INI-format file, not just `.gitconfig`. `GitConfigReader` is
  retained as an alias for backward compatibility
- `_init_git_config` renamed to `_init_config` to match the broader
  scope
- `buildspec.yml` recipe now uses a temp file and safely appends
  `resources.yml` only if present, then cleans up
- Module name validation added — invalid Perl module names are caught
  before any files are created on disk
- Options in `main` sorted alphabetically for readability
- `YAML::XS` added as a dependency for `resources.yml` generation
- `.gitignore` distributed as `gitignore` in MANIFEST to avoid CPAN
  tooling issues with dotfiles

### `make help` Coverage

All targets across `Makefile`, `git.mk`, `help.mk`, `version.mk`, and
`release-notes.mk` now carry `##` annotations and appear in `make
help` output.

### Distribution

- `git.mk` and `help.mk` added to MANIFEST and distributed with the package
- `YAML::XS` added to `requires`
