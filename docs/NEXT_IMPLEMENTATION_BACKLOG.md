# Purpose

This document ranks the next plausible implementation slices for `clau-dex` after bootstrap without starting runtime work yet.

It exists to help the project choose one deliberate first post-bootstrap build lane based on current checked-in repo truth, current shell/operator/catalog surfaces, and high-level clean-room-safe lessons already recorded in `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md`.

# Current Repo Read

The current repository state supports planning a first implementation lane, but not starting that lane in this task.

What is clearly present now:

- one canonical executable surface in `scripts/clau-dex.ps1`
- documented operator entry guidance around `status`, `audit`, `brief`, and `checkpoint`
- a checked-in prompt-pack library and super-agent library that `brief` can summarize
- docs that already define metadata conventions, shell boundaries, local-state hygiene posture, and checkpoint discipline
- one minimal CI workflow validating the bootstrap shell surface

What is not present yet:

- runtime code in `src/` beyond `src/README.md`
- a reusable source-level module with a documented interface
- a product-facing capability independent of repo inspection, briefing, audit, or scaffolding
- a formal test harness or package-managed runtime story

The immediate decision is therefore not "what should we build in `src/` right now?" The immediate decision is "which implementation slice would most honestly earn the first post-bootstrap build lane next?"

# Candidate Implementation Slices

## Slice A: `brief` metadata contract enforcement

Harden the existing `brief` surface around prompt-pack and super-agent metadata so the shell can verify preferred headings, supported fallbacks, and warning-grade drift more deliberately.

Grounding in current repo:

- `scripts/clau-dex.ps1 brief` already reads local markdown metadata
- `docs/CATALOG_MAINTENANCE.md` and the catalog maps already depend on this contract
- `docs/NEXT_SLICE_DECISION.md` and `docs/ARCHITECTURE_CHECKPOINT.md` both identify this area as the most immediate hardening target

Likely implementation lane later:

- shell-adjacent work in `scripts/` plus narrowly matching doc updates

## Slice B: shell/operator claim verification hardening

Strengthen the verification around existing `status`, `audit`, `brief`, and `checkpoint` claims so docs, shell output, and operator workflow stay aligned as one canonical execution surface.

Grounding in current repo:

- `README.md`, `docs/WORKFLOW_ENTRY_MAP.md`, and `docs/OPERATOR_RUNBOOK.md` all route operators through the current shell
- `audit` already encodes repo-shape checks and warning/fail posture
- the repo values executable proof over status prose

Likely implementation lane later:

- shell-adjacent work in `scripts/` with doc-backed truth checks, still without introducing a product runtime

## Slice C: prompt and super-agent catalog consistency helper

Implement a narrow catalog-maintenance helper that checks whether prompt-pack and super-agent surfaces stay aligned across asset files, `brief`, maps, and folder README surfaces.

Grounding in current repo:

- `docs/CATALOG_MAINTENANCE.md` defines a real repeated maintenance workflow
- `docs/PROMPT_LIBRARY_MAP.md` and `docs/SUPER_AGENT_MAP.md` are operator-facing summaries that can drift from checked-in assets
- current shell behavior depends on local markdown conventions rather than a separate catalog database

Likely implementation lane later:

- shell-adjacent work in `scripts/` focused on checked-in markdown assets only

## Slice D: local-state hygiene and canonical-boundary guidance hardening

Refine the implementation around warning-grade local residue and helper-script boundary drift so the shell gives more precise, trustworthy operator guidance without becoming a generic policy engine.

Grounding in current repo:

- `status` and `audit` already surface hygiene and canonical shell boundary posture
- `docs/OPERATOR_RUNBOOK.md` treats warning-versus-fail handling as part of routine operator work
- `docs/CLI_FIRST_SHELL.md` and `README.md` frame this as a first-class bootstrap concern

Likely implementation lane later:

- shell-adjacent work in `scripts/` with no `src/` move

## Slice E: first source-level metadata parsing engine

Define and implement the first tiny source-level module in `src/` that would power markdown metadata parsing for shell briefing or later catalog work.

Grounding in current repo:

- there is a real repeated parsing concern already visible in `brief`
- multiple docs describe a future threshold where reusable logic could move into `src/`

Why it is only plausible, not yet favored:

- the repo has not yet documented one source-level capability strongly enough to cross the Phase 2 threshold
- current architecture docs still say the next move belongs in `scripts/`

Likely implementation lane later:

- first `src/` slice only after a separate checkpoint explicitly justifies it

## Slice F: first source-level briefing data model

Define a tiny, original data model for prompt-pack and super-agent briefing records so the shell could eventually become a thin entry wrapper around reusable local code.

Grounding in current repo:

- `brief` already produces structured summaries with summary text, best-for bullets, notices, and first-pick cues
- there is a visible future need for a stable data contract if the project ever wants source modules

Why it is only plausible, not yet favored:

- the shell still works as an explicit bootstrap helper
- the current repo does not yet require a reusable data model to stay honest

Likely implementation lane later:

- deferred `src/`-adjacent planning after the shell-side contract is tighter

# Ranking Criteria

The backlog ranking uses the current repo constraints rather than abstract product ambition.

Higher-ranked slices should:

- strengthen a capability that already exists in the checked-in repo
- reinforce the shell as the current execution center of gravity
- improve clarity, verification, or operator trust around documented behavior
- stay small enough for one clean checkpoint-sized build lane
- help the repo decide when `src/` would become justified without crossing that line prematurely
- remain clean-room and avoid any transplant-style planning from outside repos

