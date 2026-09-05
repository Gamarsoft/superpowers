---
name: executing-plans
description: Use to execute an approved plan in the controller when subagent tools are unavailable or the plan explicitly selects controller execution
---

# Executing Plans

## Boundary

Execute a complete, approved implementation plan in the current controller
context. Normal route: use this skill only when the harness exposes no subagent tools.
If subagents are available, route ordinary planned delivery to
`superpowers:subagent-driven-development`. If the plan explicitly selects this skill, honor that override
even when subagents are available.

This is an honest fallback, not simulated SDD. Do not claim fresh implementers, checkpoint reviewers,
typed roles, or independent evidence that did not exist.
The controller performs implementation, TDD, focused verification, rulings,
commits, and self-review sequentially.

**Announce at start:** “I'm using executing-plans to implement this plan in the
controller context.” State whether this is the no-subagent route or an explicit
plan override.

## Preflight

1. Use `superpowers:using-git-worktrees` to create or verify an isolated
   workspace. Never start on main/master without explicit human consent.
2. Read the full plan and approved specification. Require reachable identities
   plus Goal, First delivery boundary, Risk class, Risk triggers, and Verification lanes.
   Require each task's ownership, contract, dependencies,
   acceptance criteria, errors, risk, focused verification, and pointers.
3. For review-required plans, require the Readiness Record to end in `READY`.
4. Resolve the implementation base to a full commit ID. Refuse ambiguous
   unrelated worktree changes.
5. Run `../subagent-driven-development/scripts/sdd-workspace PLAN_FILE` and use
   only its returned plan-scoped directory. Read
   `../subagent-driven-development/references/execution-report.md` completely.

A missing specification, critical plan gap, contradictory readiness record, or
unresolved observable WHAT/protected-authority decision stops before Task 1.
Do not repair product requirements inside execution. Resolve reversible HOW
locally when it preserves the contract; record the ruling, why it is reversible,
and its cost if wrong.

## Controller Task Loop

For each task in dependency order:

1. Execute the task contract, not commentary or illustrative pseudocode.
2. Apply `superpowers:test-driven-development`: capture focused RED evidence,
   implement the minimum coherent change, then capture GREEN evidence.
3. Run the task's focused verification and its stated integration contribution.
   Finishing alone runs the complete repository suite.
4. Self-review the diff against its spec anchors, scope, errors, risk triggers,
   and downstream consumers.
5. Dispose findings with the shared labels below, update the plan-scoped ledger,
   and commit the coherent task result. Record the exact commit and evidence.

Use only:

- `BLOCKING`: proved, causally connected contract or downstream-safety defect;
  fix locally with focused RED/GREEN evidence before continuing.
- `DECISION`: unresolved observable WHAT or protected, destructive, or external
  authority; ask one bounded question and update the contract before continuing.
- `FOLLOW_UP`: real adjacent issue or out-of-bound improvement; record without
  enlarging the task.
- `INVALID`: unsupported, contradicted, already-covered, HOW-only, or preference
  finding; record why it does not apply.

Stop for a repeated verification failure instead of looping. Also stop when a
blocker needs unavailable context or a proposed fix would change approved WHAT.

## Integration and Optional Review

After every task commit, run the plan's affected integration lanes once and
self-review the cumulative implementation-base-to-HEAD range. Do not run the
complete repository suite.

Dispatch one final independent review only when the harness actually exposes a
fresh reviewer and this route was selected by explicit plan override. Use fresh
context, the exact BASE/HEAD range, full spec and plan, report evidence, shared
dispositions, and selected risk profiles. The controller owns fixes; use the
same reviewer for a scoped re-review, and stop on a repeated verification
failure. Do not add task or checkpoint review gates.

For the normal no-subagent route, write exactly:

```text
Reviewer availability: unavailable
Result: NOT RUN
Evidence: The harness exposed no fresh reviewer; controller self-review is not independent review.
```

## Write the Handoff

Require a clean worktree after the final implementation commit. Resolve current
HEAD again and write the plan-scoped `execution-report.md` using the shared
contract. It must name the plan/spec identity, completed tasks, focused and
integration evidence, controller rulings, deviations, follow-ups, remaining
risks, decisions, corrections, reviewer availability/result, implementation
base, and exact implementation HEAD.

Do not change implementation code after recording that HEAD. Announce
`superpowers:finishing-a-development-branch` and pass both the plan and report
paths. Keep the ignored workspace intact; finishing validates the report, runs
the sole complete suite, persists the evidence, and owns integration/cleanup.

## Stop Conditions

Stop without a finishing handoff for:

- missing specification or required plan contract;
- critical plan gap or contradictory readiness evidence;
- unresolved observable WHAT or protected authority;
- ambiguous worktree ownership;
- repeated verification failure; or
- a dirty worktree or HEAD/report mismatch at handoff.

Report the evidence and one bounded next decision. Do not improvise another
workflow, fabricate review coverage, or force through the blocker.
