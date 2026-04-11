# NAME

CPAN::Maker::Bootstrapper - Scaffold a new CPAN distribution in one command

# SYNOPSIS

    # Create a new plain Perl module project
    cpan-maker-bootstrapper --module My::New::Module

    # Create a CLI module project (inherits from CLI::Simple)
    cpan-maker-bootstrapper --module My::New::CLI --stub cli

    # Use a custom stub
    cpan-maker-bootstrapper --module My::Module --stub /path/to/mystub.pm

    # Install into a specific directory
    cpan-maker-bootstrapper --module My::Module --installdir ~/git

    # Override git identity
    cpan-maker-bootstrapper --module My::Module --username "Rob Lauer" --email rob@example.org

# DESCRIPTION

`CPAN::Maker::Bootstrapper` scaffolds a new CPAN distribution directory
ready to build immediately. It installs a project Makefile, a
`buildspec.yml` pre-populated from your git config, stub source and test
files, and supporting makefiles - then runs `make` to generate the initial
artifacts.

The result is a project that can produce a distributable tarball with a
single additional `make` invocation, with no manual editing required for
a standard project layout.

# SETUP

`cpan-maker-bootstrapper` will read your global `.gitconfig` file to populate
some of the options used when creating a distribution. If you have a
GitHub user account add your username:

    git config --global user.github <your-username>

If you typically create projects in one directory, add the `basedir`
option:

    git config --global cpan-maker.basedir $HOME/git

# WORKFLOW

1. **Scaffold the project**:

        cpan-maker-bootstrapper --module My::New::Module

    This creates `My-New-Module/` in the directory specified by
    `--basedir` (or the directory specified by `--installdir`), copies
    the scaffold files, and runs `make MODULE_NAME=My::New::Module` to
    generate the initial source and test stubs.

2. **Review the generated files** - particularly `buildspec.yml`, which
controls how `make-cpan-dist.pl` builds the distribution. Your git
identity is filled in automatically but you may want to adjust the
description or resource URLs before committing.
3. **Add new components** - as your project grows, add new modules to
`lib/` and scripts to `bin/` as `.pm.in` and `.pl.in` files
respectively. The Makefile discovers them automatically via
`find-files` - no manual changes to the Makefile are required. Any
new `.pm.in` or `.pl.in` file will trigger a dependency rescan on
the next `make` and be included in the distribution automatically.

    Similarly, add new test files to `t/` as `.t` files. They will be
    picked up automatically by `make test-requires` and included in the
    distribution.

