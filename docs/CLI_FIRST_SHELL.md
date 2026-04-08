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
- list key documentation, prompt, and agent assets
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
- `docs`
- `prompts`
- `agents`

## Verification
Manual verification for this shell definition:
- Confirm the shell is documented as a local repository helper, not a full runtime.
- Confirm the command surface is limited to repository navigation and state reporting.
- Confirm the script location and non-goals are clear.
