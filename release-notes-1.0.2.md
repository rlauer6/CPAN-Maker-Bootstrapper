## CPAN::Maker::Bootstrapper 1.0.2

*Released Fri Apr 10 2026*

### New Features

**Modulino support** - a new `make modulino` target generates a bash
wrapper script in `bin/` that invokes your module as a command-line
script using the modulino pattern (`caller or __PACKAGE__->main`). The
generated script name is automatically added to `.gitignore` if that
file exists. A `modulino.tmpl` template is now distributed with the
package.

**Dependency management overhaul** - the `requires` and
`test-requires` targets now preserve user-controlled entries across
rescans. Two new mechanisms are supported:

- Prefix a module name with `+` to make the entry sticky - it will
  survive all subsequent rescans even if the scanner no longer detects
  it
- Manually set a version number to pin it - if the scanner detects a
  different version on a subsequent scan, your pinned version is
  preserved

**Skip file support** - create a `requires.skip` or
`test-requires.skip` file to permanently exclude modules from the
scanned dependency list. Useful for modules the scanner incorrectly
picks up, or sub-modules already pulled in transitively.

**POD handling** - two new `make` options control POD in your
distributed modules:

- `make POD=extract` - strips POD from the `.pm` file and writes it to
  a separate `.pod` file included in the distribution
- `make POD=remove` - strips POD from the `.pm` file with no `.pod` output

**`SCAN` variable renamed** - `CPAN_MAKER_SCAN` is now `SCAN`. The
check is case-insensitive, so `make SCAN=off` works as expected.

### Improvements

- Script targets in the Makefile are now scoped to `bin/` for clarity
  and safety
- `requires` and `test-requires` output is now sorted for stable diffs
- `MODULE_NAME` inference now uses `SOURCE` environment variable for
  better compatibility
- `.gitignore` cleaned up - removed unrelated Lambda/AWS project
  artifacts, added `bin/cpan-maker-bootstrapper`
- Command renamed from `cpan-maker.sh` to `cpan-maker-bootstrapper`
  throughout
- POD substantially expanded covering dependency management,
  modulinos, skip files, POD stripping, and first-run behavior
- `--basedir` / `--installdir` relationship clarified in documentation
- `make` added to PREREQUISITES

### Bug Fixes

- `scan-deps` internal variable renamed from `requires` to
  `dep_requires` to eliminate collision with the make target name
- Trap cleanup in `requires`/`test-requires` targets now correctly
  unquotes `$cleanfiles` so all temp files are actually removed
- Trailing space removed from package name capture in `scan-deps`

### Distribution

- `modulino.tmpl` and `.gitignore` added to MANIFEST and distributed
  with the package
- `requires.skip` added to suppress sub-module entries
  (`CLI::Simple::Constants`, `CLI::Simple::Utils`) that are already
  covered by `CLI::Simple`
- `+CPAN::Maker` and `+Pod::Markdown` pinned in `requires`
