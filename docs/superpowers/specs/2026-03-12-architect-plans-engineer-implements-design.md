# Architect Plans, Engineer Implements

**Date:** 2026-03-12
**Status:** Approved
**Scope:** `skills/writing-plans/`, `skills/subagent-driven-development/`, `skills/writing-plans/plan-document-reviewer-prompt.md`

## Problem

The writing-plans → subagent-driven-development pipeline treats implementer subagents as copy-paste workers. Plans contain full implementation and test code — speculative code written without running it — that is correct only 30-60% of the time. Implementers blindly copy this code even when it contradicts the actual codebase, producing broken implementations that trigger expensive spec and code quality review loops.

The root cause is a role mismatch: plan writers do work they're bad at (writing speculative code without running it) while implementers are prevented from doing work they could do well (reading the codebase and writing idiomatic code).

## Design

### Core Mindset Shift

**Current:** "The implementer is an unskilled worker. Pre-write everything. They copy-paste."

**New:** "The implementer is a skilled engineer with no project context. Tell them WHAT to build, WHERE it fits, and HOW to verify — but let them write the code."

The plan becomes an **architectural blueprint**: file structure, interfaces/contracts, acceptance criteria, codebase pointers, verification commands. The implementer becomes a **builder**: reads the codebase, understands patterns, writes tests and code, self-reviews against acceptance criteria.

### What Changes

| Artifact                        | Current Role                                    | New Role                                                                                    |
| ------------------------------- | ----------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `writing-plans`                 | Pre-writes code, tests, and commands            | Defines WHAT to build (interfaces, contracts, acceptance criteria) — no implementation code |
| `implementer-prompt`            | "Copy plan code, run tests, commit"             | "Read codebase, write tests from criteria, implement, self-review"                          |
| `subagent-driven-development`   | Dispatches copy-paste workers + reviews         | Dispatches autonomous engineers + reviews (same review gates)                               |
| `spec-reviewer-prompt`          | "Did implementer copy the plan code correctly?" | "Did implementer satisfy acceptance criteria and respect interfaces?"                       |
| `plan-document-reviewer-prompt` | Checks for code completeness in tasks           | Checks for acceptance criteria, interfaces, codebase pointers. Rejects implementation code. |

### What Stays the Same

- TDD is mandatory (but the implementer writes the tests)
- Two-stage review (spec compliance + code quality) after every task — non-negotiable
- The 5-step rhythm per task (but step content changes — see below)
- Escalation protocol (BLOCKED, NEEDS_CONTEXT, DONE_WITH_CONCERNS)
- Plan reviewer loop before execution handoff
- Context7 handoff contract
- Final code reviewer for entire implementation
- Model tier selection (spark/standard/deep) with adjusted criteria

## Changes by File

### `skills/writing-plans/SKILL.md`

**A. Replace the task structure template.**

Current mandatory 5-step template has code blocks in steps 1 and 3. Replace with:

```markdown
### Task N: [Name]

**Files:** [create/modify/test paths]

**Interfaces and contracts:**

- [Public API signatures, method contracts, data shapes, type constraints]
- [Only boundaries between this task's code and the rest of the system]

**Acceptance criteria:**

- [Observable behaviors stated as testable assertions]
- [Include happy path AND edge cases as separate criteria]

**Error handling:**

- [What can fail and how each failure must be handled]
- [Or: N/A with justification]

**Verification:**

- Run: `[exact test command]`
- Expected: [what success looks like]

**Codebase pointers:**

- [Existing files/patterns the implementer should read before writing]

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit
```

**B. Update the "Overview" section.**

Replace the framing of the implementer. Current text says "assuming the engineer has zero context for our codebase and questionable taste" and instructs the plan writer to provide full code. New text:

> Write implementation plans that tell a skilled engineer WHAT to build, not HOW to code it. The implementer has zero project context but is a capable developer who can read existing code and write idiomatic solutions. Document interfaces, acceptance criteria, edge cases, and where to look in the codebase — but do not write implementation or test code.

**C. Remove or replace all references to providing "complete test code" or "concrete snippets" of implementation.**

The "Remember" section currently says "Include concrete snippets and commands." Change to: "Include interface signatures, acceptance criteria, and verification commands. Do not include implementation or test code."

