# Purpose

This runbook explains how to operate the current `clau-dex` bootstrap shell without overstating what the repo does today.

Use it as the practical companion to:
- `docs/CLI_FIRST_SHELL.md` for the shell contract
- `docs/LOCAL_STATE_HYGIENE.md` for warning versus fail hygiene posture
- `docs/GAMMIT_PROTOCOL.md` for task-specific validation and checkpoint discipline

# When To Use Status

Use `.\scripts\clau-dex.ps1 status` for a quick-glance operator summary.

Use it when you need to confirm:
- the canonical shell boundary is intact or broken
- local-state hygiene is currently clean or warning-grade
- bootstrap is still warning-first for advisory conditions
- `src/` still has no implementation runtime
- which shell commands are available

`status` is the fast orientation surface. It summarizes current audit truths and explicitly points back to `audit` for detailed evidence.

# When To Use Brief

Use `.\scripts\clau-dex.ps1 brief` when you need the local picker surface for current prompt packs and super-agents.

Use it when you need to:
- scan the currently checked-in prompt-pack families before reading individual entries
- compare current super-agent roles quickly
- choose a likely first pick from local metadata without opening every file first
- keep the decision local and deterministic rather than relying on search or generated recommendations

`brief` is the shell picker surface. It is for fast local selection, not repo-health evidence. Trust `status` for quick posture and `audit` for detailed contract evidence.

# When To Use Audit

Use `.\scripts\clau-dex.ps1 audit` when you need the detailed truth surface for the current bootstrap contract.

Use it when you need to:
- verify a repo-visible claim before a checkpoint
- inspect the exact PASS / WARN / FAIL results behind `status`
- confirm whether a hygiene issue is advisory or boundary-breaking
- confirm the repo still matches the documented bootstrap shape

`audit` is the operator truth source for the current shell-first workflow. If `status` and `audit` seem different in tone, trust `audit`.

# When To Use Checkpoint

Use `.\scripts\clau-dex.ps1 checkpoint` when you want the current clean-checkpoint checklist in the shell without hunting through docs first.

Use it when you need a concise reminder to:
- confirm the repo-visible claim
- run the task-specific gammit
- review current warnings and choose remediate versus ignore intentionally
- verify the changed-file list is tight
- verify no unrelated `src/`, CI, or workflow changes slipped in
- prepare one clean commit

`checkpoint` is checklist-style only. It does not run validation, edit files, replace this runbook, or replace `prompts/codex/gammit-pass.md`.

# How To Read Warning-Grade Hygiene Drift

Warning-grade hygiene drift means visible local residue or other advisory drift exists, but the checked-in bootstrap shell contract is still usable.

In the current shell, warning-grade hygiene drift is operator-facing and non-blocking. It means:
- inspect the warning
- decide whether the artifact is a real cleanup target or an intentional local byproduct
- do not treat the warning by itself as proof that the canonical shell boundary changed

For example, the current `audit` output warns on `clau-dex.zip` as obvious local residue. That is a hygiene warning, not a fail-grade shell-boundary break.

# Remediate Versus Ignore Intentionally

Remediate when the warning is accidental, stale, confusing, or likely to keep showing up as noise for other operators.

Ignore intentionally when the warning is clearly operator-local, non-canonical, and expected for a local workflow, such as a temporary archive or export artifact that does not change checked-in repo truth.

When ignoring intentionally:
- be honest that the condition still exists
- do not rewrite it as a PASS
- keep the distinction clear between local byproducts and canonical repo state

If a condition stops being merely advisory and starts breaking the documented shell boundary or bootstrap repo shape, it is no longer an ignore-or-remediate warning decision. It becomes a fail-grade issue that should be corrected before claiming the repo is in the documented state.

# Clean Checkpoint Workflow

Use this checkpoint flow for meaningful bootstrap work:

1. Review the repo-truth docs that define the surface you are changing.
2. Make the smallest coherent change that matches one repo-visible claim.
3. Run the task-specific gammit for that claim.
4. Read `status` for the quick summary, then `audit` for the exact evidence when shell posture matters.
5. Use `checkpoint` when you want the compact shell reminder for the current clean-checkpoint checklist.
6. Record whether any warnings were remediated or intentionally left as non-blocking operator-local drift.
7. Confirm the changed-file list is tight and does not include unrelated shell, runtime, CI, or workflow edits.
8. Checkpoint only when the change is reviewable and the recorded evidence supports the claim being made.

For this repo, a clean checkpoint means small, honest, and reversible. Warning-grade hygiene drift may still allow a checkpoint when the runbooked claim remains true and the warning has been intentionally reviewed.

# Non-Goals

This runbook does not:
- replace `docs/CLI_FIRST_SHELL.md` as the shell contract
- replace `docs/LOCAL_STATE_HYGIENE.md` as the warning/fail hygiene contract
- replace `docs/GAMMIT_PROTOCOL.md` as the validation doctrine
- introduce shell automation or auto-remediation behavior
- imply an implementation runtime, package-managed workflow, or broader operations system

# Verification

Manual verification for this runbook:
- review `README.md`
- review `docs/CLI_FIRST_SHELL.md`
- review `docs/LOCAL_STATE_HYGIENE.md`
- review `docs/GAMMIT_PROTOCOL.md`
- review `scripts/README.md`
- run `.\scripts\clau-dex.ps1 status`
- run `.\scripts\clau-dex.ps1 checkpoint`
- run `.\scripts\clau-dex.ps1 audit`
- confirm the runbook matches current shell behavior exactly
- confirm `status` is described as quick-glance and `audit` as detailed truth
- confirm `checkpoint` is described as checklist-style only and non-destructive
- confirm warning-grade hygiene drift is described as operator-facing and non-blocking
- confirm remediate versus ignore intentionally is explained in bootstrap terms
- confirm no shell, `src/`, CI, or workflow files were changed for this task
