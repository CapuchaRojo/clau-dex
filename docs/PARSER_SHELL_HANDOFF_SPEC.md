# Purpose

This document defines the future handoff seam between a narrow parser output and the existing `clau-dex` shell.

It exists so the project can describe how `.\scripts\clau-dex.ps1` could later consume parser results while remaining the only executable front door and without starting implementation work in this task.

# Shell-Owned Responsibilities

The shell remains the only operator-facing execution surface.

Even if a parser lane exists later, the shell still owns:

- operator commands such as `status`, `audit`, `brief`, `checkpoint`, `docs`, `prompts`, `agents`, and `rules`
- operator-facing phrasing, formatting, and output grouping
- workflow entry guidance and checkpoint reminders
- warning-versus-fail posture as expressed to the operator
- repo posture summaries, picker hints, and next-action wording
- scaffold creation and other shell-local helper behavior
- any decision about when parser output is shown, suppressed, summarized, or combined with other shell-owned checks

The shell therefore continues to decide what the operator runs and what claims the executable surface makes.

# Parser-Owned Responsibilities

The parser would own only the narrow inspection work already justified by the parser planning docs.

That means the parser could later own:

- reading one supported markdown asset in the current parser scope
- matching supported summary and best-use headings for that asset kind
- extracting the first non-empty summary line
- extracting up to the first two best-use bullets
- classifying heading use as preferred, fallback, or missing
- classifying metadata state using the current documented categories
- returning inspection notices grounded in the current metadata contract

The parser does not own shell wording, command surfaces, workflow routing, or operator decisions.

# Handoff Seam

The handoff seam lives conceptually between "inspect one asset and return structured facts" and "present shell output for operators."

In practical terms, the seam is:

- shell selects the current command path and determines whether parser-backed inspection is needed
- shell identifies one supported asset to inspect
- parser returns one structured record for that asset
- shell decides how that record is used in `brief`, `audit`, or a later equivalent shell-owned presentation step

The seam should stay one-directional:

- parser returns inspection facts
- shell interprets those facts for command output

The parser should not call back into shell behavior, choose commands, or decide how operators are guided.

# Expected Parser Return Shape

The parser return shape should stay aligned with `docs/PARSER_RECORD_SPEC.md` and the current implementation blueprint.

The expected record shape is one record per inspected asset with fields such as:

- `asset_kind`
- `relative_path`
- `matched_summary_heading`
- `matched_best_use_heading`
- `summary_text`
- `best_use_bullets`
- `heading_use`
- `metadata_state`
- `metadata_notices`

This return shape should be inspection-ready rather than presentation-ready.

That means the parser returns:

- what heading matched
- what text was extracted
- what metadata state was detected
- what notices apply

It does not return:

- final shell sentences
- command-specific banners
- picker hints
- warning banners
- workflow recommendations

# Expected Shell Consumption Shape

The shell should consume parser output as one structured fact source, not as a replacement for shell logic.

In practical terms, later shell consumption would likely work like this:

- `brief` uses parser records to fill summary text, best-for bullets, and metadata notice lines for one asset at a time
- `audit` uses parser records to decide whether a metadata check passes or warns under the current shell-owned posture
- `status` may continue summarizing repo posture from shell-owned checks without needing to expose raw parser records directly
- workflow docs such as `docs/WORKFLOW_ENTRY_MAP.md` continue pointing operators to shell commands rather than to a parser layer

The shell should remain free to:

- reorder fields for readability
- collapse multiple parser notices into one shell-facing line
- translate a `metadata_state` into current PASS / WARN shell output
- choose whether to show a direct file-review fallback when parser output is incomplete

This keeps the parser as a reusable inspection helper while the shell stays the presentation and workflow owner.

# What Must Stay Out Of Scope

The parser/shell handoff must not widen into:

- a second executable surface outside `.\scripts\clau-dex.ps1`
- parser-owned command routing or workflow entry decisions
- parser-owned output formatting or operator wording
- generalized repo scanning across unrelated docs
- ranking, recommendation, search, or semantic interpretation
- catalog aggregation, family summaries, or broad orchestration
- runtime expansion, network behavior, or automation

The seam is only for handing off one narrow inspection result to a shell-owned command surface.

# Non-Goals

This document does not:

- start `src/` implementation
- define shell code changes
- redesign `brief`, `audit`, or the shell command set
- replace the parser readiness map, record spec, entry criteria, or implementation blueprint
- authorize a parser entry checkpoint by itself
- imply that parser output is already being consumed by the shell today

# Verification

Manual grounding and verification for this handoff spec:

- reviewed `docs/PARSER_READINESS_MAP.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/WORKFLOW_ENTRY_MAP.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the spec builds directly on the parser readiness map, record spec, entry criteria, and implementation blueprint
- confirmed the shell remains the only executable surface
- confirmed the spec clearly separates parser output from shell-owned phrasing, workflow guidance, and operator commands
- confirmed the document does not start `src/` implementation
- confirmed the document does not imply shell replacement or runtime expansion
