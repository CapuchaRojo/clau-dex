# Purpose

This document defines the likely `src/` placement for the first narrow parser slice in `clau-dex` without starting implementation.

It exists so the repo can describe where that first parser lane would probably live, what would sit immediately around it, and how small the first code footprint must remain when parser entry is eventually allowed.

# Current Constraints

The current parser planning set already fixes the relevant boundaries:

- `.\scripts\clau-dex.ps1` remains the only executable front door
- the first parser lane is limited to local markdown metadata inspection already reflected by `brief` and `audit`
- the supported scope stays limited to prompt packs under `prompts/` and super-agents under `agents/super-agents/`
- the first parser slice is inspection-only and returns one structured record per inspected asset
- this document must not start `src/` implementation, shell changes, CI changes, or broader runtime planning

So this preflight is about likely placement only. It is not approval to activate `src/`.

# Likely src Placement

The first parser module would most likely live under a parser-specific lane inside `src/`, with the narrowest credible placement being:

- `src/parser/` as the first parser boundary

Within that lane, the first implementation slice would most likely center on one small entry module that inspects one supported asset and returns one parser record.

That placement is the best fit for current repo truth because it:

- keeps the parser isolated from shell command code in `scripts/`
- signals that the lane is reusable inspection logic, not a second executable surface
- leaves the rest of `src/` inactive rather than implying broad implementation has started
- matches the current parser docs, which describe one narrow parsing concern rather than a full application structure

# Likely Adjacent Files Or Modules

The first parser slice would likely need only a few adjacent pieces around that `src/parser/` lane.

The most likely neighbors are:

- one parser entry module that accepts one supported asset input and returns one parser record
- one heading-or-section reader module limited to the current summary and best-use headings
- one record-shaping module aligned with `docs/PARSER_RECORD_SPEC.md`
- one metadata-notice or metadata-state helper limited to current categories such as `clean`, `fallback`, `missing`, `empty`, and `scaffold-grade`

These are likely boundaries, not committed filenames. The important point is that section matching, field extraction, record assembly, and notice classification stay inside the parser lane while shell phrasing and command behavior stay outside it.

# Minimum First Code Footprint

The first code footprint should stay as small as possible.

In practical terms, the minimum first slice should be small enough to cover only:

- one parser lane under `src/parser/`
- one supported inspection contract for one checked-in asset at a time
- the current summary-heading and best-use-heading reads already justified by existing docs
- one parser record output shape already defined in `docs/PARSER_RECORD_SPEC.md`

The first slice should not expand beyond the smallest reusable extraction of the current shell-readable metadata contract.

If the future implementation needs broader path scanning, catalog aggregation, command routing, or a second `src/` subsystem to make the first slice feel worthwhile, the footprint is already too large for entry.

# What Must Still Stay Outside src

Even after the first parser slice begins, these concerns must still stay outside `src/`:

- all operator command surfaces in `.\scripts\clau-dex.ps1`
- shell-owned output phrasing, formatting, and workflow guidance
- shell decisions about PASS / WARN / FAIL posture
- scaffolding commands such as `scaffold-agent`, `new-agent`, and `scaffold-prompt`
- repo posture reporting, checkpoint reminders, and bootstrap boundary checks

This preserves the shell as the only executable front door. A later parser lane may support shell commands, but it does not become a command surface of its own.

# What Must Still Stay Absent

Even after the first parser slice begins, the following should still remain absent from `src/`:

- a packaged runtime or application entrypoint
- search, ranking, recommendation, or semantic interpretation layers
- generalized parsing for unrelated `docs/` content
- network behavior, hosted services, or automation
- dependency manifests, lockfiles, frameworks, or runtime-expansion scaffolding
- multi-feature `src/` activation beyond the narrow parser lane

The first parser slice must not be used to imply shell replacement, broader runtime growth, or open-ended `src/` implementation.

# Non-Goals

This preflight does not:

- authorize parser implementation by itself
- define final filenames or language-specific details beyond the likely parser lane
- redesign the shell or hand command ownership to `src/`
- define a broad `src/` architecture for future unrelated features
- widen the parser scope beyond the current metadata-inspection planning docs

# Verification

Manual review and task checks for this preflight:

- reviewed `docs/PARSER_READINESS_MAP.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed this document builds directly on the current parser planning docs
- confirmed this document stays non-coding and does not start `src/` implementation
- confirmed this document defines likely `src/` placement and nearby boundaries clearly
- confirmed this document keeps the first code footprint narrow
- confirmed this document does not imply shell replacement, runtime expansion, or broader `src/` activation
- confirm no shell, `src/`, CI, or workflow files are changed as part of this task
