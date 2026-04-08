# Scripts

Local bootstrap helpers live here.

## Current Scripts
- `clau-dex.ps1`: a small CLI-first shell for repo status, a narrow bootstrap audit, concise prompt/agent briefing, operating-rule summaries, focused agent scaffolding, and prompt-pack scaffolding

## Current Commands
- `help`: show the shell command summary
- `status`: show the current executable repository surface
- `audit`: check a small hardcoded bootstrap-state surface and print a PASS / WARN / FAIL report
- `docs`: list checked-in docs
- `prompts`: list prompt packs
- `agents`: list agent definitions
- `brief`: print a concise local briefing from checked-in prompt packs and super-agent files
- `rules`: print the current operating rules summary
- `scaffold-agent <name>`: create a focused agent scaffold under `agents/super-agents/`
- `new-agent <name>`: compatibility alias for `scaffold-agent <name>`
- `scaffold-prompt <name>`: create a prompt-pack scaffold under `prompts/codex/` using the preferred prompt metadata headings

## Script Rules
- Keep scripts optional and locally understandable.
- Avoid external dependencies unless they are documented in-repo.
- Prefer small command surfaces over speculative automation.

## Bootstrap Validation
One minimal GitHub Actions workflow validates the current PowerShell shell surface on `push`
and `pull_request` by running:
- `./scripts/clau-dex.ps1 help`
- `./scripts/clau-dex.ps1 status`
- `./scripts/clau-dex.ps1 audit`
- `./scripts/clau-dex.ps1 brief`
