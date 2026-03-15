# Documentation: The `askQuestions` Tool in VS Code

> **Source**: [`src/vs/workbench/contrib/chat/common/tools/builtinTools/askQuestionsTool.ts`](https://github.com/microsoft/vscode/blob/612372fe9bf23264750b354284b5747f537a63a6/src/vs/workbench/contrib/chat/common/tools/builtinTools/askQuestionsTool.ts)

## 1. Overview

The `askQuestions` tool is a **built-in, internal tool** in VS Code's chat/agent system that allows the AI model (or agent) to ask the user **structured clarifying questions** before proceeding with a task. It presents a visual "question carousel" in the chat UI, supporting single-select, multi-select, and freeform text input types.

### Key Identifiers

| Property                        | Value                                                  |
| ------------------------------- | ------------------------------------------------------ |
| **Internal Tool ID**            | `vscode_askQuestions`                                  |
| **Tool Reference Name**         | `askQuestions`                                         |
| **Legacy Reference Names**      | `vscode_askQuestions`, `vscode/askQuestions`           |
| **Claude-compatible Alias**     | `AskUserQuestion` (maps to `vscode/askQuestions`)      |
| **Copilot Extension ID**        | `copilot_askQuestions`                                 |
| **Display Name**                | "Ask Clarifying Questions"                             |
| **Source**                      | `Internal` (built into VS Code, not from an extension) |
| **Can be referenced in prompt** | `false`                                                |

---

## 2. How It Works — Architecture

### 2.1 Registration

The tool is registered as a built-in tool in:

```typescript name=tools.ts url=https://github.com/microsoft/vscode/blob/612372fe9bf23264750b354284b5747f537a63a6/src/vs/workbench/contrib/chat/common/tools/builtinTools/tools.ts#L30-L32
const askQuestionsTool = this._register(
  instantiationService.createInstance(AskQuestionsTool),
);
this._register(
  toolsService.registerTool(AskQuestionsToolData, askQuestionsTool),
);
this._register(toolsService.vscodeToolSet.addTool(AskQuestionsToolData));
```

It is added to the **`vscodeToolSet`** (the built-in VS Code tool set), making it available to agents that have access to these internal tools.

### 2.2 Invocation Flow

Here's the step-by-step flow when the model calls the `askQuestions` tool:

1. **Model sends tool call** — The language model decides to ask the user questions and emits a tool invocation with `questions` parameters.

2. **`prepareToolInvocation()`** — Validates the questions:
   - Must have at least 1 question.
   - If a question has `options`, it must have ≥ 2 options (or none for free text).
   - Truncates question text to hard limits (header: 75 chars, question: 300 chars).
   - Returns human-readable invocation messages (e.g., _"Asking 3 questions (Color, Framework, Testing)"_).

3. **`invoke()`** — The main execution:
   - Creates a **`ChatQuestionCarouselData`** from the questions.
   - Appends the carousel to the chat response via `chatService.appendProgress()`.
   - **Awaits the user's answers** — the carousel's `completion` promise resolves when the user submits answers in the UI.
   - Converts carousel answers back to a structured `IAnswerResult`.
   - Returns the JSON-serialized result to the model.

4. **UI Rendering** — The `ChatQuestionCarouselPart` renders the questions as an interactive widget in the chat input area, not inline in the response. The carousel is displayed near the chat input box.

### 2.3 Key Data Structures

```typescript name=askQuestionsTool.ts url=https://github.com/microsoft/vscode/blob/612372fe9bf23264750b354284b5747f537a63a6/src/vs/workbench/contrib/chat/common/tools/builtinTools/askQuestionsTool.ts#L56-L82
export interface IQuestionOption {
  readonly label: string;
  readonly description?: string;
  readonly recommended?: boolean;
}

export interface IQuestion {
  readonly header: string;
  readonly question: string;
  readonly multiSelect?: boolean;
  readonly options?: IQuestionOption[];
  readonly allowFreeformInput?: boolean;
}

export interface IAskQuestionsParams {
  readonly questions: IQuestion[];
}

export interface IQuestionAnswer {
  readonly selected: string[];
  readonly freeText: string | null;
  readonly skipped: boolean;
}

export interface IAnswerResult {
  readonly answers: Record<string, IQuestionAnswer>;
}
```

---

## 3. Input Schema (What the Model Sends)

The tool's JSON Schema that the model must conform to:

```json name=inputSchema.json
{
  "type": "object",
  "required": ["questions"],
  "properties": {
    "questions": {
      "type": "array",
      "description": "List of questions to ask the user. Order is preserved.",
      "minItems": 1,
      "items": {
        "type": "object",
        "required": ["header", "question"],
        "properties": {
          "header": {
            "type": "string",
            "description": "Short identifier for the question. Must be unique so answers can be mapped back to the question.",
            "maxLength": 50
          },
          "question": {
            "type": "string",
            "description": "The question text to display to the user. Keep it concise, ideally one sentence.",
            "maxLength": 200
          },
          "multiSelect": {
            "type": "boolean",
            "description": "Allow selecting multiple options when options are provided."
          },
          "allowFreeformInput": {
            "type": "boolean",
            "description": "Allow freeform text answers in addition to option selection."
          },
          "options": {
            "type": "array",
            "description": "Optional list of selectable answers. If omitted, the question is free text.",
            "items": {
              "type": "object",
              "required": ["label"],
              "properties": {
                "label": {
                  "type": "string",
                  "description": "Display label and value for the option."
                },
                "description": {
                  "type": "string",
                  "description": "Optional secondary text shown with the option."
                },
                "recommended": {
                  "type": "boolean",
                  "description": "Mark this option as the recommended default."
                }
              }
            }
          }
        }
      }
    }
  }
}
```

### Character Limits

| Field      | Soft Limit (Schema) | Hard Limit (Truncation) |
| ---------- | ------------------- | ----------------------- |
| `header`   | 50 chars            | 75 chars                |
| `question` | 200 chars           | 300 chars               |

The **soft limits** are communicated to the model via the schema's `maxLength`. If the model exceeds these, the **hard limits** are used to truncate with `"..."` appended.

---

## 4. Output Format (What the Model Receives Back)

After the user answers, the tool returns JSON in this format:

```json name=answerResult.json
{
  "answers": {
    "Database Engine": {
      "selected": ["PostgreSQL"],
      "freeText": null,
      "skipped": false
    },
    "Testing Framework": {
      "selected": ["Jest", "Playwright"],
      "freeText": null,
      "skipped": false
    },
    "Additional Notes": {
      "selected": [],
      "freeText": "Please also add logging",
      "skipped": false
    },
    "Deployment Target": {
      "selected": [],
      "freeText": null,
      "skipped": true
    }
  }
}
```

Each answer is keyed by the **`header`** of the corresponding question and contains:

- **`selected`**: array of selected option labels (for single-select, this is a 1-element array)
- **`freeText`**: the user's free-text input, or `null`
- **`skipped`**: `true` if the user didn't answer this question

---

## 5. Question Types

### 5.1 Free Text (no options)

When `options` is omitted or empty, the user sees a text input box.

```json
{
  "header": "Project Name",
  "question": "What would you like to name this project?"
}
```

### 5.2 Single Select (options, no multiSelect)

The user picks exactly one option from a list.

```json
{
  "header": "Database",
  "question": "Which database engine do you want to use?",
  "options": [
    {
      "label": "PostgreSQL",
      "description": "Relational, open source",
      "recommended": true
    },
    { "label": "MongoDB", "description": "Document-based, NoSQL" },
    { "label": "SQLite", "description": "Lightweight, file-based" }
  ]
}
```

### 5.3 Multi Select (options + multiSelect)

The user can select multiple options.

```json
{
  "header": "Features",
  "question": "Which features should be included?",
  "multiSelect": true,
  "options": [
    { "label": "Authentication" },
    { "label": "Rate Limiting" },
    { "label": "Caching" },
    { "label": "Logging", "recommended": true }
  ]
}
```

### 5.4 Options + Freeform (allowFreeformInput)

The user can select from options **and** type their own answer.

```json
{
  "header": "CSS Framework",
  "question": "Which CSS framework do you prefer?",
  "allowFreeformInput": true,
  "options": [{ "label": "Tailwind CSS" }, { "label": "Bootstrap" }]
}
```

---

## 6. Using askQuestions in SKILL Instructions

### 6.1 The Tool is in the `vscodeToolSet`

The `askQuestions` tool is part of VS Code's **internal vscode tool set** (registered via `toolsService.vscodeToolSet.addTool()`). This means it's automatically available to agents running in the default agent mode.

### 6.2 Important: `canBeReferencedInPrompt: false`

The tool has `canBeReferencedInPrompt: false`, which means you **cannot** directly reference it via `#askQuestions` in prompt files or skill files. Instead, the model decides to use it based on its `modelDescription`:

> _"Use this tool to ask the user a small number of clarifying questions before proceeding. Provide the questions array with concise headers and prompts. Use options for fixed choices, set multiSelect when multiple selections are allowed, and set allowFreeformInput to let users supply their own answer."_

### 6.3 Claude-Compatible Alias

In VS Code's prompt system, the Claude-compatible tool name `AskUserQuestion` maps to `vscode/askQuestions`:

```typescript name=promptValidator.ts url=https://github.com/microsoft/vscode/blob/9d6ae94c149dfcb5e9708684aea7f7773d05b125/src/vs/workbench/contrib/chat/common/promptSyntax/languageProviders/promptValidator.ts#L903
{ name: 'AskUserQuestion', description: 'Ask multiple-choice questions', toolEquivalent: ['vscode/askQuestions'] },
```

So if you're writing a **Claude-format agent file** (e.g., `AGENTS.md` with Claude syntax), you can enable it via the `AskUserQuestion` tool name.

### 6.4 Subagent Restriction

When running **subagents** (via the `runSubagent` tool), the `askQuestions` tool is **explicitly disabled**:

```typescript name=runSubagentTool.ts url=https://github.com/microsoft/vscode/blob/9d6ae94c149dfcb5e9708684aea7f7773d05b125/src/vs/workbench/contrib/chat/common/tools/builtinTools/runSubagentTool.ts#L244-L246
if (modeTools) {
  modeTools[RunSubagentTool.Id] = false;
  modeTools[ManageTodoListToolToolId] = false;
  modeTools["copilot_askQuestions"] = false;
}
```

This prevents subagents from calling `askQuestions`, as it would interfere with the parent agent's UI. If multiple parallel subagents tried to invoke it simultaneously, the earlier carousel would be superseded.

### 6.5 How to Guide the Model in SKILL Files

Since you can't directly reference the tool in prompt files, you should **instruct the model in natural language** within your SKILL or instruction files. For example:

```markdown name=my-skill/SKILL.md
---
name: project-setup
description: Guide the user through setting up a new project with the right technology choices.
---

# Project Setup Skill

When the user asks to set up a new project, **ask clarifying questions first** before generating any code. Use the askQuestions tool to present structured choices for:

1. **Programming language** — Single select with options like TypeScript, Python, Go, Rust
2. **Package manager** — Single select (npm, yarn, pnpm for JS; pip, poetry for Python)
3. **Features to include** — Multi-select: testing, linting, CI/CD, Docker, logging
4. **Project name** — Free text input

Wait for the user's answers before proceeding. Respect skipped questions by using sensible defaults.
```

The model's built-in `modelDescription` for the tool already tells it when and how to use it. Your skill instructions just need to **describe the scenario** and what kinds of questions should be asked.

### 6.6 Enabling in Custom Agent Files (`.github/agents/`)

In a VS Code-target custom agent file, you can enable the tool in the `tools` header. The tool reference name is `vscode/askQuestions`:

```markdown name=.github/agents/my-agent.md
---
name: setup-wizard
description: An interactive setup wizard that asks questions before generating code
tools: vscode/askQuestions, edit/editFiles, read/readFile
---

You are a setup wizard agent. Before generating any code, always use the askQuestions tool to gather requirements from the user.
```

For Claude-target agent files:

```markdown name=.github/agents/my-claude-agent.md
---
name: setup-wizard
description: An interactive setup wizard
tools: AskUserQuestion, Edit, Read, Write
target: claude
---

You are a setup wizard. Always use AskUserQuestion to gather requirements first.
```

---

## 7. UI Behavior

- The question carousel is rendered in the **chat input area** (not inline in the response).
- Questions are presented one at a time in a carousel format with navigation.
- Users can **skip** questions if `allowSkip` is true (which it always is for this tool).
- Options with `recommended: true` are pre-selected as defaults.
- If a new carousel is triggered while one is already showing, the old one is **auto-completed as skipped**.
- The tool invocation is **not pinned** to the thinking/collapsed tools section — it's shown prominently.

---

## 8. Telemetry

The tool tracks usage via the `askQuestionsToolInvoked` telemetry event with these metrics:

| Metric                      | Description                                              |
| --------------------------- | -------------------------------------------------------- |
| `questionCount`             | Total questions asked                                    |
| `answeredCount`             | Questions that were answered                             |
| `skippedCount`              | Questions that were skipped                              |
| `freeTextCount`             | Questions answered with free text                        |
| `recommendedAvailableCount` | Questions that had a recommended option                  |
| `recommendedSelectedCount`  | Questions where the user selected the recommended option |
| `duration`                  | Time in ms to complete all questions                     |

---

## 9. Edge Cases & Validation Rules

1. **At least 1 question** is required — otherwise throws an error.
2. **Options must have ≥ 2 items** — a single option is rejected (use no options for free text instead).
3. **Headers must be unique** — they serve as keys in the answer map.
4. **Missing chat context** → all questions marked as `skipped` (graceful degradation).
5. **Cancellation** → throws `CancellationError`.
6. **Parallel carousels** → old carousel is completed with `undefined` answers (all skipped), new carousel takes over.
