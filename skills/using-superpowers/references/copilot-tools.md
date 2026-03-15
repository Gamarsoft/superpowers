# Copilot Tool Mapping

Skills use Claude Code tool names. When you encounter these in a skill, use your Copilot equivalent:

| Skill references                 | Copilot equivalent (VS Code)                                |
| -------------------------------- | ----------------------------------------------------------- |
| `Task` tool (dispatch subagent)  | `runSubagent` (Run Subagent tool)                           |
| Multiple `Task` calls (parallel) | Multiple `runSubagent` calls                                |
| Task returns result              | `runSubagent` result payload                                |
| Task completes automatically     | Automatic completion when tool finishes (no explicit close) |
| `TodoWrite` (task tracking)      | `ManageTodoList` tool (when enabled)                        |
| `AskUserQuestion`                | `ask_questions` (Ask Clarifying Questions tool)             |
| `vscode/askQuestions`            | `ask_questions` (Ask Clarifying Questions tool)             |
| usages tool / find references    | `vscode_listCodeUsages`                                     |
| rename tool / rename symbol      | `vscode_renameSymbol`                                       |
| `Skill` tool (invoke a skill)    | Built-in tools / Copilot tools (no explicit mapping)        |
| `Read`, `Write`, `Edit` (files)  | VS Code file tools / workspace edits                        |
| `Bash` (run commands)            | VS Code terminal / tasks (no direct tool mapping)           |

## Symbol-aware code navigation and refactors

When a skill or user request is about code-symbol references or renaming, prefer the VS Code symbol tools instead of text search:

- Use `vscode_listCodeUsages` to find usages, references, definitions, or implementations of a known symbol.
- Use `vscode_renameSymbol` when the task is to rename a symbol and update its references precisely.
- Do **not** default to `grep`/`rg` for symbol rename workflows; text search is only a fallback when symbol tools are unavailable or the task is explicitly plain-text search.

## Subagent lifecycle (Copilot)

Copilot subagents are **single-shot** tool invocations:

- Use `runSubagent` to spawn and run a subagent.
- The subagent returns its final result in the tool payload.
- There is no explicit `close` step; completion happens when the tool finishes.
- Subagents do **not** recursively spawn other subagents.

## Interactive questions (Copilot)

Use `ask_questions` when a skill needs structured clarification from the user (single-select, multi-select, or free text).

- Prefer concise batches of 1-4 questions.
- Keep each question decision-focused; avoid asking about facts discoverable from workspace context.
- In this platform, subagents cannot use `ask_questions`; ask from the parent agent before dispatching subagents.
- If structured questions are unnecessary, ask a concise plain-text question instead.

### `ask_questions` schema-first checklist

Use all relevant input fields for better UX and consistency:

- `header`: short, unique identifier for answer mapping
- `question`: concise prompt (single decision)
- `options[].label`: clear user-facing choice text
- `options[].description`: one-line trade-off/pros-cons summary per option
- `options[].recommended`: mark the default option you recommend
- `multiSelect`: set `true` only when choices are additive
- `allowFreeformInput`: set `true` when user may need a custom answer

Validation and formatting rules:

- If `options` are provided, include at least 2 options.
- Omit `options` for pure free-text questions.
- Keep option labels short and mutually exclusive for single-select.
- For A/B/C decisions, put details in `description` instead of making `question` too long.
