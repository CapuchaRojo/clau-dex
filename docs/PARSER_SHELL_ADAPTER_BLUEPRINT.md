# Purpose

This document defines the smallest conceptual adapter seam between a future `src/parser` record and the existing shell-owned surfaces in `clau-dex`.

It exists so the repo can describe how shell commands could later consume parser facts without giving up shell-owned phrasing, workflow guidance, command ownership, or the rule that `.\scripts\clau-dex.ps1` remains the only executable front door.

# Current Constraints

The adapter blueprint must stay grounded in current checked-in repo truth:

- the shell remains the only executable operator surface
- the current parser scope is still one supported asset at a time
- the current parser contract is inspection-only and record-shaped
- current shell surfaces such as `brief`, `audit`, and `status` still own wording, grouping, warning posture, and workflow cues
- this task does not start shell integration, `src/` runtime code, CI changes, or workflow changes

So this blueprint is a seam description only. It is not a shell redesign and it is not evidence that parser-backed shell behavior exists now.

# Why An Adapter Layer Exists

An adapter layer exists to keep two responsibilities separate:

- the parser returns narrow inspection facts about one supported asset
- the shell turns those facts into operator-facing output

Without that seam, the parser would be pressured to return shell-ready sentences, command-specific guidance, or workflow decisions. That would blur ownership and make the future parser wider than the current docs justify.

The adapter therefore exists only to normalize a parser record into a shell-consumable fact shape while preserving the shell as the presentation and workflow owner.

# Smallest Adapter Responsibility

The smallest adapter responsibility is:

- accept one parser record for one supported asset
- preserve the parser's inspected facts
- normalize those facts into a small shell-consumable object with stable field names
- avoid adding command logic, operator phrasing, or workflow decisions

In practical terms, the adapter should do no more than convert "parser inspection record" into "shell-ready facts for one asset."

It should stay thin because the shell already owns command behavior and the parser already owns extraction. A wider adapter would become an unnecessary third logic layer.

# Parser Input To The Adapter

The adapter should conceptually accept one parser record aligned with `docs/PARSER_RECORD_SPEC.md`.

That input is justified today as containing fields such as:

- `asset_kind`
- `relative_path`
- `matched_summary_heading`
- `matched_best_use_heading`
- `summary_text`
- `best_use_bullets`
- `heading_use`
- `metadata_state`
- `metadata_notices`

The adapter should treat that record as inspection data, not as a draft of final shell output.

It should not require:

- shell command names
- shell formatting preferences
- workflow context beyond the inspected asset
- cross-file aggregation
- ranking signals
- remote state

# Adapter Output To Shell-Owned Surfaces

The adapter should return the smallest normalized shape that shell-owned surfaces could consume later without losing their own wording.

Conceptually, that normalized shape should expose:

- asset identity: kind and repo-relative path
- extracted content: one summary string and up to two best-use bullets
- heading facts: which supported headings matched and whether they were preferred, fallback, or missing
- metadata posture: one current metadata-state category plus current notices

In practical terms, the shell should be able to read the adapter output as:

- "what asset was inspected"
- "what reusable summary facts were found"
- "what metadata condition applies"

The adapter output should stay fact-shaped rather than sentence-shaped. For example, it may normalize fields into shell-friendly labels or nested groups, but it should not return final lines such as:

- first-pick cues
- warning banners
- remediation wording
- checkpoint reminders
- operator instructions

# What Must Stay Shell-Owned

The following must remain outside the adapter and inside shell-owned surfaces:

- command selection such as `status`, `brief`, `audit`, and `checkpoint`
- operator-facing phrasing and output formatting
- grouping and ordering of fields for readability
- first-pick cues and picker hints
- warning-versus-fail posture as presented to the operator
- workflow guidance, checkpoint reminders, and next-action wording
- any decision to show, suppress, collapse, or combine parser-derived facts with other shell-local checks

This keeps the shell as the only executable front door and prevents the adapter from becoming a second presentation surface.

# What Must Stay Outside The Adapter

The adapter must also stay smaller than the parser and smaller than the shell.

It must stay outside:

- markdown reading and heading extraction logic already owned by the parser
- broad repo scans or multi-asset catalog assembly
- recommendation, ranking, or semantic interpretation
- shell scaffolding behavior
- runtime bootstrap, services, APIs, or automation
- any replacement of the current shell command surfaces

If the adapter starts doing those jobs, it is no longer the smallest seam.

# Non-Goals

This blueprint does not:

- add shell code
- add runtime code in `src/`
- start parser-to-shell integration
- redefine the parser record contract
- redesign `brief`, `audit`, `status`, or other shell surfaces
- imply parser-owned phrasing, parser-owned workflow guidance, or shell replacement
- widen the current parser scope beyond one-asset inspection

# Verification

Manual grounding and verification for this blueprint:

- reviewed `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/FIRST_PARSER_FILESET_PLAN.md`
- reviewed `docs/PARSER_VALIDATION_PREFLIGHT.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/WORKFLOW_ENTRY_MAP.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the blueprint builds directly on the current parser record and shell-handoff docs
- confirmed it stays non-coding and does not change shell behavior
- confirmed it defines the smallest conceptual adapter seam as a thin normalization layer only
- confirmed the shell remains the only executable front door and owner of phrasing, workflow guidance, and command behavior
- confirmed the document does not imply shell replacement, parser-owned phrasing, broader runtime activation, or current parser-shell integration
