# Scripts

Local bootstrap helpers live here.

## Current Scripts
- `clau-dex.ps1`: a small CLI-first shell for repo status, a narrow bootstrap audit, concise prompt/agent briefing, operating-rule summaries, focused agent scaffolding, and prompt-pack scaffolding

## Current Commands
- `help`: show the shell command summary
- `status`: show the current executable repository surface and a quick-glance operational summary, while pointing to `audit` as the detailed truth surface
- `audit`: check the small hardcoded bootstrap-state surface and print the detailed PASS / WARN / FAIL truth report for shell-boundary, hygiene, and metadata-contract checks
- `docs`: list checked-in docs
- `prompts`: list prompt packs
- `agents`: list agent definitions
- `brief`: print the local picker summary from checked-in prompt packs and super-agent files, with explicit notices when fallback, missing, or empty metadata is encountered
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

## Warning And Fail Posture
- `audit` warns on advisory or recoverable conditions such as local residue patterns, metadata drift, and helper-only script sprawl in `scripts/`
- `audit` fails when the documented canonical `clau-dex` shell boundary is broken, such as an alternate `clau-dex` entrypoint outside `scripts/clau-dex.ps1`
