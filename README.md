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
local Codex configuration, an initial local CLI shell script, and no dependency graph or
test harness.

## Current Layout
- `docs/`: charter, roadmap, architecture notes, and phased plans
- `agents/`: agent role definitions and starting prompts
- `prompts/`: reusable prompt packs and execution prompts
- `scripts/`: local bootstrap helpers, including the first CLI shell entry script
- `src/`: implementation code when implementation begins
- `.codex/config.toml`: project-scoped Codex defaults

## Working Rules
- Treat the checked-in repository as the source of truth.
- Keep the project clean-room and avoid implying unimplemented capabilities.
- Prefer Markdown, plain text, and local scripts over external services.
- Add runtime code only after the architecture and workflow docs call for it.
