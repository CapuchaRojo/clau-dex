# Source Intake Protocol

## Purpose
This protocol defines how outside reference material may be reviewed without breaking the clean-room status of `clau-dex`.

## Intake Rule
If `c.src.code` is reviewed, treat it as reference-only input. Do not copy from it, transcribe it, or convert it into partially rewritten implementation for this repository.

## What May Be Taken
Only the following may be extracted from `c.src.code`:
- high-level observations
- patterns
- workflows
- UX ideas
- architecture shapes
- feature categories

## What Must Not Be Taken
The following must not be brought into `clau-dex` from `c.src.code`:
- direct code snippets
- near-copy implementations
- line-by-line rewrites
- copied prompts or specifications
- mirrored file structure meant to replicate the reference
- distinctive naming copied from the reference when it serves no original project need

## Transformation Expectation
Any accepted takeaway must be re-expressed in original language and then implemented as net-new work inside `clau-dex`. High-level inspiration is allowed; derivative implementation is not.

## Recording Outcome
If a reference review influences project direction, document the result as an original summary in `docs/` before relying on it in prompts, agents, scripts, or future implementation.

## Verification
Manual verification for this protocol change:
- Confirm this file limits intake to high-level categories only.
- Confirm this file forbids direct copying from `c.src.code`.
- Confirm this file requires all `clau-dex` implementation to be net-new.
