# Purpose

This map shows how the current metadata warning surfaces, operator triage flow, narrow fix flow, and separate contract-enforcement lane fit together in `clau-dex`.

It is a routing document, not a new source of truth. Use it to choose the right metadata workflow step without changing the current shell behavior.

# Start Here

Start from the shell surface that exposed the issue:

- use `.\scripts\clau-dex.ps1 brief` when the problem is about picker quality, first-pick guidance, or a metadata notice shown on a prompt pack or super-agent
- use `.\scripts\clau-dex.ps1 audit` when the problem is about repo-truth evidence, checkpoint readiness, or the exact warning reason

Then use these checked-in companions:

- `docs/METADATA_WARNING_EXAMPLES.md` to recognize the warning category in practical terms
- `docs/METADATA_CONVENTIONS.md` to confirm what the current shell actually reads and why it warns
- `docs/OPERATOR_RUNBOOK.md` to choose fix now, defer intentionally, or split

# Warning Categories

The current metadata warnings are warning-grade only:

- missing metadata: a supported summary or best-for surface is absent
- fallback metadata: a supported fallback heading was used instead of the preferred heading
- empty metadata: a supported section exists but does not yield usable summary text or usable bullets
- scaffold-grade metadata: bullets exist but still read like untouched scaffold defaults

Use `docs/METADATA_WARNING_EXAMPLES.md` first when you need a quick category match before deciding what to do next.

# Triage Path

Use `prompts/codex/metadata-triage-check.md` when a warning is real but the next action is not obvious.

This is the right path when:

- `brief` or `audit` shows a metadata warning and you need to decide whether it belongs in the current checkpoint
- you need one honest recommendation: fix now, defer intentionally, or split into a separate metadata checkpoint
- you want to stay inside the current warning-first contract without inventing stricter failure behavior

Triage should stay narrow:

- classify the warning using the current four categories only
- name the affected prompt pack or super-agent files
- decide whether the warning blocks a clean picker cue or is tolerable for now
- keep shell changes, `src/` work, CI changes, and broad cleanup out of scope

# Narrow Fix Path

Use `prompts/codex/metadata-fix-check.md` only after triage has already established that a small repair belongs in the current checkpoint.

This is the right path when:

- one prompt pack or one super-agent already in scope needs better metadata for `brief`
- the repair is limited to headings, concise summary text, or file-specific best-for bullets
- only minimal map or README alignment is needed to keep operator-facing docs honest

The companion docs for this path are:

- `docs/METADATA_CONVENTIONS.md` for the preferred headings and current shell-readable contract
- `docs/METADATA_WARNING_EXAMPLES.md` for the practical warning shape being repaired
- `docs/CATALOG_MAINTENANCE.md` when a prompt-pack or super-agent change also requires small map or README alignment

This path is for narrow asset repair. It does not change the shell contract.

# Contract-Enforcement Path

Use `prompts/codex/brief-metadata-enforcement.md` only when the task is specifically about the shell-side metadata contract for `brief`.

This is a separate lane from normal metadata warning repair:

- it is about approved shell-surface clarification, tightening, or minimal validation in `scripts/`
- it belongs to the contract side of the workflow, not to one-off prompt-pack or super-agent cleanup
- it must be explicitly in scope before any shell work happens

If the current task is only about warning interpretation, asset repair, or operator guidance, stay out of this lane.

# Common Operator Paths

Common current paths in this repo:

- warning seen in `brief`, category unclear: read `docs/METADATA_WARNING_EXAMPLES.md`, then use `prompts/codex/metadata-triage-check.md`
- warning seen in `audit`, checkpoint decision needed: read `docs/OPERATOR_RUNBOOK.md`, then use `prompts/codex/metadata-triage-check.md`
- warning already triaged and the affected asset is in scope: use `prompts/codex/metadata-fix-check.md`
- prompt-pack or super-agent metadata changed and operator-facing maps may drift: use `docs/CATALOG_MAINTENANCE.md` as the alignment guide
- question is really about changing how `brief` enforces or validates metadata: use `prompts/codex/brief-metadata-enforcement.md`

`docs/OPERATOR_RUNBOOK.md` is the right companion whenever the decision is operational: whether to fix now, defer intentionally, split the work, or prepare a clean checkpoint.

# How To Choose The Right Metadata Workflow Step

Use this decision rule:

- start from examples when you first need to identify what kind of warning you are looking at
- use `metadata-triage-check` when the category is known or knowable but the next action is undecided
- use `metadata-fix-check` when the next action is already approved and the work is a narrow asset-side repair
- use `brief-metadata-enforcement` only when the task explicitly moves into shell-side contract work for `brief`

A practical boundary:

- narrow asset repair means editing a prompt pack, a super-agent, or only the small catalog docs needed to keep those asset surfaces aligned
- contract-side shell work means changing or tightening the metadata rules, validation, or enforcement lane in `scripts/clau-dex.ps1` and its companion contract docs

If the issue can be resolved by improving one asset's headings or bullets, it is usually a narrow fix path. If the issue requires changing what the shell reads, warns on, or enforces, it is the contract-enforcement path.

# Non-Goals

This map does not:

- replace `docs/METADATA_CONVENTIONS.md` as the metadata contract
- replace `docs/OPERATOR_RUNBOOK.md` as the operational decision guide
- duplicate the full examples, conventions, runbook, or prompt-pack contents
- introduce metadata automation, new warning categories, or stronger failure semantics
- change shell behavior, add runtime code, or add CI or workflow changes

# Verification

Manual verification for this map:

- review `docs/METADATA_WARNING_EXAMPLES.md`
- review `docs/METADATA_CONVENTIONS.md`
- review `docs/OPERATOR_RUNBOOK.md`
- review `docs/CATALOG_MAINTENANCE.md`
- review `prompts/codex/metadata-triage-check.md`
- review `prompts/codex/metadata-fix-check.md`
- review `prompts/codex/brief-metadata-enforcement.md`
- review `scripts/clau-dex.ps1`
- run `.\scripts\clau-dex.ps1 brief`
- run `.\scripts\clau-dex.ps1 audit`
- confirm the map stays grounded in current checked-in repo behavior only
- confirm the map clearly separates examples, triage, narrow repair, and contract-side enforcement
- confirm the map does not duplicate whole source documents
- confirm no shell, `src/`, CI, or workflow files were changed for this task
