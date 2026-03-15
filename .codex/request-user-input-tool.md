# Documentation: `request_user_input` Tool in OpenAI Codex

## Overview

The `request_user_input` tool is a **function-call tool** that allows the Codex agent (the model) to pause execution and present the user with structured multiple-choice questions in the TUI (Terminal UI) or app-server UI. It is the primary mechanism for the agent to ask clarifying questions during a session, especially in **Plan mode**.

> ⚠️ This feature is marked as **EXPERIMENTAL** throughout the codebase.

---

## 1. Tool Description (as seen by the model)

From the tool registration in [`codex-rs/core/src/tools/handlers/request_user_input.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/src/tools/handlers/request_user_input.rs#L49-L53):

> "Request user input for one to three short questions and wait for the response. This tool is only available in Plan mode."
>
> _(or "...in Default or Plan mode." when the `DefaultModeRequestUserInput` feature flag is enabled)_

---

## 2. JSON Schema / Parameters

The tool is defined as a `ToolSpec::Function` in [`codex-rs/core/src/tools/spec.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/src/tools/spec.rs#L886-L968). Here is its full parameter schema:

```json name=request_user_input_schema.json
{
  "name": "request_user_input",
  "description": "Request user input for one to three short questions and wait for the response.",
  "strict": false,
  "parameters": {
    "type": "object",
    "properties": {
      "questions": {
        "type": "array",
        "description": "Questions to show the user. Prefer 1 and do not exceed 3",
        "items": {
          "type": "object",
          "properties": {
            "id": {
              "type": "string",
              "description": "Stable identifier for mapping answers (snake_case)."
            },
            "header": {
              "type": "string",
              "description": "Short header label shown in the UI (12 or fewer chars)."
            },
            "question": {
              "type": "string",
              "description": "Single-sentence prompt shown to the user."
            },
            "options": {
              "type": "array",
              "description": "Provide 2-3 mutually exclusive choices. Put the recommended option first and suffix its label with \"(Recommended)\". Do not include an \"Other\" option in this list; the client will add a free-form \"Other\" option automatically.",
              "items": {
                "type": "object",
                "properties": {
                  "label": {
                    "type": "string",
                    "description": "User-facing label (1-5 words)."
                  },
                  "description": {
                    "type": "string",
                    "description": "One short sentence explaining impact/tradeoff if selected."
                  }
                },
                "required": ["label", "description"],
                "additionalProperties": false
              }
            }
          },
          "required": ["id", "header", "question", "options"],
          "additionalProperties": false
        }
      }
    },
    "required": ["questions"],
    "additionalProperties": false
  }
}
```

### Parameter Breakdown

| Parameter                           | Type              | Required | Description                                           |
| ----------------------------------- | ----------------- | -------- | ----------------------------------------------------- |
| `questions`                         | `Array<Question>` | ✅       | 1-3 structured questions to show the user             |
| `questions[].id`                    | `string`          | ✅       | Stable snake_case identifier for mapping answers back |
| `questions[].header`                | `string`          | ✅       | Short header label (≤12 chars) shown in the UI        |
| `questions[].question`              | `string`          | ✅       | Single-sentence prompt shown to the user              |
| `questions[].options`               | `Array<Option>`   | ✅       | 2-3 mutually exclusive choices (must be non-empty)    |
| `questions[].options[].label`       | `string`          | ✅       | User-facing label (1-5 words)                         |
| `questions[].options[].description` | `string`          | ✅       | One short sentence explaining the impact/tradeoff     |

---

## 3. Data Types (Protocol Layer)

The underlying data types are defined in [`codex-rs/protocol/src/request_user_input.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/protocol/src/request_user_input.rs#L1-L55):

```rust name=request_user_input.rs url=https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/protocol/src/request_user_input.rs#L1-L55
pub struct RequestUserInputQuestionOption {
    pub label: String,
    pub description: String,
}

pub struct RequestUserInputQuestion {
    pub id: String,
    pub header: String,
    pub question: String,
    pub is_other: bool,      // auto-set to true by the handler
    pub is_secret: bool,     // for secret/sensitive inputs (e.g. env vars)
    pub options: Option<Vec<RequestUserInputQuestionOption>>,
}

pub struct RequestUserInputArgs {
    pub questions: Vec<RequestUserInputQuestion>,
}

pub struct RequestUserInputAnswer {
    pub answers: Vec<String>,
}

pub struct RequestUserInputResponse {
    pub answers: HashMap<String, RequestUserInputAnswer>,
}

pub struct RequestUserInputEvent {
    pub call_id: String,
    pub turn_id: String,
    pub questions: Vec<RequestUserInputQuestion>,
}
```

---

## 4. Mode Availability

The tool is **mode-gated**. From [`codex-rs/protocol/src/config_types.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/protocol/src/config_types.rs#L220-L222):

```rust name=config_types.rs url=https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/protocol/src/config_types.rs#L220-L222
pub const fn allows_request_user_input(self) -> bool {
    matches!(self, Self::Plan)
}
```

| Mode                 | Available by Default?       | Notes                                                         |
| -------------------- | --------------------------- | ------------------------------------------------------------- |
| **Plan**             | ✅ Yes                      | Always available                                              |
| **Default**          | ❌ No (unless feature flag) | Requires `Feature::DefaultModeRequestUserInput` to be enabled |
| **Execute**          | ❌ No                       | Always rejected                                               |
| **Pair Programming** | ❌ No                       | Always rejected                                               |

When called in an unavailable mode, the handler returns an error like:

> `"request_user_input is unavailable in Execute mode"`

---

## 5. Handler Execution Flow

From [`codex-rs/core/src/tools/handlers/request_user_input.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/src/tools/handlers/request_user_input.rs#L62-L123):

```
1. Parse the JSON arguments from the model's function call
2. Check mode availability → reject with error if mode disallows it
3. Validate that every question has non-empty options → reject if missing
4. Set `is_other = true` on every question (client auto-adds "Other" option)
5. Call `session.request_user_input(...)` → suspends and waits for user response
6. Serialize the response as JSON → return as tool output to the model
```

Key validations:

- **Options are required and must be non-empty** for every question. If any question lacks options, the error is: `"request_user_input requires non-empty options for every question"`
- **Cancellation**: If the user input request is cancelled before a response, the error is: `"request_user_input was cancelled before receiving a response"`

---

## 6. Example Tool Call (from tests)

From [`codex-rs/core/tests/suite/request_user_input.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/tests/suite/request_user_input.rs#L77-L113):

### Request (model → tool):

```json name=example_request.json
{
  "questions": [
    {
      "id": "confirm_path",
      "header": "Confirm",
      "question": "Proceed with the plan?",
      "options": [
        {
          "label": "Yes (Recommended)",
          "description": "Continue the current plan."
        },
        {
          "label": "No",
          "description": "Stop and revisit the approach."
        }
      ]
    }
  ]
}
```

### Response (tool → model):

```json name=example_response.json
{
  "answers": {
    "confirm_path": {
      "answers": ["yes"]
    }
  }
}
```

The response is a `HashMap<String, RequestUserInputAnswer>` mapping each question's `id` to an `answers` array containing the user's selection(s).

---

## 7. App Server Protocol (MCP / JSON-RPC)

In the app-server (used by desktop/web clients), `request_user_input` surfaces as a **server → client JSON-RPC request** using the method `"item/tool/requestUserInput"`.

From [`codex-rs/app-server-protocol/src/protocol/common.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/app-server-protocol/src/protocol/common.rs#L723-L727):

```rust name=common.rs url=https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/app-server-protocol/src/protocol/common.rs#L723-L727
ToolRequestUserInput => "item/tool/requestUserInput" {
    params: v2::ToolRequestUserInputParams,
    response: v2::ToolRequestUserInputResponse,
}
```

The params include `thread_id`, `turn_id`, `item_id`, and `questions`. The client responds with answers keyed by question `id`.

---

## 8. Usage in SKILLS Instructions

### 8.1 Collaboration Mode Templates

The `request_user_input` tool is deeply integrated into the **collaboration mode developer instructions** that are injected into the model's system prompt:

#### Plan Mode (`plan.md`)

From [`codex-rs/core/templates/collaboration_mode/plan.md`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/templates/collaboration_mode/plan.md):

The Plan mode instructions tell the model:

> **Asking questions (Critical rules):**
>
> - Strongly prefer using the `request_user_input` tool to ask any questions.
> - Offer only meaningful multiple‑choice options; don't include filler choices that are obviously wrong or irrelevant.
> - In rare cases where an unavoidable, important question can't be expressed with reasonable multiple‑choice options (due to extreme ambiguity), you may ask it directly without the tool.
>
> Each question must:
>
> - materially change the spec/plan, OR
> - confirm/lock an assumption, OR
> - choose between meaningful tradeoffs.
> - not be answerable by non-mutating commands.

#### Default Mode (`default.md`)

From [`codex-rs/core/templates/collaboration_mode/default.md`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/templates/collaboration_mode/default.md), the template includes placeholders:

```
## request_user_input availability
{{REQUEST_USER_INPUT_AVAILABILITY}}
{{ASKING_QUESTIONS_GUIDANCE}}
```

These placeholders are filled in at runtime by [`collaboration_mode_presets.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/src/models_manager/collaboration_mode_presets.rs#L84-L109):

- **When `request_user_input` is available** in Default mode:

  > "The `request_user_input` tool is available in Default mode."
  > "In Default mode, strongly prefer making reasonable assumptions and executing the user's request rather than stopping to ask questions. If you absolutely must ask a question because the answer cannot be discovered from local context and a reasonable assumption would be risky, prefer using the `request_user_input` tool rather than writing a multiple choice question as a textual assistant message. Never write a multiple choice question as a textual assistant message."

- **When `request_user_input` is NOT available** in Default mode:
  > "The `request_user_input` tool is unavailable in Default mode. If you call it while in Default mode, it will return an error."
  > "In Default mode, strongly prefer making reasonable assumptions and executing the user's request rather than stopping to ask questions. If you absolutely must ask a question because the answer cannot be discovered from local context and a reasonable assumption would be risky, ask the user directly with a concise plain-text question. Never write a multiple choice question as a textual assistant message."

### 8.2 Skills Environment Variable Dependencies

Skills can declare `env_var` dependencies in their metadata. When a skill is invoked and the required env var is missing, the system **programmatically** uses `request_user_input` to prompt the user.

From [`codex-rs/core/src/skills/env_var_dependencies.rs`](https://github.com/openai/codex/blob/75e7c804eac4d3fae12d1dda38c726d1f37e17fe/codex-rs/core/src/skills/env_var_dependencies.rs#L93-L162):

This is a **system-level** (non-model) use of `request_user_input` where:

- The `is_secret` flag is set to `true` (input is masked)
- `is_other` is set to `false` (no multiple choice, pure text entry)
- `options` is set to `None` (free-form input only)
- The `call_id` is formatted as `"skill-deps-{sub_id}"`

---

## 9. How to Use `request_user_input` in SKILL Instructions

If you're writing a **SKILL.md** file and want the model to use `request_user_input` effectively, here's what you need to know:

### Best Practices for SKILL authors

1. **The model can only call `request_user_input` in Plan mode (or Default mode with the feature flag).** If your skill needs to ask questions, instruct the model to use `request_user_input` for structured choices.

2. **Instruct the model to use `request_user_input` for decisions, not for discoverable facts.** The Plan mode instructions already enforce this, but you can reinforce it in your skill:

   ```markdown
   When you need the user to choose between implementation approaches,
   use the `request_user_input` tool with 2-3 options.
   Put the recommended option first with "(Recommended)" suffix.
   ```

3. **Each question needs:**
   - A stable `id` in `snake_case` (used to map answers back)
   - A short `header` (≤12 chars)
   - A single-sentence `question`
   - 2-3 `options`, each with a `label` (1-5 words) and `description` (1 sentence)

4. **The client auto-adds an "Other" free-form option.** Don't include one in your options list.

5. **Limit to 1-3 questions per call.** Prefer 1 question at a time.

6. **Example instruction in a SKILL.md:**

   ````markdown name=SKILL.md
   ## Gathering Requirements

   Before implementing, use `request_user_input` to confirm:

   - The target framework (if ambiguous from the codebase)
   - The testing strategy (unit vs integration vs both)

   Example call structure:

   ```json
   {
     "questions": [
       {
         "id": "test_strategy",
         "header": "Testing",
         "question": "Which testing approach should we use?",
         "options": [
           {
             "label": "Unit Tests (Recommended)",
             "description": "Fast, isolated tests for each component."
           },
           {
             "label": "Integration Tests",
             "description": "End-to-end tests covering full workflows."
           },
           {
             "label": "Both",
             "description": "Comprehensive coverage with both approaches."
           }
         ]
       }
     ]
   }
   ```
   ````

7. **For env var dependencies** (automatic prompting), declare them in your skill's metadata YAML:

   ```yaml
   dependencies:
     tools:
       - type: env_var
         value: MY_API_KEY
         description: "API key for the external service"
   ```

   When the skill is invoked and `MY_API_KEY` is not set, the system will automatically prompt the user via `request_user_input` with a secret input field.

---

## 10. Architecture Summary

```
┌─────────────────┐    function_call    ┌──────────────────────────┐
│   Model (LLM)   │ ──────────────────► │  RequestUserInputHandler │
│                 │                     │  (tools/handlers/        │
│                 │                     │   request_user_input.rs) │
└─────────────────┘                     └────────────┬─────────────┘
        ▲                                            │
        │  tool_output (JSON)                        │ session.request_user_input()
        │                                            ▼
        │                               ┌──────────────────────────┐
        │                               │       Session / TUI      │
        │                               │  (EventMsg::             │
        │                               │   RequestUserInput)      │
        └───────────────────────────────┤                          │
                                        │  User selects option     │
                                        │  → RequestUserInput-     │
                                        │    Response returned     │
                                        └──────────────────────────┘
```
