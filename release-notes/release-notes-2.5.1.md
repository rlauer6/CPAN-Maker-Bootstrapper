# CPAN::Maker::Bootstrapper 2.5.1 Release Notes

## Overview

This release removes the LLM-assisted commands from the core
distribution and reorganizes them as an optional plugin. Two new
commands are added — `add-plugin` and `uninstall` — and the build
workflow gains a cleaner `pre-update`/`post-update` hook structure.
Dependencies on LLM and POD extraction modules are dropped from the
core `requires` and `suggests` lists.

---

## LLM Commands Moved to a Separate Plugin

The most significant change in 2.5.1 is the removal of all
LLM-related commands and their supporting roles from the core
distribution:

**Removed commands:** `annotate`, `change-log`, `code-finding`,
`code-review`, `models`, `pod-finding`, `pod-review`,
`publish-to-cpan`, `release-notes`, `update-annotations`

**Deleted roles:**
- `CPAN::Maker::Bootstrapper::Role::LLM::Annotator`
- `CPAN::Maker::Bootstrapper::Role::LLM::ChangeLog`
- `CPAN::Maker::Bootstrapper::Role::LLM::Models`
- `CPAN::Maker::Bootstrapper::Role::LLM::ReleaseNotes`
- `CPAN::Maker::Bootstrapper::Role::LLM::Reviewer`
- `CPAN::Maker::Bootstrapper::Role::LLM::Utils`
- `CPAN::Maker::Bootstrapper::Role::PAUSEUpload`

**Deleted managed includes:** `.includes/change-log.mk`,
`.includes/publish.mk`, `.includes/release-notes.mk`

**Deleted prompt files:** `.prompts/cli-tool.prompt`,
`.prompts/code-review.prompt`, `.prompts/pod-review.prompt`

These capabilities are now expected to be delivered through the new
plugin mechanism (see below). Projects that need the LLM commands can
install the corresponding plugin distribution separately.

```
make add-plugin PLUGIN=LLM
```

The `--max-tokens|-t` and `--model|-M` options, and the `llm` and
`llm_api_key_helper` `extra_options`, have been removed from
`cpan-maker-bootstrapper.yml` along with the commands that used them.

The `with 'CPAN::Maker::Bootstrapper::Role::LLM::Utils'` composition
is removed from `CPAN::Maker::Bootstrapper`. The `_init_config` and
`init` methods in `Role::Init` no longer call `set_llm_api_key_helper`
or `set_max_tokens`. The `show-defaults` output no longer includes
`llm_api_key_helper` or `max_tokens` entries.

**User action required:** Projects that rely on `make release-notes`,
`make change-log`, or the `cmb code-review` / `cmb pod-review` family
of commands must install the LLM plugin separately. Existing
`config.mk` or environment settings for `--model` or `--max-tokens`
will no longer have any effect when passed to `cmb`.

---

## New Commands

### `add-plugin`

A new `add-plugin` command is implemented in
`CPAN::Maker::Bootstrapper::Role::AddPlugin`. It is managed through
the new `.includes/add-plugin.mk` include, which is now part of
`MANAGED_MK_FILES` and tracked in `cmb_md5sums.txt` and
`buildspec.yml`. The corresponding make fragment is installed and
updated via `make update` like other managed includes.

### `uninstall`

A new `uninstall` command is implemented in
`CPAN::Maker::Bootstrapper::Role::Uninstall`.

Both commands are registered in `cpan-maker-bootstrapper.yml`.

---

## Plugin Architecture

`CPAN::Maker::Bootstrapper` now supports project-registered command
role extensions. The main module's `CLI::Simple->import` call has
been updated to load `.roles/*/role.yml` in addition to the built-in
`:roles`. The `Makefile` includes `$(wildcard .roles/*/role.mk)` so
that plugin make fragments are incorporated automatically when a
plugin is installed into the project.

The `.roles/CPAN-Maker-Bootstrapper-Role-LLM/` directory, containing
`role.mk` and `role.yml`, is the reference example of this
mechanism and provides the hook point for reinstalling the LLM command
set as an external plugin.

---

## Build Workflow: `pre-update` / `post-update` Hooks

`update.mk` gains a more structured update lifecycle:

- `INCLUDES_DIR` and `BOOTSTRAPPER_DIST_DIR` variables are now
  defined at the top of `update.mk`.
- A new `pre-update` phony target is introduced as a double-colon
  rule, making it extensible from `project.mk`.
- `post-update` now declares `pre-update` as a prerequisite.
- The `Makefile` copy and permission change (`chmod`) steps have been
  moved into `post-update`.
- The `update` target now invokes `pre-update` explicitly before the
  managed file copies.

Projects that need to run steps before or after `make update` can now
use `pre-update::` and `post-update::` in `project.mk`.

---

## Dependency Changes

The following packages are **removed** from `requires` and `cpanfile`:

- `IO::Scalar 2.113`
- `Pod::Extract 1.0.2`

The following packages are **removed** from `suggests`:

- `LLM::API 1.0.1`
- `Term::ANSI::Color`

The `deps.mk` no longer declares build-time dependencies on any of the
deleted `LLM::*` roles.

---

## `.gitignore`

A `!cpanfile.darkpan` negation rule has been added to `.gitignore`,
allowing `cpanfile.darkpan` to be tracked by git when
`DARKPAN_REQUIRES` is enabled, overriding the broader
`cpanfile.*` exclusion pattern.
