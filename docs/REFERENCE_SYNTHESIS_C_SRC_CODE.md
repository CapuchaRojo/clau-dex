# Mission Read

This document translates the completed Phase 1 and Phase 2 architecture audits of `c.src.code` into original guidance for `clau-dex`. Its purpose is not to reuse design, structure, naming, or implementation material from the reference repo. Its purpose is to extract lawful lessons that help `clau-dex` choose its next narrow move while staying local-first, bootstrap-disciplined, and clean-room safe.

# Inputs Reviewed

- `C:\Users\mich3\GitHubProjects\c.src.code\docs\ARCHITECTURE_AUDIT_PHASE1.md`
- `C:\Users\mich3\GitHubProjects\c.src.code\docs\ARCHITECTURE_AUDIT_PHASE2.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\CLEAN_ROOM_POLICY.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\OPERATING_MODEL.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\ARCHITECTURE_CHECKPOINT.md`
- `C:\Users\mich3\GitHubProjects\clau-dex\docs\BOOTSTRAP_PLAN.md`

The audit inputs show a mature reference system with a strong canonical execution surface, visible validation discipline, meaningful boundary controls, and a parallel reference-oriented layer that raises governance cost when it grows too large. The `clau-dex` inputs show a bootstrap-stage repo that already prioritizes clean-room rules, small checkpoints, shell-first execution, and delayed entry into `src/`.

# Safe Lessons for clau-dex

1. Keep one operational center of gravity. The audits show that a system stays easier to understand when docs, validation, and operator guidance all point to the same execution surface.
2. Treat validation as part of architecture, not a later add-on. The strongest transferable lesson is that quality signals become more believable when documentation claims, executable surfaces, and checks reinforce each other.
3. Make boundary-denial behavior explicit early. The audits repeatedly surfaced permissions, sandboxing, and boundary clarity as signs of maturity; `clau-dex` can adopt that principle without borrowing any implementation form.
4. Keep secondary analysis surfaces visibly secondary. If `clau-dex` ever adds inventories, snapshots, or audit helpers, they should remain narrow support assets rather than grow into a competing runtime story.
5. Use docs to reduce interpretation drift. A small system benefits from fewer, sharper documents that state what is canonical, what is helper-only, and what is still planned.
6. Prefer behavior-level verification over status prose. The reference audits showed that narrative documents are helpful, but confidence comes from checks that prove real behavior.
7. Preserve modular thinking before modular code. `clau-dex` does not need a large implementation surface yet, but it can still define clean responsibility boundaries in docs so future code does not accrete arbitrarily.

# Do-Not-Import Warnings

1. Do not import a dual-surface story in which two sizable trees both appear authoritative.
2. Do not import local session state, sandbox residue, or operator-specific artifacts into the committed source tree unless they are deliberate fixtures with documented purpose.
3. Do not import mature-repo complexity just because it exists elsewhere. Multiple runtime layers, broad extension seams, and large validation harnesses would be premature in the current bootstrap stage.
4. Do not import status-heavy documentation as a substitute for executable proof.
5. Do not import broad extensibility claims before `clau-dex` has a single clearly bounded core capability.
6. Do not import large mixed-responsibility files or structures that would make ownership blurry from the start.
7. Do not import reference naming, file layouts, or subsystem decomposition from `c.src.code`, even when the high-level idea seems useful.

# What clau-dex should emulate in principle

- Consistent source-of-truth signaling across docs, scripts, and checks.
- Architecture decisions that make runtime boundaries easy for a new contributor to identify.
- Verification that exercises expected behavior and denial behavior, not just happy-path summaries.
- Explicit treatment of operator safety, local-state hygiene, and permission boundaries as first-class concerns.
- Clean audit discipline that records observations and lessons without drifting into transplant planning.

# What clau-dex should avoid

- Building a mirror analysis layer that grows almost as large as the main system it supports.
- Letting documentation sprawl create uncertainty about which file speaks for current reality.
- Treating bootstrap helpers as if they already justify a product runtime.
- Adding extension mechanisms before the repo has a small, stable core worth extending.
- Allowing planned capabilities to read like existing capabilities.

# Recommended Next Direction

The next direction for `clau-dex` should remain narrow and should stay aligned with the current architecture checkpoint rather than reopening the roadmap.

The most grounded next slice is:

- keep the shell-first bootstrap surface as the only executable truth for now
- harden the contract around the documented content it already inspects or scaffolds
- add only the smallest validation needed to prove those documented contracts hold
- define one future source-level capability in original terms before any code moves into `src/`

In practical terms, the audits point to one main decision rule for `clau-dex`: before inventing a richer runtime or a second execution layer, first make it impossible to misunderstand what is canonical, what is helper-only, and what would justify the first real implementation slice.

That means the best next move is not to emulate the reference repo's scale. It is to use the audits as a caution against premature breadth. `clau-dex` should continue hardening execution-surface clarity, metadata conventions, local-state hygiene, and validation discipline until one minimal capability is documented tightly enough to deserve source code of its own.

# Clean-Room Notes

- This synthesis is based on audit reports and `clau-dex` policy/architecture docs, not on copied implementation material.
- It does not reproduce code, identifiers, command layouts, implementation structures, or patch ideas from `c.src.code`.
- It intentionally converts the audits into project-local guidance for `clau-dex` rather than a reference migration plan.
- Manual review evidence used here:
- Phase 1 audit evidence: the reference repo was described as having one canonical operational surface, a companion reference-oriented layer, and multiple documentation and execution surfaces that required interpretation discipline.
- Phase 2 audit evidence: the reference repo was described as strong in validation, modular separation, and boundary awareness, but risky where source-of-truth drift, local artifact hygiene, extension-surface breadth, and maintenance overhead could increase.
- `clau-dex` evidence: the clean-room policy prohibits copying; the operating model requires direction before execution and a task-specific gammit; the architecture checkpoint keeps the next move in `scripts/`; the bootstrap plan delays `src/` until one justified implementation slice exists.
- Scope check: this document separates safe lessons, non-import warnings, principles to emulate, principles to avoid, and a recommended next direction for `clau-dex`.
- Scope check: this document does not propose changes to `c.src.code`, does not plan a transplant, and does not describe any borrowed implementation structure.
