---
name: writing-plans
description: Use when you have a spec or requirements for a multi-step task, before touching code
---

# Writing Plans

## Overview

Write implementation plans that tell a skilled engineer WHAT to build, not HOW to code it. The implementer has zero project context but is a capable developer who can read existing code and write idiomatic solutions. Document interfaces, acceptance criteria, edge cases, and where to look in the codebase — but do not write implementation or test code.

TDD in plans is mandatory, not optional. Plans that put implementation before a failing test are invalid and must be revised before execution handoff.

Assume they are a skilled developer, but know almost nothing about our toolset or problem domain. They will read the codebase to learn patterns and conventions before writing code.

**Announce at start:** "I'm using the writing-plans skill to create the implementation plan."

If the work involves external libraries/frameworks/APIs (or any uncertainty about their correct usage):

- **REQUIRED SUB-SKILL:** Use superpowers:context7-research before writing the plan
- Include the resulting findings in the plan so execution/subagents don’t have to re-research

**Context:** This should be run in a dedicated feature branch (created by brainstorming skill).

**Save plans to:** `docs/superpowers/plans/YYYY-MM-DD-<feature-name>.md`

- (User preferences for plan location override this default)

## Scope Check

If the spec covers multiple independent subsystems, it should have been broken into sub-project specs during brainstorming. If it wasn't, suggest breaking this into separate plans — one per subsystem. Each plan should produce working, testable software on its own.

## File Structure

Before defining tasks, map out which files will be created or modified and what each one is responsible for. This is where decomposition decisions get locked in.

- Design units with clear boundaries and well-defined interfaces. Each file should have one clear responsibility.
- You reason best about code you can hold in context at once, and your edits are more reliable when files are focused. Prefer smaller, focused files over large ones that do too much.
- Files that change together should live together. Split by responsibility, not by technical layer.
- In existing codebases, follow established patterns. If the codebase uses large files, don't unilaterally restructure - but if a file you're modifying has grown unwieldy, including a split in the plan is reasonable.

This structure informs the task decomposition. Each task should produce self-contained changes that make sense independently.

## Task Right-Sizing

A task is the smallest unit that carries its own test cycle and is worth a
fresh reviewer's gate. Fold setup, configuration, scaffolding, and
documentation into the task whose deliverable needs them. Split tasks only
where a reviewer could meaningfully reject one task while approving its
neighbor. Every task must end with an independently testable deliverable.

## Bite-Sized Task Granularity

**Each step is one action (2-5 minutes):**

- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement the minimal code to make the test pass" - step
- "Run the tests and make sure they pass" - step
- "Commit" - step

## Output Budget Guardrails

To avoid oversized responses and token overflows:

- Keep plans concise: target **~80 lines max** per chunk (excluding blank lines)
- Cap at **10 tasks per response**
- If work is larger, split into phases and only output **Phase 1**
- Do not include implementation or test code — describe interfaces, acceptance criteria, and codebase pointers instead
- For repetitive tasks, provide one concrete example then reference the same pattern for remaining tasks

## Plan Document Header

**Every plan MUST start with this header:**

```markdown
# [Feature Name] Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** [One sentence describing what this builds]

**Architecture:** [2-3 sentences about approach]

**Tech Stack:** [Key technologies/libraries]

**Global Constraints:**

- [Project-wide version floors, dependency limits, naming/copy rules,
  platform requirements, and safety boundaries copied exactly from the spec]
- [Every task implicitly inherits these constraints; map behavioral rules to
  concrete acceptance criteria and verification below]

**Context7 Findings (required if any external libs/APIs are involved):**

- Libraries + installed versions
- Doc-backed API/config decisions
- Caveats/migrations

---
```

## Plan Context (after header, before tasks)

If the spec defines cross-cutting information, extract it into a Plan Context section right after the header. This section serves two purposes:

1. **Plan authoring reference** — use it to enrich each task's interfaces, acceptance criteria, and naming with the right spec details.
2. **Cross-cutting rules** — items that apply to multiple tasks stay here. The orchestrator selects relevant items per implementer — a lean Plan Context means higher signal.

**Placement rule:** if a piece of context applies to multiple tasks, keep it in Plan Context. If it only applies to one task, embed it in that task's interfaces or acceptance criteria instead.

**Critical rule:** global requirements must not stay global-only. If the spec says something must "always", "never", "only when", "before any action", "must remain visible", or otherwise constrains behavior across multiple tasks, record it in Plan Context and later map it to concrete task coverage and verification.

