# Purpose

This document defines one exact structured record for a future narrow metadata-inspection parser in `clau-dex`.

The record is intentionally limited to one inspected markdown asset that is already part of the current shell-readable metadata contract:

- a prompt pack under `prompts/`
- a super-agent under `agents/super-agents/`

This spec exists so any later parser work can target one stable local-first output contract before any `src/` implementation begins.

# Scope

This spec is for inspection only.

It defines the structured output a future parser could emit after reading one checked-in asset with the same narrow metadata surfaces that `.\scripts\clau-dex.ps1 brief` and `audit` already depend on:

- summary heading selection
- best-use heading selection
- first non-empty summary line
- up to the first two best-use bullets
- preferred-heading versus fallback-heading use
- warning-grade metadata notices grounded in the current repo contract

This spec does not create a parser, start `src/` work, or change the shell contract.

# One Record Per Asset

The parser record represents exactly one inspected asset file.

One file yields one record. The record does not aggregate families, compare assets, rank assets, or describe workflow behavior.

The inspected asset must be one current supported kind:

- `prompt-pack`
- `super-agent`

The record must use repo-relative paths so the contract stays local-first and grounded in the checked-in checkout.

# Required Fields

The following fields are required now because they map directly to current shell-readable metadata behavior and current warning semantics.

| Field | Type | Required value shape | Current grounding |
| --- | --- | --- | --- |
| `asset_kind` | string | `prompt-pack` or `super-agent` | Current supported asset kinds in `brief` |
| `relative_path` | string | repo-relative markdown path | Current local file inspection surface |
| `matched_summary_heading` | string or null | supported heading actually used for summary | Current preferred/fallback heading match behavior |
| `matched_best_use_heading` | string or null | supported heading actually used for best-use bullets | Current preferred/fallback heading match behavior |
| `summary_text` | string | first non-empty summary line, or the current missing-metadata message | Current summary readout in `brief` |
| `best_use_bullets` | array of strings | up to first two bullet lines, may be empty | Current best-use readout in `brief` |
| `heading_use` | object | preferred-versus-fallback result for summary and best-use fields | Current convention check behavior |
| `metadata_state` | string | one current warning-grade state classification | Current metadata warning categories |
| `metadata_notices` | array of strings | zero or more current repo-truth notices | Current notice surface in `brief` |

`heading_use` must contain:

- `summary`: `preferred`, `fallback`, or `missing`
- `best_use`: `preferred`, `fallback`, or `missing`

Required field rules:

- `asset_kind` comes from the supported asset lane, not from speculative future types.
- `relative_path` must be relative to the repo root, not absolute and not remote.
- `matched_summary_heading` and `matched_best_use_heading` report the actual supported heading used, or `null` when no supported heading matched.
- `summary_text` must reflect the current shell-readable contract only. It is not an AI summary.
- `best_use_bullets` must preserve inspected bullet text from the file and must not invent bullets when none exist.
- `metadata_notices` must stay local and contract-backed. They are inspection notices, not remediation steps.

# Optional Fields

The following fields are optional now because they can be useful to shell callers later, but the current repo truth does not require them to make the record valid.

| Field | Type | Why optional now |
| --- | --- | --- |
| `preferred_summary_heading` | string | Helpful for convention reporting, but derivable from `asset_kind` and current docs |
| `preferred_best_use_heading` | string | Helpful for convention reporting, but derivable from `asset_kind` and current docs |
| `weak_best_use_bullets` | array of strings | Mirrors current scaffold-grade detection, but not required for the core contract |
| `has_summary_text` | boolean | Derivable from `summary_text` and `matched_summary_heading` |
| `has_best_use_bullets` | boolean | Derivable from `best_use_bullets` |
| `has_strong_best_use_bullets` | boolean | Derivable if scaffold-grade detection is carried forward later |

Optional fields should only be added when they still describe the same one-asset inspection result and do not widen the contract into ranking, orchestration, or runtime behavior.

# Metadata State Categories

`metadata_state` should classify the inspected asset using only the current metadata warning posture already documented for `brief` and `audit`.

Allowed categories now:

- `clean`
- `fallback`
- `missing`
- `empty`
- `scaffold-grade`

How to use them:

- `clean`: preferred headings were used and usable summary text plus usable best-use bullets were found without notices
- `fallback`: at least one supported fallback heading was used, but the record still yielded usable metadata
- `missing`: a supported summary or best-use heading was not found
- `empty`: a supported heading was found, but it did not yield usable summary text or usable best-use bullets
- `scaffold-grade`: best-use bullets were found, but they still match current scaffold-grade defaults too closely to act as a reliable picker cue

If more than one notice applies, `metadata_state` should report the highest-signal warning-grade category for the asset, while `metadata_notices` carries the fuller detail.

# Example Record

Example prompt-pack record:

```json
{
  "asset_kind": "prompt-pack",
  "relative_path": "prompts/codex/metadata-fix-check.md",
  "matched_summary_heading": "Goal",
  "matched_best_use_heading": "Use This Prompt When",
  "summary_text": "Repair one narrow metadata issue in a checked-in prompt pack or super-agent.",
  "best_use_bullets": [
    "one prompt pack or one super-agent already in scope needs better metadata for brief",
    "the repair is limited to headings, concise summary text, or file-specific best-for bullets"
  ],
  "heading_use": {
    "summary": "preferred",
    "best_use": "preferred"
  },
  "metadata_state": "clean",
  "metadata_notices": []
}
```

Example fallback-bearing super-agent record:

```json
{
  "asset_kind": "super-agent",
  "relative_path": "agents/super-agents/example-agent.md",
  "matched_summary_heading": "Goal",
  "matched_best_use_heading": "Best Used For",
  "summary_text": "Handle one focused repository lane with clear boundaries and reviewable output.",
  "best_use_bullets": [
    "one repeated repo task",
    "one narrow planning or review lane"
  ],
  "heading_use": {
    "summary": "fallback",
    "best_use": "preferred"
  },
  "metadata_state": "fallback",
  "metadata_notices": [
    "Summary heading fallback used: expected 'Purpose', found 'Goal'."
  ]
}
```

# Non-Goals

This spec does not:

- imply that a parser already exists in `src/`
- define a broad document schema for all markdown in the repo
- describe shell commands, runtime interfaces, or API endpoints
- introduce ranking, search, recommendation, or automation behavior
- define asset scoring, family summaries, or cross-file aggregation
- replace `docs/METADATA_CONVENTIONS.md` as the source of truth for current headings
- replace `scripts/clau-dex.ps1` as the current executable metadata surface

This is a contract for a possible future parser lane, not evidence that such a lane has been implemented.

# Verification

Manual verification for this spec:

- reviewed `docs/PARSER_READINESS_MAP.md`
- reviewed `docs/METADATA_CONVENTIONS.md`
- reviewed `docs/METADATA_WORKFLOW_MAP.md`
- reviewed `docs/NEXT_IMPLEMENTATION_BACKLOG.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the spec is grounded in the current checked-in repo only
- confirmed the spec defines one narrow parser record for current metadata inspection only
- confirmed the spec does not imply parser implementation already exists
- confirmed the spec does not start `src/` work
- confirmed the spec does not imply runtime, search, ranking, or automation behavior
- confirmed this task adds one docs file only
