# Scripts

Local bootstrap helpers live here.

## Current Scripts
- `clau-dex.ps1`: a small CLI-first shell for repo status, a narrow bootstrap audit, operating-rule summaries, and focused agent scaffolding

## Current Commands
- `help`: show the shell command summary
- `status`: show the current executable repository surface
- `audit`: check a small hardcoded bootstrap-state surface and print a PASS / WARN / FAIL report
- `docs`: list checked-in docs
- `prompts`: list prompt packs
- `agents`: list agent definitions
- `rules`: print the current operating rules summary
- `scaffold-agent <name>`: create a focused agent scaffold under `agents/super-agents/`
- `new-agent <name>`: compatibility alias for `scaffold-agent <name>`

## Script Rules
- Keep scripts optional and locally understandable.
- Avoid external dependencies unless they are documented in-repo.
- Prefer small command surfaces over speculative automation.
