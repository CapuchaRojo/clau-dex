# Codex Prompt Pack: Brief Metadata Enforcement

## Role
You are Codex implementing the approved next slice for `clau-dex`: metadata-contract enforcement for the existing `brief` shell surface.

## Goal
Harden the metadata contract used by `.\scripts\clau-dex.ps1 brief` so the shell remains the canonical execution surface, the warning-versus-fail posture is chosen and documented carefully, and only the smallest validation needed to prove the contract is added in `scripts/`.

## Use This Prompt When
- the task is specifically the approved next slice from `docs/NEXT_SLICE_DECISION.md`
- `brief` metadata behavior for prompt packs or super-agents needs to be clarified, tightened, or minimally validated
- the work should stay in the bootstrap shell and must not introduce a runtime slice in `src/`

## Required Inputs
- the user request
- `docs/NEXT_SLICE_DECISION.md`
- `docs/METADATA_CONVENTIONS.md`
- `docs/CLI_FIRST_SHELL.md`
- `docs/GAMMIT_PROTOCOL.md`
- `prompts/codex/gammit-pass.md`
- `scripts/clau-dex.ps1`
- any docs or prompt assets directly affected by the metadata-contract change

## Operating Rules
- start with repo inspection and confirm the task matches the winning slice exactly before editing
- keep the shell in `scripts/` as the canonical execution surface for this work
- harden only the metadata contract that `brief` already uses for prompt packs and super-agents
- choose warning versus fail behavior deliberately and document that choice in repo language before relying on it
- add only the smallest validation needed to prove the documented contract; do not turn this slice into a general lint engine, search engine, ranking engine, or repo-wide policy system
- do not add runtime code in `src/`
- do not create new shell code just because this prompt pack exists; implement shell changes only when the requested task explicitly requires them
- do not broaden the slice into semantic search, embeddings, AI-generated ranking, or repo-wide metadata enforcement
- keep the change narrow, practical, local-first, and bootstrap-appropriate
- define and run a task-specific gammit before checkpointing by using `prompts/codex/gammit-pass.md` as the validation companion instead of duplicating its full protocol here

## Expected Output
Produce:
1. a narrow implementation or documentation change set that targets only `brief` metadata-contract enforcement for the approved next slice
2. a concise explanation of the exact warning-versus-fail posture chosen for this slice
3. a task-specific gammit summary with:
   - final changed-file list
   - the exact implementation slice driven by the prompt
   - PASS, FAIL, or INCOMPLETE
   - explicit evidence from manual review against `docs/NEXT_SLICE_DECISION.md`
   - explicit evidence from manual review against `docs/METADATA_CONVENTIONS.md`
   - explicit evidence from `.\scripts\clau-dex.ps1 brief`
4. a recommended checkpoint commit message

## Completion Standard
The work is complete when the resulting change stays in the approved `brief` metadata-enforcement slice, keeps implementation in `scripts/` rather than `src/`, avoids shell/runtime creep, includes a task-specific gammit run, complements `prompts/codex/gammit-pass.md` instead of duplicating it, and is tight enough for one checkpoint commit.
