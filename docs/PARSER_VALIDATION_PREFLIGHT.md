# Purpose

This document defines the validation preflight for the first parser code checkpoint in `clau-dex` before implementation begins.

It exists so the repo can state one narrow validation surface for that first checkpoint: example inputs, parser-record output checks, shell non-regression expectations, and the pass-or-abort line for entry.

# Validation Scope

The first parser checkpoint should validate only the smallest docs-backed claim:

- one narrow parser lane can inspect one current supported asset
- that parser returns one record aligned with `docs/PARSER_RECORD_SPEC.md`
- the shell remains unchanged and still owns execution, phrasing, and workflow guidance

The validation surface should stay limited to:

- one or two checked-in markdown assets already in current parser scope
- one one-asset parser record check per example input
- shell non-regression checks through `.\scripts\clau-dex.ps1 status` and `.\scripts\clau-dex.ps1 brief`

This preflight does not justify a broader testing roadmap, parser-shell integration, or general `src/` activation.

# Candidate Example Inputs

The first checkpoint should validate one prompt-pack example and, if a second example is needed, one super-agent example.

Most likely first example types:

- one prompt pack under `prompts/codex/` that already uses current preferred headings and yields a clean record shape
- one super-agent under `agents/super-agents/` or one warning-bearing example shape grounded in `docs/METADATA_WARNING_EXAMPLES.md` if the checkpoint needs one non-clean metadata case

Practical selection guidance:

- start with a real checked-in prompt pack because prompt packs are already part of the current `brief` surface and the parser record spec includes a concrete prompt-pack example
- add one super-agent example only if the first checkpoint needs to prove asset-kind coverage or fallback-or-warning classification without widening scope
- do not add synthetic fixtures, new sample files, or docs-only mock assets just to make the checkpoint feel larger

# Expected Output Shape Checks

For each example input, the checkpoint should confirm one parser record that matches the current required shape in `docs/PARSER_RECORD_SPEC.md`.

At minimum, the output check should confirm:

- `asset_kind` is exactly `prompt-pack` or `super-agent` for the inspected asset
- `relative_path` is repo-relative and points to the checked-in input file
- `matched_summary_heading` and `matched_best_use_heading` report the actual supported headings used, or `null` when no supported heading matched
- `summary_text` follows the current first-non-empty-line rule or the current missing-metadata message
- `best_use_bullets` preserves up to the first two inspected bullets and does not invent bullets
- `heading_use` reports only `preferred`, `fallback`, or `missing`
- `metadata_state` stays within `clean`, `fallback`, `missing`, `empty`, or `scaffold-grade`
- `metadata_notices` stays grounded in current shell-visible warning categories

If a second example is used, it should preferably prove one warning-bearing case already justified by current docs, such as fallback or scaffold-grade handling, rather than introducing a new output category.

# Shell Non-Regression Checks

The first parser checkpoint must leave the shell unchanged.

That means validation should explicitly confirm:

- `.\scripts\clau-dex.ps1` remains the only executable front door
- `status` still reports no broader implementation runtime in `src/`
- `brief` still describes itself as reading local markdown headings only
- no parser-backed command routing, output phrasing, or workflow guidance has moved into `src/`
- no shell, CI, or workflow changes were required to make the checkpoint look complete

In practical terms, the shell non-regression evidence should come from:

- `.\scripts\clau-dex.ps1 status`
- `.\scripts\clau-dex.ps1 brief`
- changed-file review showing parser-lane files only, plus any minimal truth-maintenance docs updates

# PASS Conditions

The first parser checkpoint should count as valid only if all of these are true:

- one narrow parser lane exists under the planned `src/parser/` footprint
- the checkpoint validates at least one checked-in supported asset successfully
- the parser output for that asset matches the documented record shape without widening the contract
- any warning-bearing example used is classified with current documented categories only
- `.\scripts\clau-dex.ps1 status` and `.\scripts\clau-dex.ps1 brief` remain unchanged in role and posture
- the changed-file set stays narrow enough for one reversible checkpoint commit

That is enough to support the smallest credible repo-visible claim: one source-level parser seam exists for one-asset inspection under the current metadata contract.

# Abort Conditions

The first parser checkpoint should still be treated as premature if any of these are true:

- the validation story needs new shell behavior to make the parser appear useful
- the parser output cannot be checked cleanly against `docs/PARSER_RECORD_SPEC.md`
- the checkpoint depends on new asset types, broader repo scanning, or multi-asset aggregation
- the validation surface needs a new test harness, CI expansion, or runtime scaffolding to feel credible
- the shell docs and parser docs no longer agree on headings, notice categories, or ownership boundaries
- the changed-file list spills into `scripts/`, CI, workflow files, or unrelated `src/` areas

Any of those conditions means the repo is still in parser planning or shell-hardening mode, not ready for the first parser code checkpoint.

# Non-Goals

This preflight does not:

- add parser code, shell code, or runtime code
- define a general parser test framework
- require fixtures, golden files, or CI automation beyond current repo truth
- promise parser-to-shell integration in the first checkpoint
- widen validation into a multi-checkpoint roadmap
- imply that parser entry has already been approved

# Verification

Manual grounding and verification for this validation preflight:

- reviewed `docs/FIRST_PARSER_FILESET_PLAN.md`
- reviewed `docs/FIRST_PARSER_CHECKPOINT_PLAN.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- reviewed `docs/METADATA_WARNING_EXAMPLES.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the preflight builds directly on the current parser planning docs
- confirmed it defines one narrow validation surface for the first code checkpoint
- confirmed it names likely example asset types without starting implementation
- confirmed it preserves the shell as unchanged and shell-owned
- confirmed it does not imply broader `src/` activation, shell replacement, or runtime expansion
- confirm no shell, `src/`, CI, or workflow files are changed as part of this task
