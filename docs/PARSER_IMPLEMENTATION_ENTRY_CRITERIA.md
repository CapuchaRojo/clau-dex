# Purpose

This document defines the entry criteria for the first real parser implementation slice in `src/`.

It exists to state exactly what must already be true before `clau-dex` allows a narrow source-level parser lane to begin.

This is a threshold document, not an implementation start. It does not add parser code, change the shell, or claim that `src/` work is already justified.

# What Must Already Be Stable

Before the first `src/` parser slice begins, the current shell-and-docs contract must already be stable enough that moving one narrow inspection concern into reusable code would reduce ambiguity rather than create it.

The following must already be true:

- `.\scripts\clau-dex.ps1` remains the only executable front door and still owns operator-facing commands, output phrasing, and workflow guidance
- `brief` and `audit` already read the same narrow metadata surfaces consistently for prompt packs and super-agents
- `docs/METADATA_CONVENTIONS.md` is accepted as the current source of truth for supported headings, fallback handling, and warning-grade metadata drift
- `docs/METADATA_WORKFLOW_MAP.md` still cleanly separates asset-side metadata repair from shell-side contract work
- the repo still treats parser work as local-first metadata inspection only, not as a new runtime lane
- the current repo still has no broader `src/` runtime, package-managed app story, or second execution surface waiting behind the parser

If those shell and docs surfaces are still moving materially, parser entry is premature.

# Minimum Contract Preconditions

The first `src/` parser slice is only allowed after the minimum parser contract is already defined in repo docs.

The following preconditions must already exist and stay aligned:

- `docs/PARSER_READINESS_MAP.md` defines the first safe parser boundary as narrow metadata inspection only
- `docs/PARSER_RECORD_SPEC.md` defines one exact record for one inspected asset
- the parser record fields are limited to current repo-truth signals such as asset kind, relative path, matched headings, summary text, best-use bullets, heading use, metadata state, and metadata notices
- current metadata state categories remain narrow and documented: `clean`, `fallback`, `missing`, `empty`, and `scaffold-grade`
- the supported asset scope remains limited to prompt packs under `prompts/` and super-agents under `agents/super-agents/`
- the repo can explain the parser output contract without inventing search, ranking, automation, or generalized document ingestion

If the record contract is still being renamed, widened, or debated, parser entry is not yet earned.

# Allowed First Implementation Scope

Once entry criteria are met, the first allowed `src/` parser slice may do only this:

- inspect one current supported markdown asset type lane used by `brief`
- read only the currently documented summary and best-use metadata sections
- produce one parser record per inspected asset using the documented parser record spec
- classify metadata state using the currently documented categories only
- stay local-first, deterministic, and limited to checked-in files
- serve as a reusable inspection helper that a shell surface could call later

The first parser slice should be narrow enough that it can be described as "source-level extraction of the existing metadata contract," not as a new product capability.

# What Still Stays Out Of Scope

Even after entry is allowed, the following still stay out of scope for the first parser slice:

- replacing `.\scripts\clau-dex.ps1` as the executable front door
- adding new shell commands, changing shell workflow routing, or moving operator wording into `src/`
- parsing arbitrary files across `docs/` or the whole repo as a generalized knowledge layer
- ranking, recommendation, search, semantic matching, or embeddings
- network behavior, remote services, or automation
- package manifests, lockfiles, frameworks, or a broader runtime story
- CI/workflow expansion beyond the current bootstrap surface
- catalog aggregation, map regeneration, or multi-asset orchestration

Entry allows one narrow parser lane only. It does not open a general `src/` build phase.

# Validation Expectations Before Entry

Before the first `src/` parser slice begins, the repo should be able to validate these practical claims from current checked-in truth:

- `status` still reports that `src/` has no implementation runtime
- `brief` still describes itself as a local markdown-heading reader, not a search or recommendation system
- the current shell metadata behavior is stable enough that the parser would mirror an existing contract rather than invent one
- the parser readiness map, parser record spec, metadata conventions, and workflow map do not contradict one another
- the next implementation decision still says parser work is later and threshold-based, not already underway

A strong sign of readiness is that the project can point to one stable, docs-backed inspection contract and one stable record shape without needing to broaden either one to justify `src/`.

# Abort Conditions

Do not start the first `src/` parser slice if any of these are true:

- the shell-side metadata contract for `brief` is still being actively tightened or redefined
- `docs/METADATA_CONVENTIONS.md`, `docs/PARSER_READINESS_MAP.md`, and `docs/PARSER_RECORD_SPEC.md` disagree on supported headings, signals, or state categories
- the repo still needs shell-side contract enforcement work before a source-level extraction would be trustworthy
- the desired parser scope has widened into search, ranking, workflow routing, catalog maintenance, or runtime planning
- the task depends on adding new asset types or new metadata surfaces that the current shell does not read
- the project is using parser planning language to imply that parser code already exists or that `src/` is generally open for implementation

Any of those conditions mean the repo is still in pre-entry planning or shell-hardening mode, not parser-entry mode.

# Non-Goals

This document does not:

- authorize parser implementation by itself
- claim the repo has now crossed the entry threshold
- define file layouts, module names, or implementation language choices for `src/`
- replace the parser readiness map or parser record spec
- broaden the roadmap beyond the first parser-entry decision
- add shell code, runtime code, CI changes, or workflow changes

# Verification

Manual verification for this criteria document:

- reviewed `docs/PARSER_READINESS_MAP.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/NEXT_IMPLEMENTATION_BACKLOG.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/METADATA_CONVENTIONS.md`
- reviewed `docs/METADATA_WORKFLOW_MAP.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the criteria build directly on the parser readiness map and parser record spec
- confirmed the criteria define what must be stable before `src/` parser work starts
- confirmed the criteria define what remains out of scope even after entry
- confirmed the document does not start `src/` implementation work
- confirmed the document does not imply parser code already exists
- confirmed this task adds one docs file only
