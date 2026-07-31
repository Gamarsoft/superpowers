---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements, including Java 21/Spring Boot/JPA/GKE security and performance checks when applicable
---

# Requesting Code Review

Dispatch a dedicated reviewer subagent to catch issues before they cascade. The reviewer gets precisely crafted context for evaluation — never your session's history. This keeps the reviewer focused on the work product, not your thought process, and preserves your own context for continued work.

- Codex multi-agent role: `sp_code_reviewer`
- Other platforms with named agents: `superpowers:code-reviewer`

**Core principle:** Review early, review often.

## When to Request Review

**Mandatory:**

- After each task in subagent-driven development
- After completing major feature
- Before merge to main
- After changes touching Java/Spring Boot/JPA/GKE runtime, security, persistence, or performance behavior

**Optional but valuable:**

- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

**1. Get git SHAs:**

```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

**2. Dispatch code-reviewer subagent:**

**Step 1 — Read the reviewer instructions:**

Read `skills/requesting-code-review/code-reviewer.md` in full before constructing the prompt.

**Step 2 — Build the subagent prompt:**

Paste the FULL content of `skills/requesting-code-review/code-reviewer.md` verbatim, substituting the placeholders:

| Placeholder              | Replace with                               |
| ------------------------ | ------------------------------------------ |
| `{PLAN_OR_REQUIREMENTS}` | What it should do                          |
| `{DESCRIPTION}`          | Brief summary                              |
| `{BASE_SHA}`             | Starting commit SHA                        |
| `{HEAD_SHA}`             | Ending commit SHA                          |
| `{SUPERPOWERS_DIR}`      | Absolute path to the superpowers directory |

**Step 3 — Dispatch:**

Use the `Task tool (superpowers:code-reviewer)` block structure for the tool call, but only send the content of `code-reviewer.md` (with substitutions applied) as the subagent's actual prompt.

For Codex multi-agent roles, spawn the agent with `agent_type = "sp_code_reviewer"` and use the same substituted prompt body.

```
Task tool (superpowers:code-reviewer):
  [Full content of skills/requesting-code-review/code-reviewer.md with substitutions applied]
```

Codex equivalent:

```text
spawn_agent(
  task_name="review_changes",
  agent_type="sp_code_reviewer",
  fork_turns="none",
  message=[substituted code-reviewer.md content]
)
```

**3. Act on feedback:**

- Fix Critical issues immediately
- Fix Important issues before proceeding
- Note Minor issues for later
- Push back if reviewer is wrong (with reasoning)

## Example

```
[Just completed Task 2: Add verification function]

You: Let me request code review before proceeding.

BASE_SHA=$(git log --oneline | grep "Task 1" | head -1 | awk '{print $1}')
HEAD_SHA=$(git rev-parse HEAD)

[Dispatch superpowers:code-reviewer subagent]
  DESCRIPTION: Verification and repair functions for conversation index
  PLAN_OR_REQUIREMENTS: Task 2 from docs/superpowers/plans/deployment-plan.md
  BASE_SHA: a7981ec
  HEAD_SHA: 3df7661
  DESCRIPTION: Added verifyIndex() and repairIndex() with 4 issue types

[Subagent returns]:
  Strengths: Clean architecture, real tests
  Issues:
    Important: Missing progress indicators
    Minor: Magic number (100) for reporting interval
  Assessment: Ready to proceed

You: [Fix progress indicators]
[Continue to Task 3]
```

## Integration with Workflows

**Subagent-Driven Development:**

- Review after EACH task
- Catch issues before they compound
- Fix before moving to next task

**Executing Plans:**

- Review after each batch (3 tasks)
- Get feedback, apply, continue

**Ad-Hoc Development:**

- Review before merge
- Review when stuck

## Red Flags

**Never:**

- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback

**If reviewer wrong:**

- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification

## Common Rationalizations

| Excuse | Reality |
| --- | --- |
| "I'll review the diff inline." | The coordinator needs its context for execution; a dedicated read-only reviewer keeps the evidence and evaluation isolated. |
| "The reviewer needs the whole session." | Give it the requirements, exact range, and template—not your thought process or accumulated history. |

See template at: requesting-code-review/code-reviewer.md
