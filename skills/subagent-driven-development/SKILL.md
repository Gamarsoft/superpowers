---
name: subagent-driven-development
description: Use when executing an approved implementation plan with independent agents in the current session
---

# Subagent-Driven Development

## Overview

Execute an approved specification and plan through one controller, fresh
implementers, risk-scaled work units, proof-bearing reviews, and a bounded
correction loop. Preserve decisions and evidence in a plan-scoped ledger so
compaction cannot restart completed work.

**Core principle:** preflight once, batch ordinary work, isolate risky work,
review each work unit once, correct at most twice, and finish with one
integration review.

**Announce at start:** "I'm using subagent-driven-development to implement this plan."

This skill owns implementation orchestration. It does not delegate to
`requesting-code-review` or `receiving-code-review`; their public workflows are
for ad hoc, human, forge, or pre-merge review outside this controller.

## Non-Negotiable Boundaries

- The approved specification governs observable WHAT. The codebase governs
  idiomatic HOW when both can be satisfied.
- One root controller owns every dispatch, ruling, disposition, correction
  round, ledger update, and user interruption.
- Implementers and reviewers do not spawn agents.
- SDD runs focused and integration verification. It does not run the complete repository suite
  and does not delete its workspace. Finishing owns both.
- Do not pause between successful units to ask whether to continue.

Stop only for an unresolved WHAT or protected-authority decision, an unsafe or
unusable workspace, or a supported blocker that survives two corrections.

## Codex Dispatch Contract

Use fresh context for every new implementer and reviewer. On Codex, set
`fork_turns: "none"` and provide the complete role prompt through the referenced
prompt template and artifact paths.

Use these roles when the runtime advertises their exact names:

- normal implementation: `sp_implementer`
- second-round rescue: `sp_implementer_deep`
- task, re-, and final integration review: `sp_reviewer`

Inspect the runtime-advertised role list before dispatch. If the requested role
is absent, omit `agent_type` and dispatch a fresh generic agent with the same
complete prompt. Record the generic fallback in the ledger. Never probe an
unknown role by intentionally making a failing call, and never skip required
implementation or review coverage because a typed role is unavailable.

Other harnesses use their fresh-agent mechanism and the same prompt files.

## Preflight Before Task 1

### 1. Establish the workspace

Use `superpowers:using-git-worktrees` to create or verify an isolated workspace.
Never implement on main/master without explicit human consent. Refuse to begin
when unrelated tracked or untracked changes make ownership ambiguous.

Run `scripts/sdd-workspace PLAN_FILE`. It returns this plan's ignored directory:

```text
<repo-root>/.superpowers/sdd/<plan-basename>/
```

All briefs, reports, review packages, `progress.md`, and
`execution-report.md` for this plan live there. Never read or clean another
plan's directory.

### 2. Validate identity and readiness

Read the plan and specification once. Before dispatch, verify:

- the plan's specification path and approved revision are present and
  reachable;
- Goal, First delivery boundary, Risk class, Risk triggers, and Verification
  lanes are present;
- every task has files/ownership, contracts, dependencies, acceptance criteria,
  error boundaries, risk, focused verification, and codebase pointers;
- a review-required plan's Readiness Record ends in `READY`; and
- the current worktree and implementation base are explicit.

Missing acceptance criteria, an unreachable spec, an unresolved WHAT conflict,
or a contradictory readiness record blocks Task 1. Do not repair product
requirements inside execution; return the conflict to `writing-plans` or the
human authority.

### 3. Create or resume the ledger

The first lines of `<workspace>/progress.md` record:

```markdown
# SDD ledger
Plan: <canonical plan path>
Spec: <canonical spec path>
Spec revision: <approved revision>
Implementation base: <full commit>
Status: preflight | executing | final-review | ready-for-finishing
```

Copy the plan's complete Readiness Record into the ledger. On resume, trust the
ledger and git history over conversation memory. Verify every recorded commit
exists and every completed unit commit is an ancestor of current HEAD; never
redispatch a completed unit. A commit that exists off the current history is
not completed work—stop and restore or reconcile the intended history rather
than duplicating it. A malformed identity or missing commit blocks resume
rather than guessing.

#### Resume by ledger status

| Ledger status | Resume action |
| --- | --- |
| `preflight` | Revalidate identity and the complete preflight table; dispatch nothing until it is complete |
| `executing` / unit `dispatched` | Wait for or message the recorded agent; if unavailable, inspect its report and commits before deciding whether a replacement is necessary |
| unit `review` | Recreate the exact recorded BASE..HEAD package and continue the pending review |
| unit `correction-1` | First reconcile the report and commits; if the correction is complete, continue its pending re-review, otherwise resume only the original implementer |
| unit `correction-2` | First reconcile the report and commits; if the rescue is complete, continue its pending re-review, otherwise resume only the recorded deep rescue |
| `final-review` | Recreate the cumulative package and continue the final review or its recorded correction round |
| `ready-for-finishing` | If no matching `producer-return.md` exists, require a clean worktree, revalidate current HEAD against the report, and invoke finishing. If a matching return exists, archive the old handoff, invalidate the old handoff, preserve the final-review correction count, and resume the recorded final correction instead of invoking finishing again |

