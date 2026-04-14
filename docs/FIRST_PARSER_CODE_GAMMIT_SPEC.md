# Purpose

This document defines the exact gammit spec for validating the first real `src/parser/` code checkpoint in `clau-dex` before implementation begins.

It exists so the repo has one concise validation contract for the first parser checkpoint: what must be reviewed, what local checks must run, what parser output must be checked, what shell behavior must remain unchanged, and what counts as `PASS`, `FAIL`, or `INCOMPLETE`.

# Manual Review Set

Before the first parser checkpoint can be claimed as valid, manual review must confirm that the implementation still matches the current parser planning set.

The required review set is:

- `docs/FIRST_PARSER_IMPLEMENTATION_TASK_BRIEF.md`
- `docs/PARSER_VALIDATION_PREFLIGHT.md`
- `docs/FIRST_PARSER_CHECKPOINT_PLAN.md`
- `docs/PARSER_RECORD_SPEC.md`
- `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- `docs/PARSER_SHELL_HANDOFF_SPEC.md`

That review must confirm, in practical terms:

- the checkpoint still matches the narrow repo-visible claim from the implementation brief
- the code checkpoint stays limited to one inspection-only parser lane
- the parser contract still means one record for one checked-in supported asset
- the validation story still stays narrow enough for the first checkpoint claim
- the shell remains the only executable front door and presentation owner

# Local Validation Checks

The local checks for the first parser checkpoint should stay minimal and exact.

The required local checks are:

- review the changed-file list against the planned first parser footprint
- inspect at least one checked-in supported asset in current parser scope
- run the task-specific parser output check for that inspected asset
- run `.\scripts\clau-dex.ps1 status`
- run `.\scripts\clau-dex.ps1 brief`
- run `git status --short`

These checks are enough for the first code checkpoint because the claimed outcome is still narrow: one parser lane, one asset inspection result, and no shell integration.

# Parser Output Contract Checks

For the first checkpoint, the parser output check must stay aligned with `docs/PARSER_RECORD_SPEC.md` and the current implementation brief.

At minimum, validation must confirm that the inspected asset yields one parser record with:

- `asset_kind` set only to `prompt-pack` or `super-agent`
- `relative_path` set to the repo-relative path of the checked-in inspected asset
- `matched_summary_heading` reporting the actual matched supported heading or `null`
- `matched_best_use_heading` reporting the actual matched supported heading or `null`
- `summary_text` using the first non-empty supported summary line or the current missing-metadata message
- `best_use_bullets` preserving up to the first two inspected bullets only
- `heading_use.summary` and `heading_use.best_use` limited to `preferred`, `fallback`, or `missing`
- `metadata_state` limited to `clean`, `fallback`, `missing`, `empty`, or `scaffold-grade`
- `metadata_notices` limited to current contract-backed inspection notices

The output check must also confirm:

- the parser reads only the current summary and best-use metadata surfaces
- the parser does not invent bullets, summaries, rankings, or workflow guidance
- the parser returns inspection facts, not shell-facing phrasing
- any warning-bearing example used stays within currently documented categories only

# Shell Non-Regression Checks

The first parser checkpoint must leave shell behavior unchanged.

Validation must explicitly confirm:

- `.\scripts\clau-dex.ps1` is still the only executable front door
- `status` still reports no broader implementation runtime in `src/`
- `brief` still describes itself as reading local markdown headings only
- no parser-backed command routing or shell wording has moved into `src/`
- the checkpoint does not require shell changes to appear complete
- no CI or workflow changes were introduced to validate the checkpoint

The shell non-regression evidence for this gammit must come from:

- `.\scripts\clau-dex.ps1 status`
- `.\scripts\clau-dex.ps1 brief`
- changed-file review
- `git status --short`

# PASS Conditions

The first parser checkpoint is `PASS` only if all of the following are true:

- manual review confirms the checkpoint still matches the current parser brief and planning docs
- one narrow parser lane exists under `src/parser/` and stays within the first-checkpoint scope
- at least one checked-in supported asset is validated successfully
- the parser emits one record for that asset that matches the documented parser record contract
- the parser output stays inspection-only and does not widen into search, ranking, aggregation, or shell presentation behavior
- `.\scripts\clau-dex.ps1 status` and `.\scripts\clau-dex.ps1 brief` remain unchanged in role and posture
- the changed-file set stays narrow enough for one reviewable checkpoint commit

# FAIL Conditions

The first parser checkpoint is `FAIL` if any of the following are true:

- the implementation no longer matches the narrow first-checkpoint claim
- the parser output cannot be checked cleanly against `docs/PARSER_RECORD_SPEC.md`
- the parser depends on unsupported asset kinds, multi-asset scanning, or broader repo parsing
- the checkpoint requires shell integration, shell wording changes, or a second executable surface
- the checkpoint introduces CI, workflow, dependency, or broader runtime changes
- the shell truth surfaces and parser docs disagree on headings, metadata categories, or ownership boundaries
- the changed-file set spills into unrelated shell, CI, workflow, or non-parser runtime areas

# INCOMPLETE Conditions

The first parser checkpoint is `INCOMPLETE` if the intended narrow claim may still be valid, but the validation evidence is not complete enough to prove it.

That includes cases where:

- the manual review set was not fully reviewed
- `.\scripts\clau-dex.ps1 status` or `.\scripts\clau-dex.ps1 brief` was not run
- no checked-in supported asset was used for the parser output check
- the parser record was only partially checked against the documented field contract
- the changed-file review or `git status --short` evidence is missing
- the checkpoint appears narrow, but the repo cannot yet prove shell non-regression clearly

# Non-Goals

This gammit spec does not:

- add parser code, shell code, or runtime code
- define a general parser testing framework
- require a new test harness, CI expansion, fixtures, or golden files
- approve shell integration in the first parser checkpoint
- broaden the parser checkpoint into a multi-step validation roadmap
- imply that the first parser code checkpoint has already been implemented

# Verification

This gammit spec is grounded in the current checked-in parser planning docs and should remain valid only if all of the following stay true:

- it builds directly on `docs/FIRST_PARSER_IMPLEMENTATION_TASK_BRIEF.md`
- it stays aligned with `docs/PARSER_VALIDATION_PREFLIGHT.md`
- it matches the checkpoint boundary in `docs/FIRST_PARSER_CHECKPOINT_PLAN.md`
- it uses the output contract from `docs/PARSER_RECORD_SPEC.md`
- it respects the threshold in `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- it follows the narrow first-slice shape in `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- it preserves the shell boundary in `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- it stays non-coding and does not start `src/` implementation in this task
- it does not imply shell integration, CI expansion, or broader runtime activation
- no shell, `src/`, CI, or workflow files are changed by this docs-only task
