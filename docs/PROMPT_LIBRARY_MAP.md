# Purpose

This map helps operators find the right current prompt family in `clau-dex` faster without changing shell behavior.

It summarizes the prompt packs that are actually checked in under `prompts/codex/` and `prompts/chatgpt/`, grouped by practical workflow purpose rather than by folder alone.

# Prompt Families

## Bootstrap And Docs Prompts

Use these when the work is mainly about repo policy, documentation, bootstrap conventions, or truth-surface clarity.

- `prompts/codex/bootstrap-docs.md`
- `prompts/codex/repo-audit.md`

## Clean-Room And Reference Prompts

Use these when the task involves lawful outside references or clean-room-safe synthesis boundaries.

- `prompts/codex/clean-room-analysis.md`
- `prompts/codex/lawful-reference-audit.md`

## Hygiene And Boundary Prompts

Use these when the task is about local-state residue, warning interpretation, canonical shell boundaries, or narrow bootstrap hardening around those topics.

- `prompts/codex/local-state-hygiene.md`
- `prompts/codex/hygiene-warning-remediation.md`
- `prompts/codex/brief-metadata-enforcement.md`

## Operator Workflow Prompts

Use these when the operator needs help choosing among the current shell surfaces or applying the runbook honestly during routine work.

- `prompts/codex/shell-surface-chooser.md`
- `prompts/codex/operator-runbook-check.md`

## Gammit And Checkpoint Prompts

Use these when the task needs explicit validation planning, evidence capture, and checkpoint discipline.

- `prompts/codex/gammit-pass.md`

## ChatGPT Launch Templates

Use these when CLAU-DEX PRIME or ChatGPT is shaping work before Codex starts editing.

- `prompts/chatgpt/spawn-template.md`
- `prompts/chatgpt/task-brief-template.md`

# When To Use Each Family

- Start with `Bootstrap And Docs Prompts` when the task is docs-first and should not imply runtime capability.
- Use `Clean-Room And Reference Prompts` when outside material is involved and the main risk is crossing the clean-room boundary.
- Use `Hygiene And Boundary Prompts` when the question is about warnings, local residue, canonical shell boundaries, or the narrow `brief` metadata slice.
- Use `Operator Workflow Prompts` when the operator needs to choose between `status`, `audit`, `brief`, and `checkpoint`, or apply the current runbook/checkpoint posture.
- Use `Gammit And Checkpoint Prompts` when the work needs a task-specific validation plan before editing and explicit pass/fail evidence after editing.
- Use `ChatGPT Launch Templates` when the task still needs shaping into a reusable launch brief before Codex execution.

# Current Prompt Packs

## Codex Prompt Packs

- `bootstrap-docs.md`: docs-first bootstrap drafting for policy, architecture, and workflow clarification.
- `brief-metadata-enforcement.md`: narrow prompt for the approved `brief` metadata-contract slice.
- `clean-room-analysis.md`: clean-room-safe synthesis from allowed reference-informed material.
- `gammit-pass.md`: task-specific validation planning and final evidence-based pass/fail reporting.
- `hygiene-warning-remediation.md`: narrow remediation for hygiene and canonical-boundary warnings.
- `lawful-reference-audit.md`: lawful external reference audit with explicit do-not-import boundaries.
- `local-state-hygiene.md`: narrow shell-first hygiene and canonical-boundary hardening slice.
- `operator-runbook-check.md`: practical operator guidance for shell use, warnings, and checkpoint prep.
- `repo-audit.md`: checked-in repo truth audit against current docs and structure.
- `shell-surface-chooser.md`: fast picker for `status`, `audit`, `brief`, and `checkpoint`.

## ChatGPT Prompt Packs

- `spawn-template.md`: fuller launch shaping when mission, scope, and boundaries still need to be defined.
- `task-brief-template.md`: lighter execution-ready brief for scoped work with a proposed gammit and checkpoint.

# How This Relates To brief

`.\scripts\clau-dex.ps1 brief` is the shell picker surface for current prompt packs and agent assets. This map does not replace `brief` or change its behavior.

Instead, this document complements `brief` by:

- grouping the checked-in prompt packs by workflow purpose
- giving operators a stable docs reference when prompt filenames alone are not enough
- clarifying where similar packs differ, especially around operator workflow, hygiene, and gammit use

Use `brief` for the concise shell summary. Use this map when you need a slightly richer explanation of which current prompt family fits the task.

# Non-Goals

- Do not introduce new shell commands or change `brief` behavior.
- Do not invent future prompt packs, agent roles, or ranking behavior.
- Do not imply runtime code, `src/` implementation, or broader automation.
- Do not duplicate prompt files in full.
- Do not restate repository policy that already belongs in `AGENTS.md` or other docs unless it directly helps prompt selection.

# Verification

Manual verification for this map:

- review `prompts/README.md`
- review `README.md`
- review `docs/OPERATOR_RUNBOOK.md`
- review the checked-in prompt packs under `prompts/codex/` and `prompts/chatgpt/`
- run `.\scripts\clau-dex.ps1 brief`
- confirm every family in this map is grounded in real checked-in prompt files
- confirm the groupings describe current workflow purpose rather than future plans
- confirm this change adds only `docs/PROMPT_LIBRARY_MAP.md`
- confirm no shell, `src/`, CI, or workflow files were changed