Record the current unit, agent identity, BASE, HEAD, report path, open findings,
and correction round before every wait so each resume action is deterministic.

Finishing writes `<workspace>/producer-return.md` when a stale handoff or the
complete suite returns ownership. Match it by failed Implementation HEAD. Before
changing code, copy the old execution report and return marker under
`<workspace>/attempts/<failed-head>/`, change ledger status to `final-review`,
and preserve the final-review correction count. A failed suite consumes the next
correction round; a stale-head mismatch is diagnosed first and consumes a round
only when implementation correction is required. Never reset the budget by
issuing a new handoff. If two final-evidence corrections are already recorded,
stop before a third correction and surface the evidence to the human.

### 4. Write the preflight table

Write one task/self row for every task, one proposed-unit row, and one pairwise
row for every pair that shares a file, interface, or state transition. A “scan
clean” summary is insufficient.

| Field | Required evidence |
| --- | --- |
| Tasks or unit | Ordered task IDs and why they belong together |
| Produces / consumes | Exact shared interfaces, artifacts, or state |
| Files / ownership | Overlap, ordering, and sole mutation owner |
| Spec anchors | Binding sections, names, and approved values |
| Risk | Class and every named trigger, or `none` |
| Verification | Focused tests, integration contribution, final-suite contribution |
| Ruling | Resolution and authority for every conflict or ambiguity |

The task/self row checks that the task's files, inputs, outputs, acceptance,
errors, risk triggers, and verification lane agree with one another and the
specification. Pairwise rows check ordering and shared boundaries between tasks.

Resolve a reversible HOW ambiguity autonomously when it preserves the contract.
Record the choice, why it is reversible, and the cost if wrong. Ask one bounded
human question only when the answer changes observable WHAT or acceptance,
controls money/authorization/security/privacy, authorizes destructive or
external action, or chooses after the correction breaker trips.

If the approved specification already resolves an apparent WHAT conflict,
record that ruling and correct the plan through its readiness owner before Task
1. Do not ask the human to repeat an existing decision.

## Form Work Units

Apply the plan's risk predicate exactly:

| Work | Unit and review cadence |
| --- | --- |
| Money, authorization, security, privacy, migration, destructive behavior, concurrency, idempotency, retry/recovery, public or cross-system contract, multi-owner invariant, or explicit user-requested review | Review-required tasks remain individual and are reviewed before downstream consumption |
| Same-shaped, independent mechanical edits | One ordinary checkpoint unit when files and interfaces are disjoint |
| Other compatible checkpoint work | One coherent ordered unit, normally no more than three tasks |

Do not add a separate reviewer for each task inside an ordinary unit. Split a
unit when tasks share mutable files without one owner, require different risk
cadence, or cannot be verified coherently.

Record the final ordered units and reasons in the ledger before dispatch.

## Work-Unit Loop

### 1. Build the brief

Record the unit BASE with `git rev-parse HEAD`. Run:

```text
scripts/task-brief PLAN_FILE TASK_NUMBER [TASK_NUMBER ...]
```

The generated brief contains plan context, TDD mechanics, and only the ordered
tasks in this unit. Pass its path to `implementer-prompt.md` with:

- the unit's role in the first delivery boundary;
- exact relevant spec anchors and prior interface decisions;
- task-relevant Context7 findings or explicit `NONE`;
- the implementer report path; and
- the workspace path.

Do not paste the full plan, session history, or unrelated completed-task
summaries. Record the agent identity and dispatch mode in the ledger.

### 2. Wait for the implementer

Use the harness's event wait, selecting the longest host-compatible bounded wait
that still permits periodic user updates. On an unchanged timeout, create no
new work, dispatch, speculation, or narration; wait again with backoff. Resume
or message the existing agent when it asks a question—do not replace it merely
because it is slow.

### 3. Handle implementation status

- `DONE`: verify report and commits, then review.
- `NEEDS_DECISION`: apply the authority boundary above. Reversible HOW is ruled
  by the controller; unresolved WHAT/protected authority gets one user question.
- `BLOCKED`: provide genuinely missing context or stop. Do not blindly retry.

Every implementer report contains RED/GREEN evidence, focused/integration
results, commits, files, reversible rulings with cost if wrong, deviations,
follow-ups, and residual risk. The implementer never changes the approved WHAT
silently.

### 4. Review the unit

Record HEAD and run:

```text
scripts/review-package PLAN_FILE BASE HEAD
```

