# CPAN::Maker::Bootstrapper 2.3.4 Release Notes

**Released:** Mon Sep 28 2026  
**Distribution:** CPAN-Maker-Bootstrapper  
**Author:** Rob Lauer \<rclauer@gmail.com\>

---

## Overview

This is a maintenance release focused on build system improvements,
documentation enhancements, and a fix to prevent `extra-files.skip`
from being overwritten during the `extra-files` target run.

---

## What's New

### `test-local` Extension Point

A new `test-local::` double-colon target has been added to the managed
`Makefile`. Projects may now define project-specific tests —
integration tests, infrastructure tests, or tests that exercise
generated artifacts — without including them in the CPAN
distribution's `t/` directory.

To extend `make test` with additional tests, add a `test-local::` rule
to `project.mk`:

```makefile
test-local::
    prove -I lib -v xt/
```

or:

```makefile
test-local::
    ./bin/test-integration
```

`make test` now runs both the distribution tests under `t/` and any
`test-local::` recipes defined in `project.mk`. The double-colon form
ensures that `project.mk` extends the managed target rather than
replacing it.

---

### `extra-files.skip` No Longer Overwritten

The `extra-files` Makefile target previously overwrote
`extra-files.skip` during its run. This has been corrected.

The `extra-files` target now respects a pre-existing
`extra-files.skip` file. Files listed in `extra-files.skip` are
excluded from the git-tracking verification check while remaining part
of the distribution. This is intended for generated build artifacts
that should not be committed to the repository.

**Format of `extra-files.skip`** — one file per line; blank lines and
lines beginning with `#` are ignored:

```
generated/service-data.dat
share/generated-index.json
```

> **Note:** `extra-files.skip` only disables the git tracking
> check. Files listed there remain part of the distribution and
> continue to be included as build dependencies for tarball rebuild
> determination.

---

### `make help` Now Documents Project-Specific Targets

`make help` lists available build targets and commonly used build
variables. Project-specific targets defined in `project.mk` are now
automatically included in the help output when the target definition
contains a `##` description comment:

```makefile
deploy: all ## deploy the distribution
    scp $(TARBALL) user@myserver:/opt/cpan
```

Because `project.mk` is included in `MAKEFILE_LIST`, there is no
separate help table to maintain.

---

## Documentation Updates

The POD in `lib/CPAN/Maker/Bootstrapper.pm.in` and the generated
`README.md` have received a number of improvements and corrections:

- **`make test`** — New section documenting the `test-local::`
  extension point, with worked examples.
- **`make help`** — New section describing how project-specific
  targets appear in help output.
- **`make package`** — Fixed a character encoding artifact in the
  description (mojibake `â€"` corrected to `-`).
- **`extra-files.skip`** — New FAQ section and expanded
  `buildspec.yml` documentation covering how to use `extra-files.skip`
  for generated artifacts.
- **`cmb extra-files`** — Clarified the command description and added
  documentation for removing entries via the `-` prefix, and noted
  that direct editing of `buildspec.yml` is the clearest approach for
  removal.
- **`project.mk` guidance** — Improved guidance on extending managed
  variables (`CLEANFILES +=` rather than redefining), corrected a typo
  in the `clean-local` example (`workd` → `workdir`), and added the
  `test-local::` extension example.
- **`resolve-vars` version example** — Updated inline version
  reference from `2.3.3` to `2.3.4`.
- **Reflowed several long prose paragraphs** for improved readability.

---

## Files Changed

| File | Change |
|------|--------|
| `Makefile` | Added `test-local::` target; updated `test` to depend on `test-local`; fixed `extra-files` to stop overwriting `extra-files.skip` |
| `lib/CPAN/Maker/Bootstrapper.pm.in` | POD updates (see Documentation Updates above) |
| `README.md` | Regenerated from updated POD |
| `VERSION` | Bumped to `2.3.4` |
| `cmb_md5sums.txt` | Regenerated to reflect updated `Makefile` |

---

## Upgrade Notes

Run `make update` in any project managed by `CPAN::Maker::Bootstrapper` to pull in the updated `Makefile` containing the `test-local` changes and the `extra-files.skip` fix.

```bash
make upgrade   # installs latest CPAN::Maker::Bootstrapper, then runs make update
# or
make update    # refreshes managed files from the currently installed bootstrapper
```

Review changes with `git diff` before committing.
