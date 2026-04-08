# Repository Guidelines

## Project Intent
`clau-dex` is a clean-room, Codex-native, local-first project. Treat the repository as the source of truth. Do not claim or design around capabilities that are not present in this repo. At the time of writing, the installed project assets are bootstrap documentation, prompt/agent folders, a project-scoped Codex config, and no application runtime, package manager lockfile, test harness, or CI pipeline.

## Current Repository Reality
- `clau-dex` is in bootstrap mode, not implementation mode.
- Documentation and repository policy are first-class project assets.
- `src/` is intentionally reserved for future implementation, not placeholder code.
- If a capability is not represented by checked-in files, describe it as planned, not existing.

## Repo Layout
- `src/`: implementation code when it exists. Keep modules small and composable.
- `agents/`: specialized agent definitions and starting prompts.
- `prompts/`: reusable prompt packs and execution prompts.
- `scripts/`: local automation, validation, and bootstrap helpers.
- `docs/`: charter, roadmap, and architecture notes.
- `.codex/config.toml`: local Codex defaults for this repo.

If you add a new top-level directory, update `README.md` and the nearest folder `README.md` in the same change.

## Workflow Rules
- Start with repo inspection, not assumptions. Read existing docs before proposing structure.
- Prefer local files, local scripts, and checked-in prompts over remote services.
- Keep changes narrow. One task, one concern, one coherent diff.
- Do not add frameworks, dependencies, or external services without a committed need and a matching doc update.
- When behavior is aspirational rather than implemented, label it as planned in `docs/` instead of implying it exists.
- Prefer docs-only changes when the task is architectural or policy-oriented.
- Do not create placeholder application modules, fake CLIs, or speculative config files to suggest progress.
- Before adding any executable artifact, document why the manual workflow is insufficient.

## Documentation Rules
- Update `README.md` when the repo's advertised purpose, status, or top-level structure changes.
- Put durable architecture and planning material in `docs/`, not scattered across prompts.
- Keep folder `README.md` files short and role-specific; avoid duplicating policy text everywhere.
- Record verification steps in the same change, even if they are manual.
- If a new convention is introduced for prompts, agents, or scripts, document it before relying on it.

## Git Checkpoint Discipline
- Commit in small checkpoints with Conventional Commit subjects, e.g. `docs: tighten contributor rules`.
- Make a checkpoint when a unit of work becomes reversible and reviewable.
- Before each checkpoint, run `git status` and verify only intended files changed.
- Do not mix repository policy edits, prompt content, and source implementation in the same commit unless they are inseparable.

## Local-First Assumptions
- The project must remain understandable and operable from the local checkout.
- Document any required command in-repo before depending on it.
- Never commit secrets, `.env` files, caches, build output, or virtual environments.
- Prefer plain text artifacts and Markdown docs that Codex can inspect directly.

## Execution Guardrails
- Do not assume internet access, hosted services, or background infrastructure.
- Do not introduce package manifests, lockfiles, CI configs, containers, or frameworks during bootstrap unless the task explicitly requires them and docs are updated in the same change.
- Do not reference proprietary, leaked, or unavailable source material. Clean-room means the repository and user-provided context are the only design inputs unless the user clearly approves another source.
- Keep scripts optional and local. Every new script should be understandable from its file contents and companion docs.
- Preserve CLI-first direction. If a future interface is discussed, document it as planned until code exists.

## Preferred Bootstrap Sequence
1. Clarify policy and architecture.
2. Define prompt and agent conventions.
3. Add lightweight validation helpers if repeated manual checks appear.
4. Add the first implementation slice only after its scope and verification approach are documented.

## Definition of Done
A change is done when:

- the affected files are consistent with the charter and roadmap,
- the scope is reflected in repo docs when structure or workflow changed,
- no uninstalled capability is implied,
- verification steps are recorded, even if verification is manual,
- `git diff` is tight and reviewable,
- the change is ready to stand alone as a checkpoint commit.
