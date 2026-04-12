# Purpose

This document defines the smallest credible first implementation checkpoint for the first parser slice in `clau-dex` before any parser code is written.

It exists so the project can describe one honest first code claim, the likely files that checkpoint would touch, the validation surface it would need, and the boundaries that must still remain in place after that checkpoint lands.

# Smallest Credible First Claim

The smallest believable first parser implementation claim is:

- `clau-dex` now contains one narrow source-level parser that can inspect one supported checked-in markdown asset and return one parser record that matches the current documented metadata contract.

That claim is intentionally narrow.

It does not say the shell uses the parser yet. It does not say `brief` or `audit` were rewritten. It does not say `src/` is generally active. It only claims that one reusable parser lane now exists for one-asset inspection under the current docs-backed contract.

This is the smallest credible claim because anything smaller would risk creating code without a reviewable outcome, while anything larger would start implying shell integration, broader `src/` activation, or a runtime story the repo has not earned yet.

# Likely Files Touched

The first parser checkpoint would likely touch only a very small set of file types.

Most likely touched files:

- `src/README.md` to keep the checked-in `src/` description honest once the first real code file exists
- one parser entry file under `src/parser/`
- one or more small parser-adjacent helper files under `src/parser/` for section reading, record shaping, or metadata-state handling
- one docs file if the checkpoint needs a small verification note or direct cross-reference update tied to the new parser checkpoint

Likely file-type boundaries:

- source files only inside `src/parser/`
- docs updates only where current repo truth must acknowledge the existence of that first parser checkpoint

Not likely touched in this first checkpoint:

- `scripts/clau-dex.ps1`
- shell docs that would imply parser consumption is already happening
- CI or workflow files
- files outside the narrow parser lane unless a minimal truth-maintenance doc update is required

# What The First Checkpoint Would Do

The first parser checkpoint would likely do only the following:

- accept one supported asset kind limited to `prompt-pack` or `super-agent`
- accept one repo-relative path for one checked-in markdown file
- inspect only the currently documented summary and best-use metadata sections
- return one parser record aligned with `docs/PARSER_RECORD_SPEC.md`
- classify heading use and metadata state using only the already documented categories
- stay deterministic, local-first, and inspection-only

In practical terms, the checkpoint would establish a source-level parser seam that proves the documented contract can be implemented in code without yet changing how the operator uses the repo.

# What The First Checkpoint Would Not Do

The first parser checkpoint would not:

- wire the parser into `.\scripts\clau-dex.ps1`
- replace or alter the `brief`, `audit`, or `status` command surface
- scan multiple assets or aggregate catalog results
- parse arbitrary files under `docs/`
- add search, ranking, recommendation, or semantic interpretation behavior
- introduce a packaged runtime, dependency stack, framework, or broader `src/` subsystem
- change CI, workflow, or operator-routing behavior

Those exclusions are what keep the checkpoint honest as the first parser code claim rather than the start of a broader implementation phase.

# Validation Surface

The first parser checkpoint would likely need a very small validation surface.

At minimum, that validation would need to prove:

- the parser accepts one supported asset in current scope only
- the parser emits one record shaped by `docs/PARSER_RECORD_SPEC.md`
- the parser reads only the current summary and best-use metadata surfaces
- the parser preserves current metadata-state categories and notice boundaries
- the checkpoint does not change the shell as the executable front door

The likely validation surface would therefore be:

- manual review against `docs/PARSER_RECORD_SPEC.md`, `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`, `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`, and `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- a task-specific code-level verification for one supported asset input and one expected parser-record output shape
- `.\scripts\clau-dex.ps1 status` to confirm the shell still reports no broader runtime activation
- `.\scripts\clau-dex.ps1 brief` to confirm the current operator surface remains shell-owned and unchanged

The checkpoint does not need broader validation than that because broader validation would likely mean the checkpoint has widened beyond the smallest credible first slice.

# Rollback Simplicity

This checkpoint should stay easy to reverse.

Rollback should be simple because the intended change surface is small:

- one parser lane under `src/parser/`
- one `src/README.md` truth update if needed
- no shell integration
- no CI changes
- no workflow changes

That means the checkpoint can be removed cleanly if the parser contract proves premature, without having to unwind operator-facing behavior or repo-wide infrastructure changes.

# Non-Goals

This checkpoint plan does not:

- authorize implementation by itself
- define the final implementation language or exact filenames
- promise shell consumption of parser output in the same checkpoint
- define a multi-checkpoint parser roadmap
- broaden `src/` into a general implementation area
- imply that parser entry criteria have already been met

# Verification

Manual review and task checks for this checkpoint plan:

- reviewed `docs/SRC_PARSER_LAYOUT_PREFLIGHT.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- reviewed `docs/NEXT_IMPLEMENTATION_BACKLOG.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed this plan builds directly on the current parser planning docs
- confirmed this plan defines one smallest believable first code checkpoint
- confirmed this plan names likely touched files and file types without starting implementation
- confirmed this plan keeps the first checkpoint narrow and inspection-only
- confirmed this plan does not imply broader `src/` activation, shell replacement, or runtime expansion
- confirm no shell, `src/`, CI, or workflow files are changed as part of this task
