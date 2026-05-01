---
name: gsd-context7-research
description: Use when GSD work depends on external libraries, frameworks, APIs, SDKs, services, or version-sensitive tooling.
---

# GSD Context7 Research

## Mission

When a GSD task depends on third-party behavior, verify the current docs before planning or editing.

Do not guess API shapes, config flags, auth flows, or framework conventions from memory.

## Use When

- The task touches a library, framework, SDK, cloud API, or external service
- The task depends on version-sensitive config or tooling behavior
- The repo already uses a dependency, but you are not fully sure about the correct API
- Research or planning needs a doc-backed decision before the slice or task can be scoped safely

## Preferred Timing In GSD

- **Research phase:** best place to do this
- **Planning phase:** use it when docs determine task breakdown or proof strategy
- **Execution phase:** stop and do this before editing if the task reaches an external-docs unknown

If docs uncertainty appears mid-task, pause implementation and research first.

## Tools

Use GSD's doc lookup flow:

1. `resolve_library`
2. `get_library_docs`

## Workflow

### 1. Identify the real external surface

From the task, repo, and current slice, identify the smallest set of libraries or services that determine correctness.

Check versions from the repo when possible.

### 2. Research the minimum necessary scope

For each relevant library or service:

- resolve the library
- fetch the docs for the exact API, config, or workflow you need
- look for version caveats, migrations, or deprecated patterns

Do not spray broad doc lookups across unrelated tools.

Stop when the docs answer the API, config, workflow, or version decision needed for the current GSD unit. Search again only if a missing version, option, migration note, or caveat would change the implementation or proof path.

### 3. Turn docs into GSD artifacts

Capture the result in the right place for the current phase:

- **Milestone or slice research:** record concise findings in `M###-RESEARCH.md` or `S##-RESEARCH.md`
- **Planning:** reflect doc-backed constraints in the roadmap or plan
- **Execution:** if the docs drive an architectural or library decision, append it to `.gsd/DECISIONS.md`
- **Task completion:** mention the doc-backed choice in `T##-SUMMARY.md` when it materially affected the implementation

### 4. Only then edit code

Once the docs answer is clear, implement the smallest change that follows the verified guidance.

### 5. If docs stay unclear

Do not guess.

Record the uncertainty plainly in the current research or summary artifact and avoid overclaiming completion.

## What Good Output Looks Like

For each library or service you researched, capture:

- library or service name
- relevant version, if known
- exact API, config, or workflow used
- caveats, migrations, or footguns
- the implementation decision derived from docs

Keep it short and reusable by the next GSD unit.

## Anti-Patterns

- Guessing because the docs lookup feels slow
- Researching five libraries when one actually determines correctness
- Leaving doc findings only in chat instead of GSD artifacts
- Continuing to edit after discovering docs uncertainty

## Rule

No doc-sensitive code edits without fresh docs.
