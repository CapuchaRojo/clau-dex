# Architecture Checkpoint

## Purpose
Record the architecture review taken after the expanded bootstrap shell and minimal CI validation so the repository has an explicit decision about whether the next executable move still belongs in `scripts/` or has crossed the threshold for first implementation code in `src/`.

## Review Date
2026-04-08

## Current Executable Truth
The checked-in executable surface is still a bootstrap-stage repository helper centered on `scripts/clau-dex.ps1`.

What exists now:
- a local PowerShell entry surface for `help`, `status`, `audit`, `docs`, `prompts`, `agents`, `brief`, `rules`, and agent scaffolding
- one minimal GitHub Actions workflow that validates `help`, `status`, and `audit`
- prompt, agent, and documentation assets that the shell can inspect or scaffold
- no application runtime, package manifest, dependency graph, or formal test harness

What does not exist yet:
- a product-facing capability with behavior independent of repository inspection
- a stable data model shared across multiple executable surfaces
- a documented source-level interface that would justify reusable implementation modules
- verification broad enough to support an application slice in `src/`

## Decision
The next move still belongs in `scripts/`, not `src/`.

`src/` is not yet justified because the current executable truth remains repository-oriented shell behavior. The repo has gained a useful local CLI helper, but it has not yet crossed into a product implementation boundary.

## Why `scripts/` Still Fits
- The shell commands are still local operator aids for inspection, audit, summarization, and scaffolding.
- The current CI workflow validates only the bootstrap shell surface, not an application contract.
- The first reusable parsing behavior in `brief` is not yet backed by a stable markdown metadata convention across prompt and agent files.
- The repo's docs still describe `src/` as reserved until the first concrete implementation target is both defined and justified.

## Signals Against Starting `src/` Now
The current shell has grown, but growth alone is not enough. This checkpoint found that:
- the shell still operates on repository assets rather than domain objects or product state
- command behavior is explicit and hardcoded, which is acceptable for bootstrap helpers
- metadata extraction expectations across prompts and agents are not yet stable enough to treat as a source-level contract
- verification still proves "bootstrap helper works" rather than "first application slice works"

These signals suggest the project is still refining conventions and bootstrap helpers, not yet implementing a standalone runtime capability.

## What Should Happen Next
The next narrow move should keep extending the documented shell layer only where it hardens repeated local workflows already present in the repo.

Recommended next focus:
- tighten the prompt and agent heading contract that `brief` relies on
- decide whether `brief` should validate conventions, degrade gracefully, or both
- extend validation only enough to cover the documented shell surface that now exists
- keep `src/` limited to documentation until one source-level capability is explicitly defined

## Threshold For First Code In `src/`
The first implementation code in `src/` becomes justified only when all of the following are true:
- there is one documented capability that is more than repository inspection or scaffolding
- that capability has explicit inputs, outputs, and non-goals in `docs/`
- the behavior would benefit from reusable modules rather than a hardcoded shell helper
- verification can show the capability works as an implementation slice, not only as a shell smoke test

## Candidate Shape When The Threshold Is Met
The first justified `src/` slice should be tiny and CLI-first. A valid example would be a small, documented local engine that powers one concrete capability the shell can call, with the shell remaining only the entry surface.

Until that threshold is met, moving logic into `src/` would mostly rename bootstrap helpers as application code without improving architectural clarity.

## Verification
Manual verification for this checkpoint:
- Confirm the decision matches the current checked-in shell and CI surface.
- Confirm this file distinguishes existing shell behavior from a future implementation slice.
- Confirm the next move is named as continued shell hardening, not speculative runtime code.
- Confirm the threshold for introducing `src/` code is explicit and reviewable.