Lower-ranked slices are still plausible, but they lose points when they:

- require the repo to invent a new runtime story
- depend on a source-level abstraction not yet justified by docs and checks
- solve a secondary problem before the most immediate shell contract is stable

# Ranked Backlog

## 1. `brief` metadata contract enforcement

Why it ranks first:

- it is the most direct continuation of the current shell surface
- it strengthens behavior that already exists and is already operator-visible
- it is explicitly named by `docs/NEXT_SLICE_DECISION.md` and reinforced by `docs/ARCHITECTURE_CHECKPOINT.md`
- it improves trust in prompt and super-agent selection without implying a broader runtime

Checkpoint shape when chosen:

- one narrow implementation lane in `scripts/`
- docs updated only where the `brief` contract and verification posture need to become sharper

## 2. shell/operator claim verification hardening

Why it ranks second:

- it reinforces the repo-wide preference for executable proof over prose
- it keeps `status`, `audit`, `brief`, and `checkpoint` aligned as one operator story
- it is highly grounded, but slightly broader and less immediately bounded than the `brief` contract lane

Checkpoint shape when chosen:

- one shell-focused hardening pass around current claims, not new features

## 3. prompt and super-agent catalog consistency helper

Why it ranks third:

- it addresses a real repeated maintenance workflow already documented in `docs/CATALOG_MAINTENANCE.md`
- it helps keep maps, READMEs, and local markdown assets honest
- it is valuable, but it depends on the metadata contract being stable enough first

Checkpoint shape when chosen:

- a local helper or check around markdown catalog alignment only

## 4. local-state hygiene and canonical-boundary guidance hardening

Why it ranks fourth:

- the concern is real and already surfaced by `status` and `audit`
- it would improve operator clarity around warnings
- it is still more secondary than the `brief` contract because the current repo's most active content-parsing surface is the prompt and agent catalog

Checkpoint shape when chosen:

- a shell-only warning/guidance refinement lane

## 5. first source-level metadata parsing engine

Why it ranks fifth:

- it is the strongest current candidate for the first eventual `src/` module
- it has a concrete relationship to existing shell behavior
- it still loses today because the repo has not met its own threshold for moving logic into `src/`

Checkpoint shape when chosen later:

- a tiny CLI-first engine only after a separate justification checkpoint

## 6. first source-level briefing data model

Why it ranks sixth:

- it could eventually make the shell thinner and more modular
- it is still one level more abstract than the repo currently needs
- it risks naming future architecture before the shell-side contract is fully proven

Checkpoint shape when chosen later:

- a very small `src/` design-and-implementation slice after the parsing contract is stable

# Recommended First Slice

The recommended first slice is `brief` metadata contract enforcement.

It wins now because it offers the highest value with the lowest architectural risk:

- the behavior already exists
- the repo already documents the surrounding maintenance workflow
- the current shell already depends on the quality of this metadata
- the architecture checkpoint already says the next move remains in `scripts/`
- it strengthens a real operator-facing capability without inventing a second execution story

This slice is also the best bridge between bootstrap hardening and later implementation choice. If the metadata contract becomes sharper and more trustworthy, the project will be in a much better position to decide whether any later parsing or briefing logic truly deserves a move into `src/`.

# Why Not The Others Yet

`shell/operator claim verification hardening` is close behind, but it is broader than necessary for the first lane. The repo will get a cleaner checkpoint by tightening the most immediate contract first.

`prompt and super-agent catalog consistency helper` is useful, but it should build on a stable `brief` contract rather than define one indirectly.

`local-state hygiene and canonical-boundary guidance hardening` matters, but the current repo already has a workable warning-first posture there. The metadata contract is the more active and structurally important near-term dependency.

`first source-level metadata parsing engine` is the most credible future `src/` candidate, but the current docs still say Phase 2 is not closed. Starting that lane now would turn aspiration into implied capability too early.

`first source-level briefing data model` is even more deferred because it is an abstraction on top of a contract that is not yet final enough to deserve one.

# Non-Goals

- This document does not start implementation work.
- This document does not add or propose copied code, layouts, or subsystem shapes from outside repos.
- This document does not claim that `src/` is now ready.
- This document does not add shell code, runtime code, CI changes, or new automation.
- This document does not replace the broader bootstrap plan or roadmap.
- This document does not rank speculative product ideas that are not grounded in current checked-in repo surfaces.

# Verification

Manual grounding and verification for this backlog:

- reviewed `README.md`
- reviewed `docs/WORKFLOW_ENTRY_MAP.md`
- reviewed `docs/OPERATOR_RUNBOOK.md`
- reviewed `docs/PROMPT_LIBRARY_MAP.md`
- reviewed `docs/SUPER_AGENT_MAP.md`
- reviewed `docs/CATALOG_MAINTENANCE.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md`
- reviewed `docs/NEXT_SLICE_DECISION.md`
- reviewed `docs/ARCHITECTURE_CHECKPOINT.md`
- reviewed `docs/BOOTSTRAP_PLAN.md`
- reviewed `scripts/clau-dex.ps1`
- run `.\scripts\clau-dex.ps1 status`
- run `.\scripts\clau-dex.ps1 brief`
- confirm the backlog is grounded in checked-in repo surfaces only
- confirm outside-reference lessons are used only as high-level clean-room-safe guidance
- confirm no shell, `src/`, CI, or workflow files were changed for this task
- confirm the ranking stays focused on the next implementation decision rather than a generic roadmap
