# Agents

Store specialized agent role definitions here.

## Layout
- `super-agents/`: reusable high-leverage roles for recurring strategic or audit tasks

Current reusable super-agents include:
- `super-agents/reference-auditor.md`: lawful reference-review lane for public, open-source, owned, or explicitly authorized external repos or materials

For a concise operator-facing guide to when to use each current super-agent, see [`docs/SUPER_AGENT_MAP.md`](../docs/SUPER_AGENT_MAP.md).

## Conventions
- Keep one file per agent role.
- State the role purpose, default tasks, boundaries, and expected outputs.
- Treat agent files as reusable launch assets, not project policy dumps.
- Reference clean-room and repo-truth constraints when they affect the role directly.
