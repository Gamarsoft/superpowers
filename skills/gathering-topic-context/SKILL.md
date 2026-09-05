---
name: gathering-topic-context
description: Use when preparing to brainstorm or write an implementation plan for a specific feature or change and you need topic-specific codebase context before choosing a track, asking design questions, or planning steps.
---

# Gathering Topic Context

## Overview

Gather topic-specific context before brainstorming or planning. The goal is relevance, not a generic project summary.

For repo-specific brainstorming, this is the default context-gathering step before reflection and track selection.

## When to Use

- Before `brainstorming` or `writing-plans` on a specific feature or change
- When questions feel generic or you lack local vocabulary
- When you need the files, tests, configs, or dependencies tied to the topic
- When `brainstorming` needs real codebase constraints before shaping options

When NOT to use

- When you need a generic project overview (use `AGENTS.md`)
- When the request is not tied to this repo

## Core Pattern

Before: ask broad questions without scanning.
After: infer topic terms, scan targeted files, then ask focused questions.

**Default execution:** dispatch a subagent to gather context and return only the Topic Context Bundle. If subagents are unavailable (for example, `collab` is off or `spawn_agent` is missing), run the steps locally and say why.

## Quick Reference

| Step        | Deep (default for brainstorming/planning)           | Light                                     |
| ----------- | --------------------------------------------------- | ----------------------------------------- |
| Infer scope | Extract topic terms + repo vocabulary               | Extract topic terms only                  |
| Scan        | `rg` across code, tests, config; open top 3–6 files | `rg` across code only; open top 1–2 files |
| Output      | Full Topic Context Bundle                           | Compact Topic Context Bundle              |
| Execution   | Subagent (default)                                  | Subagent (default)                        |

**Override keywords:** “deep brainstorming,” “light brainstorming,” “light plan.”

**Depth rule:** Use deep by default. Use light only when the user explicitly requests it.

## Retrieval Budget

Gather the minimum topic evidence needed to make the next brainstorming or planning step concrete, then stop.

Enough evidence means the bundle can name:

- likely scope and search terms
- affected files or areas
- current behavior or data flow
- constraints, tests, dependencies, risks, and edge cases
- suggested track and decision hooks

Search again only when a missing fact would change the track, first delivery boundary, integration risk, brownfield invariant, or next guided question. Do not keep searching to make the bundle feel exhaustive, improve prose, or collect unrelated project background.

## Implementation

### Subagent Flow (Default)

1. If subagents are unavailable, switch to Local Flow and state the reason. Do not assume they are unavailable unless the platform or user confirms it.
2. Dispatch a subagent using the prompt template at `./topic-context-subagent-prompt.md`.
   - On Codex, inspect the runtime-advertised roles first. When available, use
     `agent_type: "sp_topic_context"` with `fork_turns: "none"`.
   - When that role is absent, omit `agent_type`, keep `fork_turns: "none"`,
     and send the same complete prompt to a fresh generic agent. Never probe an
     unknown role with an intentionally failing dispatch.
3. Fill placeholders before dispatch:
   - `{USER_REQUEST}`
   - `{DEPTH}` (`deep` or `light`)
   - `{CONSTRAINTS}` (`none` if no constraints)
   - Keep all other template text unchanged.
4. If the subagent asks a clarification question, answer it and re-dispatch.
5. Use the returned Topic Context Bundle for the next step. Do not paste scan output or file contents.

### Prompt Template

- `./topic-context-subagent-prompt.md` - Dispatch a topic-context gatherer subagent
- Codex role pack mapping: `sp_topic_context`, with the generic fallback above

### Local Flow (Fallback)

Use this only if subagents are unavailable.

1. Infer the topic and initial terms from the user request.
2. Add repo vocabulary: skim `AGENTS.md` (if present) and the newest `docs/plans/*` for terms only.
3. Decide depth: deep for brainstorming/planning unless the user requests “light.”
4. Ambiguity check: if scope is unclear, ask one confirmation question.
5. Scan:
   - Deep: `rg` across code, tests, and config; open the top 3–6 relevant files.
   - Light: `rg` across code only; open the top 1–2 relevant files.
6. Produce the Topic Context Bundle (paths + brief notes only, no snippets).
7. Keep a light in-session cache of terms, candidate files, and open gaps. Do not create artifacts.

**Topic Context Bundle (default sections):**

- Inferred scope and search terms
- Key files and areas
- Current behavior and data flow (topic-specific)
- Constraints and assumptions
- Related tests
- Config and flags
- Dependencies and APIs touched
- Risks and edge cases
- Suggested track and why
- Decision hooks for the next step
- Open questions (2–4)

**Command examples (adapt as needed):**

```bash
rg -n "oauth|login|auth" src/ tests/ config/
rg -n "scheduler|job|queue" src/
```

For advanced `rg` usage (hidden files, type filters, multiline), use the `ripgrep` skill.

## Example

**User:** “Deep brainstorming: add OAuth login.”

**Output (abridged):**

- Inferred scope and search terms: `oauth`, `login`, `auth`, `oidc`, `session`
- Key files and areas: `src/auth/`, `src/routes/login.ts`, `config/auth.yml`
- Current behavior and data flow: local email/password flow, session cookie issued in `auth/session.ts`
- Constraints and assumptions: single-tenant, email login must remain
- Related tests: `tests/auth/login.test.ts`
- Config and flags: `AUTH_PROVIDER`, `SESSION_TTL`
- Dependencies and APIs touched: `passport`, `openid-client`
- Risks and edge cases: account linking, email collision
- Suggested track and why: brownfield-major-feature, because auth touches existing session and login flows
- Decision hooks for the next step: whether OAuth is additive vs replacement, whether account linking is required first release
- Open questions: Do we need multi-provider support? What is the callback URL strategy?

## Rationalizations and Counters

| Excuse                                              | Reality                                                                   |
| --------------------------------------------------- | ------------------------------------------------------------------------- |
| “This is brainstorming, so code context can wait.”  | Generic questions cause weak designs and rework. Scan first.              |
| “AGENTS.md is enough context.”                      | It is general, not topic-specific. You still need local files and tests.  |
| “Searching the codebase will slow us down.”         | A focused scan is faster than revising a weak design.                     |
| “We’re in a hurry, use light.”                      | Only the user can request light. Default is deep.                         |
| “Subagents might be unavailable, so I’ll go local.” | Switch only when the platform or user confirms subagents are unavailable. |
| “We can validate details during implementation.”    | Plans are stronger when grounded in existing behavior.                    |

## Red Flags

- Asking broad questions before any scan
- Producing a generic project summary
- Skipping scans because of time pressure
- Using README-only context for a feature decision

## Common Mistakes

- Summarizing the whole project instead of the topic
- Dumping file lists without notes
- Including snippets instead of paths + brief notes
- Failing to ask a scope question when the topic is ambiguous
- Adding narration instead of the raw subagent prompt
