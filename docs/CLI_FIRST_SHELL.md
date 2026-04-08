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
- print a concise operating-rules summary from the current repo docs
- scaffold a focused agent prompt file from a local template shape
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
- `rules`
- `new-agent <name>`
- `scaffold-agent <name>`

`new-agent <name>` and `scaffold-agent <name>` both expose the first real orchestration slice in the shell. They create a small Markdown scaffold under `agents/super-agents/` so repeated agent-role authoring starts from a consistent local template instead of a blank file.

`audit` is the second executable slice. It checks only a narrow bootstrap-state surface:
- required top-level files and directories that define the documented bootstrap repo shape
- expected docs, prompt, agent, script, and `src/` asset folders
- `src/` still contains only `README.md`
- package manifests and lockfiles are absent
- one minimal GitHub Actions workflow exists only to validate `help`, `status`, and `audit` on `push` and `pull_request`
- other CI, container, and deployment artifacts are absent
- `scripts/clau-dex.ps1` exists and `scripts/README.md` documents it

The audit stays intentionally explicit and hardcoded. It is not a generic policy engine, linter, or repo-wide search tool.

## Verification
Manual verification for this shell definition:
- Confirm the shell is documented as a local repository helper, not a full runtime.
- Confirm the command surface remains small and local-first.
- Confirm `audit` reports PASS / WARN / FAIL results against the documented bootstrap-state checks.
- Confirm the minimal GitHub Actions workflow stays limited to validating `help`, `status`, and `audit`.
- Confirm `rules` summarizes the current operating constraints without implying extra automation.
- Confirm `new-agent <name>` creates a focused agent prompt file under `agents/super-agents/`.
- Confirm `scaffold-agent <name>` creates the same focused agent prompt file under `agents/super-agents/`.
- Confirm the script location and non-goals are clear.
