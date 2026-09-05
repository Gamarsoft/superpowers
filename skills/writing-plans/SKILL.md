---
name: writing-plans
description: Use when you have an approved spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write a self-contained implementation plan that tells a skilled engineer WHAT
to build. The approved specification owns observable behavior; the plan turns
that contract into bounded tasks, interfaces, risks, and verification lanes.
The implementer reads the codebase and chooses idiomatic HOW.

Do not include method bodies, test bodies, shell transcripts, or repeated TDD
ceremony. Concrete names, signatures, paths, enum values, migrations, and data
from the specification are required implementation anchors, not forbidden code.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

If external libraries, frameworks, or APIs are involved, use
`superpowers:context7-research` first and carry its versioned findings into the
plan. Do not make each executor rediscover them.

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

User preferences for plan location override this default.

## Preconditions

Before planning:

1. Locate the approved specification. If none exists, return to brainstorming
   instead of inventing product behavior.
2. Read the specification completely and record its path and approved revision.
3. Inspect the relevant code, tests, project instructions, and prior decisions.
4. Confirm the first delivery boundary. If independent subsystems can ship and verify separately,
   split them into separate specifications or plans. Keep tightly coupled
   behavior together until it has an independently verifiable boundary.

A missing or unreachable specification, contradictory WHAT requirement, or
undefined protected authority blocks planning handoff. A reversible HOW choice
does not: leave it to execution or record the cheapest safe default.

## Plan Shape

Prefer a compact plan that can be held in context. Keep each task independently
testable and give one owner to every changed file or shared interface. Fold
setup, scaffolding, configuration, and documentation into the task whose
deliverable needs them. Split tasks only where downstream work could consume
one result while its neighbor remains unfinished.

Chunks are optional readability groups, not review boundaries. Avoid more than
ten tasks in one plan; split larger work along independently shippable product
boundaries.

### Required header

Every plan starts with:

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when
> subagents are available, or `superpowers:executing-plans` otherwise. Honor an
> explicit execution-route override in this plan.

**Goal:** [observable result]
**First delivery boundary:** [what this plan ships, and where it stops]
**Architecture:** [short structural approach]
**Tech Stack:** [languages, frameworks, and version constraints]
**Spec:** [exact path to the approved specification]
**Spec revision:** [approved commit, hash, version, or dated revision]
**Risk class:** [review-required | checkpoint-review]
**Risk triggers:** [named triggers, or `none`]
**Verification lanes:** [focused, integration, and complete-suite ownership]
```

### Plan context

After the header, include only cross-cutting information:

- global constraints and compatibility promises;
- invariants and non-goals;
- terminology or reference data used by multiple tasks;
- adversarial or valid-but-dangerous boundary cases;
- Context7 findings when external APIs are involved;
- selected specialist profiles, if any;
- whole-feature acceptance and the owner of its verification.

Keep task-local detail in its task. Every global invariant must map to at least
one task and a later verification lane; global prose alone is not coverage.

### Readiness record

Every saved plan ends its context with a durable review record:

```markdown
## Readiness Record

**Author self-review:** [complete; short summary of corrections]
**Independent readiness gate:** [not required | READY after round N]

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| [review ID or `none`] | [BLOCKING, DECISION, FOLLOW_UP, INVALID] | [what changed or why it did not] | [task/report destination] |
```

Record every readiness finding, including `FOLLOW_UP` and `INVALID`, plus each
autonomous ruling or human decision. This record travels with the plan so SDD
can copy it into its ledger and final report after session compaction.

### Task contract

Each task contains:

```markdown
### Task N: [outcome-oriented name]

**Outcome:** [independently testable result]

**Files and ownership:**
- Create/modify/test: `exact/path`
- [Name the sole mutation owner for shared files]

**Interfaces and contracts:**
- Consumes: [earlier output, signature, state, or `none`]
- Produces: [exact downstream interface, state, or artifact]
- [Public names, types, compatibility rules, and specification anchors]

**Dependencies:** [task IDs and why, or `none`]

**Risk class and triggers:** [review-required plus named triggers, or
checkpoint-review with `none`]

**Acceptance criteria:**
- [observable happy-path assertion]
- [dangerous boundary and compatibility assertions]

**Error handling:**
- [reject, skip, degrade, stop, or recover—state the boundary]

**Verification:**
- Run: `exact focused command`
- Expected: [specific evidence]
- [Integration or final-suite contribution]

