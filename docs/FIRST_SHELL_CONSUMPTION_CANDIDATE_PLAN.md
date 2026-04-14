# Purpose

This document defines the first future shell surface that could consume parser facts in `clau-dex` without changing shell ownership or widening runtime scope.

It exists so the repo can name one exact first consumer, one narrow read-only consumption boundary, and the shell-owned behavior that must remain unchanged in that checkpoint.

# Candidate Shell Surfaces Considered

The current shell docs justify only three realistic parser-adjacent surfaces:

- `brief`
- `audit`
- `status`

`brief` is the strongest first candidate because it already reads the same narrow metadata facts named in `docs/PARSER_RECORD_SPEC.md`.

`audit` is a weaker first candidate because it also owns PASS / WARN / FAIL posture and mixes metadata checks with broader bootstrap checks. Using parser facts there first would raise the risk of changing shell judgment behavior in the same checkpoint.

`status` is the weakest first candidate because it is a quick-glance summary surface built from shell-owned rollups rather than one-asset metadata facts. Starting there would blur the boundary between parser inspection and shell summarization too early.

# Recommended First Consumer

The recommended first future consumer is `brief`.

That recommendation matches current repo truth because `brief` is already the shell surface most directly grounded in:

- one asset at a time
- summary text
- best-use bullets
- heading fallback detection
- metadata notices

So the first future parser-fact consumption checkpoint should be framed as:

- `brief` remains the same shell command
- `brief` remains read-only
- `brief` may later source some of its asset facts from a parser record or adapter output instead of only direct shell extraction

# Why This Surface Is First

`brief` is the safest first consumer for practical reasons:

- it already presents exactly the metadata fields the parser contract describes
- it already works asset-by-asset rather than as a broader repo-status rollup
- it does not own shell failure semantics in the way `audit` does
- it is already described as a local picker summary, so parser-backed facts would remain inspection-oriented rather than policy-oriented
- current shell docs already say `brief` reads local markdown headings only, which aligns with the narrow parser slice

This makes `brief` lower risk than `audit` or `status`.

The shell can keep the same operator-facing role while swapping only the internal fact source for one narrow metadata lane later.

# Read-Only Consumption Boundary

The first consumption boundary should stay read-only and narrow.

In practical terms, that future checkpoint should allow only this:

- `brief` selects one supported prompt pack or one supported super-agent
- parser or adapter returns one normalized fact object for that asset
- `brief` uses those facts to fill the same summary, best-for, and metadata-notice slots it already owns

The parser facts that could later be consumed there are only the currently documented ones:

- asset kind
- repo-relative path
- matched summary heading
- matched best-use heading
- summary text
- up to two best-use bullets
- heading-use results
- metadata state
- metadata notices

That boundary must stay read-only:

- no file edits
- no scaffold behavior
- no command routing changes
- no workflow state changes
- no broader repo scanning beyond the current supported asset scope

# What Must Stay Shell-Owned

Even if `brief` later reads parser facts, the shell must still own:

- all operator-facing wording in `brief`
- section ordering and grouping
- first-pick cues
- picker hints
- the metadata posture line
- any decision to collapse or rewrite metadata notices for readability
- fallback messaging such as telling the operator to review the file directly
- the command surface itself and when operators should use `brief`

The future parser consumer checkpoint must therefore keep `brief` as the presenter and the parser as a fact source only.

# What Must Not Change In The Same Checkpoint

The first shell-consumption checkpoint must not combine `brief` consumption with wider shell changes.

It must not change in the same checkpoint:

- `audit` PASS / WARN / FAIL behavior
- `status` repo-posture summaries
- shell command names or command routing
- workflow docs that tell operators where to start
- parser scope beyond current prompt-pack and super-agent metadata inspection
- shell scaffolding commands
- CI, workflow, or broader runtime surfaces

If those move at the same time, the checkpoint stops being a narrow first consumer and starts looking like a shell redesign.

# Non-Goals

This plan does not:

- add shell code
- add runtime code in `src/`
- start parser-shell integration now
- recommend `audit` or `status` as parallel first consumers
- define a broader shell roadmap
- imply parser-owned presentation, parser-owned workflow logic, or shell replacement
- authorize broader runtime activation or multi-surface parser rollout

# Verification

Manual grounding and verification for this plan:

- reviewed `docs/PARSER_SHELL_ADAPTER_BLUEPRINT.md`
- reviewed `docs/PARSER_SHELL_HANDOFF_SPEC.md`
- reviewed `docs/PARSER_IMPLEMENTATION_BLUEPRINT.md`
- reviewed `docs/PARSER_RECORD_SPEC.md`
- reviewed `docs/CLI_FIRST_SHELL.md`
- reviewed `docs/WORKFLOW_ENTRY_MAP.md`
- reviewed `scripts/clau-dex.ps1`
- confirmed the plan builds directly on the adapter blueprint and shell handoff docs
- confirmed it chooses one exact first future consumer: `brief`
- confirmed the planned consumption boundary stays read-only and narrow
- confirmed shell-owned wording, grouping, and workflow logic remain unchanged
- confirmed the document does not imply shell replacement, parser-owned presentation, or broader runtime activation
