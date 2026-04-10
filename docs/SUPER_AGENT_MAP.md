# Purpose

This map helps operators choose among the current `clau-dex` super-agents quickly without changing shell behavior or restating each full agent definition.

Use it as a concise picker for the checked-in super-agent library, especially alongside `.\scripts\clau-dex.ps1 brief`.

# Current Super-Agents

- `Architecture Mapper`
- `Promptsmith`
- `Reference Auditor`
- `Repo Auditor`

These are the current real super-agents represented by checked-in files under `agents/super-agents/`.

# When To Use Each Super-Agent

## Architecture Mapper

Use first when the task is about repository shape, content boundaries, phase-appropriate structure, or deciding what belongs in `docs/`, `prompts/`, `agents/`, `scripts/`, or future `src/`.

Best fit:
- defining folder responsibilities
- mapping current bootstrap docs into later implementation phases
- deciding the next structural move before code exists
- separating current assets from planned assets and deferred decisions

## Promptsmith

Use first when the task is to create or improve reusable prompt assets for recurring work in `clau-dex`.

Best fit:
- creating a new prompt pack
- tightening prompt scope, constraints, or output shape
- splitting planning prompts from execution prompts
- making repeated work easier to launch consistently

## Reference Auditor

Use first when the task involves a lawful outside reference and the goal is to learn from it safely without importing source material into `clau-dex`.

Best fit:
- auditing a public, open-source, owned, or explicitly authorized repo
- producing a high-level inventory or quality readout from lawful material
- extracting safe lessons and do-not-import warnings
- checking source authorization before reference-informed planning

## Repo Auditor

Use first when the task is to inspect `clau-dex` itself for truth, consistency, drift, or checkpoint readiness.

Best fit:
- checking whether docs match the checked-in repo
- finding implied capabilities that are not actually present
- reviewing narrow bootstrap changes before a checkpoint
- identifying missing verification notes, README updates, or policy alignment gaps

# When Not To Use Each Super-Agent

## Architecture Mapper

Do not use it as a general repo-audit lane, a prompt-writing lane, or a way to invent speculative runtime architecture.

## Promptsmith

Do not use it for durable repo policy, broad architecture planning, or repo-truth audits. If the real issue is docs policy or repo drift, start elsewhere.

## Reference Auditor

Do not use it for internal `clau-dex` audits, generic web research, or any leaked, proprietary, unlicensed, or otherwise unauthorized material.

## Repo Auditor

Do not use it to study outside references, draft reusable prompts, or design future structure beyond what current repo truth can support.

# Overlap And First-Pick Guidance

`Architecture Mapper` and `Repo Auditor` can both look similar when a task mentions structure. Choose `Repo Auditor` first when the question is "what is true right now?" Choose `Architecture Mapper` first when the question is "how should we shape the next structural move?"

`Promptsmith` and `Architecture Mapper` can both appear in bootstrap planning work. Choose `Promptsmith` when the output should be a reusable prompt asset. Choose `Architecture Mapper` when the output should be structure, boundaries, or phase-aware placement guidance.

`Reference Auditor` and `Repo Auditor` are both audit roles, but their sources differ. Choose `Repo Auditor` for checked-in `clau-dex` truth. Choose `Reference Auditor` only when the source is external and lawfully approved.

Common first-pick cases:
- "Which folder should this kind of asset live in?" Start with `Architecture Mapper`.
- "We keep repeating this task; should it become a prompt pack?" Start with `Promptsmith`.
- "Can we safely learn from this outside repo or document set?" Start with `Reference Auditor`.
- "Does the repo actually support the claim we want to make?" Start with `Repo Auditor`.
- "This task mentions both repo truth and the next structural move." Start with `Repo Auditor` to confirm current reality, then use `Architecture Mapper` if a structural recommendation is still needed.

# How This Relates To brief

`.\scripts\clau-dex.ps1 brief` is the shell-level quick briefing surface for prompt packs and super-agents. This map does not replace it.

Use `brief` when you want the current checked-in summaries gathered directly from local markdown headings. Use this map when you want operator-facing guidance about overlap, non-goals, and which super-agent to pick first in common cases.

In short:
- `brief` shows what is available
- this map helps decide which current super-agent to use first

# Non-Goals

This map does not:
- change shell behavior
- replace the checked-in super-agent files as the source definitions
- duplicate each agent's full purpose, tasks, or boundaries
- invent future super-agents or unimplemented capabilities
- introduce runtime, CI, or workflow behavior

# Verification

Manual verification performed for this map:
- reviewed `agents/README.md`
- reviewed `agents/super-agents/architecture-mapper.md`
- reviewed `agents/super-agents/promptsmith.md`
- reviewed `agents/super-agents/reference-auditor.md`
- reviewed `agents/super-agents/repo-auditor.md`
- reviewed `docs/OPERATOR_RUNBOOK.md`
- reviewed `README.md`
- ran `.\scripts\clau-dex.ps1 brief`
- confirmed the map names only the four real current super-agents
- confirmed the map improves discoverability only and does not restate full agent definitions
- confirmed the map does not invent future agents or capabilities
- confirmed no shell, `src/`, CI, or workflow files were changed for this task
