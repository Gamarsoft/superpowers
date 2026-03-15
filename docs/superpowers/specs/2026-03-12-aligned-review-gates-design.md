# Aligned Review Gates

Eliminate circular conflicts between spec and code-quality reviewers in subagent-driven development.

## Problem

The current two-stage review (spec compliance → code quality) creates deadlocks. The spec reviewer enforces "nothing more, nothing less" against the plan. The code quality reviewer enforces production standards. When these conflict — validation, security boundaries, error handling — the implementer is caught between them with no resolution mechanism.

Example: Plan says "skip invalid origins." Implementer adds HTTPS validation (security best practice). Spec reviewer blocks it as "extra work." Implementer removes it. Code quality reviewer flags the missing validation as a security issue. The snake bites its tail.

Root causes:

1. Plans don't pre-resolve boundary decisions that sit between "what to build" and "how to build it safely"
2. Spec reviewer can't distinguish scope creep from legitimate safety improvements
3. Code quality reviewer re-litigates decisions the plan already made
4. No cross-task memory of resolved trade-offs
5. Review re-dispatches re-examine the whole task instead of the fixes

## Approach: Aligned Gates

Fix at both layers: plans pre-resolve boundary decisions, and both reviewers share the same source of truth for those decisions. Add a decision log so resolved trade-offs carry across tasks.

## 1. Plan-Level: Error Handling & Boundaries

Plans gain a per-task **"Error handling"** section alongside acceptance criteria. The plan writer pre-resolves ambiguous safety and validation decisions for every task that touches input boundaries, external data, or error paths.

**What it covers:**

- Input validation: rejected vs. skipped vs. accepted
- Error strategy: fail fast, degrade gracefully, skip and log
- Security boundaries: which inputs are sanitized and how strictly
- Edge-case policy: nulls, empty collections, malformed data

**Format (inside each task):**

```markdown
**Error handling:**

- Invalid minisite origins: skip from response (do NOT reject the request)
- Blank origins: omit silently, no error log
- Migration: fail fast if any parking cannot be assigned a group
```

The plan writer draws from the spec's error handling section plus their own judgment about the task's boundary surface. Tasks with no boundary surface mark it `N/A`.

The plan-document-reviewer checks that every task has either an "Error handling" section with concrete decisions or an explicit `N/A`.

## 2. Spec Reviewer: Complementing vs. Contradicting

The spec reviewer's mandate changes from "nothing more, nothing less" to "everything requested, plus reasonable production safety that doesn't contradict the spec."

Extra work falls into two categories:

**Contradicting extras** — work that violates acceptance criteria or changes specified behavior (plan says "skip invalid," implementer rejects instead). Flagged as a spec issue.

