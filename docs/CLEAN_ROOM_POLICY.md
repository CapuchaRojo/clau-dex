# Clean Room Policy

## Purpose
`clau-dex` is original work created inside this repository. The project is clean-room by default, and the checked-in files in this repo are the source of truth for what exists today.

## Reference Boundary
`c.src.code` is reference-only material. It must not be treated as source code to adapt, port, translate, or reproduce inside `clau-dex`.

## Non-Copying Rule
No direct copying is allowed from `c.src.code` into `clau-dex`, including:
- source code
- pseudocode that closely tracks original implementation structure
- prompt text copied line-for-line
- comments, identifiers, filenames, or folder layouts reproduced to mirror the reference

## Allowed Extraction
Reference review may extract only high-level material such as:
- observations
- patterns
- workflows
- UX ideas
- architecture shapes
- feature categories

These outputs must stay abstract enough that they do not recreate the original implementation.

## Implementation Standard
All implementation in `clau-dex` must be net-new. New code, prompts, scripts, docs, and agent assets should be authored from first principles based on project goals and high-level takeaways rather than direct reference text.

## Documentation Requirement
When reference-informed decisions affect architecture or workflow, record the resulting high-level rationale in `docs/` using original wording. Do not paste or lightly paraphrase reference material.

## Verification
Manual verification for this policy change:
- Confirm this file states that `clau-dex` is original work.
- Confirm this file marks `c.src.code` as reference-only.
- Confirm this file prohibits direct copying and requires net-new implementation.
