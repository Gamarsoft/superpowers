# Execution Report Contract

SDD and `executing-plans` produce the same plan-scoped handoff. Keep the live
report at `<workspace>/execution-report.md`, where `<workspace>` is returned by
`scripts/sdd-workspace PLAN_FILE`.

Write the report only after all implementation commits and required focused and
integration verification are complete. Require a clean worktree, resolve
current HEAD to a full commit ID, and record that value as Implementation HEAD.
Any later implementation change makes the report stale and returns ownership to
the producer before finishing may run.

Use this schema; write `none` rather than omitting an empty section:

```markdown
# Execution report

Status: ready-for-finishing
Producer: subagent-driven-development | executing-plans
Plan: <canonical path>
Spec: <canonical path>
Spec revision: <approved revision or immutable identifier>
Implementation base: <full commit ID>
Implementation HEAD: <full commit ID>

## Completed work

<task and work-unit IDs, outcomes, files, and commits>

## Focused verification

<exact commands, results, and associated tasks>

## Integration verification

<exact commands and results; not the complete repository suite>

## Controller rulings

<reversible HOW rulings, reasons, and cost if wrong>

## Deviations

<accepted in-scope deviations and proof they preserve the contract>

## Follow-ups

<every FOLLOW_UP disposition and evidence>

## Remaining risks

<known residual risk and mitigation>

## Decisions

<resolved DECISION entries and authority; no unresolved entry is allowed>

## Corrections

<rounds, ranges, findings, and verification, or none>

## Independent review

Reviewer availability: available | unavailable
Result: READY | NOT RUN
Evidence: <reviewed range and verdict, or why no independent reviewer existed>
```

`READY` requires no supported `BLOCKING` or unresolved `DECISION`. `NOT RUN` is
valid only for the honest no-subagent fallback; never describe controller
self-review as independent review.

Finishing appends the sole complete-suite evidence and durable report-copy
metadata. Producers do not run the complete repository suite, copy this report
into tracked documentation, or remove the ignored workspace.