```markdown
## Plan Context

**Invariants** (rules that must hold across all tasks):

- [e.g., "`groupCustomerId` is canonical — the single customer identifier across all services"]
- [e.g., "No email-based auto-merge across tenants — UID-only linking"]

**Non-goals** (explicitly out of scope — do not build):

- [e.g., "Cross-tenant SSO", "Group leave/split handling"]

**Terminology** (domain definitions, synonyms the implementer must know):

- [e.g., "`tenantId` and `parkingId` are synonymous — both identify a parking"]

**Reference data** (tables, enums, lookups needed by multiple tasks):

- [e.g., Role classification table with scope → role → behavior mapping]

**Backward compatibility** (existing contracts that must not break):

- [e.g., "`parking_id` claim stays alongside new `parking_ids` and `tenant_group_id`"]

**Cross-Task Invariants** (global rules that can be broken at task boundaries, integration points, or execution time):

- [e.g., "Blocked items remain visible in review output even when excluded from execution"]
- [e.g., "Authorization/state is re-validated at execution time, not only when building the request/plan"]

**Adversarial / Boundary Cases** (valid-but-dangerous cases that must be covered somewhere in the plan):

- [e.g., malformed-but-plausible config/input]
- [e.g., partial configuration state]
- [e.g., identifiers/paths/values that are valid but ambiguous when serialized, escaped, or displayed]
- [e.g., state drift between review/check time and execution time]
```

## Task Structure (MANDATORY)

Every implementation task MUST follow this exact 5-step order:

1. **Step 1: Read codebase pointers** and understand existing patterns
2. **Step 2: Write failing tests** from acceptance criteria
3. **Step 3: Run tests to verify they fail**
4. **Step 4: Write minimal implementation** to pass tests
5. **Step 5: Run tests, self-review, commit**

Do NOT include implementation or test code in the plan. Provide interfaces, acceptance criteria, and codebase pointers instead. The implementer writes all code.

**What counts as "implementation code" (forbidden):** method bodies, test bodies, code blocks with logic.

**What is NOT implementation code (required — carry from spec):** class/file names the spec mentions, concrete data values (seed data, enum values, group names), method signatures, strategy/pattern names, specific columns/tables. These are implementation anchors — without them the implementer doesn't know WHAT to change.

```markdown
### Task N: [Component Name]

**Files:**

- Create: `exact/path/to/file.ext`
- Modify: `exact/path/to/existing.ext`
- Modify: `exact/path/to/another-existing.ext` (every file the spec names for this area of work must appear here)
- Test: `tests/exact/path/to/test.ext`

**Interfaces and contracts:**

- [Public API signatures, method signatures with parameter names/order, data shapes, type constraints]
- [Only the boundaries between this task's code and the rest of the system]
- [Spec-defined names for new elements: entity names, table/column names, enum values, specific data values, method signatures — carry these verbatim from the design spec. For existing elements, codebase naming takes precedence.]
- [Or: N/A — pure config/docs task with no code interfaces (explain why)]

**Acceptance criteria:**

- [Observable behaviors stated as testable assertions — happy path]
- [Edge case: boundary conditions, empty inputs, null/missing values]
- [Edge case: error conditions, concurrent access, max/min values]
- [Backward compat: existing behavior that must still work after this change, if any]

**Error handling:**

- [Pre-resolved boundary decisions: what is rejected vs. skipped vs. accepted]
- [Error strategy per operation: fail fast, degrade gracefully, skip and log]
- [Security boundaries: which inputs are sanitized and how strictly]
- [Edge-case policy: nulls, empty collections, malformed data]
- [Or: N/A — no boundary surface in this task (explain why)]

**Verification:**

- Run: `exact test command`
- Expected: [what success looks like]
- [If this task touches a cross-task invariant, name the specific fixture/assertion or end-to-end proof here]

**Codebase pointers:**

- [Existing files/patterns the implementer should read before writing]
- [e.g., "Follow conventions in `src/service/FooService.ext` for service layer patterns"]

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit
```

## Task Structure Validation (MANDATORY)

Before saving the plan, verify every implementation task meets these criteria:

- Plan has a **Plan Context** section if the spec defines cross-cutting rules (invariants, non-goals, reference data, backward compat). Single-task context is embedded in that task instead.
- Every task has **Interfaces and contracts** (or N/A with justification for pure config/docs tasks)
- Every task has **Acceptance criteria** with testable assertions (observable behaviors, not vague)
- Every task has **Error handling** with concrete boundary decisions, or `N/A` with justification
- Every task that modifies existing code has **Codebase pointers**
- No task contains implementation or test code blocks (interface one-liner signatures are allowed)
- Step 1 is "Read codebase pointers" not "Write the failing test"
- Steps follow the TDD order: read → write tests → fail → implement → pass + commit
- Cross-Task Invariants from Plan Context are mapped to at least one task and at least one verification step
- Adversarial / Boundary Cases from Plan Context are either embedded in task acceptance criteria/verification or explicitly marked out of scope with justification
- Any requirement about execution-time safety is verified at execution time, not only at setup/review time

If a task contains full method bodies or test method bodies, STOP and rewrite it to use acceptance criteria instead.

Allowed exceptions (must be explicitly justified in the plan):

- Pure documentation-only tasks
- Pure configuration-only tasks
- Schema/migration-only tasks (still require a separate test task to validate behavior)

## Invariant-to-Task Mapping (MANDATORY)

Before saving the plan, add a brief mapping for every Cross-Task Invariant:

