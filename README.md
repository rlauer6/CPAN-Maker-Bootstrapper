# NAME

CPAN::Maker::Bootstrapper - Scaffold a new CPAN distribution in one command

# SYNOPSIS

    # Create a new plain Perl module project
    cpan-maker-bootstrap --module My::New::Module

    # Create a CLI module project (inherits from CLI::Simple)
    cpan-maker-bootstrap --module My::New::CLI CLI_MODULE=1

    # Install into a specific directory
    cpan-maker-bootstrap --module My::Module --install-dir ~/git

    # Override git identity
    cpan-maker-bootstrap --module My::Module --username "Rob Lauer" --email rob@example.org

# DESCRIPTION

`CPAN::Maker::Bootstrapper` scaffolds a new CPAN distribution directory
ready to build immediately. It installs a project Makefile, a
`buildspec.yml` pre-populated from your git config, stub source and test
files, and supporting makefiles - then runs `make` to generate the initial
artifacts.

The result is a project that can produce a distributable tarball with a
single additional `make` invocation, with no manual editing required for
a standard project layout.

# WORKFLOW

1. **Scaffold the project**:

        cpan-maker-bootstrap --module My::New::Module

    This creates `My-New-Module/` (or the directory specified by
    `--install-dir`), copies the scaffold files, and runs `make
    MODULE_NAME=My::New::Module` to generate the initial source and
    test stubs.

2. **Review the generated files** - particularly `buildspec.yml`, which
controls how `make-cpan-dist.pl` builds the distribution. Your git
identity is filled in automatically but you may want to adjust the
description or resource URLs before committing.
3. **Implement your module** - edit the generated stub in `lib/` and add
your dependencies to `cpanfile` (if needed).
4. **Build the distribution**:

        make

    This auto-generates `requires` and `test-requires` via
    `scandeps-static.pl`, generates `README.md` from your POD via
    `pod2markdown`, and builds the tarball via `make-cpan-dist.pl`.

# INSTALLED PROJECT FILES

The following files are installed into the project directory:

- `Makefile` - the complete build system. Derives all paths and
names from `MODULE_NAME`. See ["THE PROJECT MAKEFILE"](#the-project-makefile).
- `buildspec.yml` - generated from the template, pre-populated
with your module name, git identity, GitHub username, and project URLs.
- `lib/<Module/Path>.pm.in` - stub module, populated from
either `class-module.pm.tmpl` (default) or `cli-module.pm.tmpl` (when
`CLI_MODULE=1` is set). Contains package declaration, `$VERSION`,
and a POD skeleton with your name and email from git config.
- `t/00-<project-name>.t` - minimal smoke test that calls
`use_ok` on your module.
- `version.mk` - provides `make release`, `make minor`,
`make major` version bump targets.
- `release-notes.mk` - provides `make release-notes` to generate
a diff and file list against the previous tagged version.
- `ChangeLog` - empty placeholder, required by the distribution.

# THE PROJECT MAKEFILE

The installed Makefile is self-configuring. The only value it requires is
`MODULE_NAME`, and it derives everything else:

    MODULE_PATH  - lib/My/New/Module.pm (from MODULE_NAME)
    PROJECT_NAME - My-New-Module (from MODULE_NAME)
    TARBALL      - My-New-Module-1.0.0.tar.gz (from PROJECT_NAME + VERSION)

If `MODULE_NAME` is not supplied on the command line, it is inferred
from the project directory name.

Key Makefile targets:

- `make` / `make all`

    Builds the distribution tarball. Generates `requires`,
    `test-requires`, and `README.md` as prerequisites.

- `make requires` / `make test-requires`

    Scans source files with `scandeps-static.pl` and writes the dependency
    files used by `buildspec.yml`.

- `make release` / `make minor` / `make major`

    Bumps the patch, minor, or major version number in `VERSION`.

- `make release-notes`

    Generates a diff, file list, and tarball comparing the current version
    to the previous git tag.

- `make clean`

    Removes generated files. Does not affect `buildspec.yml`, `VERSION`,
    or any `*.in` source files.

# OPTIONS

- `--module|-m` MODULE (required)

    The Perl module name for the new project, e.g. `My::New::Module`.
    Used to derive the project directory name, source file path, and tarball
    name.

- `--install-dir|-i` DIR

    Directory in which to create the project. Defaults to the current working
    directory. The directory is created if it does not exist.

- `--username|-u` NAME

    Override the author name used in the module stub and `buildspec.yml`.
    Defaults to `user.name` from your global git config.

- `--email|-e` EMAIL

    Override the author email. Defaults to `user.email` from your global
    git config.

- `--github-user|-g` USER

    Override the GitHub username used to construct repository URLs in
    `buildspec.yml`. Defaults to `user.github` from your global git config.

- `--force|-f`

    Overwrite an existing project. Without this flag, the command dies if a
    `Makefile` already exists in the target directory.

# PREREQUISITES

The following tool(s) must be on your `PATH`:

- `git` - used to read global identity config

# SEE ALSO

[CPAN::Maker](https://metacpan.org/pod/CPAN%3A%3AMaker) - the distribution builder driven by `buildspec.yml`

[CLI::Simple](https://metacpan.org/pod/CLI%3A%3ASimple) - the CLI framework used by the bootstrapper itself and
optionally by generated CLI module stubs

[CPAN::Maker::GitConfigReader](https://metacpan.org/pod/CPAN%3A%3AMaker%3A%3AGitConfigReader) - the git config reader bundled with
this distribution, available for use in your own tools

# AUTHOR

Rob Lauer - <rlauer6@comcast.net>

# LICENSE

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
