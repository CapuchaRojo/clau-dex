# GAMMIT Protocol

## Purpose
The gammit is the task-specific validation pass required before a meaningful `clau-dex` task can be considered complete.

In `clau-dex`, "run the gammit" means choose the right checks for the task at hand, execute them, and record clear pass or fail evidence. It does not mean "run one fixed command."

## What A Gammit Is
A gammit is a small validation bundle shaped around the actual change. It may include one or more of the following:
- shell command checks
- `audit` output
- `brief` output
- CI workflow status
- smoke tests
- `curl` or API checks
- truth checks against checked-in repo state
- file or path assertions
- manual review steps
- future `npm`, `python`, or other test runs when those ecosystems exist in-repo

The gammit is part of task completion, not an optional extra after the "real" work.

## Why Gammits Are Task-Specific
`clau-dex` is bootstrap-stage, local-first, and intentionally narrow. The repository already contains different kinds of work:
- docs and policy changes
- prompt and agent asset changes
- shell behavior changes
- CI surface changes
- future source-code changes
- future API-facing work

Those task types do not share one honest universal validator. A docs-only change may need repo-truth checks and manual review. A shell change may need command output checks. A CI change may need workflow evidence. Future application code may need unit tests and smoke tests once those assets exist.

Treating every task as if one command can prove correctness would hide real task differences and encourage fake certainty.

## When A Gammit Is Required
A gammit is required for every meaningful task that changes repository truth, including:
- documentation or workflow changes
- prompt or agent convention changes
- script or shell behavior changes
- CI workflow changes
- future implementation work in `src/`

Tiny no-op edits such as typo fixes may use a very small gammit, but they still need an explicit validation note. If the task matters enough to checkpoint, it needs a gammit.

## What Counts As Passing
A gammit passes when:
- the chosen checks match the task that was actually performed
- each check has explicit evidence, not implication
- required checks are green, or any non-blocking warnings are clearly labeled as warnings
- the evidence supports the user-visible claim being made
- the final summary says what passed, what was reviewed manually, and what remains intentionally out of scope

A gammit does not pass just because no error was observed during editing. "Seems fine" is not evidence.

## How To Choose The Right Gammit
Choose the gammit before implementation starts.

Use this selection sequence:
1. Name the task type.
2. Name the user-visible or repo-visible claim the change is making.
3. Pick the smallest checks that can prove that claim honestly.
4. Include manual review steps when automation does not exist yet.
5. Exclude checks that do not test the change you made.
6. Record the exact evidence after the work is done.

Selection rules:
- Prefer existing local commands and checked-in repo truth over invented tooling.
- Use `audit` when the task changes bootstrap-state assumptions that `audit` can honestly check.
- Use `brief` when the task changes prompt or agent metadata, summary behavior, or prompt-pick guidance.
- Use CI status when the task changes workflow files or depends on workflow validation.
- Use file and path assertions when the claim is about repository structure or checked-in assets.
- Use manual review when the task is policy-heavy, docs-heavy, or not yet covered by automation.
- Use future language or framework test commands only when those ecosystems actually exist in the repo.

## Example Gammit Shapes
### Docs-Only Change
Use when editing architecture, policy, workflow, roadmap, or README material.

Possible gammit:
- confirm the changed docs do not imply capabilities missing from the repo
- confirm cross-referenced files exist and wording matches current repo state
- manually review affected docs for consistency with `AGENTS.md`, `README.md`, and related `docs/` files
- run any local listing or truth-check command needed to confirm referenced paths are real

Passing evidence:
- file references resolve
- repo truth matches the claims
- manual review notes are recorded

### Shell Change
Use when changing `scripts/clau-dex.ps1` or shell-facing documentation that claims shell behavior.

Possible gammit:
- run the relevant shell commands for the changed surface, such as `help`, `status`, `audit`, `brief`, or `scaffold-agent`
- inspect command output for the exact behavior changed
- confirm shell docs still match the checked-in command surface
- include CI evidence if the workflow covers the affected commands

Passing evidence:
- the changed commands run successfully
- output matches the updated contract
- docs and shell behavior agree

### CI Change
Use when editing workflow files or making claims about automated validation.

Possible gammit:
- inspect the workflow file for scope correctness
- confirm the workflow validates only the commands or checks it claims to validate
- obtain green CI status for the affected workflow
- manually verify repo docs describe the workflow truthfully

Passing evidence:
- workflow file matches the intended scope
- CI is green for the changed workflow
- repo docs do not overstate CI coverage

### Future Source-Code Change
Use when `src/` begins to contain real implementation work.

Possible gammit:
- run the task-relevant unit or integration tests that exist in-repo
- run a small smoke test for the user-visible behavior changed
- verify docs distinguish implemented behavior from planned behavior
- add file or path assertions when the task introduces new modules or assets

Passing evidence:
- task-relevant tests pass
- smoke behavior matches the intended claim
- implementation and docs stay aligned

### Future API Work
Use when the repo eventually contains local API clients, local service layers, or CLI flows that make API calls.

Possible gammit:
- run targeted `curl` or client checks against the intended local or approved endpoint
- verify response shape, status codes, or error handling for the scenario changed
- run any supporting unit tests that exist in-repo
- record any required manual review for credentials, environment assumptions, or request/response truth

Passing evidence:
- the checked endpoint behavior matches the claim
- response and error expectations are demonstrated
- any environment-sensitive limits are called out explicitly

## Gammit Summary Template
Use this shape in task notes, commit notes, or Codex summaries:

1. Proposed gammit
   - task type:
   - repo or user-visible claim:
   - checks to run:
2. Gammit result
   - pass or fail:
   - evidence:
   - manual review performed:
   - gaps intentionally out of scope:

## Non-Goals
The GAMMIT protocol does not:
- define one universal validation command
- require a generalized test runner
- replace task judgment with a policy engine
- claim automation where only manual review exists
- force future ecosystems into the repo before they are needed

## Verification
Manual verification for this protocol change:
- Confirm this document defines the gammit as task-specific validation rather than one fixed command.
- Confirm this document explains when a gammit is required and what counts as passing.
- Confirm this document includes current `clau-dex` examples for docs-only work, shell changes, and CI changes.
- Confirm this document includes clearly labeled future examples for source-code and API work without implying those capabilities already exist.
