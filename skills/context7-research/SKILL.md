---
name: context7-research
description: Use when implementing or changing anything involving external libraries/frameworks/APIs (or uncertainty) - do Context7 docs research before any code edits
---

# Context7 Research

## Overview

When you touch a library/framework/API without verifying current docs, you will guess. Guessing creates rework.

**Core principle:** When external docs matter, do mandatory Context7 research **before any code edits**.

**Announce at start:** "I'm using the context7-research skill to verify docs before coding."

## When to Use

Use this skill when the task involves ANY of:

- A third-party library/framework (new dependency or existing)
- A cloud/service API (SDKs, REST APIs, auth flows)
- Tooling/config with version-sensitive behavior (build tools, linters, test runners)
- Uncertainty about correct API, flags, config, or best practices

**Usually NOT needed** when:

- Pure internal refactors with no library surface-area changes
- Pure language stdlib usage you are already confident about
- Mechanical edits (renames, formatting) with no behavioral change

If unsure whether docs matter: **assume they do and run this skill.**

## The Iron Law

```
NO CODE EDITS WHEN EXTERNAL DOCS ARE UNCERTAIN
```

If you cannot cite the relevant doc point(s), you cannot start editing.

## Tools (Context7 MCP)

- resolve-library-id({ libraryName, query })
- query-docs({ libraryId, query })

## Constraints (Important)

- **Tool budget:** Context7 calls are limited. Prefer researching the **one or two most relevant** libraries first.
- **Don’t spray queries.** If you identify many libraries, ask which ones are in scope or prioritize the ones that affect the code you are about to change.

## Procedure (strict order)

### Step 1: Identify libraries/frameworks and versions

Identify candidates from:

- User request (explicit library names, APIs, frameworks)
- Repo indicators (package managers/lockfiles/build files)
  - Node: package.json + lockfiles
  - Python: pyproject.toml / requirements.txt
  - Java: pom.xml / build.gradle
  - Go/Rust/.NET equivalents

Extract installed versions when possible.

### Step 2: Prioritize scope

Pick the smallest set of libraries that actually determine correctness for the change.

Rules of thumb:

- Prefer the library you are integrating with (the one whose API you must call)
- Include a framework only if it constrains configuration or patterns (e.g. Next.js routing, Spring bean wiring)
- Skip transitive libs unless the issue is inside them

If >2 libraries seem required, stop and ask for clarification about scope.

### Step 3: Research each prioritized library (repeat per library)

For EACH prioritized library/framework:

1. Call resolve-library-id({ libraryName, query })

   - Query should include what you’re trying to do, plus the suspected version.

2. Select the best matching libraryId

   - Prefer exact name matches
   - Prefer higher snippet coverage/reputation
   - If ambiguous, pause and ask a clarifying question rather than guessing

3. Call query-docs({ libraryId, query })
   - Include installed version in the query if known
   - Ask for:
     - the exact API/config you will use
     - any version caveats/migrations
     - minimal working example

### Step 4: Version mismatch handling

If docs appear mismatched:

- Re-check installed version in repo
- Re-run query-docs with an explicitly version-aware query
- If still mismatched, re-run resolve-library-id and pick a better match
- If uncertain remains: STOP and ask before editing code

### Step 5: Record findings for downstream skills

You MUST paste findings into chat so other skills can reuse them without re-querying.

If you are using superpowers:writing-plans:

- Add a short **Context7 Findings** section near the top of the plan.
- Reference it from tasks instead of re-researching.

If you are using superpowers:subagent-driven-development:

- Provide the findings in the task context you pass to subagents.
- Subagents should not re-run Context7 unless new unknowns appear.

## Output Format (paste into chat)

Use this exact structure:

- **Libraries identified:**
  - <lib> (<version or "unknown">) — why relevant
- **Context7 selection:**
  - <lib>: chosen libraryId = <id> (why)
- **Key findings (short):**
  - Bullet points with the doc-backed API/config/pattern
- **Decisions derived from docs:**
  - What you will implement (and what you will not)
- **Caveats:**
  - Migrations, deprecations, breaking changes, footguns

## Stop Conditions (Ask, don’t guess)

STOP and ask for clarification when:

- The correct libraryId is ambiguous
- The repo version cannot be determined and behavior is version-sensitive
- Docs conflict with patterns in the codebase and you can’t reconcile them
- The change touches security-sensitive flows (auth, crypto, signing) and docs aren’t clear

## Integration

Works best as a mandatory pre-step for:

- **superpowers:writing-plans** (plan references doc-backed decisions)
- **superpowers:executing-plans** (treat as "Task 0" if needed)
- **superpowers:subagent-driven-development** (prevent subagents from guessing APIs)
- **superpowers:systematic-debugging** (if the issue is "docs mismatch" treat it as evidence-gathering)
