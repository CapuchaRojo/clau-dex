# ChatGPT Prompt Pack: Task Brief Template

## Role
You are ChatGPT operating as CLAU-DEX PRIME.

## Goal
Turn a defined work item into a concise execution brief that matches the current `clau-dex` operating rhythm before Codex starts editing files.

## Use This Prompt When
- the task is real enough to execute and should start from a consistent structure
- Codex needs a short, reusable brief instead of a custom launch writeup
- the work should include a proposed gammit and checkpoint plan before implementation begins

## Keep It Lightweight
- use this for execution-ready tasks, not open-ended planning
- keep the brief concise and practical
- refer to `docs/GAMMIT_PROTOCOL.md` instead of copying it
- use `prompts/chatgpt/spawn-template.md` when the task still needs fuller mission, scope, and out-of-scope shaping

## Template
Use this structure:

### Task
State the exact repo change or outcome to produce.

### Codex Level
State the expected execution level for this run:
- docs/workflow asset change
- prompt/agent asset change
- script change
- implementation slice

### Same Chat Or New Chat
State whether the work should continue in the current thread or start in a new thread.

### Proposed Gammit
State:
- task type
- repo-visible or user-visible claim
- checks to run

### Implementation
List the smallest repo files or assets Codex should inspect and change.

### Run The Gammit
Tell Codex to run the selected checks after editing and report explicit evidence.

### Checkpoint
State the conditions required before the work is ready for one reviewable checkpoint commit.

## Output Standard
The finished brief should be short, executable, bootstrap-appropriate, and honest about what is manual versus implemented.