- Invariant: [text]
  - Implemented in: Task N, Task M
  - Re-verified in: Task X / Whole-feature verification
  - Failure mode if omitted: [what could silently break]

If an invariant appears in Plan Context but is not implemented by a task and re-verified later, the plan is incomplete.

## Remember

- Exact file paths always
- Include interface signatures, acceptance criteria, and verification commands. Do not include implementation or test code.
- Error handling and Acceptance criteria sections per task (N/A requires justification)
- Exact commands with expected output
- Reference relevant skills with @ syntax
- DRY, YAGNI, KISS, strict TDD order, frequent commits
- Reject and rewrite any plan that contains implementation code or test bodies
- Concrete class names, file paths, seed data values, and strategy names from the spec are NOT implementation code — they are implementation anchors that must be preserved in the plan

## Design-Plan Alignment Check

Before saving the plan, verify alignment with the design doc (if one exists):

1. **Read the design doc** — open `docs/plans/*-design.md` for this feature
2. **Check coverage** — every requirement in the design must map to at least one plan task
3. **Check concrete anchors** — every class name, file, strategy, seed data value, and specific data the spec names must appear somewhere in the plan (in a task's Files, Interfaces, or Acceptance criteria). If the spec says "`ParkingGroupeFlippingStrategy` changes from X to Y", that class must appear in a task. If the spec says "insert group named 'Solution Parking - Groupe'", that exact name must appear in acceptance criteria.
4. **Check scope** — no plan task should implement something not in the design (no feature creep)
5. **Preserve spec naming** — entity names, table/column names, enum values, specific data values, and endpoint paths defined in the spec must appear verbatim in the plan's interfaces and contracts for new elements. For existing elements being modified, codebase naming takes precedence — note any discrepancy with the spec.
6. **List the mapping** — briefly note which design requirement each task covers
7. **Promote global rules** — any requirement phrased as "always", "never", "only when", "before any action", "must remain visible", or similar must appear in Plan Context as a Cross-Task Invariant unless it is truly local to one task
8. **Operationalize invariants** — every Cross-Task Invariant must map to task-local acceptance criteria plus a later verification step; global prose alone is not enough
9. **Pressure-test boundaries** — for parsing, state transitions, destructive actions, serialization/display, identity, or concurrency, ensure the plan names at least the dangerous-but-valid boundary cases that could survive normal happy-path slicing

If you find gaps (design requirements with no corresponding task), add tasks. If you find extras (tasks that implement unrequested functionality), remove them.

## Whole-Feature Verification (MANDATORY for multi-task plans)

If the feature spans multiple tasks, the plan must end with either:

- a dedicated final verification task, or
- a final verification section that is explicitly referenced by the last task

This final verification must prove the feature still satisfies cross-task invariants after all tasks are complete. It should check end-to-end behavior, not just per-task behavior in isolation.

Minimum questions to answer:

- Which user-visible states must remain faithful after all task stitching is complete?
- Which safety checks must still hold at execution time, not just at review/build time?
- Which adversarial or valid-but-dangerous cases could slip through task boundaries if only local tests are run?

## Plan Review Loop

After completing each chunk of the plan:

1. Dispatch plan-document-reviewer subagent (see plan-document-reviewer-prompt.md) with precisely crafted review context — never your session history. This keeps the reviewer focused on the plan, not your thought process.
   - Provide: chunk content, path to spec document
   - Codex multi-agent role: `sp_plan_reviewer`
2. If ❌ Issues Found:
   - Fix the issues in the chunk
   - Re-dispatch reviewer for that chunk
   - Repeat until ✅ Approved
3. If ✅ Approved: proceed to next chunk (or execution handoff if last chunk)

**Chunk boundaries:** Use `## Chunk N: <name>` headings to delimit chunks. Each chunk should be ≤1000 lines and logically self-contained.

**Review loop guidance:**

- Same agent that wrote the plan fixes it (preserves context)
- If loop exceeds 5 iterations, surface to human for guidance
- Reviewers are advisory - explain disagreements if you believe feedback is incorrect

## Execution Handoff

After saving the plan:

**1. Record context.** Before anything else, verify all artifacts are saved and the plan is self-contained:

- Spec document path (if one was written)
- Plan document path
- Key architectural decisions, constraints, or user preferences that affect implementation but aren't captured in the plan — add them to the plan now

**2. Advise compaction.** Execution works better with a fresh window. Tell the user:

> "The plan is saved to `docs/superpowers/plans/<filename>.md`. Before we start implementation, I recommend compacting this session — execution works better with a fresh window."

**3. Give exact continuation prompt.** Tell the user exactly what to say after compacting. Use the actual filename, not a placeholder.

If you can dispatch subagents (Claude Code, etc.):

> "After compacting, say: **Execute the plan at `docs/superpowers/plans/<filename>.md` using subagent-driven-development.**"

If you cannot dispatch subagents, ask the user: "The plan is ready. I can't dispatch subagents in this environment — should I execute the tasks in this thread?"
