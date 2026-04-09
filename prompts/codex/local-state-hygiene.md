# Codex Prompt Pack: Local-State Hygiene

## Role
You are Codex implementing an explicitly approved `clau-dex` bootstrap slice for local-state hygiene and canonical-boundary checks.

## Goal
Add only the smallest shell-first bootstrap hardening needed to make local-state hygiene and canonical execution boundaries easier to inspect, warn on, and trust without implying a broader runtime, policy engine, or `src/` implementation.

## Use This Prompt When
- the task has been explicitly approved as the local-state hygiene and canonical-boundary slice inside the shell-first bootstrap surface
- the work needs narrow checks or warning-grade reporting for local-state drift, untracked bootstrap residue, or canonical-surface boundary clarity
- the implementation should stay in `scripts/` and should not introduce runtime work in `src/`

## Required Inputs
- the user request
- `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md`
- `docs/NEXT_SLICE_DECISION.md`
- `docs/CLEAN_ROOM_POLICY.md`
- `docs/CLI_FIRST_SHELL.md`
- `docs/GAMMIT_PROTOCOL.md`
- `prompts/codex/gammit-pass.md`
- `scripts/clau-dex.ps1`
- any docs or script files directly affected by the approved hygiene or boundary-check change

## Operating Rules
- start with repo inspection and manual review of the required docs before editing
- keep the shell in `scripts/` as the canonical execution surface for this slice
- keep the slice narrow: local-state hygiene and canonical-boundary checks only
- add only the smallest checks needed to make bootstrap-local drift or boundary confusion visible
- prefer warning-grade reporting when the issue is advisory, recoverable, or useful for operator awareness rather than hard failure
- reserve fail behavior for cases where the documented canonical shell boundary would otherwise be misrepresented or broken
- keep future implementation in `scripts/`, not `src/`
- do not add shell code in this prompt-pack creation task; future implementation should use this prompt in a separate task
- do not add runtime code in `src/`
- do not add frameworks, package manifests, lockfiles, CI changes, or containers
- do not widen the slice into a generic scanner, linter, policy engine, or repo-wide enforcement layer
- do not broaden the task into general metadata enforcement, semantic search, or unrelated bootstrap hardening
- define and run a task-specific gammit before checkpointing, using `prompts/codex/gammit-pass.md` as the validation companion
- keep all language and implementation choices clean-room safe and authored from repo-local truth

## Expected Output
Produce:
1. a narrow implementation or documentation change set for local-state hygiene and canonical-boundary checks within the shell-first bootstrap surface
2. a short statement of the exact slice being implemented, including what counts as local-state hygiene and what counts as a canonical-boundary check for this task
3. a task-specific gammit result that includes:
   - the final changed-file list
   - the exact implementation slice this prompt pack is meant to drive
   - PASS, FAIL, or INCOMPLETE
   - explicit evidence from manual review against `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md`
   - explicit evidence from manual review against `docs/NEXT_SLICE_DECISION.md`
   - explicit evidence from `.\scripts\clau-dex.ps1 brief`
4. a recommended checkpoint commit message

## Completion Standard
The work is complete when the resulting change targets only local-state hygiene and canonical-boundary checks inside the shell-first bootstrap surface, keeps future implementation in `scripts/`, avoids `src/` runtime work and CI widening, remains warning-first where appropriate, includes a task-specific gammit run with explicit evidence, and is tight enough for one checkpoint commit.
