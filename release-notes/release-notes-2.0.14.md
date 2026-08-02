# CPAN::Maker::Bootstrapper 2.0.14 Release Notes

**Released:** Sun Aug 2, 2026  
**Author:** Rob Lauer <rclauer@gmail.com>

---

## Overview

This is a maintenance release focused on build system hygiene. No
functional changes were made to the bootstrapper's runtime behavior or
its commands. All changes are internal to the `Makefile` and affect
only how intermediate build artifacts are managed during the
dependency resolution and `deps.mk` regeneration phases.

---

## Changes

### Makefile — Intermediate File Declarations

Two sets of build targets are now declared as `.INTERMEDIATE`,
instructing GNU Make to treat them as temporary files that may be
deleted once their dependents have been built:

- **`.INTERMEDIATE: requires.raw recommends.raw suggests.raw test-requires.raw`**  
  The raw scanner output files produced by `scandeps-static` are now
  properly declared as intermediates. These files have always been
  transitional — they exist only to feed the `cmb filter` step that
  produces the final `requires`, `recommends`, `suggests`, and
  `test-requires` files — and are now cleaned up automatically by Make
  rather than persisting on disk.

- **`.INTERMEDIATE: cpanfile.requires cpanfile.suggests cpanfile.recommends`**  
  Similarly, the per-section `cpanfile.*` fragments generated before
  being merged into the final `cpanfile` are now declared intermediate
  and will be removed automatically after the merge step completes.

### Makefile — `cpanfile` Recipe Cleanup

The `cpanfile` recipe previously used a `trap 'rm -f $+'` to clean up
the intermediate fragment files on exit. That manual cleanup is now
redundant given the `.INTERMEDIATE` declarations above and has been
removed, simplifying the recipe.

### Makefile — `deps.mk` Source Dependency Fix

The `deps.mk` target previously depended on `$(SOURCE_FILES:%=%.in)`
(the `.pm.in` source files with an extra `.in` suffix appended, which
was incorrect). It now correctly depends on `$(SOURCE_FILES)` directly
— the actual `.pm.in` and `.pl.in` source files. This ensures
`deps.mk` is regenerated whenever a source file changes, without
requiring build artifacts to exist first, and prevents spurious
rebuilds triggered by non-existent translated filenames.

---

## What's Not Changed

- No changes to any bootstrapper commands (`install`, `code-review`,
  `pod-review`, `annotate`, `release-notes`, etc.)
- No changes to installed project files, templates, or `.includes/` managed files
- No dependency additions or removals

---

## Upgrade

```bash
cpanm CPAN::Maker::Bootstrapper
make update
```

After upgrading, run `make update` in any existing bootstrapped
project to pull in the updated `Makefile`.

---

## Previous Release

See [2.0.13 release notes](release-notes/release-notes-2.0.13.md) for the prior release.
