# Local-State Hygiene

## Purpose
This document makes the current bootstrap shell contract explicit for local-state residue and canonical-boundary drift. It describes the repo truth already enforced by `.\scripts\clau-dex.ps1 audit`; it does not introduce a broader policy engine.

## Scope
The contract in this document is intentionally narrow and shell-matched:
- it applies to the current bootstrap audit surface only
- it describes the hardcoded checks in `scripts/clau-dex.ps1`
- it distinguishes advisory warnings from boundary-breaking failures
- it does not define a generic cleanliness framework for all future repo work

## Local-State Residue
In `clau-dex`, local-state residue means obvious operator-local byproducts found anywhere under the repo except `.git/` and `.codex/`.

The current shell treats these filename patterns as residue candidates:
- exact names: `.DS_Store`, `Thumbs.db`
- extensions: `.bak`, `.log`, `.orig`, `.rej`, `.temp`, `.tmp`, `.zip`
- suffixes: `~`

This is a practical bootstrap definition, not a claim that every matching file is always invalid. It exists so the shell can surface likely local leftovers without pretending to understand intent.

## Canonical-Boundary Drift
In `clau-dex`, canonical-boundary drift means the shell surface no longer matches the documented bootstrap truth that `scripts/clau-dex.ps1` is the canonical `clau-dex` entrypoint.

The current shell checks two drift cases:
- alternate `clau-dex.*` entrypoints outside `scripts/clau-dex.ps1`
- extra helper scripts in `scripts/` beyond `clau-dex.ps1` and `README.md`

These cases are not treated equally. One breaks the canonical boundary; the other is operator-visible sprawl that may still be acceptable during bootstrap.

## Warning-Grade Conditions
The current shell warns, rather than fails, when a condition is advisory, recoverable, or mainly useful for operator awareness.

Warning-grade conditions currently include:
- local-state residue patterns
- extra helper scripts in `scripts/`
- prompt-pack or super-agent metadata drift reported by the `brief` contract

During bootstrap, a warning means:
- the repo should be reviewed by a human operator
- the condition is visible enough to record and discuss
- the shell still considers the bootstrap surface usable
- `audit` may add a short next-action summary such as review, remove, archive outside the repo, or ignore intentionally when the warning is clearly operator-local

## Fail-Grade Conditions
The current shell fails when a condition would make the documented canonical shell boundary or bootstrap repo shape untrue.

Fail-grade conditions currently include:
- an alternate `clau-dex` entrypoint outside `scripts/clau-dex.ps1`
- missing required bootstrap files or directories
- `src/` no longer matching the documented reserved bootstrap shape
- package manifests, extra CI, container, or deployment artifacts appearing in the repo bootstrap surface

For the local-state hygiene and boundary contract specifically, the fail-grade case is canonical-boundary breakage, not residue.

## How To Interpret Warnings In Bootstrap
Operators should read current warnings as "visible residue or drift exists, but the shell contract has not been broken."

That means:
- warning output is a prompt to inspect and clean up when appropriate
- warning output is not yet a stop-work signal by itself
- warning output does not mean the repo is claiming an additional runtime or shell surface
- actionable guidance should stay concise and operator-facing rather than becoming auto-fix behavior

## Why Warning-Grade Residue Does Not Yet Block Work
Bootstrap work is still documentation-first and shell-first. At this stage, the audit aims to keep local conditions visible without overreaching into a generic enforcement system.

Warning-grade residue stays non-blocking because:
- the current shell can identify only obvious filename patterns, not operator intent
- residue does not by itself prove that the canonical checked-in shell boundary changed
- blocking on every local byproduct would create false precision during bootstrap
- the clean-room source of truth remains the checked-in repository shape, not every local leftover file

If residue begins to obscure repo truth or repeatedly causes confusion, the stricter rule should be documented first and only then enforced in shell code.

## Verification
Manual verification for this contract:
- Confirm the definitions in this file match the hardcoded local-state and canonical-boundary checks in `scripts/clau-dex.ps1`.
- Confirm this file describes local-state residue as warning-grade and alternate `clau-dex` entrypoints as fail-grade.
- Confirm this file keeps the contract bootstrap-stage, narrow, and local-shell specific.
