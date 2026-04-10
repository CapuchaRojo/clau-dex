# Metadata Conventions

## Purpose
This document defines the markdown metadata conventions that the bootstrap `clau-dex` shell already relies on when it reads prompt packs and super-agent files.

The contract in this file is intentionally narrow:
- it documents the current `brief` and `audit` expectations
- it keeps the shell behavior grounded in checked-in repo docs
- it does not introduce a generic schema system, runtime feature, search layer, or automation surface

## Scope
This contract applies to the markdown assets currently consumed by `.\scripts\clau-dex.ps1 brief`:
- prompt packs under `prompts/`
- super-agent files under `agents/super-agents/`

`brief` reads only local markdown headings and section content. It does not infer metadata from filenames, tags, frontmatter, embeddings, ranking, or remote services.

## Current Shell Contract
`brief` reads two metadata fields from each supported markdown file:
- a summary field
- a best-use field

For each asset kind, the shell has one preferred heading for each field and a small fallback list for compatibility.

`audit` currently performs one metadata convention check per file:
- whether a supported summary heading exists
- whether the preferred summary heading was used or a fallback was needed
- whether the matched summary section contains usable summary text
- whether a supported best-use heading exists
- whether the preferred best-use heading was used or a fallback was needed
- whether the matched best-use section contains at least one bullet
- whether the matched best-use bullets are file-specific enough to act as a picker cue rather than still looking like untouched scaffold defaults

Missing preferred headings currently produce warnings, not failures.

## Prompt Pack Conventions
Preferred headings for prompt packs:
- summary: `## Goal`
- best used for: `## Use This Prompt When`

Allowed fallback headings currently recognized by `brief` for prompt packs:
- summary fallbacks: `## Purpose`, `## Overview`
- best-use fallbacks: `## Use When`, `## Best Used For`

Prompt pack example:

```md
# Codex Prompt Pack: Example

## Goal
Create or refine a reusable task prompt for a narrow bootstrap-stage workflow.

## Use This Prompt When
- the task repeats often enough to deserve a reusable prompt
- the task needs a stable output shape
- the work should stay local-first and docs-first
```

How `brief` reads prompt pack metadata:
- summary text: the first non-empty line under the first supported summary heading it finds
- best-use text: up to the first two bullet lines under the first supported best-use heading it finds
- weak best-use check: warning-grade if those picked bullets still match the default scaffold bullets from `scaffold-prompt`

## Super-Agent Conventions
Preferred headings for super-agents:
- summary: `## Purpose`
- best used for: `## Best Used For`

Allowed fallback headings currently recognized by `brief` for super-agents:
- summary fallbacks: `## Goal`, `## Overview`
- best-use fallbacks: `## Use When`, `## Recommended For`

Super-agent example:

```md
# Super-Agent: Example

## Purpose
Handle one focused repository lane with clear boundaries and reviewable output.

## Best Used For
- one repeated repo task
- one narrow planning or review lane
- one clear output shape
```

How `brief` reads super-agent metadata:
- summary text: the first non-empty line under the first supported summary heading it finds
- best-use text: up to the first two bullet lines under the first supported best-use heading it finds
- weak best-use check: warning-grade if those picked bullets still match the default scaffold bullets from `scaffold-agent`

## Future Shell-Consumable Markdown Assets
If a future shell command starts consuming another markdown asset type, document that contract in repo docs before depending on it.

Until a future asset type gets its own command-specific contract:
- do not claim that the current shell consumes it
- do not invent shared frontmatter or schema machinery
- prefer `## Purpose` for the summary field
- prefer `## Best Used For` for the best-use field

Those provisional headings are a documentation convention only. No current shell command reads additional asset types today.

## Missing Metadata Behavior
If preferred headings are present:
- `brief` reads them directly
- `audit` stays green for that file's metadata check

