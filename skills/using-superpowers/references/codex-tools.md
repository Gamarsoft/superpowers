# Codex Tool Mapping

Skills sometimes use Claude Code tool names. Translate them to the active
Codex multi-agent and task APIs instead of copying a stale tool name.

| Skill reference | Codex equivalent |
| --- | --- |
| `Task` (dispatch a subagent) | `spawn_agent` with `task_name` and `message` |
| `Task` (named role) | `spawn_agent` with `agent_type`; for checked-in typed roles use `fork_turns: "none"` |
| Multiple independent `Task` calls | Spawn each bounded task; the agents then run concurrently |
| Send context without starting a turn | `send_message` |
| Resume an idle agent for a fix/follow-up | `followup_task` |
| Stop or redirect the current agent turn | `interrupt_agent`, then send/follow up as needed |
| Inspect live agent states | `list_agents` |
| Wait for agent activity | `wait_agent` |
| `TodoWrite` | `update_plan` |
| `AskUserQuestion` / `vscode/askQuestions` | `request_user_input` when available; otherwise ask concise plain text |
| `Skill` | Skills load natively; read and follow the selected skill instructions |
| `Read`, `Write`, `Edit`, `Bash` | Use Codex's native file and shell tools |

Named roles contributed by this repository live in `.codex/agents/*.toml`.
For example, when a skill selects `sp_code_reviewer`, call `spawn_agent`
with `agent_type: "sp_code_reviewer"`, `fork_turns: "none"`, and the filled
review prompt as `message`. Typed roles own their configured model and
instructions; do not override them with inherited conversation history.

## Subagent dispatch requires multi-agent support

Add this to `~/.codex/config.toml` when the subagent tools are unavailable:

```toml
[features]
multi_agent = true
```

## Current lifecycle

1. **Create:** `spawn_agent` returns an agent ID/canonical task name.
2. **Communicate:** use `send_message` while an agent is running, or
   `followup_task` to trigger a new turn when it is idle.
3. **Monitor:** `wait_agent` waits for mailbox activity; `list_agents`
   provides a compact state snapshot.
4. **Redirect:** `interrupt_agent` stops the current turn but keeps the agent
   available for a corrected follow-up.

Final agent messages are delivered back to the parent automatically. There
is no separate close/free-slot call in the current API, so do not invent one.
Keep implementation agents available through their fix loop; reuse them with
`followup_task` for rounds that require the original implementer.

## Environment detection

Skills that create worktrees or finish branches should detect the current
checkout before mutating it:

```bash
GIT_DIR=$(cd "$(git rev-parse --git-dir)" 2>/dev/null && pwd -P)
GIT_COMMON=$(cd "$(git rev-parse --git-common-dir)" 2>/dev/null && pwd -P)
BRANCH=$(git branch --show-current)
```

- `GIT_DIR != GIT_COMMON` means the checkout is a linked worktree unless the
  submodule guard in `using-git-worktrees` says otherwise.
- An empty `BRANCH` means detached HEAD; follow the finishing skill's reduced
  options and leave externally managed workspaces in place.

## Interactive questions

Use `request_user_input` for structured choices when it is available in the
active mode. Prefer one question, provide mutually exclusive options, and do
not ask for information that read-only inspection can discover. If the tool
is unavailable, ask one concise plain-text question.
