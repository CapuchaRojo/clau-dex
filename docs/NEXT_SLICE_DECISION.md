# Mission Read

This document chooses the next original implementation slice for `clau-dex` based on current repository truth and the completed clean-room synthesis from `c.src.code`. The goal is to select one narrow, reviewable, bootstrap-appropriate slice that improves execution-surface clarity without overstating readiness for application code in `src/`.

# Inputs Reviewed

- `C:\Users\mich3\GitHubProjects\clau-dex\docs\REFERENCE_SYNTHESIS_C_SRC_CODE.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\ARCHITECTURE_CHECKPOINT.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\BOOTSTRAP_PLAN.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\OPERATING_MODEL.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\CLI_FIRST_SHELL.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\README.md`

These inputs agree on four important points:

- `clau-dex` is still in bootstrap mode.
- the canonical executable surface is the local shell in `scripts/`
- the next move should harden documented shell-supported workflows rather than jump to a product runtime
- `src/` remains reserved until one source-level capability is explicitly defined, justified, and verifiable

# Candidate Next Slices

## Candidate 1

Add a documented metadata-contract enforcement slice for the existing `brief` surface. This would keep the current shell as the execution center, tighten the required and warning-only heading rules for prompt packs and super-agent files, and define the smallest validation pass that proves those conventions hold.

## Candidate 2

Define and start the first tiny source-level engine in `src/` for local briefing or metadata parsing, with the shell reduced to an entry wrapper. This would create the first reusable implementation module and the first direct claim that `src/` now contains an actual runtime slice.

## Candidate 3

Add a new bootstrap shell slice focused on local-state hygiene and boundary checks. This would define what local artifacts should remain untracked, what bootstrap surfaces count as canonical, and what warnings the shell should produce when repo hygiene drifts.

# Evaluation Criteria

- The slice must be original and clean-room safe.
- The slice must match current repo maturity rather than future ambition.
- The slice must reinforce one canonical execution surface.
- The slice must improve clarity or validation for already-documented behavior.
- The slice must stay small enough for one checkpoint-sized follow-on implementation.
- The slice must avoid implying that `src/` is ready before the current threshold is met.

# Winning Slice

The winning slice is Candidate 1: a documented metadata-contract enforcement slice for the existing `brief` surface.

# Why It Wins Now

Candidate 1 wins because it strengthens a shell capability that already exists, already has documented behavior, and is already named in the architecture checkpoint as the most immediate area needing hardening.

It is the best fit for the repo's current state because:

- it improves execution-surface clarity without adding a second runtime story
- it turns current conventions into a more testable contract instead of leaving them partly implied
- it supports the synthesis lesson that validation should reinforce documented reality
- it remains local-first and repo-centered rather than inventing a broader product capability
- it helps answer an open decision already named in the checkpoint: whether `brief` should validate conventions, degrade gracefully, or both

Candidate 2 does not win because the current docs still say `src/` is not justified. Starting a source-level engine now would cross the threshold before the repo has one documented capability that is more than inspection, summarization, or scaffolding.

Candidate 3 is plausible, but it is weaker than Candidate 1 because local-state hygiene is important yet still secondary to the more immediate ambiguity around the `brief` contract. The shell already depends on prompt and agent metadata conventions, so clarifying and validating that contract has a more direct architectural payoff.

# Scope Guardrails

- The chosen slice is a shell-surface hardening move, not a runtime expansion.
- It should stay focused on prompt-pack and super-agent metadata conventions that the existing `brief` behavior depends on.
- It should define preferred headings, supported fallback headings, and warning-versus-fail boundaries in original project language.
- It should not create a new planner, search engine, ranking engine, or general lint framework.
- It should not broaden into a repo-wide policy system.
- It should not move logic into `src/`.
- It should not rewrite the roadmap beyond clarifying this one next slice.

# Why It Belongs In scripts Or src

This slice belongs in `scripts/`, not `src/`.

The deciding reasons are:

- the current executable truth is still the bootstrap shell
- the capability remains repository-oriented and metadata-oriented rather than product-facing
- the architecture checkpoint explicitly says the next move still belongs in `scripts/`
- the bootstrap plan says Phase 2 remains open until the shell-supported surface is hardened and one later source-level capability is defined

If this slice succeeds, it may help define the conditions for a future `src/` capability, but it is not itself that capability.

# Immediate Execution Shape

The immediate execution shape for the next implementation task should be:

- document the `brief` metadata contract more decisively where needed
- choose the exact enforcement posture for missing or weak metadata
- keep the shell as the only execution entrypoint
- add only the smallest validation needed to prove the contract works as documented
- record the result as a narrow checkpoint that still leaves `src/` untouched

The intended outcome is not "a smarter system." The intended outcome is "a clearer and more trustworthy bootstrap shell surface."

# Clean-Room Notes

- This decision uses the clean-room synthesis as guidance, not as a source for implementation borrowing.
- It does not copy reference naming, layouts, or subsystem designs from `c.src.code`.
- It chooses a next slice by comparing `clau-dex`-local options against current repo truth.
- Manual review evidence used here:
- `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md` emphasized one canonical execution surface, validation-backed architecture, secondary-surface discipline, and caution against premature breadth.
- `docs/ARCHITECTURE_CHECKPOINT.md` stated that the next move remains in `scripts/` and specifically called out the `brief` contract as a near-term hardening target.
- `docs/BOOTSTRAP_PLAN.md` kept Phase 2 in execution-surface hardening and delayed Phase 3 until one source-level capability is explicitly defined.
- Final scope check: this document compares exactly three realistic candidate slices, selects exactly one winner, states that the winner belongs in `scripts/`, and does not claim that `src/` is ready now.
