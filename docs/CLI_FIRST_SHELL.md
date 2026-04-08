# CLI-First Orchestration Shell

## Purpose
This document defines the first executable surface for `clau-dex`: a minimal, local-first CLI shell that helps operators inspect and navigate the repository without implying a larger application runtime.

## Why This Exists
The repository has reached the point where repeated manual orientation work is predictable:
- checking the current bootstrap state
- locating core docs
- locating prompt packs and super-agent definitions
- confirming the local shell entry surface

That repeated workflow is sufficient to justify one small executable artifact in `scripts/`.

## First Shell Scope
The first CLI shell is intentionally narrow. It should:
- present a help surface
- report the current repository bootstrap status from checked-in files
- audit a small hardcoded bootstrap-state surface from checked-in files
- list key documentation, prompt, and agent assets
- generate a concise local briefing from checked-in prompt packs and super-agent files
- print a concise operating-rules summary from the current repo docs
- scaffold a focused agent prompt file from a local template shape
- scaffold a convention-compliant prompt-pack markdown file from a local template shape
- avoid any dependency on package managers, frameworks, or external services

## Non-Goals
The first CLI shell does not:
- orchestrate remote agents or hosted services
- manage dependencies or environments
- execute application features from `src/`
- claim a packaged product runtime
- replace future implementation planning

## Implementation Location
The first shell lives in `scripts/` as a local PowerShell entry script. This keeps the execution surface honest: it is a repository helper, not yet a full application layer.

## Initial Command Shape
The first command surface should stay small and explicit:
- `help`
- `status`
- `audit`
- `docs`
- `prompts`
- `agents`
- `brief`
- `rules`
- `new-agent <name>`
- `scaffold-agent <name>`
- `scaffold-prompt <name>`

`new-agent <name>` and `scaffold-agent <name>` both expose the first real orchestration slice in the shell. They create a small Markdown scaffold under `agents/super-agents/` so repeated agent-role authoring starts from a consistent local template instead of a blank file.

`scaffold-prompt <name>` creates a small Markdown prompt-pack scaffold under `prompts/codex/`. It stays intentionally narrow: one local template, one default target area, and the preferred prompt-pack metadata headings already documented for `brief`.

`audit` is the second executable slice. It checks only a narrow bootstrap-state surface:
- required top-level files and directories that define the documented bootstrap repo shape
- expected docs, prompt, agent, script, and `src/` asset folders
- `src/` still contains only `README.md`
- package manifests and lockfiles are absent
- prompt packs still expose the minimum `brief` metadata heading `## Goal`
- super-agents still expose the minimum `brief` metadata heading `## Purpose`
- one minimal GitHub Actions workflow exists only to validate `help`, `status`, and `audit` on `push` and `pull_request`
- other CI, container, and deployment artifacts are absent
- `scripts/clau-dex.ps1` exists and `scripts/README.md` documents it

Missing `brief` metadata headings warn instead of fail so the audit can flag drift without blocking bootstrap work. The audit stays intentionally explicit and hardcoded. It is not a generic policy engine, linter, or repo-wide search tool.

`brief` is the third executable slice. It turns the checked-in prompt packs and super-agent files into a short local picker brief by reading local markdown headings such as goals, purposes, and best-use bullets. It should:
- stay fully local and deterministic
- summarize only checked-in prompt and agent assets
- help operators choose between prompt packs and super-agent roles faster
- degrade gracefully when preferred headings are missing by trying a small documented set of heading aliases
- show explicit missing-metadata notices when summary or best-use fields cannot be read
- perform a tiny convention check that reports when the preferred prompt or agent headings are absent
- avoid remote search, network access, embeddings, or AI-generated recommendations

The heading contract for that briefing behavior is documented in `docs/METADATA_CONVENTIONS.md`. That document is the repo truth for preferred headings, supported fallback headings, and current warning-only metadata drift behavior.

The briefing stays intentionally lightweight. It is not a semantic search engine, ranking system, or dynamic planner.

## Verification
Manual verification for this shell definition:
- Confirm the shell is documented as a local repository helper, not a full runtime.
- Confirm the command surface remains small and local-first.
- Confirm `audit` reports PASS / WARN / FAIL results against the documented bootstrap-state checks.
- Confirm `brief` produces a concise local summary from checked-in prompt packs and super-agent files.
- Confirm the minimal GitHub Actions workflow stays limited to validating `help`, `status`, `audit`, and `brief`.
- Confirm `rules` summarizes the current operating constraints without implying extra automation.
- Confirm `new-agent <name>` creates a focused agent prompt file under `agents/super-agents/`.
- Confirm `scaffold-agent <name>` creates the same focused agent prompt file under `agents/super-agents/`.
- Confirm `scaffold-prompt <name>` creates a prompt-pack file under `prompts/codex/` with the documented preferred prompt metadata headings.
- Confirm the script location and non-goals are clear.