**Codebase pointers:**
- [existing files and patterns to inspect before implementation]
```

Pure documentation or configuration tasks may mark an irrelevant section
`N/A`, but must explain why. No other placeholders are allowed. Reject `TBD`,
`TODO`, “handle errors appropriately,” “test the above,” or “similar to Task N.”

TDD remains mandatory during execution: each behavior needs evidence that its
test failed before implementation and passed afterward. State this once in the
plan context; do not repeat a five-step TDD script in every task.

## Risk Classification

Use exactly two classes. Risk follows behavior, not file size.

| Class | Trigger | Planning gate |
| --- | --- | --- |
| `review-required` | Money, authorization, security, privacy, schema migration, destructive behavior, concurrency, idempotency, retry/recovery, public contract, cross-system contract, multi-owner invariant, or explicit user request | Author self-review plus exactly one holistic readiness review |
| `checkpoint-review` | No named trigger | Author self-review only |

Plan-level risk is `review-required` when any task or cross-task invariant has a
named trigger. Copy every trigger into the relevant task so execution can
preserve the same classification.

## Author Self-Review

After writing the complete plan, inspect the full specification and full plan
with fresh eyes. The plan author owns this check and fixes gaps directly.

Verify:

1. **Spec identity and coverage:** the path and revision are reachable; every
   requirement and concrete anchor maps to a task; no task expands scope.
2. **Task consistency:** inputs, outputs, names, types, ordering, and shared-file
   ownership agree across producers and consumers.
3. **Executable contracts:** acceptance criteria and error boundaries are
   testable; codebase pointers and commands are exact; placeholders are absent.
4. **Boundary coverage:** invariants and dangerous cases have task-local proof
   and later integration or whole-feature proof.
5. **Risk classification:** task and plan triggers use the shared predicate,
   and no protected boundary is mislabeled as ordinary work.
6. **Execution-lane ownership:** focused, integration, and complete-suite work
   each has one owner; the handoff names the correct execution route.

Record a short requirement-to-task and invariant-to-verification mapping in the
plan. Do not dispatch a reviewer for wording polish or because the plan is long.

## Holistic Readiness Gate

If `Risk triggers` is `none`, author self-review completes planning. Do not
dispatch an independent plan reviewer.

If any risk trigger is named, dispatch exactly one holistic readiness review
using `plan-readiness-reviewer-prompt.md`. Give the reviewer the full approved
specification and full implementation plan—never one output chunk or session
history. Use the advertised `sp_reviewer` role when it exists; otherwise omit `agent_type`
and send the same prompt to a fresh generic agent. On Codex both
paths use `fork_turns: "none"`; never probe an unknown role with a failing call.

The plan author applies supported findings directly. Do not dispatch a separate
plan fixer. A correction round is one author edit followed by a re-run of the
same holistic review:

- Round one: apply supported load-bearing findings, then re-review.
- Round two: apply any remaining supported load-bearing findings, then
  re-review once.
- If a supported `BLOCKING` finding survives two correction rounds, stop and
  return the architectural conflict to the human partner before execution.

Do not hand off until the reviewer returns `READY`. A `DECISION` item that
changes observable WHAT, protected authority, or destructive or external authority
goes to the human partner; its resolution updates the specification and plan,
counts as a correction round, and returns through the same holistic review.
Reversible HOW remains with the executor. `FOLLOW_UP` items do not enlarge this
plan. Explain why any reviewer finding classified `INVALID` is unsupported;
never silently ignore it. Persist all dispositions and resolutions in the
plan's Readiness Record.

## Whole-Feature Verification

A multi-task plan ends with a whole-feature verification section or dedicated
final task. It names:

- user-visible states that must remain faithful after task stitching;
- cross-task contracts and execution-time safety checks;
- dangerous cases that local tests could miss;
- the exact integration evidence produced during execution; and
- the complete-suite command reserved for `finishing-a-development-branch`.

## Execution Handoff

Before handoff, verify the spec, plan, mappings, and external research are
saved. Add any uncaptured decision to the plan now.

A plan may explicitly override the execution route, as self-hosting or recovery
plans sometimes must. Preserve that route verbatim in the continuation prompt.
Otherwise:

- if subagents are available, route to `superpowers:subagent-driven-development`;
- if subagents are unavailable, route to `superpowers:executing-plans` and say
  plainly that independent agent review is unavailable.

Recommend compacting before execution, then give one exact continuation prompt
containing the real plan path and selected route. Do not offer another planning
or refining skill after this gate.
