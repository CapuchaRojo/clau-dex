# Parser Lane

`src/parser/` is the first narrow implementation lane in `clau-dex`.

Current scope is intentionally limited to one inspection-only parser flow that can:

- accept one repo-relative markdown path
- accept one supported asset kind: `prompt-pack` or `super-agent`
- inspect only the current summary and best-use metadata sections
- return one parser record aligned with `docs/PARSER_RECORD_SPEC.md`

Current boundaries:

- no shell integration
- no multi-file scanning or aggregation
- no ranking, search, or recommendation behavior
- no broader runtime activation outside this lane

This lane is source-only. `scripts/clau-dex.ps1` remains the only operator-facing executable
surface.

For local verification during development, dot-source `parse-asset.ps1` and call
`Invoke-ParseAsset`.
