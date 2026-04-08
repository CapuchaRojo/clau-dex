# Bootstrap Plan

## Goal
Advance `clau-dex` from repository bootstrap into a documented, reviewable foundation
without introducing speculative runtime code.

## Phase 0: Repository Grounding
Status: complete

Deliverables:
- tightened repository policy in `AGENTS.md`
- explicit repository architecture note
- realistic `README.md` that reflects the actual checkout
- phased plan for the next bootstrap steps

Verification:
- manual review of docs for consistency with the charter and roadmap
- confirm no runtime code, frameworks, or external services were introduced

## Phase 1: Workflow Conventions
Status: complete

Deliverables:
- conventions for prompt files in `prompts/`
- conventions for agent role files in `agents/`
- one lightweight validation script only if a repeated manual check emerges
- documented checkpoint workflow for small, reviewable commits

Exit criteria:
- contributors can place prompts and agent assets consistently
- repeated bootstrap checks are documented and locally runnable

## Phase 2: Execution Surface Definition
Status: current focus

Deliverables:
- first concrete definition of what belongs in `src/`
- interface sketch for a CLI-first entry surface, if still warranted
- explicit non-goals so implementation starts with tight scope

Exit criteria:
- the repository has a single, documented first implementation target
- the proposed execution surface does not require framework assumptions

## Phase 3: First Implementation Slice
Status: next after the execution-surface checkpoint

Deliverables:
- minimal source code for the first agreed capability
- matching local verification instructions
- doc updates describing what is implemented versus still planned

Exit criteria:
- the repository contains one executable slice that stands on its own
- implemented behavior is clearly separated from aspirational roadmap items

## Sequencing Rules
- Do not start application code before Phase 2 artifacts are written.
- Do not add a framework until the first implementation slice proves the need.
- Do not automate a workflow before it exists as a documented manual workflow.
- Prefer one reversible checkpoint per phase milestone.
