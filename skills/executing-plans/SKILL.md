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

The ledger records a correction count for the current task or final-evidence
gate. A supported blocker or failed focused verification gets at most two correction plus re-review rounds: correct with focused RED/GREEN evidence, then
self-review the affected contract (or use the selected final reviewer below).
If it survives round two, stop before a third correction and report the
architectural conflict. Starting another task or renaming the gate does not
reset this budget.

Use only:

- `BLOCKING`: proved, causally connected contract or downstream-safety defect;
  fix locally with focused RED/GREEN evidence before continuing.
- `DECISION`: unresolved observable WHAT or protected, destructive, or external
  authority; ask one bounded question and update the contract before continuing.
- `FOLLOW_UP`: real adjacent issue or out-of-bound improvement; record without
  enlarging the task.
- `INVALID`: unsupported, contradicted, already-covered, HOW-only, or preference
  finding; record why it does not apply.

Stop for a repeated verification failure according to that correction budget.
Also stop when a blocker needs unavailable context or a proposed fix would
change approved WHAT.

## Integration and Optional Review

After every task commit, run the plan's affected integration lanes once and
self-review the cumulative implementation-base-to-HEAD range. Do not run the
complete repository suite.

Dispatch one final independent review only when this route was selected by
explicit plan override and the harness exposes agent tools.
Inspect the runtime-advertised role list before dispatch. On Codex:

- when `sp_reviewer` is available, dispatch a fresh reviewer with
  `agent_type: "sp_reviewer"` and `fork_turns: "none"`;
- otherwise, omit `agent_type` and dispatch a fresh generic reviewer. Use the
  identical complete review prompt and `fork_turns: "none"`.

Do not skip this review because `sp_reviewer` is absent. Do not probe an
unknown role with a failing call. The complete prompt must state: "Do not spawn subagents."
It must also make the review read-only: no file, index, commit, branch, or
plan-scoped workspace changes. Populate it with:

- the full approved specification and plan;
- the exact implementation BASE and HEAD, plus the complete cumulative
  `BASE..HEAD` review package;
- the plan-scoped ledger, task evidence, controller rulings and dispositions,
  accepted deviations, and selected risk profiles;
- focused and integration evidence; and
- the shared `BLOCKING`, `DECISION`, `FOLLOW_UP`, and `INVALID` definitions,
  proof and candidate causal connection requirements, and the
  exact verdict/report contract.

The exact verdict/report contract is one compact table:

`ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution`

Then require:

- Spec compliance: `PASS` or `FAIL`
- Change quality: `PASS` or `FAIL`
- Evidence checked: exact commands and artifacts
- Verdict: `READY` only when no `BLOCKING` or `DECISION` remains; otherwise
  `NOT READY`

Require `FOLLOW_UP` and `INVALID` rows even when the verdict is `READY`.

The reviewer checks whole-feature acceptance and cross-task contracts without
running the complete repository suite. The controller owns fixes; use the same
reviewer for a scoped re-review, and stop on a repeated verification failure.
Do not add task or checkpoint review gates.

On resume, inspect `<workspace>/producer-return.md` before trusting an existing
`ready-for-finishing` report. When the marker matches that report's failed
Implementation HEAD, archive both under `<workspace>/attempts/<failed-head>/`,
invalidate the old handoff, resume the final-evidence gate, and preserve the existing final-evidence correction count. A failed complete suite consumes the
next round; a stale mismatch consumes one only when code correction is needed.
Refresh affected evidence and optional review before issuing a new handoff at a
new Implementation HEAD. Stop before round three.

When the harness exposes no agent tools, do not dispatch a reviewer. For the
normal no-subagent route, write exactly:

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
base, exact implementation HEAD, and the explicit
`Final-evidence correction count`. Task-local correction counts do not
contribute to that final-evidence field.

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
