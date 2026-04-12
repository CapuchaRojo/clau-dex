# Purpose

This document describes the first allowed parser implementation slice for `clau-dex` without starting `src/` work in this task.

It exists to turn the current parser planning set into one practical, implementation-adjacent blueprint that future work can follow when the repo is ready to cross the parser entry threshold.

# Current Constraints

The blueprint must stay grounded in current checked-in repo truth:

- `.\scripts\clau-dex.ps1` remains the only executable front door
- the current parser concern is limited to local markdown metadata inspection already visible in `brief` and `audit`
- the current supported asset scope is limited to prompt packs under `prompts/` and super-agents under `agents/super-agents/`
- the current metadata contract is limited to summary headings, best-use headings, first non-empty summary text, first best-use bullets, heading preference versus fallback use, and warning-grade metadata notices
- the first parser slice must stay inspection-only and deterministic
- this blueprint does not authorize shell changes, `src/` code, CI changes, or broader runtime planning

# First Allowed Parser Slice

The first allowed parser slice is one narrow local parser lane that inspects one supported markdown asset and returns one structured parser record for that asset.

In practical terms, the slice is allowed to:

- read one checked-in prompt pack or one checked-in super-agent file
- inspect only the currently documented summary and best-use metadata surfaces
- recognize the current preferred headings and documented fallback headings for that asset kind
- extract the first non-empty summary line and up to the first two best-use bullets
- classify the inspected file into the current metadata-state categories
- attach warning-grade metadata notices that mirror the current shell contract

This keeps the first slice narrow enough to describe as "source-level extraction of the existing metadata contract" rather than a new feature lane.

# Likely Module Boundaries

The first implementation should likely separate responsibilities into small layers even if the actual future file layout stays undecided.

One likely boundary shape:

- asset selector layer: accepts one repo-relative path plus the expected asset kind and rejects unsupported scope
- markdown section reader layer: finds only the supported summary and best-use headings for that asset kind and returns matched section content
- metadata extraction layer: turns the matched sections into summary text, best-use bullets, heading-use results, and missing-or-empty signals
- record assembly layer: produces the final one-asset parser record in the documented contract shape
- metadata notice layer: derives current warning-grade notices such as fallback used, missing heading, empty summary text, missing bullets, or scaffold-grade bullets

The important constraint is not the exact names. The important constraint is that path selection, section matching, field extraction, and record shaping remain distinct enough that later shell callers could reuse the parser without inheriting shell wording or command behavior.

# Inputs

The first slice should take only the smallest current inputs needed to inspect one supported asset:

- a repo-relative file path
- an asset kind limited to `prompt-pack` or `super-agent`
- the current heading convention for that asset kind, as already documented in repo docs
- the raw checked-in markdown contents of that one file

No other inputs should be required for the first slice.

It should not depend on:

- cross-file context
- catalog maps
- search queries
- ranking signals
- shell command arguments beyond selecting one supported asset
- network state, environment state, or remote services

# Outputs

The first slice should emit one parser record per inspected asset, shaped by `docs/PARSER_RECORD_SPEC.md`.

That record should practically carry:

- asset kind
- repo-relative path
- matched summary heading or `null`
- matched best-use heading or `null`
- summary text using the current first-non-empty-line rule
- up to the first two best-use bullets
- heading-use status for summary and best-use fields
- one current metadata-state category
- zero or more metadata notices grounded in the current shell-visible warning categories

The output should be sufficient for a later shell caller to present briefing or convention-check information without forcing the parser itself to own shell phrasing, command structure, or workflow guidance.

# Internal Responsibilities

Inside this first slice, the parser would likely own only the following responsibilities:

- confirm that the requested asset is in the currently supported parser scope
- locate the first supported summary heading for the asset kind
- locate the first supported best-use heading for the asset kind
- read the first non-empty line under the matched summary heading
- read up to the first two bullet lines under the matched best-use heading
- distinguish preferred-heading use from fallback-heading use
- distinguish usable metadata from missing, empty, or scaffold-grade metadata
- create the one-asset parser record without aggregating across files

Record creation would likely be shaped as a final assembly step after extraction:

- raw markdown sections become normalized extracted fields
- extracted fields become heading-use and metadata-state decisions
- those decisions become one stable parser record for the inspected file

That sequence keeps the parser focused on inspection facts first and shell-facing interpretation second.

# What The Slice Must Not Do

The first slice must not:

- replace `.\scripts\clau-dex.ps1` as the executable front door
- scan arbitrary markdown across `docs/` as a generic knowledge layer
- aggregate multiple assets into one catalog result
- own the `brief` or `audit` command surface
- generate operator guidance, checkpoint advice, or workflow routing
- infer metadata from filenames, tags, frontmatter, embeddings, or semantic search
- introduce ranking, recommendation, search, or shell replacement behavior
- imply a packaged runtime, remote service, or automation surface

# Non-Goals

This blueprint is not:

- a source tree design for all of `src/`
- a broad architecture rewrite
- a parser for every markdown document in the repo
- a basis for shell command expansion
- a justification for new dependencies, CI changes, or workflow changes
- evidence that parser entry criteria have already been met

The first slice stays narrow precisely so later implementation can be justified as one small extraction of an already-documented contract rather than the start of a broader runtime story.

# Verification

Manual grounding and verification for this blueprint:

- reviewed `docs/PARSER_READINESS_MAP.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_ENTRY_CRITERIA.md`
- reviewed `docs/NEXT_IMPLEMENTATION_BACKLOG.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/METADATA_CONVENTIONS.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the blueprint builds directly on the current parser contract docs
- confirmed the blueprint stays non-coding and does not start `src/` implementation
- confirmed the blueprint defines likely module boundaries, inputs, outputs, and responsibilities clearly
- confirmed the slice stays narrow and inspection-only
- confirmed the blueprint does not imply shell replacement, search, ranking, or broader runtime behavior
