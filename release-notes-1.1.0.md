# CPAN::Maker::Bootstrapper 1.1.0

**Released:** Mon Apr 20 2026

## Overview

This is a significant feature release introducing AI-assisted
development tools via the Anthropic Claude API. The release adds an
iterative code review workflow with structured finding annotations,
POD documentation review and generation, AI-generated release notes,
and supporting prompt infrastructure. Several correctness and
robustness improvements are also included.

---

## New Features

### AI-Assisted Development (LLM Commands)

All LLM commands require [LLM::API](https://metacpan.org/pod/LLM::API)
(now a recommended dependency) and a valid Anthropic API key. The API
key is deleted from the environment immediately after being read and
is never passed to child processes.

#### `code-review`

Submits a Perl module or script to the LLM for a structured code
review. POD is automatically stripped before submission to reduce
token costs. The review is written as a timestamped JSON file
(`<module>-review-<timestamp>.code`) containing `findings`,
`confirmations`, and `deferred` arrays.

```
cpan-maker-bootstrapper code-review --prompt-profile cli-tool lib/My/Module.pm
```

On subsequent runs, the latest annotated review file is automatically
included with the submission so the LLM can build on prior rounds. New
options: `--prompt`, `--prompt-profile`, `--context`.

#### `annotate`

Applies disposition tags to findings in the latest review file and
displays the current annotation state as a formatted table (with
optional ANSI color).

```
cpan-maker-bootstrapper annotate -a 1:accept -a 2:wrong -a 3:reject lib/My/Module.pm
```

Supports incremental annotation across multiple invocations. New
options: `--annotate|-a`, `--auto-annotate|-A`,
`--finalize-annotations|-F`.

**Dispositions:** `ACCEPT`, `REJECT`, `WRONG`, `WRONG-RECONSIDER`,
`DEFER`, `CONFIRMED`

#### `pod-review`

Submits a Perl module to the LLM for documentation review. The full
file including code is submitted for consistency checking. If no POD
exists, the LLM generates complete POD ready to paste after
`__END__`. Output is written to `<module>-review-<timestamp>.pod`.

#### `release-notes`

Generates release notes in Markdown format using the LLM. Consumes the
three artifacts produced by `make release-notes`:

```
release-<version>.diffs
release-<version>.lst
release-<version>.tar.gz
```

Binary files are automatically excluded. Output is written to
`release-notes-<version>.md`. The `--max-diff-files` option (default:
50) caps token consumption on large distributions.

#### `show-finding`

Displays the complete details of a single finding from the latest
review file as a formatted table.

```
cpan-maker-bootstrapper show-finding lib/My/Module.pm 1
```

### Iterative Review Workflow

The release introduces a structured review workflow with convergent
rounds. Each round: run a review, annotate findings,
resubmit. Findings accumulate dispositions that guide the LLM on
subsequent rounds - suppressing noise, confirming fixes, and carrying
forward deferred items. See `THE REVIEW WORKFLOW` section of the
documentation for full details.

**Release artifacts:** When satisfied with the review state, use
`--finalize-annotations` to produce a versioned certification file
(e.g., `Bootstrapper-1.1.0.review`) committing all finding
dispositions to the repository. Findings marked `WRONG` are
automatically converted to `WRONG-RECONSIDER` for careful
re-examination in the next version's first review.

### Prompt Profiles

Prompt profiles are additive prompt fragments stored in `.prompts/`
that customize LLM review behavior for specific application
types. They are appended to the base review prompt before submission.

```
cpan-maker-bootstrapper code-review --prompt-profile cli-tool MyModule.pm
```

**Built-in profile: `cli-tool`** - suppresses findings inappropriate
for single-user developer tools (TOCTOU races, `qx{}` security
concerns sourced from the user's own config, issues that
perlcritic/perltidy would catch).

Custom profiles can be created as plain text files in
`.prompts/`. Planned future profiles include `library`,
`web-application`, `mod-perl-handler`, and `lambda-function`.

Prompt files (`code-review.prompt`, `pod-review.prompt`) are now
installed with the distribution and copied to `.prompts/` on first
use.

### New Configuration Options

#### In `~/.gitconfig` or `~/.cpan-makerrc`

```ini
[cpan-maker]
    llm-api-key-helper = cat ~/.ssh/anthropic-api-key
    max-tokens         = 4096
```

`llm-api-key-helper` is a shell command whose output is used as the
LLM API key, avoiding exposure in shell history and process listings.

#### New CLI Options

| Option | Description |
|---|---|
| `--annotate\|-a N:DISPOSITION` | Apply disposition to finding N (repeatable) |
| `--auto-annotate\|-A` | Annotate and immediately submit the next review |
| `--finalize-annotations\|-F` | Create versioned release artifact |
| `--context\|-C PATH` | Context file to include with code review (repeatable) |
| `--max-diff-files LIMIT` | Cap files sent to LLM for release notes (default: 50) |
| `--max-tokens\|-t TOKENS` | Max output tokens for LLM response (default: 4096) |
| `--prompt PATH` | Custom prompt file for code or pod review |
| `--prompt-profile NAME` | Additive prompt profile name (repeatable) |
| `--no-color` | Disable ANSI coloring of annotation table |

---

## Improvements

### Atomic Project Installation

`cmd_install` now performs all work in a temporary directory on the
same filesystem as the target and atomically renames it to the final
install directory on success. An existing install directory is only
removed after all steps succeed, preventing partial or corrupt
installations on failure.

### Module Discovery via `Module::Metadata`

Package detection during `--import` now uses `Module::Metadata`
instead of a hand-rolled regex scan. This correctly handles all valid
Perl package declaration forms.

A new `_find_primary_package` method matches a source file path to the most specific package name in the file by reversing path components and testing against reversed package names. This replaces the previous approach that required the filename to match the package name exactly.

### Improved `_import_file_listing`

- Import path error message clarified: "not a directory" instead of "does not exist"
- File extension matching uses `\z` anchor instead of `$` for correctness
- `Module::Metadata` used for all package detection

### Robustness Fixes (from code review)

- **`_finalize_annotations`**: Fixed guard that checked `$VERSION`
  (the package constant, always truthy) instead of `$version` (the
  local variable holding the `VERSION` file contents). A missing or
  unreadable `VERSION` file now correctly dies.
- **`cmd_annotate`**: Added guard that dies with a clear error if no
  review file is found before attempting to write the temporary
  annotation file.
- **`cmd_code_review`**: `api_key` extracted from arguments is now
  correctly passed through to `_cmd_review` and `_check_llm`.
- **`_init_config`**: Now checks `$EVAL_ERROR` after the `eval` block
  when loading the config reader, and logs the actual error
  message. Resources and basedir defaults set to `undef` instead of
  empty string.
- **`cmd_install`**: Module name validation regex changed from
  `[[:upper:]]` to `[[:alpha:]]` to correctly accept
  lowercase-starting package names (e.g., `main`).
- **`_install_files`**: `copy` failures and `chmod` warnings now
  produce explicit die/warn messages rather than silently
  continuing. `rename` failures are checked and reported.

### Build System Updates

#### `.includes/git.mk`

- `README.md` removed from `RECOMMENDED_ARTIFACTS` (generated, not
  source-controlled)
- `.includes/` and `.prompts/` directories added to
  `RECOMMENDED_ARTIFACTS`
- `git add` loop now conditionally skips entries that do not exist,
  preventing errors on fresh scaffolds

#### `.includes/release-notes.mk`

- `LAST_TAG` environment variable override: `make release-notes
  LAST_TAG=v1.0.4` now works, useful when tag names do not follow the
  default numeric pattern

#### `.includes/help.mk`

- `LINT=OFF` variable documented in `make help` output

#### `Makefile`

- `make quick` target now has a `## quick build...` comment so it
  appears in `make help`
- `buildspec.yml` recipe uses `$(BUILDSPEC_TEMPLATE)` as the explicit
  input file rather than `$<` (the first dependency), fixing a subtle
  ordering bug

### Dependency Updates

**New required dependencies:**

- `Archive::Tar`
- `Email::Valid 1.204`
- `JSON::PP`
- `LLM::API 1.0.0` (also added as a recommended dependency)
- `Module::Metadata`
- `Readonly 2.05`
- `Text::ASCIITable 0.22`

**New recommended dependency:**

- `LLM::API 1.0.0`

### Configuration Key Rename

`syntax_checking` is now `syntax-checking` in the `[cpan-maker]`
config section, consistent with hyphenated naming used by all other
keys. The `cpan_maker_syntax_checking` reader method is updated
accordingly.

### Documentation

- `README.md` and POD comprehensively updated with new `LLM COMMANDS`,
  `THE REVIEW WORKFLOW`, and `PROMPT PROFILES` sections
- `CPAN::Maker::ConfigReader` POD updated with `llm-api-key-helper`
  and `max-tokens` configuration keys
- Import behavior note added to the `Notes` section documenting the
  skip-and-warn behavior when no matching package is found
- Token substitution documentation corrected to use `@PACKAGE_VERSION@` and `@MODULE_NAME@` notation throughout

---

## New Files

| File | Description |
|---|---|
| `.prompts/cli-tool.prompt` | Built-in prompt profile for single-user CLI tools |
| `.prompts/code-review.prompt` | Default code review prompt (installed to projects) |
| `.prompts/pod-review.prompt` | Default POD review prompt (installed to projects) |
| `Bootstrapper-1.1.0.review` | Code review certification artifact for this release |
| `recommends` | New recommended dependencies file |
| `t/find-primary-package.t` | Tests for `_find_primary_package` with 8 cases |

---

## Deferred

- `cmd_install`: `chdir` to `tmpdir` is not undone on failure;
  subsequent relative-path operations in the caller may be
  affected. Acknowledged, not yet addressed.

---

## Upgrade Notes

- If you have `syntax_checking` in your `[cpan-maker]` config, rename
  it to `syntax-checking`.
- Install the new required dependencies: `cpanm Archive::Tar
  Email::Valid JSON::PP Module::Metadata Readonly Text::ASCIITable`
- To use LLM commands, install `LLM::API` and configure
  `llm-api-key-helper` in your config or set `LLM_API_KEY` in your
  environment.
- Prompt files are auto-installed on first use; to pre-install them
  run any `code-review` or `pod-review` command from your project
  directory.
