# Purpose

This map shows how the current `clau-dex` shell entry surfaces and supporting workflow docs fit together.

Use it to choose the right starting point without changing shell behavior, duplicating full source documents, or implying automation the repo does not have.

# Start Here

Start with `.\scripts\clau-dex.ps1 status` when you need the fastest truthful orientation to the current bootstrap repo.

It is the best first stop when you want to confirm:

- whether the canonical shell boundary still looks intact
- whether local-state hygiene is clean or warning-grade
- whether `src/` is still runtime-free
- which shell commands are available right now

If `status` tells you enough, stay at the shell level. If you need the underlying evidence behind the quick summary, escalate to `audit`. If you need operator process rather than shell posture, move to `docs/OPERATOR_RUNBOOK.md`.

# Shell Entry Surfaces

## `status`

Use `status` for quick repo posture and shell-surface orientation.

Choose it first when:

- you are starting a task and need the fastest truthful overview
- you want to see whether the current bootstrap shell boundary appears intact
- you want a quick reminder of the shell command surface
- you want to confirm whether deeper review is needed before a checkpoint

## `audit`

Use `audit` when the quick-glance summary is not enough and you need the detailed repo-truth evidence behind it.

Escalate from `status` to `audit` when:

- you need PASS / WARN / FAIL details behind the current posture
- you are validating a repo-visible claim before checkpointing
- you need to distinguish advisory hygiene warnings from boundary-breaking failures
- you need exact evidence about bootstrap-shape checks rather than a summary

`audit` is the shell truth surface. `status` is the short front door.

## `brief`

Use `brief` when the task is not repo-health verification but choosing among the checked-in prompt packs and super-agents.

Choose it when:

- you want a quick local scan of prompt-pack families
- you need a first-pick cue for current super-agents
- you want to compare local prompt and agent assets without opening every file
- you need a shell-level picker before reading the richer maps

`brief` helps pick assets. It does not replace `status` or `audit`.

## `checkpoint`

Use `checkpoint` when you want the current clean-checkpoint reminder in one place before committing.

Choose it when:

- the work is edited and you want the checkpoint checklist
- you need a concise reminder to confirm the repo-visible claim and gammit evidence
- you want to verify the diff is tight and free of unrelated shell, runtime, CI, or workflow changes
- you want the shell checklist before making one clean commit

`checkpoint` is reminder-only. It does not run validation or replace the runbook.

# Supporting Docs

## `docs/OPERATOR_RUNBOOK.md`

Use the operator runbook when you need the practical operating workflow around `status`, `audit`, `brief`, warnings, and checkpoint preparation.

Choose it when:

- you need to know where routine operator work should start
- you need guidance on when warning-grade hygiene drift can remain non-blocking
- you need checkpoint discipline explained in workflow terms rather than just a shell checklist

## `docs/PROMPT_LIBRARY_MAP.md`

Use the prompt library map when `brief` shows the available prompt packs but you need richer guidance about which prompt family fits the task.

Choose it when:

- prompt filenames alone are not enough
- you need the difference between prompt families explained by workflow purpose
- you want a docs reference for prompt-pack selection without reading every prompt file

## `docs/SUPER_AGENT_MAP.md`

Use the super-agent map when `brief` shows the current roles but you need overlap guidance or first-pick help.

Choose it when:

- two current super-agents sound similar
- you need practical first-pick guidance for a repo, reference, prompt, or structure task
- you want to understand which checked-in role fits before reading the full agent file

## `docs/CATALOG_MAINTENANCE.md`

Use the catalog maintenance guide when the task changes prompt packs, super-agents, or their operator-facing map and README surfaces.

Choose it when:

- a prompt pack or super-agent is being added or updated
- you need to keep `brief`, the maps, and the short README surfaces aligned
- you need the maintenance responsibilities without inventing automation

This guide is for maintaining the catalog surfaces, not for routine operator entry.

