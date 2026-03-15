# Codex Tool Mapping

Skills use Claude Code tool names. When you encounter these in a skill, use your platform equivalent:

| Skill references                 | Codex equivalent                                    |
| -------------------------------- | --------------------------------------------------- |
| `Task` tool (dispatch subagent)  | `spawn_agent` with prompt                           |
| `Task` tool (named role)`*`      | `spawn_agent` with prompt and `agent_type`          |
| Multiple `Task` calls (parallel) | Multiple `spawn_agent` calls with prompt            |
| Task returns result              | `wait`                                              |
| Task completes automatically     | `close_agent` to free slot                          |
| `TodoWrite` (task tracking)      | `update_plan`                                       |
| `AskUserQuestion`                | `request_user_input`                                |
| `vscode/askQuestions`            | `request_user_input`                                |
| `Skill` tool (invoke a skill)    | Skills load natively — just follow the instructions |
| `Read`, `Write`, `Edit` (files)  | Use your native file tools                          |
| `Bash` (run commands)            | Use your native shell tools                         |

`*` Example: when a skill says to use the Codex role `sp_code_reviewer`, spawn the agent with `agent_type = "sp_code_reviewer"` and pass the filled prompt template as the agent prompt.

## Subagent dispatch requires multi_agent

Add to your Codex config (`~/.codex/config.toml`):

```toml
[features]
multi_agent = true
```

This enables the subagents tools for skills like `dispatching-parallel-agents` and `subagent-driven-development`.

## Subagent lifecycle

Codex manages subagents through five tools:

| Step            | Tool           | Purpose                                                                                              |
| --------------- | -------------- | ---------------------------------------------------------------------------------------------------- |
| **Create**      | `spawn_agent`  | Spawn a sub-agent for a well-scoped task. Returns the agent ID for all further communication.        |
| **Communicate** | `send_input`   | Send a follow-up message to a running agent. Supports `interrupt` to redirect work immediately.      |
| **Monitor**     | `wait`         | Block until one or more agents reach a final status. Returns the agent's final message or times out. |
| **Revive**      | `resume_agent` | Resume a previously closed agent so it can receive `send_input` and `wait` calls again.              |
| **Terminate**   | `close_agent`  | Shut down an agent that is no longer needed, free its thread slot, and return its last status.       |

### Key rules

- Always `close_agent` when done to free the thread slot — there is a configurable `agents.max_threads` limit (default 10).
- Prefer longer `timeout_ms` values in `wait` to avoid busy polling.
- `spawn_agent` enforces a maximum nesting depth — agents cannot spawn subagents indefinitely.
- A closed agent can be brought back with `resume_agent`; Use only if explicitlty instructed to do so.

## Interactive questions (Codex)

Use `request_user_input` when a skill requires structured user choices.

- Prefer 1 question per call (up to 3 when tightly related).
- In standard Codex behavior, this tool is available in Plan mode (and may be enabled in Default mode by feature flag).
- Questions should present meaningful choices and avoid asking for information discoverable from local context.
- If unavailable in the current mode, ask a concise plain-text question instead.

### `request_user_input` schema-first checklist

- Include stable `id` (snake_case) for answer mapping.
- Use short `header` and one-sentence `question`.
- Provide 2-3 meaningful `options` with `label` + `description`.
- Keep options mutually exclusive for single-choice decisions.
- Put your recommended option first when relevant.
