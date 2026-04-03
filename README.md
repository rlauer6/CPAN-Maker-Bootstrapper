# NAME

CPAN::Maker::Bootstrapper - Scaffold a new CPAN distribution in one command

# SYNOPSIS

    # Create a new plain Perl module project
    cpan-maker.sh --module My::New::Module

    # Create a CLI module project (inherits from CLI::Simple)
    cpan-maker.sh --module My::New::CLI --stub cli

    # Use a custom stub
    cpan-maker.sh --module My::Module --stub /path/to/mystub.pm

    # Install into a specific directory
    cpan-maker.sh --module My::Module --installdir ~/git

    # Override git identity
    cpan-maker.sh --module My::Module --username "Rob Lauer" --email rob@example.org

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

`cpan-maker.sh` will read your global `.gitconfig` file to populate
some of options used when creating a distribution. If you have a
GitHub user account add your username:

    git config --global user.github <your-username>

If you typically create projects in one directory, add the `basedir`
option:

    git config --global cpan-maker.basedir $HOME/git

# WORKFLOW

1. **Scaffold the project**:

        cpan-maker.sh --module My::New::Module

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

4. **Implement your module** - edit the generated stub in `lib/` and add
your dependencies to `cpanfile` (if needed).
5. **Build the distribution**:

        make

    This auto-generates `requires` and `test-requires` via
    `scandeps-static.pl`, generates `README.md` from your POD via
    `pod2markdown`, and builds the tarball via `make-cpan-dist.pl`.

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
    significant delay to when you have many modules and a large number of
    dependencies. You can avoid the scan by setting the environment
    variable `CPAN_MAKER_SCAN` to any value other than 'ON'._

        make CPAN_MAKER_SCAN=OFF

- `make release` / `make minor` / `make major`

    Bumps the patch, minor, or major version number in `VERSION`.

- `make release-notes`

    Generates a diff, file list, and tarball comparing the current version
    to the previous git tag.

- `make clean`

    Removes generated files. Does not affect `buildspec.yml`, `VERSION`,
    or any `*.in` source files.

# OPTIONS

- `--basedir|-b` DIR

    Base directory in which to create the projects. Defaults to the
    current working directory when `--installdir` and `--basedir` are not
    provided. The directory must exist or the script will throw an
    exception.

    _Note: The `--basedir` option is used when you do not provide an
    `--installdir` option. They are mutually exclusive._

    default: pwd

- `--module|-m` MODULE (required)

    The Perl module name for the new project, e.g. `My::New::Module`.
    Used to derive the project directory name, source file path, and
    tarball name. You can omit this option if you provide a stub file
    (`--stub path`) that contains a package name that is consistent with
    the stub's path. For example, if my package is `My::App` and the
    module's path contains `My/App` then the script will assume your
    module name is `My::App`.

        cpan-maker.sh --stub $HOME/workdir/My/App.pm

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