## `docs/CLI_FIRST_SHELL.md`

Use the CLI-first shell doc when you need the shell contract itself: purpose, scope, command boundaries, and non-goals.

Choose it when:

- you need to confirm what the bootstrap shell is allowed to do
- you need the documented meaning of `status`, `audit`, `brief`, or scaffolding commands
- you need the shell's scope and non-goals as the source of truth

# Common Operator Paths

- New task, quick orientation: start with `status`, then move to the runbook if you need process guidance.
- Need exact shell evidence before making a claim: start with `status`, then escalate to `audit`.
- Need to choose a prompt pack or super-agent: start with `brief`, then read `docs/PROMPT_LIBRARY_MAP.md` or `docs/SUPER_AGENT_MAP.md` if the shell summary is not enough.
- Need to place parser-adjacent work honestly: read `docs/PARSER_READINESS_MAP.md` for the boundary map; for the concrete parser planning contract, use `docs/PARSER_RECORD_SPEC.md` and `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`; for the implementation-facing planning pair, use `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md` and `docs/PARSER_SHELL_HANDOFF_SPEC.md`; then use `prompts/codex/parser-lane-chooser.md` when you want a concise lane recommendation without changing shell behavior.
- Preparing a clean commit: use `checkpoint`, then confirm the fuller workflow in `docs/OPERATOR_RUNBOOK.md` if needed.
- Updating prompt or agent catalog surfaces: use `docs/CATALOG_MAINTENANCE.md` first, then verify the result with `brief`.
- Unsure whether a question is about shell behavior or operator process: use `docs/CLI_FIRST_SHELL.md` for shell contract questions and `docs/OPERATOR_RUNBOOK.md` for workflow questions.

# How To Choose The Right Entry Point

- Start with `status` when the question is, "What is the current posture of the repo and shell?"
- Escalate to `audit` when the question becomes, "What exact evidence supports that posture or claim?"
- Use `brief` when the question is, "Which prompt pack or super-agent should I pick?"
- Use `checkpoint` when the question is, "What do I need to verify before this becomes one clean commit?"
- Use the operator runbook when the question is, "How should an operator work through this practically?"
- Use the prompt library map when the question is, "Which prompt family fits this task best?"
- Use the super-agent map when the question is, "Which current super-agent is the best first pick?"
- Use the catalog maintenance guide when the question is, "What docs surfaces must stay aligned after a prompt or agent catalog change?"
- Use the CLI-first shell doc when the question is, "What does the shell actually do, and what is out of scope?"

# Non-Goals

- Do not change shell behavior.
- Do not replace `docs/OPERATOR_RUNBOOK.md`, `docs/PROMPT_LIBRARY_MAP.md`, `docs/SUPER_AGENT_MAP.md`, `docs/CATALOG_MAINTENANCE.md`, or `docs/CLI_FIRST_SHELL.md` as source documents.
- Do not duplicate full shell output or full source-doc content.
- Do not invent workflow automation, runtime behavior, or new operator surfaces that are not checked in.
- Do not imply changes to `src/`, CI, or workflow files.

# Verification

Manual verification for this map:

- review `README.md`
- review `docs/OPERATOR_RUNBOOK.md`
- review `docs/PROMPT_LIBRARY_MAP.md`
- review `docs/SUPER_AGENT_MAP.md`
- review `docs/CATALOG_MAINTENANCE.md`
- review `docs/CLI_FIRST_SHELL.md`
- review `scripts/clau-dex.ps1`
- run `.\scripts\clau-dex.ps1 status`
- run `.\scripts\clau-dex.ps1 brief`
- run `.\scripts\clau-dex.ps1 checkpoint`
- confirm the map is grounded in the current checked-in repo only
- confirm the map explains where an operator starts
- confirm the map explains when to use each shell surface versus each supporting doc
- confirm the map does not duplicate whole source documents
- confirm no shell, `src/`, CI, or workflow files were changed for this task