4. **Implement your module** or edit the generated stub in `lib/`. The
scanner will detect most dependencies automatically on the next
`make`; see ["Dependencies"](#dependencies) for how to manage entries the scanner
misses or gets wrong. Review the generated `requires` and
`test-requires` files.
5. **Build the distribution**:

        make

    This auto-generates `requires` and `test-requires` via
    `scandeps-static.pl`, generates `README.md` from your POD via
    `pod2markdown`, and builds the tarball via `make-cpan-dist.pl`.

See ["Pod Stripping"](#pod-stripping) if you want to strip or extract POD from your
modules before packaging.

# INSTALLED PROJECT FILES

The following files are installed into the project directory:

- `Makefile` - the complete build system. Derives all paths and
names from `MODULE_NAME` or your stub file's package name. See ["THE
PROJECT MAKEFILE"](#the-project-makefile).
- `buildspec.yml` - generated from the template, pre-populated
with your module name, git identity, GitHub username, and project URLs.
- `lib/<Module/Path>.pm.in` - stub module, populated from
either `class-module.pm.tmpl` (default) or `cli-module.pm.tmpl` (when
`--stub cli` option is used). Contains package declaration, `$VERSION`,
and a POD skeleton with your name and email from git config.

    _Note: All source files in `lib/` and `bin/` use the `.pm.in` / `.pl.in`
    convention. These are the files you edit. The `.pm` and `.pl` files are
    derived from them by the pattern rules in the Makefile, which substitute
    `@PACKAGE_VERSION@` with the current value of `VERSION`. Never edit the
    generated `.pm` or `.pl` files directly - your changes will be
    overwritten the next time `make` runs!_

- `t/00-<project-name>.t` - minimal smoke test that calls
`use_ok` on your module.
- `version.mk` - provides `make release`, `make minor`,
`make major` version bump targets.
- `release-notes.mk` - provides `make release-notes` to generate
a diff and file list against the previous tagged version.
- `ChangeLog` - empty placeholder, required by the distribution.

# THE PROJECT MAKEFILE

The installed Makefile is self-configuring. It can derive everything
from `MODULE_NAME` or the package name inside a custom stub file.

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
    files specified in the `buildspec.yml` file used by `make-cpan-dist.pl`.

    _Note: By default, any change to your `.pm.in` files will trigger a
    rescan of your modules for new dependencies. This will add a
    significant delay when you have many modules and a large number of
    dependencies. You can avoid the scan by setting the environment
    variable `SCAN` to any value other than `ON` (case insensitive)._

        make SCAN=OFF

- `make release` / `make minor` / `make major`

    Bumps the patch, minor, or major version number in `VERSION`.

- `make release-notes`

    Generates a diff, file list, and tarball comparing the current version
    to the previous git tag.

- `make clean`

    Removes generated files. Does not affect `buildspec.yml`, `VERSION`,
    or any `*.in` source files.

# USAGE

    cpan-maker-bootstrapper options

## Options

- `--basedir|-b` DIR

    Base directory in which to create the projects. Defaults to the
    current working directory when `--installdir` and `--basedir` are not
    provided. The directory must exist or the script will throw an
    exception.

    _Note: If `--installdir` is provided it takes precedence and
    `--basedir` is ignored._

    default: pwd

- `--module|-m` MODULE (required)

    The Perl module name for the new project, e.g. `My::New::Module`.
    Used to derive the project directory name, source file path, and
    tarball name. You can omit this option if you provide a stub file
    (`--stub path`) that contains a package name that is consistent with
    the stub's path. For example, if my package is `My::App` and the
    module's path contains `My/App` then the script will assume your
    module name is `My::App`.

        cpan-maker-bootstrapper --stub $HOME/workdir/My/App.pm

- `--installdir|-i` DIR

    Directory in which to create the project. Defaults to the current working
    directory. The directory is created if it does not exist.

    _Note: `--installdir` overrides `--basedir`_.

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

- `--stub|-s` TYPE|PATH

    Controls the module stub used to generate the initial `.pm.in` source
    file. Three forms are accepted:

    - Omitted - uses the default plain class stub (`class-module.pm.tmpl`).
    - `cli` - uses the CLI stub (`cli-module.pm.tmpl`), which
    inherits from [CLI::Simple](https://metacpan.org/pod/CLI%3A%3ASimple) and includes a skeleton `main`, `init`,
    and a placeholder command.
    - A file path - uses the specified file as the stub. The file
    must exist or the command will die with an error. This allows you to
    supply your own template or bootstrap a project around a module you
    have already started writing. You can omit the `--module` option if
    you supply your own stub file. See the explanation for the
    `--module` option for details.

## Notes

- **Dependencies**

    The `Makefile` will attempt to detect Perl module dependencies by
    scanning .pm.in and .pl.in files and creating the `requires` and
    `test-requires` files whenever you run `make`. These files are used
    by the `make-cpan-dist.pl` utility to specify the dependencies in your
    CPAN distribution file. You can prevent that by setting the environment
    variable `SCAN=OFF`. The default is `SCAN=ON`.

    To prevent an entry from being removed by a rescan, prefix the module
    name with `+`. These entries are sticky and survive all subsequent
    scans even if the scanner no longer detects them.  To pin a specific
    version, simply edit the version number in the `requires` file. If
    the scanner subsequently detects a different version, the Makefile
    will preserve your pinned version. Note that pinned versions are
    **never** updated automatically - if you want to adopt a newer version
    you must edit the file manually.

    In your requires file:

        +Foo::Bar 1.0    # sticky - survives all rescans
        Baz::Qux  2.5   # version pinned - scanner won't override this version

    _Note: These two mechanisms are independent - `+` controls whether an entry
    survives rescans, while the version number controls what version is
    required._

- **Pod Stripping**

    When you package your CPAN distribution you can strip the pod from
    your modules or you can extract the pod and provide them as separate
    `.pod` files. There are two `make` environment variables you can set
    to control that behavior.

    - `make POD=extract`

        `extract` will strip POD from your module and create a `.pod` file
        containing the stripped POD that will be added to your distribution.

    - `make POD=remove`

        `remove` will strip POD from your module. No POD will be included in
        the distribution.

- **Skip File**

    Add a `requires.skip` file to exclude modules from the scanned
    list. Sometimes the scanner may include modules that are optional or
    modules you just don't want to include as requirements because they
    are already included in a module you have already required.

    Similarly, `test-requires.skip` excludes modules from the test
    dependency scan.

    On a clean first run neither `requires` nor `test-requires` exists
    yet, so the raw scanner output becomes the dependency file - meaning
    skip list and pins have no effect until the second run.

- **Modulinos**

    A modulino is a Perl file that doubles as a runnable script. The bash
    script produced by `make modulino` is the wrapper that invokes it.

        package Foo;

        caller or __PACKAGE__->main;

        sub main {
          ...
          exit 0;
        }

    Modulinos are useful when writing command line scripts for various reasons:

    - Aids creation of unit tests
    - Encourages use of OO principles like encapsulation
    - Helps organize your script into useful methods

    Modulinos are invoked with a pattern like:

        #!/usr/bin/env bash
        perl $(perl -MFoo -e 'print $INC{q{Foo}};') "$@"

    `CPAN::Maker::Bootstrapper`'s `Makefile` supports a PHONY target
    **modulino** that will produce a bash script that invokes your
    modulino. If your Perl module that implements your modulino were named `Foo::Bar`...

        make modulino

    ...would produce a bash script in `bin/` named `foo-bar.in`. `make`
    will then build `bin/foo-bar` from `bin/foo-bar.in` via a pattern
    rule producing the executable that ends up in the distribution.

    _Note: The generated modulino is added to the `.gitignore` file if
    it exists._

# PREREQUISITES

The following tool(s) must be on your `PATH`:

- `git` - used to read global identity config
- `make` - GNU make is required to build the project

# SEE ALSO

[CPAN::Maker](https://metacpan.org/pod/CPAN%3A%3AMaker) - the distribution builder driven by `buildspec.yml`
(includes `make-cpan-dist.pl`)

[CLI::Simple](https://metacpan.org/pod/CLI%3A%3ASimple) - the CLI framework used by the bootstrapper itself and
optionally by generated CLI module stubs

[CPAN::Maker::GitConfigReader](https://metacpan.org/pod/CPAN%3A%3AMaker%3A%3AGitConfigReader) - the git config reader bundled with
this distribution, available for use in your own tools

# AUTHOR

Rob Lauer - <rlauer@treasurersbriefcase.com>

# LICENSE

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
