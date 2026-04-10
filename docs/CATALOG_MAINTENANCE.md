# Purpose

This guide explains how to keep the current `clau-dex` catalog surfaces aligned when a prompt pack or super-agent is added or updated.

It is a maintenance guide for checked-in markdown assets only. It does not change shell behavior, add automation, or define a new catalog system.

# When This Guide Applies

Use this guide when a task changes any of these current asset surfaces:

- a prompt pack under `prompts/`
- a super-agent under `agents/super-agents/`
- the operator-facing maps in `docs/PROMPT_LIBRARY_MAP.md` or `docs/SUPER_AGENT_MAP.md`
- the short folder indexes in `prompts/README.md` or `agents/README.md`

Use it for both cases:

- adding a new prompt pack or super-agent
- updating an existing prompt pack or super-agent in a way that changes its purpose, best-fit usage, grouping, or operator-facing description

If a change does not alter what an operator would see in `brief`, the maps, or the folder README surfaces, keep the maintenance diff narrow and do not update extra docs just for churn.

# Prompt Pack Maintenance

When adding or changing a prompt pack, review the prompt file first and confirm it still matches the current prompt-pack metadata contract in `docs/METADATA_CONVENTIONS.md`.

Check these items in the prompt pack itself:

- the summary heading uses the preferred prompt-pack heading `## Goal`
- the best-use heading uses the preferred prompt-pack heading `## Use This Prompt When`
- the first non-empty line under `## Goal` is concise, because `.\scripts\clau-dex.ps1 brief` reads that line as the summary
- the best-use section uses bullets, because `brief` reads bullets rather than paragraphs for prompt-pack fit
- the best-use bullets are prompt-specific and not just the untouched scaffold defaults, because weak scaffold-grade bullets now warn in both `brief` and `audit`

Then check whether the prompt belongs in the current prompt-library docs surfaces:

- update `docs/PROMPT_LIBRARY_MAP.md` when the prompt adds a new checked-in item, changes practical workflow grouping, or changes the operator-facing family description
- update `prompts/README.md` when the short quick index or current reusable launch assets list would otherwise go stale

Keep those updates descriptive, not speculative. Name only prompt packs that are actually checked in.

# Super-Agent Maintenance

When adding or changing a super-agent, review the agent file first and confirm it still matches the current super-agent metadata contract in `docs/METADATA_CONVENTIONS.md`.

Check these items in the super-agent file itself:

- the summary heading uses the preferred super-agent heading `## Purpose`
- the best-use heading uses the preferred super-agent heading `## Best Used For`
- the first non-empty line under `## Purpose` is concise, because `.\scripts\clau-dex.ps1 brief` reads that line as the summary
- the best-use section uses bullets, because `brief` reads bullet lines for first-pick guidance
- the best-use bullets are agent-specific and not just the untouched scaffold defaults, because weak scaffold-grade bullets now warn in both `brief` and `audit`

Then check whether the agent belongs in the current agent-library docs surfaces:

- update `docs/SUPER_AGENT_MAP.md` when the checked-in super-agent set changes, when overlap guidance changes, or when an operator would need a different first-pick explanation
- update `agents/README.md` when the short layout or current reusable super-agent index would otherwise stop reflecting what is actually checked in

Do not expand these docs into full role definitions. The checked-in super-agent file remains the source definition.

# brief And Metadata Alignment

Metadata conventions matter whenever a prompt pack or super-agent should appear cleanly in `.\scripts\clau-dex.ps1 brief`.

Today, `brief` is grounded in a narrow local contract:

- it reads only checked-in markdown files
- it reads only supported markdown headings and section content
- it uses preferred headings plus a small documented fallback list
- it shows notices when metadata is missing, fallback headings were needed, or best-use bullets are still scaffold-grade

That means maintenance work should check for drift between the asset file and the shell-readable metadata surface.

Use `docs/METADATA_CONVENTIONS.md` as the source of truth for:

- which headings are preferred for prompt packs
- which headings are preferred for super-agents
- which fallback headings `brief` currently recognizes
- what happens when summary text or best-use bullets are missing

Use `.\scripts\clau-dex.ps1 brief` after editing to confirm the asset reads honestly from the current repo state.

# Map And README Alignment

The maps and folder READMEs are separate operator-facing catalog surfaces. They do not drive shell behavior, but they should stay aligned with the checked-in assets and with `brief`.

Update `docs/PROMPT_LIBRARY_MAP.md` when:

- a prompt pack is added or removed
- a prompt family grouping changes
- the operator-facing explanation of when to use a prompt family changes

Update `docs/SUPER_AGENT_MAP.md` when:

- a super-agent is added or removed
- overlap guidance changes between current super-agents
- the first-pick guidance would otherwise become misleading

Update `prompts/README.md` when:

- the quick index no longer reflects the current prompt-pack set
- the short launch-asset summary would otherwise omit or misdescribe a checked-in prompt

Update `agents/README.md` when:

- the listed reusable super-agents no longer match the checked-in files
- the short operator entrypoint would otherwise point to stale agent information

When in doubt, treat the checked-in asset file as primary, `brief` as the shell summary, the maps as richer picker guidance, and the folder READMEs as short entry surfaces.

# Clean Checkpoint Expectations

Keep catalog maintenance changes small enough to stand as one reviewable docs checkpoint.

Good checkpoint shape for this kind of task:

- one prompt-pack change plus only the map and README updates needed to keep that prompt discoverable
- one super-agent change plus only the map and README updates needed to keep that agent discoverable
- one maintenance guide or convention clarification plus the minimum related doc updates

Before checkpointing:

- verify only the intended docs or markdown catalog files changed
- avoid mixing catalog maintenance with shell code, `src/` work, CI changes, or unrelated policy edits
- keep operator-facing wording aligned across the asset file, `brief` output, maps, and README surfaces

If a change needs broader workflow or shell behavior updates, split that into a separate checkpoint instead of hiding it inside catalog cleanup.

# Non-Goals

This guide does not:

- introduce new shell commands or change `brief`
- define a generic metadata schema or frontmatter system
- add automation for keeping maps or READMEs in sync
- imply runtime code in `src/`
- imply CI, workflow, or hosted-service behavior beyond what is already checked in

# Verification

Manual verification for catalog maintenance:

- review `docs/METADATA_CONVENTIONS.md`
- review `docs/PROMPT_LIBRARY_MAP.md`
- review `docs/SUPER_AGENT_MAP.md`
- review `prompts/README.md`
- review `agents/README.md`
- review `docs/CLI_FIRST_SHELL.md`
- review `scripts/clau-dex.ps1`
- run `.\scripts\clau-dex.ps1 brief`
- confirm the guide stays grounded in current checked-in repo behavior
- confirm the guide explains prompt-pack and super-agent maintenance responsibilities separately
- confirm the guide does not invent automation, schema machinery, or future catalog systems
- confirm no shell, `src/`, CI, or workflow files were changed for this task
