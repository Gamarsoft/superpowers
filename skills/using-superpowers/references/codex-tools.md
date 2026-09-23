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

The minimal optional role set is `sp_reviewer`, `sp_implementer`,
`sp_implementer_deep`, and `sp_topic_context`. Codex discovers definitions from
project or user `.codex/agents` configuration. This repository's project roles
live in `.codex/agents/*.toml`; the plugin archive does not install these roles.

Select the route using Model and effort selection below, then inspect the
runtime-advertised roles and pins. For a typed route with current pins, pass the
exact role as `agent_type` with `fork_turns: "none"`. For an intentional generic
route or an absent or stale role, omit `agent_type` and send the same complete
role prompt to a fresh generic agent with `fork_turns: "none"`. Never submit an intentionally
failing unknown-role call to test availability. Typed and generic dispatches
must preserve the same implementation or review coverage.

## Model and effort selection

The source role pack and installed user roles use these defaults:

| Role | Model | Reasoning effort |
| --- | --- | --- |
| `sp_implementer` | `gpt-6-sol` | `medium` |
| `sp_implementer_deep` | `gpt-6-sol` | `xhigh` |
| `sp_reviewer` | `gpt-6-astra` | `medium` |
| `sp_topic_context` | `gpt-6-luna` | `high` |

For typed dispatch, use the advertised role's fixed settings; do not pass model
or effort overrides. After changing role files, use a fresh session and check
the advertised pins. A session still advertising old pins needs a fresh generic
dispatch with the selected model and effort until the roles reload.

For generic fallback, explicitly pass `model` and `reasoning_effort` from this
table when the active tool supports them, plus `fork_turns: "none"` and the
complete role prompt. Preserve the role's read-only and no-subagent instructions.
When a field or model is unavailable, report the limitation and use the
supported fallback without claiming the selected settings were applied.

Topic context has an intentional generic `gpt-6-sol` / `medium` route for
cross-service tracing, conflicting evidence, architectural inference, or one
material evidence-gap escalation. Apply the selection and escalation rules in
`gathering-topic-context` before checking typed-role availability. This route
does not mean the Luna role is missing and does not create another role.

Luna's `high` and the deep implementer's Sol `xhigh` are normal role baselines. Retain the complete prompts, review gates,
and correction limits when changing models. Do not add review passes or raise
effort solely because of a role name, a retry, or the cheaper implementation model.

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

When local work is exhausted and agents are still running, use one
`wait_agent` call with the longest available bounded wait that still permits a
timely user update. Do not poll with short timeouts. An unchanged timeout does
not justify a new dispatch, replacement agent, speculative work, or progress
narration; reconcile the existing agent state and wait with backoff.

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
