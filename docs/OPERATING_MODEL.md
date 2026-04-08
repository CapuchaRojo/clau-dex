# Operating Model

## Purpose
`clau-dex` is not just a repository of files. It is a coordinated working system with distinct planning and execution roles. This document defines how strategy, implementation, review, and checkpoints are divided so the project stays clean-room, local-first, and reviewable.

## System Roles
### ChatGPT / CLAU-DEX PRIME
ChatGPT, operating as CLAU-DEX PRIME, is responsible for the strategic layer of the project. Its primary roles are:
- strategist
- architect
- reviewer
- promptsmith
- QA lead

CLAU-DEX PRIME frames direction, sharpens scope, defines standards, reviews outcomes, and decides what should happen before implementation starts.

### Codex
Codex is responsible for repository execution. Its primary roles are:
- repo executor
- parser
- implementer
- checker
- doc drafter

Codex reads the repo state, applies approved changes, drafts documentation from decided direction, and performs local verification and consistency checks.

## Decision Flow
The default operating pattern is:
1. Define intent and constraints with CLAU-DEX PRIME.
2. Convert that direction into concrete repo-ready work.
3. Hand the scoped task to Codex for execution.
4. Review the result against the stated intent.
5. Capture a checkpoint before moving to the next unit of work.

This sequence is what turns the project into a system instead of a loose collection of docs and prompts.

## When To Use ChatGPT
Use CLAU-DEX PRIME when the task is primarily about judgment, direction, or evaluation, including:
- shaping project strategy
- deciding architecture direction
- defining or revising workflow conventions
- writing or refining prompt intent
- reviewing whether a proposed change fits the charter
- identifying risks, gaps, regressions, or missing validation
- deciding scope before implementation begins

Use ChatGPT first when the right move is not yet clear, when tradeoffs must be made, or when a change would influence multiple future decisions.

## When To Use Codex
Use Codex when the task is primarily about reading, changing, or checking the repository, including:
- inspecting current repo contents
- applying approved doc changes
- implementing a tightly scoped code or script change
- drafting repository documents from already-decided direction
- checking consistency across files
- running local verification steps
- preparing small, reviewable checkpoints

Use Codex after the direction is clear enough to execute without inventing policy during file edits.

## What Gets Decided Here First
Before Codex changes files, the following should be decided in this operating model layer:
- the goal of the change
- whether the change is documentation, workflow, prompt, agent, script, or implementation work
- the clean-room boundary for any reference-informed task
- the scope limits and non-goals
- the success criteria
- the verification approach, even if manual
- whether the work is small enough for a single checkpoint

If any of these are unresolved and the change would force Codex to make policy decisions while editing, pause in the ChatGPT layer first and settle them there.

## Required Checkpoint Cadence
Checkpointing is mandatory and should happen at a steady, reviewable pace.

Required cadence:
- create a checkpoint whenever a unit of work becomes reversible and reviewable
- do not let multiple unrelated concerns accumulate in one diff
- make a checkpoint after policy changes
- make a checkpoint after a completed doc convention or operating-rule change
- make a checkpoint after each implementation slice that can be verified on its own

In practice, the expected rhythm is small, coherent, conventional-commit checkpoints rather than large batch updates.

## Working Standard
The system works correctly when:
- CLAU-DEX PRIME decides direction before repo execution begins
- Codex executes within that direction rather than inventing it mid-change
- repo updates stay narrow and reviewable
- verification is recorded with each meaningful change
- checkpoints appear often enough that work can be reviewed, reverted, or resumed without ambiguity

## Verification
Manual verification for this operating model change:
- Confirm this file defines separate roles for CLAU-DEX PRIME and Codex.
- Confirm this file explains when each should be used.
- Confirm this file lists what must be decided before Codex changes files.
- Confirm this file defines a required checkpoint cadence.
