# Superpowers for Codex

Guide for using Superpowers with OpenAI Codex via native skill discovery.

## Quick Install

Tell Codex:

```
Fetch and follow instructions from https://raw.githubusercontent.com/obra/superpowers/refs/heads/main/.codex/INSTALL.md
```

## Manual Installation

### Prerequisites

- OpenAI Codex CLI
- Git

### Steps

1. Clone the repo:
   ```bash
   git clone https://github.com/obra/superpowers.git ~/.codex/superpowers
   ```

2. Create the skills symlink:
   ```bash
   mkdir -p ~/.agents/skills
   ln -s ~/.codex/superpowers/skills ~/.agents/skills/superpowers
   ```

3. Restart Codex.

4. **For subagent skills and named multi-agent roles** (optional but recommended): Skills like `dispatching-parallel-agents` and `subagent-driven-development` require Codex's multi-agent feature. Add to your Codex config:

   ```toml
   [features]
   multi_agent = true
   ```

5. **Optional: use the bundled superpowers Codex role pack.** This repo includes a project-scoped `.codex/config.toml` plus role configs under `.codex/agents/`.
   - Repo-scoped: trust the repo in Codex and the bundled `.codex/config.toml` will expose the roles while you work in this repo.
   - User-scoped: copy the `[agents.*]` stanzas into `~/.codex/config.toml` and use absolute `config_file` paths pointing at your clone under `~/.codex/superpowers/.codex/agents/`.

### Windows

Use a junction instead of a symlink (works without Developer Mode):

```powershell
New-Item -ItemType Directory -Force -Path "$env:USERPROFILE\.agents\skills"
cmd /c mklink /J "$env:USERPROFILE\.agents\skills\superpowers" "$env:USERPROFILE\.codex\superpowers\skills"
```

## How It Works

Codex has native skill discovery — it scans `~/.agents/skills/` at startup, parses SKILL.md frontmatter, and loads skills on demand. Superpowers skills are made visible through a single symlink:

```
~/.agents/skills/superpowers/ → ~/.codex/superpowers/skills/
```

The `using-superpowers` skill is discovered automatically and enforces skill usage discipline — no additional configuration needed.

## Multi-Agent Role Pack

Superpowers now ships a Codex role pack that maps the main workflow stages to explicit named agents:

| Role                        | Model                 | Effort   | Intended use                                              |
| --------------------------- | --------------------- | -------- | --------------------------------------------------------- |
| `sp_topic_context`          | `gpt-5.3-codex-spark` | `high`   | Read-only topic scanning before brainstorming or planning |
| `sp_spec_document_reviewer` | `gpt-5.4`             | `high`   | Review design specs before planning                       |
| `sp_plan_reviewer`          | `gpt-5.4`             | `medium` | Review plan chunks for execution quality                  |
| `sp_implementer_spark`      | `gpt-5.3-codex-spark` | `high`   | Fast worker for highly detailed, low-ambiguity plan steps |
| `sp_implementer_standard`   | `gpt-5.3-codex`       | `medium` | Normal implementation work                                |
| `sp_implementer_deep`       | `gpt-5.4`             | `medium` | Complex or rescued implementation tasks                   |
| `sp_spec_reviewer`          | `gpt-5.4`             | `medium` | Spec-compliance review after implementation               |
| `sp_code_reviewer`          | `gpt-5.4`             | `high`   | Code-quality and final review                             |

This split follows the Codex multi-agent guidance: use short role names, spark for exploration and rote plan steps, and stronger models for judgment-heavy review.

### Choosing the Best Model Per Superpowers Role

- Use `gpt-5.3-codex-spark (high)` for read-heavy exploration where speed matters but you still want disciplined scanning.
- Use `sp_implementer_spark` when a `writing-plans` task is already very explicit, low-ambiguity, and scoped to small mechanical edits.
- Use `gpt-5.3-codex (medium)` for the normal implementation worker.
- Use `gpt-5.4 (medium/high)` for reviewers and harder recovery paths. The extra reasoning budget is most valuable when judging correctness, architecture, scope, and test quality.

### When To Use `sp_implementer_spark`

Use `sp_implementer_spark` only when all of these are true:

- The plan step is already highly specific.
- The edit is small and local, typically one or two files.
- There is little architectural judgment required.
- Existing patterns are clear.
- A failed attempt can be cheaply re-dispatched to `sp_implementer_standard`.

Do not use it as the default worker for `subagent-driven-development`. Keep `sp_implementer_standard` as the normal implementation role and treat `sp_implementer_spark` as the fast path for rote plan steps.

### User-Scoped Example

If you want the same roles available across all projects, add entries like these to `~/.codex/config.toml` and point them at your cloned repo:

```toml
[features]
multi_agent = true

[agents.sp_code_reviewer]
description = "Read-only code reviewer for superpowers task and final reviews."
config_file = "/Users/you/.codex/superpowers/.codex/agents/code-reviewer.toml"
```

Repeat that pattern for the other role files in `.codex/agents/`.

## Usage

Skills are discovered automatically. Codex activates them when:
- You mention a skill by name (e.g., "use brainstorming")
- The task matches a skill's description
- The `using-superpowers` skill directs Codex to use one

### Personal Skills

Create your own skills in `~/.agents/skills/`:

```bash
mkdir -p ~/.agents/skills/my-skill
```

Create `~/.agents/skills/my-skill/SKILL.md`:

```markdown
---
name: my-skill
description: Use when [condition] - [what it does]
---

# My Skill

[Your skill content here]
```

The `description` field is how Codex decides when to activate a skill automatically — write it as a clear trigger condition.

## Updating

```bash
cd ~/.codex/superpowers && git pull
```

Skills update instantly through the symlink.

## Uninstalling

```bash
rm ~/.agents/skills/superpowers
```

**Windows (PowerShell):**
```powershell
Remove-Item "$env:USERPROFILE\.agents\skills\superpowers"
```

Optionally delete the clone: `rm -rf ~/.codex/superpowers` (Windows: `Remove-Item -Recurse -Force "$env:USERPROFILE\.codex\superpowers"`).

## Troubleshooting

### Skills not showing up

1. Verify the symlink: `ls -la ~/.agents/skills/superpowers`
2. Check skills exist: `ls ~/.codex/superpowers/skills`
3. Restart Codex — skills are discovered at startup

### Windows junction issues

Junctions normally work without special permissions. If creation fails, try running PowerShell as administrator.

## Getting Help

- Report issues: https://github.com/obra/superpowers/issues
- Main documentation: https://github.com/obra/superpowers