**Complementing extras** — work that protects the implementation without changing specified behavior (null checks, input sanitization, logging, defensive validation that doesn't alter control flow). Accepted silently.

**Litmus test:** "Does this extra work change the behavior described in acceptance criteria?" No → complementing. Yes → contradicting.

When the task includes an "Error handling" section, the spec reviewer treats those decisions as additional acceptance criteria. Contradicting them is a spec issue. Adding safety beyond them is complementing.

**Volume guard:** If complementing additions substantially increase implementation surface area (e.g., extensive logging framework, defensive copies everywhere), the spec reviewer notes them in the report so the orchestrator can spot gold-plating patterns — but does not block approval on individual extras.

## 3. Code Quality Reviewer: Respect Documented Decisions

The code quality reviewer gains one constraint: do not flag issues that the plan's "Error handling" section or acceptance criteria explicitly resolved.

**Example:** Plan says "skip invalid origins." Implementer skips them. Quality reviewer reads the error handling section, sees the decision was explicit, does not flag it as missing input validation.

**What the quality reviewer CAN still flag:**

- Bugs in how a boundary decision was carried out (null pointer in the skip logic)
- Missing boundary handling for surfaces the plan's error handling section didn't cover
- General code quality: naming, DRY, SOLID, test coverage, architecture
- Security issues unrelated to documented boundary decisions

**Litmus test:** "Is this a quality issue with HOW the code is written, or a disagreement with WHAT the plan decided?" If the latter, it's a plan decision — not a review finding.

## 4. Decision Log & Structured DONE_WITH_CONCERNS

### Decision Log

The orchestrator maintains a lightweight decision log across tasks in working memory (not a file). It captures deviations accepted and boundary decisions resolved at runtime.

**What goes in:**

- Accepted DONE_WITH_CONCERNS deviations with reasoning
- Complementing extras noted by spec reviewer
- Codebase-wins-over-plan decisions
- Plan ambiguities resolved at runtime

**What stays out:**

- Routine implementation details
- Review findings that were fixed normally

**How it's used:**

- Passed to each subsequent implementer in the `## Context` section as "Decisions from prior tasks"
- Passed to both reviewers so they don't re-litigate settled decisions

**Filtering heuristic:** Include only entries that share an interface surface or boundary concern with the current task. Do not dump the full log into every dispatch.

### Structured DONE_WITH_CONCERNS

Implementers report concerns with a category:

| Category          | Meaning                            | Orchestrator Action                                                  |
| ----------------- | ---------------------------------- | -------------------------------------------------------------------- |
| `SAFETY_ADDITION` | Added safety not in plan           | Accept if it doesn't contradict acceptance criteria. Log it.         |
| `PLAN_DEVIATION`  | Deviated from plan contracts       | If codebase-wins-HOW, accept and log. If it changes WHAT, ask human. |
| `SCOPE_QUESTION`  | Unsure if something is in scope    | Answer the question, re-dispatch if needed.                          |
| `OBSERVATION`     | Something noteworthy, not blocking | Note it, proceed to review.                                          |

Accepted additions go into the decision log and are communicated to both reviewers for that task.

## 5. Review Cost Reduction

### Reviewer Context

Both reviewers receive an **"Accepted decisions for this task"** section in their dispatch:

- DONE_WITH_CONCERNS items the orchestrator accepted before dispatching the reviewer
- Relevant decision log entries from prior tasks

Reviewers treat accepted decisions as part of the spec — they're settled, not surprises.

### Scoped Re-Reviews

When re-dispatching a reviewer after implementer fixes, the orchestrator includes:

- The original review findings
- What the implementer changed to address them
- Instruction: "Verify the fixes address the original findings. Do not raise new issues on code already reviewed and approved in the previous pass, unless the fix introduced a regression."

This scopes re-reviews to the delta, not the whole task.

## Files Changed

| File                                                                 | Change                                                                                                                                       |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `skills/writing-plans/SKILL.md`                                      | Add "Error handling" as a required per-task section                                                                                          |
| `skills/writing-plans/plan-document-reviewer-prompt.md`              | Check that boundary-touching tasks have error handling section                                                                               |
| `skills/subagent-driven-development/SKILL.md`                        | Add decision log protocol, structured DONE_WITH_CONCERNS categories, accepted-decisions context for reviewers, scoped re-review instructions |
| `skills/subagent-driven-development/spec-reviewer-prompt.md`         | Change "nothing more, nothing less" to complementing/contradicting rule                                                                      |
| `skills/subagent-driven-development/code-quality-reviewer-prompt.md` | Add plan-aware constraint (respect documented boundary decisions)                                                                            |
| `skills/subagent-driven-development/implementer-prompt.md`           | Add DONE_WITH_CONCERNS categories to report format                                                                                           |

## Non-Goals

- Merging spec and quality reviewers into one (keeps separation of concerns)
- Adding a third review phase (pre-implementation gap analysis)
- Cross-task shared memory beyond the decision log
- Changing the sequential dispatch model
- Changing the implementer's engineering authority (still flags, orchestrator decides)
