# CPAN::Maker::Bootstrapper 2.0.12 Release Notes

**Released:** Tue Jul 21 2026  
**Author:** Rob Lauer &lt;rclauer@gmail.com&gt;

---

## Overview

Version 2.0.12 is a build system refinement release focused on
simplifying the GNU Make dependency graph, improving dependency
scanning performance via batched scanning, and adding convenience
targets for packaging and installation. No public API changes were
made to the Perl module interface.

---

## What's New

### `make package` Target

A new `package` phony target has been added to `Makefile` as the
recommended final step before publishing a release. It performs a
clean build with full linting and scanning enabled:

```
make package
```

This is equivalent to:

```sh
make clean && make LINT=on SCAN=on
```

### `make install` Target (`project.mk`)

A new `install` target installs the built distribution tarball into `$HOME` using `cpanm`:

```make
install: $(TARBALL)
    cpanm -n -v -l $(HOME) $<
```

---

## Build System Changes (`.includes/perl.mk`)

### Templating and Syntax Checking Reunified

The previously separate templating (`%.pm` / `%.pl`) and
syntax-checking (`%.pm.checked` / `%.pl.checked`) phases have been
**combined back into a single pattern rule**. The earlier split was a
workaround for a `deps.mk` chicken-and-egg problem that is now
resolved at the source (see below).

- The `%.pm.checked` and `%.pl.checked` sentinel files have been
  **removed** entirely, along with their entries in `CLEANFILES`.
- `check-syntax` is now a convenience alias that simply depends on
  `$(PERL_MODULES)` and `$(PERL_BIN_FILES)` — no separate pass is
  needed.
- The `.PRECIOUS: %.pm %.pl` declaration has been removed as it is no
  longer required.

### Syntax Checks Now Operate on the Built Target (`$@`)

`check_syntax_pm` and `check_syntax_pl` were previously checking `$<`
(the `.pm.in` / `.pl.in` source file). They now correctly operate on
`$@` (the built `.pm` / `.pl` target), which is the file that has been
through version-token substitution and POD processing.

### `trap` Cleanup Moved to Pattern Rules

The `trap 'rm -f $$local_cleanfiles' EXIT` guard was removed from
`check_syntax_pm` and `check_syntax_pl` (where it was redundant) and
is now owned exclusively by the pattern rules (`%.pm` and `%.pl`) that
set up `local_cleanfiles`.

### `deps.mk` Include is Now Unconditional

The `ifeq ($(filter clean distclean,...))` guard around `-include
deps.mk` has been **removed**. Previously this guard was required
because `deps.mk` depended on the built `.pm` targets, which would
cause `make clean` to build every module just to immediately delete
it. Now that `deps.mk` depends on source (`.pm.in` / `.pl.in`) files,
`make clean` can never trigger a spurious rebuild, so the guard is
unnecessary.

---

## Dependency Scanning Improvements (`Makefile`)

### Batched Scanning via `--file-list`

The `scan-deps` macro now uses the new `--file-list` batch feature of
`scandeps-static.pl` rather than invoking the scanner once per
file. All source files are collected into a temporary list and scanned
in a single invocation:

```makefile
$(SCANDEPS) -r $$min_perl_version --file-list file_list.tmp --no-core | ...
```

This significantly reduces overhead when projects contain many modules.

### Minimum Required Version: `Module::ScanDeps::Static` 1.9.0

The minimum required version of `Module::ScanDeps::Static` has been
raised from `1.8.2` to `1.9.0` to support the `--file-list` option
used by the batched scanning feature.

Updated in `cpanfile`, `requires`, and the `cpanfile` dependency declaration.

---

## `deps.mk` Dependency Graph Fix (`Makefile`)

`deps.mk` now depends on **source** files rather than built targets:

```makefile
# Before
deps.mk: $(PERL_MODULES)

# After
deps.mk: $(SOURCE_FILES:%=%.in)
```

This eliminates the historical chicken-and-egg problem where `deps.mk`
needed built `.pm` files to regenerate, but `.pm` files needed
`deps.mk` to determine correct build order. The `cmb create-deps`
command already scans `.pm.in` files directly, so depending on source
is both correct and sufficient.

---

## `CreateDeps` Role Enhancements

### Discovers `.pl.in` Files in Addition to `.pm.in`

`find_modules` now matches both `.pm.in` and `.pl.in` files:

```perl
# Before
return if $File::Find::name !~ /[.]pm[.]in$/xsm;

# After
return if $File::Find::name !~ /[.]p[ml][.]in$/xsm;
```

### Targeted Dependency Output

`cmd_create_deps` now accepts optional file arguments. When one or
more files are provided as arguments, only dependency recipes for
those specific files are emitted:

```sh
cmb create-deps lib/My/Module.pm.in
```

When called without arguments, all dependency recipes are emitted as before.

---

## Dependency Changes

| Package | Previous | New |
|---|---|---|
| `Module::ScanDeps::Static` | 1.8.2 | **1.9.0** |

---

## Files Changed

| File | Change |
|---|---|
| `.includes/perl.mk` | Unified templating + syntax check; `$<` → `$@`; removed sentinels and guards |
| `Makefile` | Batched scan-deps; `deps.mk` depends on `.in` sources; new `package` target |
| `project.mk` | New `install` target |
| `lib/CPAN/Maker/Bootstrapper/Role/CreateDeps.pm.in` | Find `.pl.in`; targeted output in `cmd_create_deps` |
| `cpanfile` | `Module::ScanDeps::Static` → 1.9.0 |
| `requires` | `Module::ScanDeps::Static` → 1.9.0 |
| `VERSION` | 2.0.11 → 2.0.12 |
| `README.md` | Regenerated from POD |

---

## Upgrade Notes

Run `make update` in existing projects after upgrading to refresh the
managed `.includes/perl.mk` file. The removal of `%.pm.checked` and
`%.pl.checked` sentinel files means any `CLEANFILES` entries
referencing them in older `project.mk` files can be removed, though
they will not cause errors if left in place.