If a preferred heading is missing but a supported fallback heading exists:
- `brief` uses the fallback heading
- `brief` prints a notice that a fallback heading was used
- `brief` also prints a convention-check notice naming the missing preferred heading
- `audit` warns for that file because the preferred heading drifted

If no supported summary heading exists, or the matched summary section has no non-empty text:
- `brief` shows: `Missing metadata: no summary text found under the supported headings. Review the file directly before using it.`
- `brief` adds a notice that summary metadata is missing or empty
- `brief` sets `Next use` to `Review the file directly before choosing it.`
- `audit` warns for that file because the summary contract is incomplete

If no supported best-use heading exists, or the matched section has no bullet list:
- `brief` shows: `Best for: Missing metadata: no supported best-for bullets were found.`
- `brief` adds a notice that best-for metadata is missing or has no bullet list
- `brief` sets `Next use` to `Review the file directly before choosing it.` if no usable bullet was found
- `audit` warns for that file because the best-use contract is incomplete

If a supported best-use heading exists and contains bullets, but the picked bullets are still scaffold-grade defaults:
- `brief` keeps showing the bullets so the checked-in file is still visible
- `brief` adds a metadata notice that the best-use guidance is still scaffold-grade
- `brief` suppresses `Next use` and falls back to `Review the file directly before choosing it.`
- `audit` warns for that file because the best-use contract is too weak for a reliable picker cue

`brief` also reports one metadata posture line near the top:
- `clean` when no prompt packs or super-agents currently carry metadata notices
- `warning-grade notices on N item(s)` when fallback, missing, empty, or scaffold-grade metadata was detected

## Warning Semantics
Current metadata drift is warning-grade, not failure-grade.

What is currently a warning:
- a prompt pack is missing `## Goal`
- a super-agent is missing `## Purpose`
- a prompt pack is missing `## Use This Prompt When`
- a super-agent is missing `## Best Used For`
- `brief` had to use a supported fallback heading
- `brief` could not read summary or best-use metadata and had to print missing-metadata notices
- `brief` found best-use bullets, but they were still scaffold-grade defaults rather than file-specific guidance
- `audit` found missing or empty summary metadata
- `audit` found missing or empty best-use metadata
- `audit` found best-use bullets that were present but too weak for a reliable picker cue

What is not yet a failure:
- missing preferred metadata headings
- use of currently documented fallback headings
- missing best-use headings or missing best-use bullets
- scaffold-grade best-use bullets

What the shell does not do today:
- fail `brief` because metadata is incomplete
- fail `audit` because metadata headings drifted or a file has incomplete metadata
- enforce this contract outside prompt packs and super-agents

## Practical Authoring Guidance
When creating or updating a prompt pack:
- use `## Goal`
- use `## Use This Prompt When`
- keep the first line under `## Goal` concise because `brief` reads only the first non-empty line
- use bullet lines under `## Use This Prompt When` because `brief` reads bullets, not paragraphs, for best-use text
- replace the default scaffold bullets with prompt-specific usage cues before treating the prompt pack as fully brief-ready

When creating or updating a super-agent:
- use `## Purpose`
- use `## Best Used For`
- keep the first line under `## Purpose` concise because `brief` reads only the first non-empty line
- use bullet lines under `## Best Used For` because `brief` reads bullets, not paragraphs, for best-use text
- replace the default scaffold bullets with agent-specific usage cues before treating the super-agent as fully brief-ready

## Verification
Manual verification for this contract:
- review this document against `scripts/clau-dex.ps1`
- confirm the preferred and fallback headings match `Get-BriefConvention`
- confirm the missing-metadata behavior matches `Get-MarkdownBriefRecord`
- confirm the weak best-use handling matches `Get-WeakBestForBullets` and `Get-MarkdownBriefRecord`
- confirm the warning behavior matches `Test-BriefMetadataConvention` and `Test-BriefMetadataRecord`
- confirm the document does not imply search, ranking, embeddings, runtime automation, or non-local metadata parsing