Pass the brief, implementer report, recorded BASE/HEAD, package, relevant spec
anchors, selected specialist profiles, and existing rulings to one fresh
reviewer using `task-reviewer-prompt.md`. If the plan selects specialist
profiles, pass their exact instruction paths and require the reviewer to read
them before judging the applicable surface. For Java, Spring, persistence,
container, Kubernetes, Helm, GKE, or runtime changes, also pass
`../requesting-code-review/references/java-21-spring-gke-checklist.md` unless a
selected profile supersedes it. Reviewers inspect evidence; they do not repeat
tests whose exact commands/results are already in the report. One unit gets
one review gate before correction. Implementer self-review does not replace it.

### 5. Dispose every finding

Use only these labels:

| Disposition | Controller action |
| --- | --- |
| `BLOCKING` | Correct a proved defect that can violate the approved contract or downstream safety and has a candidate causal connection to changed work |
| `DECISION` | Ask once for unresolved observable WHAT, protected, destructive, or external authority; update the contract before correction |
| `FOLLOW_UP` | Preserve a real adjacent issue, pre-existing defect, or out-of-bound improvement without enlarging this unit |
| `INVALID` | Record why an unsupported, contradicted, already-covered, HOW-only, or preference finding does not apply |

Every `BLOCKING` or `DECISION` entry needs proof, location, candidate causal
connection, concrete failure, and required resolution. A real adjacent defect
without that connection is `FOLLOW_UP`, not a blocker. Scope suggestions such
as optimizing a bounded ten-item scan or imposing a new ASCII-only policy stay
`FOLLOW_UP` unless the approved specification makes them requirements.

Record all four dispositions continuously; do not wait for an end-of-run rollup.
Do not dispatch a second reviewer to seek a different answer.

### 6. Correct at most twice

If no supported `BLOCKING` or unresolved `DECISION` remains, mark the unit
complete and continue.

- Round one returns to the original implementer with the exact findings. Record
  the fix base first. The implementer appends correction evidence to the
  existing report, runs focused verification, commits without rewriting prior
  history, and returns status. Build a fresh fix-range package and re-review
  only those findings and that fix.
- Round two dispatches one deep rescue implementer with the brief, append-only
  report, findings, both ranges, and rulings. The rescue runs focused
  verification, commits without amending prior history, and appends its result.
  Re-review only the surviving findings and rescue diff.
- If a supported load-bearing finding remains, stop before round three. Show the
  human the open finding, proof, both attempted fixes, tests, and architectural
  conflict. Do not start another implementation or review lane.

Use `re-review-prompt.md` for both scoped re-reviews. A new defect introduced by
the fix may be `BLOCKING` when it meets the same proof/causality rule; unrelated
observations become `FOLLOW_UP` and cannot extend the correction loop. Pass the
same selected specialist profiles and applicable Java/Spring/GKE checklist used
for the unit's initial review.

## Final Integration Review

After all units are complete, dispatch one fresh `sp_reviewer` (or the generic
fallback) over:

- the full specification and plan;
- implementation base and current HEAD;
- the complete cumulative diff package;
- the ledger, unit reports, rulings, dispositions, and accepted deviations; and
- focused and integration evidence already produced.

Pass the plan's selected specialist profiles and the applicable
`../requesting-code-review/references/java-21-spring-gke-checklist.md` to this
reviewer under the same rule as unit review.

The reviewer checks whole-feature acceptance, cross-task producer/consumer
contracts, scope drift, unresolved decisions, migration/destructive safety, and
whether evidence supports the claims. It does not redo every task review or run
the complete repository suite. Final-review corrections use the same two-round
breaker and shared dispositions.

When the final review is `READY`, require a clean worktree, revalidate current HEAD
equals the reviewer's recorded HEAD, and only then record the exact
implementation HEAD in the ledger. Read
`references/execution-report.md` completely and write
`<workspace>/execution-report.md` to that shared schema. Include completed
individual tasks and checkpoint batches, every correction range, and the final
review's exact evidence. The report binds the exact implementation HEAD.
Set `Final-evidence correction count` to the ledger's explicit final-review
counter; task- or unit-level corrections do not contribute to this field.

When replacing a handoff after a producer return, archive the prior report and
marker as described above before writing the new report. The new handoff must
name a new reviewed Implementation HEAD; finishing never retries a failed suite
against the same implementation revision.

Set ledger status to `ready-for-finishing`. Do not change implementation code
after recording the implementation HEAD. Invoke
`superpowers:finishing-a-development-branch` with the plan and report paths.
Keep the workspace intact: finishing validates the report, owns the sole
complete-suite run, preserves durable evidence, and performs safe cleanup.

## Red Flags

Never:

- dispatch before the auditable preflight is complete;
- use conversation memory as the progress ledger;
- infer a review range from the latest commit;
- create one implementer/reviewer pair per ordinary mechanical task;
- classify review comments on a second severity scale;
- treat follow-ups as blockers or silently drop invalid findings;
- run a third correction round;
- run the complete suite inside SDD; or
- delete ignored SDD state before finishing accepts it.
