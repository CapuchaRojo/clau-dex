# Purpose

This document gives operators and future maintenance work one compact reference set for the current warning-grade metadata categories used by `.\scripts\clau-dex.ps1 brief` and `.\scripts\clau-dex.ps1 audit`.

It is example material only. It does not change shell behavior, add stricter validation, or replace `docs/METADATA_CONVENTIONS.md` as the metadata contract.

# Current Warning Categories

The current warning-grade metadata categories are:

- missing metadata
- fallback metadata
- empty metadata
- scaffold-grade metadata

These categories are warning-grade because the current shell contract is intentionally warning-first for metadata drift. `brief` keeps showing what it can from checked-in files, and `audit` reports metadata drift as `WARN`, not `FAIL`.

# Example: Missing Metadata

Missing metadata means the expected supported heading or bullet surface is absent, so the shell cannot read the intended summary text or best-for guidance from the file.

Illustrative prompt-pack example:

```md
# Codex Prompt Pack: Example

## Role
You are Codex acting on one narrow bootstrap task.
```

Practical meaning:

- no supported summary heading such as `## Goal`, `## Purpose`, or `## Overview` was found
- no supported best-use heading such as `## Use This Prompt When`, `## Use When`, or `## Best Used For` was found
- `brief` has to fall back to missing-metadata notices and direct-review guidance
- `audit` warns because the current metadata surface is incomplete

Why this is warning-grade, not fail-grade:

- the checked-in file still exists and can still be reviewed directly
- the current shell contract explicitly allows metadata incompleteness to warn without blocking bootstrap work

# Example: Fallback Metadata

Fallback metadata means a supported alias was found, but the file drifted from the preferred heading documented for that asset type.

Illustrative prompt-pack example:

```md
# Codex Prompt Pack: Example

## Purpose
Guide one narrow metadata maintenance task.

## Best Used For
- cleaning up one prompt file already in scope
- checking one narrow metadata convention question
```

Practical meaning:

- `brief` can still read the file because `## Purpose` and `## Best Used For` are supported fallback headings for prompt packs
- the file still drifted from the preferred prompt-pack headings `## Goal` and `## Use This Prompt When`
- `brief` reports fallback and convention-check notices
- `audit` warns because the preferred headings were not used

Why this is warning-grade, not fail-grade:

- the metadata remains usable for local picking
- the current contract treats supported fallback headings as compatibility behavior, not as a shell-breaking condition

# Example: Empty Metadata

Empty metadata means a supported section exists, but it still does not provide usable summary text or usable best-for bullets.

Illustrative super-agent example:

```md
# Super-Agent: Example

## Purpose

## Best Used For
This section still has no bullets.
```

Practical meaning:

- the headings are present, so the shape looks closer to correct than a missing-metadata case
- `brief` still cannot read a usable summary line from `## Purpose`
- `brief` still cannot read best-for bullets from `## Best Used For`
- `audit` warns because the supported metadata sections are present but not practically usable

Why this is warning-grade, not fail-grade:

- the file is still available to inspect directly
- the current shell contract warns when metadata exists in shape only but does not yet provide useful picker content

# Example: Scaffold-Grade Metadata

Scaffold-grade metadata means best-for bullets exist, but they still read like untouched scaffold defaults rather than file-specific picker guidance.

Illustrative super-agent example:

```md
# Super-Agent: Example

## Purpose
Handle one focused repository lane with clear boundaries and reviewable output.

## Best Used For
- one repeated repo task
- one narrow planning or review lane
- one clear output shape
```

Practical meaning:

- `brief` can display the bullets because they are valid bullets under a supported heading
- the bullets still do not help an operator distinguish this file from a fresh scaffold
- `brief` suppresses the first-pick cue and points the operator back to direct review
- `audit` warns because the best-use guidance is too weak for a reliable picker cue

Why this is warning-grade, not fail-grade:

- some metadata is present and visible
- the current shell contract treats weak best-use guidance as a caution about picker quality, not as proof that the repo boundary is broken

# How To Respond

Use these examples to recognize what kind of warning you are seeing before deciding whether to fix now, defer intentionally, or split metadata cleanup into a separate checkpoint.

Usual response shape under the current repo contract:

- missing metadata: fix now when the affected file is already in scope, otherwise decide intentionally whether to defer or split
- fallback metadata: usually tolerable for the current checkpoint if the file still reads clearly
- empty metadata: usually worth fixing because the visible section is not yet usable
- scaffold-grade metadata: usually worth fixing when operators need a trustworthy picker cue

For narrow triage help, use `prompts/codex/metadata-triage-check.md`.

# Non-Goals

This document does not:

- introduce new metadata categories
- rewrite `docs/METADATA_CONVENTIONS.md`
- change `brief` or `audit`
- imply that metadata warnings are now fail-grade
- add shell code, runtime code, CI behavior, or automation

# Verification

Manual verification for this example set:

- review `docs/METADATA_CONVENTIONS.md`
- review `docs/OPERATOR_RUNBOOK.md`
- review `docs/CATALOG_MAINTENANCE.md`
- review `prompts/codex/metadata-triage-check.md`
- review `docs/CLI_FIRST_SHELL.md`
- review `scripts/clau-dex.ps1`
- confirm each example matches one current warning-grade category only: missing, fallback, empty, or scaffold-grade
- confirm the examples stay docs-only and non-canonical
- confirm the examples do not imply stricter failure semantics than the current shell contract
- confirm no shell, `src/`, CI, or workflow files were changed for this task
