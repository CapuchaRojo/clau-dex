# Purpose

This brief defines the first exact implementation task for the first real `src/parser/` checkpoint in `clau-dex` without starting code in this task.

It exists so the repo has one concise, code-facing launch brief for the smallest honest parser implementation lane already justified by the current parser planning set.

# Exact Repo-Visible Claim

The first real parser checkpoint should make only this repo-visible claim:

- `clau-dex` now contains one narrow source-level parser lane under `src/parser/` that can inspect one supported checked-in markdown asset and return one parser record aligned with `docs/PARSER_RECORD_SPEC.md`.

That claim stays intentionally narrow.

It does not claim shell consumption, shell replacement, multi-file scanning, broader `src/` activation, or a new runtime surface. It only claims that one code-backed parser seam now exists for one-asset metadata inspection under the current documented contract.

# Exact First Scope

The first implementation story should stay limited to one inspection-only parser flow that:

- accepts one repo-relative file path for one checked-in supported asset
- accepts one supported asset kind limited to `prompt-pack` or `super-agent`
- reads only the currently documented summary and best-use metadata sections
- recognizes only the current preferred and fallback headings already described in repo docs
- extracts the first non-empty summary line and up to the first two best-use bullets
- classifies heading use and metadata state using only the current documented categories
- returns one parser record for that one inspected asset

This is the smallest honest first implementation lane because it turns an already-documented shell-readable metadata contract into one reusable source-level parser seam without changing how the operator uses the repo.

# Likely Files Touched

The first real parser checkpoint would most likely touch only:

- `src/README.md`
- `src/parser/README.md`
- `src/parser/parse-asset.*`
- `src/parser/read-metadata-sections.*`
- `src/parser/build-parser-record.*`
- `src/parser/classify-metadata-state.*`

The exact extension remains intentionally undecided here because the current docs justify the parser responsibilities and boundaries, not a language choice.

# Expected Outcome

When this brief is used for the first real code checkpoint, the expected outcome should be:

- `src/parser/` exists as one narrow parser lane
- one supported checked-in asset can be inspected deterministically
- the parser emits one record matching the current parser record contract
- the record stays limited to current repo-truth metadata signals such as matched headings, summary text, best-use bullets, heading-use results, metadata state, and metadata notices
- the shell still remains the only executable front door

In practical terms, the checkpoint should prove that the current metadata contract can exist as reviewable source code without yet changing `.\scripts\clau-dex.ps1`, `brief`, `audit`, or repo workflow.

# What Must Stay Out Of Scope

The first real parser checkpoint must still leave all of the following unchanged:

- `.\scripts\clau-dex.ps1` command ownership, phrasing, and output routing
- shell integration for `status`, `brief`, `audit`, or any other command
- any shell replacement or second executable surface
- broader `src/` subsystem work outside the narrow parser lane
- CI, workflow, package-manager, dependency, or runtime setup changes
- multi-asset scanning, catalog aggregation, ranking, recommendation, search, or orchestration behavior
- parsing outside the current prompt-pack and super-agent scope

# Non-Goals

This first implementation brief is not:

- a broad parser roadmap
- approval for shell integration in the same checkpoint
- approval for arbitrary markdown parsing across the repo
- a runtime activation plan for all of `src/`
- a language-selection document
- a justification for new shell, CI, or workflow changes

# Verification

This brief is grounded in the current parser planning docs and should be considered correct only if all of the following stay true:

- it builds directly on `docs/FIRST_PARSER_FILESET_PLAN.md`
- it matches the checkpoint posture in `docs/FIRST_PARSER_CHECKPOINT_PLAN.md`
- it stays aligned with `docs/PARSER_RECORD_SPEC.md`
- it respects the threshold in `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- it follows the narrow slice described by `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- it preserves the shell ownership boundary in `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- it remains consistent with the validation posture in `docs/PARSER_VALIDATION_PREFLIGHT.md`
- it defines one exact first implementation story and does not start code in this task
- it keeps the first real code checkpoint narrow, inspection-only, and grounded in checked-in repo truth
- no shell, `src/`, CI, or workflow files are changed by this docs-only task
