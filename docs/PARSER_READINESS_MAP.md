# Purpose

This map defines the first safe parser boundary `clau-dex` could eventually adopt without starting `src/` implementation work in this task.

It exists so operators can understand, in current repo terms, what an original local parser lane would inspect first, what would remain owned by the bootstrap shell, what might later justify `src/`, and what is still out of scope.

# Current Repo Read

The current checked-in repo already has one narrow parsing-adjacent behavior: `.\scripts\clau-dex.ps1 brief` reads local markdown headings and section content from prompt packs and super-agent files.

That current behavior is still shell-first and docs-backed:

- `README.md` and `docs/CLI_FIRST_SHELL.md` define the shell as the only executable truth surface today
- `docs/METADATA_CONVENTIONS.md` documents the current heading contract that `brief` reads
- `docs/METADATA_WORKFLOW_MAP.md` separates asset-side metadata repair from shell-side contract work
- `docs/CATALOG_MAINTENANCE.md` treats prompt and agent metadata as checked-in catalog maintenance, not runtime behavior
- `docs/NEXT_IMPLEMENTATION_BACKLOG.md` says a source-level parsing engine is only a later plausible lane, not the current one
- `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md` reinforces one center of gravity, explicit boundaries, and delayed entry into `src/`

So the repo is parser-aware in concept, but not parser-implemented in `src/`.

# Why A Parser Lane Exists

`clau-dex` may eventually want an original local parser because the repo already depends on small, repeated reads of checked-in markdown structure.

A parser lane would be justified only to make that repeated inspection more explicit and reusable, especially when the repo needs to:

- inspect local markdown structure consistently
- separate raw content reading from shell presentation
- produce the same repo-truth signals without widening into search, ranking, or runtime automation
- clarify what is a content-reading concern versus what is an operator-shell concern

The goal would not be to create a product runtime. The goal would be to make one narrow local inspection concern more explicit when the shell-side contract is tight enough to deserve it.

# First Safe Parser Boundary

The first safe parser boundary is a local markdown-inspection lane for already-documented metadata surfaces only.

That boundary would inspect:

- prompt packs under `prompts/`
- super-agent files under `agents/super-agents/`
- only the current shell-readable headings and section bodies documented in `docs/METADATA_CONVENTIONS.md`

That means the first parser lane could safely inspect:

- whether a supported summary heading exists
- whether a supported best-use heading exists
- the first non-empty summary line under the matched heading
- the first small set of best-use bullets under the matched heading
- whether preferred headings were used or a documented fallback was needed
- whether best-use bullets are missing, empty, or still scaffold-grade

That boundary should stop at inspection and structured readout. It should not own shell commands, workflow routing, checkpoint decisions, scaffolding, or policy enforcement.

# What Stays Shell-Owned

The shell remains the current operator-facing execution surface.

Even if a parser lane exists later, these behaviors stay shell-owned for now:

- `status`, `audit`, `brief`, `checkpoint`, `docs`, `prompts`, `agents`, and `rules` as command surfaces
- repo posture summaries, warning phrasing, and operator-facing output formatting
- scaffold creation in `scaffold-agent`, `new-agent`, and `scaffold-prompt`
- repo-shape checks, local-state hygiene checks, canonical-boundary checks, and CI-artifact checks
- checkpoint reminders and workflow entry guidance
- the warning-versus-fail posture as currently expressed by the shell and companion docs

In practical terms, the shell may call into parsing logic later, but it still owns what operators run and what claims the executable surface makes.

# What Could Later Become src/-Owned

Only a narrow reusable inspection capability is a credible future `src/` candidate.

If the repo later crosses that threshold, `src/` could own:

- original parsing of the current markdown metadata contract
- small structured records for summary, best-use bullets, heading usage, and metadata notices
- reusable classification of metadata states such as preferred, fallback, missing, empty, or scaffold-grade

That future `src/` lane would still need to stay local-first and narrow. It would not justify:

- a packaged app runtime
- network behavior
- remote search
- semantic ranking
- generalized document ingestion
- a second execution story separate from the shell

# Signals Worth Parsing First

The first parser outputs should be simple signals that the repo already knows how to explain today.

The safest first signals are:

- asset kind: prompt pack or super-agent
- relative path of the checked-in file
- matched summary heading
- matched best-use heading
- summary text present or missing
- best-use bullets present, missing, or scaffold-grade
- preferred-heading match versus fallback-heading use
- a small metadata notice set that mirrors current warning-grade categories

These are appropriate first outputs because they are already grounded in:

- `.\scripts\clau-dex.ps1 brief`
- `.\scripts\clau-dex.ps1 audit`
- `docs/METADATA_CONVENTIONS.md`
- `docs/METADATA_WORKFLOW_MAP.md`

They help the shell stay honest without implying a broader parser runtime.

# Non-Goals

This first parser lane would not:

- parse arbitrary docs across `docs/` as a generic knowledge layer
- own operator workflow routing or checkpoint decisions
- replace `.\scripts\clau-dex.ps1` as the executable front door
- introduce shell changes in this task
- add any code to `src/` in this task
- add CI, workflow, dependency, or package-manager changes
- import code, names, layouts, or subsystem shapes from outside repos
- claim semantic understanding, ranking, embeddings, or AI-generated repo interpretation
- imply that `clau-dex` already has parser automation today

# Verification

Manual grounding and verification for this map:

- reviewed `README.md`
- reviewed `docs/WORKFLOW_ENTRY_MAP.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/NEXT_IMPLEMENTATION_BACKLOG.md`
- reviewed `docs/REFERENCE_SYNTHESIS_C_SRC_CODE.md`
- reviewed `docs/METADATA_CONVENTIONS.md`
- reviewed `docs/CATALOG_MAINTENANCE.md`
- reviewed `docs/METADATA_WORKFLOW_MAP.md`
- reviewed `scripts/clau-dex.ps1`
- ran `.\scripts\clau-dex.ps1 status`
- ran `.\scripts\clau-dex.ps1 brief`
- confirmed the map is grounded in current checked-in repo truth only
- confirmed the map defines the first parser lane as metadata inspection, not shell replacement or runtime work
- confirmed the map clearly separates shell-owned behavior from a later possible `src/` parsing boundary
- confirmed this task does not start `src/` implementation work
- confirmed this task does not imply code transplant or runtime capability not present today