**D. Update the Task Structure Validation section.**

Current validation checks that tasks start with test code, not implementation. New validation checks:

- Every task has **Interfaces and contracts** (or N/A with justification for pure config tasks)
- Every task has **Acceptance criteria** with testable assertions
- Every task that modifies existing code has **Codebase pointers**
- No task contains implementation or test code blocks (interface one-liners are allowed)
- Step 1 is "Read codebase pointers" not "Write the failing test"

**E. Update the output budget.**

Current target: ~120 lines per chunk. With no code blocks, reduce to ~80 lines. Plans are denser.

**F. Update the example in the task structure (the markdown template block).**

Replace the Python example task with a language-neutral example using the new template format.

### `skills/subagent-driven-development/implementer-prompt.md`

**A. Replace `## Before You Begin` and `## Your Job` with three new sections.**

Remove the current `## Before You Begin` (ask questions before starting) and `## Your Job` (implement exactly what task specifies). Replace with:

1. `## Before You Write Any Code` — Hard gate requiring codebase exploration:
   - Read every file listed in Codebase pointers
   - Understand naming conventions, error handling style, test structure, DI approach
   - Read the interfaces/contracts — these are architectural constraints
   - If anything in the task contradicts the codebase, STOP and report NEEDS_CONTEXT

2. `## Writing Tests` — Implementer owns test authorship:
   - Translate each acceptance criterion into test methods
   - Follow test patterns found in the codebase
   - Cover happy path and all edge cases from acceptance criteria
   - Tests must verify behavior, not implementation details
   - Run tests and confirm they FAIL before writing implementation

3. `## Writing Implementation` — Implementer owns code authorship:
   - Write minimal code to pass failing tests
   - Follow patterns observed in the codebase
   - Respect interfaces/contracts from the task — don't change public signatures
   - If a contract feels wrong after reading the codebase, report DONE_WITH_CONCERNS

**B. Add `## When the Plan and Codebase Disagree` section.**

New section establishing the rule: the codebase is truth for HOW, the plan is truth for WHAT.

- Plan naming doesn't match codebase conventions → follow codebase, note deviation
- Plan contract feels wrong after reading codebase → report DONE_WITH_CONCERNS
- Plan uses a pattern not present in codebase → follow plan, note as concern

**C. Update the dispatch validity check headings.**

Old required headings: `## Task Description`, `## Context`, `## Context7 Findings`, `## Before You Begin`, `## Your Job`, `## Code Organization`, `## When You're in Over Your Head`, `## Before Reporting Back: Self-Review`, `## Report Format`

New required headings: `## Task Description`, `## Context`, `## Context7 Findings`, `## Before You Write Any Code`, `## Writing Tests`, `## Writing Implementation`, `## When the Plan and Codebase Disagree`, `## Code Organization`, `## When You're in Over Your Head`, `## Before Reporting Back: Self-Review`, `## Report Format`

**D. Keep all other sections unchanged:** `## Task Description`, `## Context`, `## Context7 Findings`, `## Code Organization`, `## When You're in Over Your Head`, `## Before Reporting Back: Self-Review`, `## Report Format`.

### `skills/subagent-driven-development/SKILL.md`

**A. Add codebase pointer validation to pre-dispatch check.**

Before dispatching an implementer, verify that codebase pointer files still exist (a previous task may have renamed or restructured them). Update stale pointers before dispatch.

**B. Add plan-deviation handling to DONE_WITH_CONCERNS.**

New rule under "Handling Implementer Status" for DONE_WITH_CONCERNS:

> If the concern is a plan-vs-codebase conflict:
>
> 1. Read the implementer's explanation
> 2. If the implementer followed codebase conventions over plan conventions → accept (codebase wins for HOW)
> 3. If the implementer deviated from plan contracts/interfaces → evaluate whether justified. If unclear, ask the human.
> 4. Note accepted deviations so later tasks don't conflict

**C. Update the dispatch template integrity check.**

Update the required headings list for implementer prompts to match the new headings from the implementer-prompt.md changes.

**D. Adjust model tier criteria.**

