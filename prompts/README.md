# Prompts

Store reusable prompt packs here.

For a fuller workflow-based map of the current prompt library, see `docs/PROMPT_LIBRARY_MAP.md`.

## Layout
- `codex/`: execution prompts for Codex-side repo work
- `chatgpt/`: planning and launch prompts for ChatGPT / CLAU-DEX PRIME

## Quick Index

Use this README as the short entrypoint. Use `docs/PROMPT_LIBRARY_MAP.md` when you need the richer prompt-family grouping.
If a prompt-pack change affects catalog discoverability, review `docs/CATALOG_MAINTENANCE.md` before leaving maps or indexes behind.

Current prompt packs group loosely as:

- bootstrap and docs: `codex/bootstrap-docs.md`, `codex/repo-audit.md`
- clean-room and reference: `codex/clean-room-analysis.md`, `codex/lawful-reference-audit.md`
- hygiene and boundaries: `codex/local-state-hygiene.md`, `codex/hygiene-warning-remediation.md`, `codex/brief-metadata-enforcement.md`, `codex/metadata-triage-check.md`, `codex/metadata-fix-check.md`
- operator workflow: `codex/shell-surface-chooser.md`, `codex/workflow-entry-chooser.md`, `codex/operator-runbook-check.md`, `codex/catalog-maintenance-check.md`, `codex/metadata-workflow-chooser.md`, `codex/parser-lane-chooser.md`
- gammit and checkpoint: `codex/gammit-pass.md`
- ChatGPT launch templates: `chatgpt/spawn-template.md`, `chatgpt/task-brief-template.md`

Metadata warning workflow pointer: examples live in `docs/METADATA_WARNING_EXAMPLES.md`, triage lives in `codex/metadata-triage-check.md`, narrow asset repair lives in `codex/metadata-fix-check.md`, and approved contract-side changes belong in `codex/brief-metadata-enforcement.md`.
Need a quick workflow-step recommendation first? Start with `codex/metadata-workflow-chooser.md`.

## Current Reusable Launch Assets

- `codex/lawful-reference-audit.md`: lawful audit lane for public, open-source, owned, or explicitly authorized external repos with explicit prohibited-source boundaries
- `codex/gammit-pass.md`: task-specific validation companion for choosing and running the right gammit with explicit evidence
- `codex/catalog-maintenance-check.md`: narrow catalog-maintenance prompt for deciding whether prompt-pack or super-agent changes need metadata, map, or README alignment work
- `codex/metadata-workflow-chooser.md`: narrow chooser for deciding whether the immediate metadata need is examples, triage, narrow repair, or contract-side enforcement
- `codex/parser-lane-chooser.md`: narrow chooser for deciding whether parser-adjacent work belongs in shell/docs, metadata workflow, parser-readiness planning, or a later `src/` parser lane; for the concrete planning contract, see `docs/PARSER_RECORD_SPEC.md` and `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`; for first code-launch planning, see `docs/FIRST_PARSER_FILESET_PLAN.md` and `docs/PARSER_VALIDATION_PREFLIGHT.md`; and for the implementation-facing planning pair, see `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md` and `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- `codex/metadata-triage-check.md`: operator-facing metadata warning triage for choosing fix-now, defer, or split-into-its-own-checkpoint
- `codex/metadata-fix-check.md`: narrow metadata-repair prompt for making one prompt pack or super-agent more brief-ready after triage says the fix belongs now
- `codex/shell-surface-chooser.md`: picker-oriented prompt for choosing between `status`, `audit`, `brief`, and `checkpoint`
- `codex/workflow-entry-chooser.md`: picker-oriented prompt for choosing across current shell entry surfaces and their supporting workflow docs
- `chatgpt/spawn-template.md`: fuller task-shaping prompt for turning rough intent into a launch brief
- `chatgpt/task-brief-template.md`: lighter execution-ready brief template for starting consistent scoped work with a proposed gammit and checkpoint

## Conventions
- Keep prompts task-oriented and reusable.
- Prefer one prompt per repeatable workflow.
- State the role, goal, inputs, constraints, and expected output shape.
- Keep repository policy in `AGENTS.md` and `docs/` unless the prompt needs a role-specific reminder.
