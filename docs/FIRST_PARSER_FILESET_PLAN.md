# Purpose

This document defines the likely initial `src/parser/` file set for the first real parser code checkpoint in `clau-dex` without starting implementation in this task.

The first narrow `src/parser/` lane has now landed, so this document should be read as the preflight plan that shaped that initial fileset rather than as a claim that parser implementation is still absent.

It exists so the repo can name one narrow parser footprint, the boundaries immediately around it, and the files that should still remain absent when that first checkpoint lands.

# Current Constraints

The current parser planning docs already constrain this plan:

- `.\scripts\clau-dex.ps1` remains the only executable front door
- the first parser slice is limited to local markdown metadata inspection already reflected by `brief` and `audit`
- current supported scope stays limited to prompt packs under `prompts/` and super-agents under `agents/super-agents/`
- the first parser slice is inspection-only, deterministic, and one-record-per-asset
- the parser record stays aligned with `docs/PARSER_RECORD_SPEC.md`
- this task must not add shell code, `src/` runtime code, CI changes, or broader `src/` architecture work

So this plan is a file-set preflight only. It does not authorize `src/` implementation by itself.

# Likely Initial File Set

The smallest credible first parser lane is likely:

- `src/parser/README.md`
- `src/parser/parse-asset.*`
- `src/parser/read-metadata-sections.*`
- `src/parser/build-parser-record.*`
- `src/parser/classify-metadata-state.*`

The exact extension is still intentionally undecided here. The plan only fixes the likely file set and responsibilities.

This is the narrowest practical set because it keeps one clear parser entry file, isolates the small helper seams already justified by the planning docs, and avoids implying a broader runtime or multi-feature `src/` activation.

# What Each File Would Likely Own

- `src/parser/README.md`
  Documents the parser lane as a narrow local inspection helper, names the current supported asset scope, and states that the shell still owns command execution and presentation.

- `src/parser/parse-asset.*`
  Likely entry file for the first parser slice. Accepts one repo-relative path plus one supported asset kind, coordinates the narrow read-and-shape flow, and returns one parser record for one checked-in asset.

- `src/parser/read-metadata-sections.*`
  Owns heading matching and section extraction only for the currently documented summary and best-use headings, including preferred-versus-fallback heading detection.

- `src/parser/build-parser-record.*`
  Owns assembly of the final one-asset parser record so the output contract stays visibly aligned with `docs/PARSER_RECORD_SPEC.md`.

- `src/parser/classify-metadata-state.*`
  Owns the current metadata-state and notice decisions only, limited to `clean`, `fallback`, `missing`, `empty`, and `scaffold-grade`.

If the first checkpoint needs materially more than these boundaries, the slice is probably too wide for entry.

# What Should Not Exist Yet

The first parser checkpoint should still avoid creating:

- `src/parser/index.*` or any app-style package entrypoint
- parser-backed command handlers or shell-routing files
- catalog, scan-all, search, ranking, recommendation, or orchestration modules
- generic repo markdown parsers outside the current prompt-pack and super-agent scope
- runtime bootstrap, service, API, daemon, or automation files
- test harness expansion that implies a broader application runtime
- sibling `src/` subsystems unrelated to the narrow parser lane

Those absences matter because the first parser checkpoint is only a source-level extraction of the current metadata contract, not the start of shell replacement or general `src/` activation.

# Expected src README Truth Update

Once the first parser code checkpoint lands, `src/README.md` would need to stay explicit and narrow.

It would likely need to say, in practical terms:

- `src/` now contains one small parser lane under `src/parser/`
- that lane is limited to local metadata inspection for current prompt-pack and super-agent files
- the parser returns structured inspection data only
- `.\scripts\clau-dex.ps1` still remains the only executable front door
- no broader runtime, package-managed app surface, or shell replacement exists

That update should describe code that is actually checked in, not a wider future architecture.

# Non-Goals

This plan does not:

- choose an implementation language or exact file extension
- authorize writing parser code in this task
- redesign `src/` as a broad runtime tree
- move shell commands, output phrasing, or workflow guidance into `src/`
- imply parser integration into `status`, `brief`, or `audit` already exists
- widen parser scope beyond the current metadata-inspection contract

# Verification

Manual grounding and verification for this file-set plan:

- reviewed `docs/SRC_PARSER_LAYOUT_PREFLIGHT.md`
- reviewed `docs/FIRST_PARSER_CHECKPOINT_PLAN.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- reviewed `src/README.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the plan builds directly on the current parser planning docs
- confirmed the plan stays non-coding and does not start `src/` implementation
- confirmed the likely initial `src/parser/` file set is defined clearly
- confirmed the proposed file set keeps the first code footprint narrow
- confirmed the plan does not imply broader `src/` activation, shell replacement, or runtime expansion
- confirm no shell, `src/`, CI, or workflow files are changed as part of this task
