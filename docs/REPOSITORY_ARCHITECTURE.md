# Repository Architecture

## Intent
This document defines the proposed repository architecture for the bootstrap phase of
`clau-dex`. It is intentionally documentation-first. It does not imply that runtime
code, packaging, or orchestration features already exist.

## Operating Constraints
- Clean-room implementation only
- Local-first, CLI-first usage
- Repository truth over aspirational descriptions
- Minimal moving parts until a concrete implementation need exists
- Plain text artifacts preferred wherever possible

## Proposed Repository Roles

### `docs/`
The durable source for project intent, constraints, architecture decisions, and phased
bootstrap planning.

Planned contents:
- charter and roadmap
- repository architecture notes
- decision records when tradeoffs need to be captured
- verification notes for manual bootstrap milestones

### `agents/`
Role definitions and starting prompts for specialized Codex-side execution.

Recommended shape when content is added:
- one file per agent role
- each file states purpose, inputs, outputs, boundaries, and handoff rules
- avoid embedding repository policy here unless the policy is role-specific

### `prompts/`
Reusable prompt packs for repeatable workflows.

Recommended shape when content is added:
- task-oriented prompt files rather than large mixed bundles
- short front matter or heading block describing intended use
- explicit distinction between planning prompts and execution prompts

### `scripts/`
Local helper scripts only after a documented, repeated workflow exists.

Script guardrails:
- no dependency on untracked tools without documentation
- prefer simple validation and bootstrap helpers over automation sprawl
- each script should have a matching usage note in this folder or in `docs/`

### `src/`
Reserved for implementation code once the project crosses from bootstrap planning into
actual product development.

Near-term constraint:
- keep `src/` empty except for documentation until architecture, interfaces, and the
  first concrete executable scope are agreed

## Suggested Content Boundaries
- Put policy in `AGENTS.md`, not inside every prompt.
- Put durable architecture decisions in `docs/`, not in `README.md`.
- Put reusable operating prompts in `prompts/`, not mixed into implementation files.
- Put executable helpers in `scripts/` only when they replace repeated manual steps.
- Put application code in `src/` only when the repository is ready to support it.

## Near-Term Growth Path
1. Tighten repository policy and bootstrap docs.
2. Define prompt and agent file conventions.
3. Add one or two narrow validation scripts if manual workflows repeat.
4. Define the first implementation slice before creating runtime code in `src/`.

## Deferred Until Proven Necessary
- package manager selection
- framework selection
- CI configuration
- deployment workflow
- packaging and distribution
- multi-environment configuration
