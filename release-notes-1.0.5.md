## CPAN::Maker::Bootstrapper 1.0.5

*Released Wed Apr 15 2026*

### New Features

**`CPAN::Maker::ConfigReader` — promoted to first-class module**

`ConfigReader` is now a standalone module in its own distribution file
`lib/CPAN/Maker/ConfigReader.pm.in` with full POD documentation. It
reads configuration from any INI-format file — not just `.gitconfig` —
and resolves the config file in this order:

1. File argument passed to `new`
2. `CPAN_MAKER_CONFIG` environment variable
3. `~/.gitconfig`

Set it once in your shell profile to use a dedicated config file
across all projects:

```bash
export CPAN_MAKER_CONFIG=~/.cpan-makerrc
```

**`create-config` command**

A new bootstrapper command writes a fully commented configuration stub
to stdout, covering all supported options including the new quality
tool settings:

```bash
cpan-maker-bootstrapper create-config > ~/.cpan-makerrc
```

**`perl.mk` — Perl quality gates in the build system**

A new `perl.mk` file, owned by `.includes/`, takes over the `%.pm` and
`%.pl` pattern rules from the main `Makefile` and introduces optional
Perl quality tooling driven by `ConfigReader` and overridable from the
command line.

*Syntax checking* — `perl -wc` runs on every generated `.pm` and `.pl`
file when `SYNTAX_CHECKING` is set:

```bash
make SYNTAX_CHECKING=on
```

Or set it permanently in your config:

```ini
[cpan-maker]
syntax_checking = on
```

*`perltidy` and `perlcritic` stage gates* — when `perltidyrc` and/or
`perlcriticrc` are set in your config, the build enforces them as
stage gates using sentinel files (`.pm.tdy`, `.pm.crit`, `.pl.tdy`,
`.pl.crit`). Sentinels only rerun when source files change, keeping
incremental builds fast.

Quality gates run against the generated `.pm` and `.pl` files — not
the `.pm.in` sources — ensuring the filename/package name match that
`perlcritic` requires. Syntax checking runs first; tidy and critic
only run after a successful build.

All gates can be disabled individually or together:

```bash
make SYNTAX_CHECKING=off   # disable syntax checking
make PERLTIDYRC=""         # disable tidy gate
make PERLCRITICRC=""       # disable critic gate
make LINT=off              # disable all linting at once
make quick                 # disable scanning AND all linting
```

*Convenience targets* — `make tidy` runs `perltidy` against the
generated `.pm` and `.pl` files and updates the `.pm.in` and `.pl.in`
sources in place. `make critic` runs `perlcritic` against generated
files. `make lint` runs both. All three trigger a full build first to
ensure generated files are current before linting.

**`LINT=off` and `make quick`**

`LINT=off` disables all three quality gates — syntax checking, tidy,
and critic — regardless of individual settings. `make quick` disables
both dependency scanning and all linting for fast iterative builds:

```bash
make quick        # equivalent to: make SCAN=off LINT=off
```

**`PERLINCLUDE` and `PERLWC_SKIP`**

`PERLINCLUDE` defaults to `-I lib` plus any paths in
`$PERL5LIB`. Modules that cannot be loaded outside their runtime
environment (Apache handlers, mod_perl modules, etc.) can be exempted
from syntax checking via `PERLWC_SKIP` in `project.mk`:

```makefile
PERLWC_SKIP = lib/My/Apache/Handler.pm
```

**`.includes/` — managed build files move out of the project root**

All managed `.mk` files now live in `.includes/` rather than the
project root, reducing clutter and reinforcing their immutable
nature. Files in `.includes/` are write-protected by `make
update`. The project root retains only `Makefile` and `project.mk`.

**`project.mk` — distributed as a stub**

An empty `project.mk` stub is now distributed and installed into new
projects. This is the sanctioned extension point for custom targets,
inter-module dependencies, and project-specific variables. The
bootstrapper's own `project.mk` demonstrates the most important use
case:

```makefile
# inter-module dependencies - build ConfigReader before Bootstrapper
lib/CPAN/Maker/Bootstrapper.pm: lib/CPAN/Maker/ConfigReader.pm
```

### Bug Fixes

- Sentinel dependency chain corrected — sentinels now depend on `%.pm`
  rather than `%.pm.in`, ensuring `perlcritic` and `perltidy` run
  against correctly-named generated files, eliminating the
  filename/package false positive in `perlcritic`
- `TARBALL` variable moved before `all:` target — fixes a default goal
  evaluation ordering bug introduced in 1.0.4 where `tidy` became the
  default target when `perl.mk` was included early
- `.DEFAULT_GOAL := all` added as an explicit safety net against
  future include ordering issues
- `rm -f` added before `cp` in pattern rules to handle write-protected
  targets on rebuild

### Changes

- Pattern rules `%.pm` and `%.pl` moved from `Makefile` into `perl.mk`
- `git.mk` updated — `.includes/*` added to `RECOMMENDED_ARTIFACTS` so
  `make git` stages all managed build files in the initial commit
- `update.mk` updated — copies managed files into `.includes/` and
  write-protects them; `perl.mk` added to `MANAGED_FILES`
- `*.tdy`, `*.ERR`, `*.pm.tdy`, `*.pm.crit`, `*.pl.tdy`, `*.pl.crit`
  added to `CLEANFILES`
- POD substantially expanded — new QUICK START, WHY YOU SHOULD
  CONSIDER USING YET ANOTHER BUILD TOOL, INSTALLED PROJECT FILES, and
  FAQ sections added; WORKFLOW replaced by QUICK START

### Distribution

- `lib/CPAN/Maker/ConfigReader.pm.in` added as a new distribution file
- `share/perl.mk` added to dist share dir and `MANAGED_FILES`
- `share/project.mk` stub added to dist share dir
- `share/update.mk` and `share/upgrade.mk` moved to `.includes/` layout
- `*.tdy`, `*.ERR`, `*.pm.tdy`, `*.pm.crit`, `*.pl.tdy`, `*.pl.crit`
  added to `CLEANFILES`
  
