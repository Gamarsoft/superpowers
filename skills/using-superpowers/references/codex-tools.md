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

Select the route using Role configuration below, then inspect the
runtime-advertised roles and pins. For a typed route with current pins, pass the
exact role as `agent_type` with `fork_turns: "none"`. For an intentional generic
route or an absent or stale role, omit `agent_type` and send the same complete
role prompt to a fresh generic agent with `fork_turns: "none"`. Never submit an intentionally
failing unknown-role call to test availability. Typed and generic dispatches
must preserve the same implementation or review coverage.

## Role configuration

Custom agent TOML files are the source of truth for model and reasoning effort.
Skills select responsibilities and supply complete prompts; they do not define
or override those settings.

| Role | Configuration file in the effective `.codex/agents` directory |
| --- | --- |
| `sp_implementer` | `implementer.toml` |
| `sp_implementer_deep` | `implementer-deep.toml` |
| `sp_reviewer` | `reviewer.toml` |
| `sp_topic_context` | `topic-context.toml` |

Resolve the effective project or user role configuration selected by Codex,
matching its `name` to the requested role. Compare advertised settings with that
configuration, never with a model table in a skill. For typed dispatch, use
`agent_type` and `fork_turns: "none"` without model or effort overrides. After
changing role files, use a fresh session and check the advertised pins.

For an absent or stale typed role, read `model` and `model_reasoning_effort`
from its effective TOML file. Pass those values as `model` and `reasoning_effort`
to a fresh generic agent when supported, plus `fork_turns: "none"` and the
complete role prompt. Preserve the role's read-only and no-subagent instructions.
If no role configuration exists or a setting is unsupported, report the
limitation and use the runtime's configured defaults without inventing role
settings or claiming unavailable settings were applied.

Topic context has an intentional generic route for cross-service tracing,
conflicting evidence, architectural inference, or one material evidence-gap
escalation. Read its settings from the effective `sp_implementer` configuration,
but send the complete read-only topic-context prompt and omit `agent_type`.
Apply the routing and escalation rules in `gathering-topic-context` first.
This route does not imply the topic-context role is missing and does not create
another role.

Retain the complete prompts, review gates, and correction limits when role
configuration changes. Do not add review passes or raise effort solely because
of a role name, a retry, or the configured implementation model.

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