| Tier     | Current                                  | New                                                                                     |
| -------- | ---------------------------------------- | --------------------------------------------------------------------------------------- |
| Spark    | Highly specific, low-ambiguity plan step | Single-file task with clear acceptance criteria AND a strong codebase pattern to follow |
| Standard | Normal implementation work               | Most tasks — multi-file, codebase reading, pattern matching                             |
| Deep     | Reasoning depth is the bottleneck        | Cross-cutting tasks, architectural judgment, ambiguous acceptance criteria              |

### `skills/subagent-driven-development/spec-reviewer-prompt.md`

**A. Update the verification focus (inline edits within existing "Your Job" section, keep section structure).**

Within the existing "Your Job" section, change these specific instructions:

> Compare the implementation against the task's **acceptance criteria** and **interfaces/contracts**. The implementer chose HOW to build it — verify the WHAT matches.

Change key instructions:

- "Compare actual implementation to requirements line by line" → "Verify each acceptance criterion is satisfied in the actual code"
- "Check for missing pieces they claimed to implement" → "Check for acceptance criteria with no corresponding implementation"
- "Did they build things that weren't requested?" → "Did they build beyond the acceptance criteria and interfaces?"

### `skills/subagent-driven-development/code-quality-reviewer-prompt.md`

**No changes.** The code quality reviewer already reviews code quality independently of plan content. Its prompt and addendum remain unchanged.

### `skills/writing-plans/plan-document-reviewer-prompt.md`

**A. Update "What to Check" table (inline additions, keep existing rows).**

Add new rows (keep all existing rows unchanged):

- **Interfaces:** Every task creating/modifying public APIs must define interfaces/contracts
- **Acceptance Criteria:** Every criterion must be testable (observable behavior, not vague)
- **Codebase Pointers:** Every task modifying existing code must include pointers
- **No Implementation Code:** Reject tasks containing implementation or test code blocks (interface one-liners allowed)

**B. Update "CRITICAL" section.**

Add to the "Look especially hard for" list:

- Tasks that contain full method bodies or test method bodies
- Acceptance criteria that are vague or subjective ("should work well", "clean code")
- Tasks modifying existing files with no codebase pointers

## Concrete Example: Before and After

### Before (current format, from example-plan.md Task 1):

````markdown
### Task 1: Add Shared Tenant Registry Contract In `model`

**Files:**

- Create: `model/src/.../TenantOriginGroupDTO.java`
- Test: `model/src/test/.../TenantOriginGroupDTOTest.java`

- [ ] **Step 1: Write the failing test**
  ```java
  class TenantOriginGroupDTOTest {
      @Test
      void roundTripsJacksonSerialization() {
          var dto = new TenantOriginGroupDTO("https://t.example", 101L, 7L);
          // ... 15+ lines of test code
      }
  }
  ```
- [ ] **Step 2: Run test** ...
- [ ] **Step 3: Write minimal implementation**
  ```java
  public record TenantOriginGroupDTO(String tenantOrigin, Long tenantId, Long groupId)
      implements Serializable {}
  ```
- [ ] **Step 4: Run test** ...
- [ ] **Step 5: Commit** ...
````

### After (new format):

```markdown
### Task 1: Add Shared Tenant Registry Contract In `model`

**Files:**

- Create: `model/src/main/java/.../uaa/TenantOriginGroupDTO.java`
- Test: `model/src/test/java/.../uaa/TenantOriginGroupDTOTest.java`

**Interfaces and contracts:**

- Immutable DTO: `tenantOrigin` (String), `tenantId` (Long), `groupId` (Long)
- Must implement `Serializable`
- Prefer a Java record if the module's Java version supports it

**Acceptance criteria:**

- DTO round-trips through Jackson serialization (serialize → deserialize → equals)
- Two DTOs with same field values are equal
- Two DTOs with different field values are not equal
- `model` module builds and installs locally
- Downstream repos can import the DTO without circular dependencies

**Error handling:** N/A — pure DTO, no fallible operations.

**Verification:**

- Run: `cd model && ./mvnw -q -ntp test`
- Expected: PASS

**Codebase pointers:**

- Check existing DTOs in `model/src/main/java/.../model/` for package conventions and
  whether records are used elsewhere

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit
```

The new task is shorter, contains no speculative code, and gives the implementer clear boundaries within which to make their own engineering decisions.
