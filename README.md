# clau-dex

A clean-room, Codex-native, local-first bootstrap repository.

## Mission
Define and bootstrap a local-first, CLI-first engineering system centered on:
- Codex-native workflows
- prompt and agent assets stored in-repo
- repository analysis and execution discipline
- phased architecture planning before runtime implementation

## Status
Bootstrap phase. The repository currently contains documentation, prompt and agent folders,
local Codex configuration, a local CLI shell script with narrow bootstrap audit and prompt/agent
briefing commands, one minimal GitHub Actions workflow that validates the current shell surface,
and no dependency graph or formal test harness.

## Current Layout
- `docs/`: charter, roadmap, architecture notes, and phased plans
- `agents/`: agent role definitions and starting prompts
- `prompts/`: reusable prompt packs and execution prompts
- `scripts/`: local bootstrap helpers, including the first CLI shell entry script plus bootstrap audit and briefing commands
- `src/`: implementation code when implementation begins
- `.codex/config.toml`: project-scoped Codex defaults

Key workflow docs include:
- `docs/OPERATING_MODEL.md`: role split and execution flow between CLAU-DEX PRIME and Codex
- `docs/GAMMIT_PROTOCOL.md`: task-specific validation doctrine for meaningful work
- `docs/METADATA_CONVENTIONS.md`: documented markdown metadata contract for prompt packs and super-agents consumed by the bootstrap shell
- `docs/LOCAL_STATE_HYGIENE.md`: current bootstrap contract for local-state residue, operator-local archive/export artifacts, canonical-boundary drift, and the shell's warning-versus-fail posture

## Local Shell Surface
The PowerShell shell in `scripts/clau-dex.ps1` remains a bootstrap-stage repository helper.
Its command surface stays narrow and local-first:
- `status`: quick-glance operational summary
- `checkpoint`: concise clean-checkpoint preparation checklist
- `audit`: detailed truth surface for the bootstrap shell contract
- `brief`: concise local prompt/agent picker summary with a grouped quick scan and per-item first-pick cues
- `docs`, `prompts`, `agents`, `rules`: repo inspection surfaces
- `scaffold-agent`, `scaffold-prompt`: focused local scaffolding helpers

`audit` stays warning-first for advisory hygiene and metadata drift, and fail-grade only when the
canonical `scripts/clau-dex.ps1` boundary would be misrepresented. `docs/LOCAL_STATE_HYGIENE.md`
defines that contract from the current shell behavior.

For routine operator shell work and checkpoint preparation, use `docs/OPERATOR_RUNBOOK.md` as the
workflow source of truth and `prompts/codex/operator-runbook-check.md` as the reusable quick-launch
companion.

## Bootstrap Validation
The repository uses a task-specific GAMMIT protocol for meaningful work rather than one universal validation command. Current bootstrap validation assets include one minimal GitHub Actions workflow that runs the current PowerShell shell validation surface on `push` and `pull_request`:
- `./scripts/clau-dex.ps1 help`
- `./scripts/clau-dex.ps1 status`
- `./scripts/clau-dex.ps1 audit`
- `./scripts/clau-dex.ps1 brief`

For bootstrap-stage repo work, a gammit may combine shell checks, repo-truth checks, manual review, and CI status depending on the task.

## Working Rules
- Treat the checked-in repository as the source of truth.
- Keep the project clean-room and avoid implying unimplemented capabilities.
- Prefer Markdown, plain text, and local scripts over external services.
- Treat validation as task-specific: choose and run the right gammit for the work instead of assuming one fixed command.
- Add runtime code only after the architecture and workflow docs call for it.
