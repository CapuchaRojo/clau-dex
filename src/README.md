# Source

Main implementation code lives here when it is justified by checked-in repo truth.

Current scope is still intentionally narrow:

- `src/parser/` contains one small parser lane for inspection-only metadata reads
- that lane is limited to one checked-in prompt pack or one checked-in super-agent at a time
- the parser returns structured records only and does not own shell wording or command flow
- `scripts/clau-dex.ps1` remains the only operator-facing executable front door

No broader packaged runtime, dependency-managed app surface, or shell replacement exists in
`src/` today.
