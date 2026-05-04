Here are the release notes for 1.0.4:

---

## CPAN::Maker::Bootstrapper 1.0.4

*Released Wed Apr 15 2026*

### New Features

**`update.mk` - keep project build files current**

A new `make update` target copies managed build files from the
currently installed bootstrapper distribution into your project
directory. After updating, use standard git tooling to review and
selectively accept changes:

```
make update
git diff
git checkout <file>   # revert any changes you don't want
```

The following files are managed and may be updated by `make update`:

```
Makefile
git.mk
help.mk
modulino.tmpl
release-notes.mk
update.mk
upgrade.mk
version.mk
```

Your `project.mk`, `buildspec.yml`, `requires`, `VERSION`, source
files and tests are never touched.

**`upgrade.mk` - keep the bootstrapper itself current**

Three new targets manage the bootstrapper's own lifecycle:

- `make check-upgrade` / `make upgrade-check` - queries MetaCPAN and
  reports whether a newer version of `CPAN::Maker::Bootstrapper` is
  available
- `make upgrade` - installs the latest version via `cpanm` then
  automatically runs `make update` to refresh project files in one
  step
- `make cpanm` - bootstraps `cpanminus` itself via `curl` if it is not
  already on your `PATH`, enabling the full self-upgrade path on a
  fresh system:

```
make cpanm && make upgrade
```

The version check uses a Perl snippet against the MetaCPAN API,
consistent with the build system's existing snippet pattern. A shared
`check_upgrade` shell snippet eliminates duplication between
`check-upgrade` and `upgrade`.

**`-include project.mk` - upgrade-safe build extension point**

The distributed `Makefile` now conditionally includes `project.mk` if
it exists. This is the sanctioned place for anything
project-specific - custom targets, inter-module dependencies,
additional file generation, project variables, and `CLEANFILES`
extensions. It is never touched by `make update`, making it fully
upgrade-safe.

### Documentation

A new **EXTENDING THE BUILD SYSTEM** section in the POD covers:

- Why the `Makefile` should be treated as immutable
- What belongs in `project.mk` with concrete examples
- What does not belong in `project.mk`
- The full lifecycle of `make update`, `make upgrade`, `make
  check-upgrade`, and `make cpanm`
- Using `git diff` and `git checkout` as the natural safety net for
  updates

### Distribution

- `update.mk` and `upgrade.mk` added to distribution and included in
  the installed `Makefile`
- `update.mk` and `upgrade.mk` added to `MANAGED_FILES` so they
  self-update on `make update`
