# Release Notes — CPAN::Maker::Bootstrapper 2.2.2

**Released:** Fri Aug 14 2026
**Author:** Rob Lauer &lt;rclauer@gmail.com&gt;

---

## Overview

This is a patch release focused on developer experience improvements
and a correctness fix in the dependency scanner. No new features or
breaking changes are introduced.

---

## Bug Fixes

### `CreateDeps`: Ignore Temporary Files During Module Discovery

**File:** `lib/CPAN/Maker/Bootstrapper/Role/CreateDeps.pm.in`

The `find_modules` subroutine previously matched against the full path
(`$File::Find::name`) when filtering files, which could cause it to
inadvertently miss temporary editor files (e.g. Emacs-style `#file#`
or `.#file` lockfiles) that satisfied the `.pm.in` / `.pl.in` filename
pattern. The fix splits this into two distinct guards:

```perl
# Before
return if $File::Find::name !~ /[.]p[ml][.]in$/xsm;

# After
return if !/[.]p[ml][.]in$/xsm;
return if /^[.]?[#]/xsm;  # ignore temp files
```

- The extension check now tests `$_` (the bare filename) directly,
  which is the correct variable for `File::Find` filename filtering.
- A new guard explicitly skips filenames beginning with `#` or `.#`,
  preventing temporary editor swap files from being picked up as
  source modules during dependency graph generation.

---

## Build System Improvements

### Show Build Log on Failure (`cpm`)

**File:** `.includes/local.mk`

The `cpm install` invocation now includes the
`--show-build-log-on-failure` flag. When a dependency fails to
install, the full build log is printed automatically, making it
significantly easier to diagnose the root cause without having to
locate and inspect log files manually.

```makefile
# Before
cpm install -L local "$${resolvers[@]}"

# After
cpm install -L local "$${resolvers[@]}" --show-build-log-on-failure
```

### Removed Redundant Installer Info Message

**File:** `Makefile`

The informational message that was printed on every `make` invocation
announcing which CPAN installer was detected has been removed. This
message appeared unconditionally (unless suppressed by
`MAKE_RESTARTS`) and provided no actionable information during normal
builds. The warning for a missing installer (`no cpm/carton found`) is
retained, with a minor fix to use standard ASCII dashes (`--`) in
place of a non-ASCII character that could cause display issues in some
terminals.

```makefile
# Before
$(warning no cpm/carton found â set SYNTAX_CHECKING=off if builds fail to find dependencies)

# After
$(warning no cpm/carton found -- set SYNTAX_CHECKING=off if builds fail to find dependencies)
```

---

## Documentation

- `README.md` regenerated from POD, reflecting the updated version (`2.2.2`).
- `VERSION` bumped to `2.2.2`.

---

## Upgrade Notes

This release is fully backwards-compatible. Run `make update` in
existing projects to pull in the updated `.includes/local.mk`:

```bash
make update
```

No changes to `buildspec.yml`, `requires`, or any project source files
are required.
