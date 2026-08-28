# Release Notes: CPAN::Maker::Bootstrapper 2.3.1

**Released:** Fri Aug 28 2026  
**Author:** Rob Lauer &lt;rclauer@gmail.com&gt;

---

## Overview

This is a patch release delivering two focused improvements: a new
`version` command and a bug fix in the dependency filter that
prevented blank lines in `requires`-style files from being handled
gracefully.

---

## What's New

### New `version` Command

A new `version` command has been registered in the bootstrapper's
command dispatch table, backed by the new
`CPAN::Maker::Bootstrapper::Role::Version` role.

```yaml
# cpan-maker-bootstrapper.yml
version: CPAN::Maker::Bootstrapper::Role::Version
```

This provides a dedicated command interface for version-related
operations via `cmb version`.

---

## Bug Fixes

### Filter Role: Blank Lines in Requires Files No Longer Cause Parse Errors

**File:** `lib/CPAN/Maker/Bootstrapper/Role/Filter.pm.in`

The `_fetch_requires` method previously attempted to `split` every
line read from a `requires`-style file, including blank lines. A blank
line would produce an undefined module name, which could result in
unexpected entries or errors when processing dependency files.

Blank lines are now explicitly skipped before parsing:

```perl
# Before
while (<$fh>) {
    chomp;
    my ( $m, $v ) = split q{ }, $_;
    $requires{$m} = $v // 0;
}

# After
while ( my $line = <$fh> ) {
    chomp $line;
    next if !$line;
    my ( $m, $v ) = split q{ }, $line;
    $requires{$m} = $v // 0;
}
```

This fix applies to all files read by the `filter` command, including
`requires`, `requires.skip`, `suggests`, and `recommends`.

---

## Internal / Build Changes

- **`lib/CPAN/Maker/Bootstrapper/Role/Version.pm.in`** — New role
  module added as a source file.
- **`deps.mk`** — Regenerated to include the build dependency for
  `Role/Version.pm` on `Constants.pm`.
- **`README.md`** — Regenerated; version reference updated from
  `2.3.0` to `2.3.1`.
- **`VERSION`** — Bumped to `2.3.1`.

---

## Upgrade Notes

This is a drop-in patch upgrade. No changes to `buildspec.yml`,
`project.mk`, or any project-managed files are required.

Run the standard update after upgrading:

```bash
cpanm CPAN::Maker::Bootstrapper
make update
```

---

## Full Changelog

See the [ChangeLog](ChangeLog) for the complete history of changes across all releases.
