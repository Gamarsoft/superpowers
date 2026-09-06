# Scoped Correction Re-Review Prompt

Use after correction round one or two. It verifies the open findings and the
fix diff; it is not another broad review.

```text
You are re-reviewing correction round [ROUND] for work unit [UNIT_ID]. Do not spawn subagents.
This is read-only: do not edit files, commits, or artifacts.

## Inputs

- Work-unit brief: [BRIEF_FILE]
- Open findings exactly as previously reported: [OPEN_FINDINGS]
- Implementer report with appended correction evidence: [REPORT_FILE]
- Fix range [FIX_BASE_SHA]..[HEAD_SHA]: [DIFF_FILE]
- Prior review coverage and reviewed range: [PRIOR_COVERAGE]
- Existing controller rulings: [RULINGS]
- Named risk triggers: [RISK_TRIGGERS]
- Selected specialist profiles, predicates, and instruction paths: [SPECIALIST_PROFILES]
- Absolute Superpowers directory: [SUPERPOWERS_DIR]

Read the fix diff and verdict every open finding. Confirm the report names the
focused tests and shows results, but do not repeat those tests unless a specific
new doubt has no evidence. Never run a broad or complete suite.

Read `[SUPERPOWERS_DIR]/skills/requesting-code-review/references/review-method.md`
and apply its correction scope and coverage output. Re-evaluate
`profile-selection.md` beside it against the fix diff and named risks; retain
applicable prior profiles and read any newly applicable checklist. Trace affected
dependencies only as needed to verify the correction and fix-introduced defects.

Inspect only the open findings and code changed in the fix diff. A new issue can
block only when the fix introduced it and you can provide proof, a candidate
causal connection, and a concrete failure. The implementer need not have
disclosed the regression first. Real observations outside that scope are
`FOLLOW_UP`; they do not extend this correction loop.

Use only `BLOCKING`, `DECISION`, `FOLLOW_UP`, and `INVALID`.

## Output

Return scoped coverage with evidence and references to unaffected prior coverage.
Then for each prior finding:

ID | ADDRESSED or OPEN | Disposition | File:line proof | Test evidence

Then list any fix-introduced finding with:

ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution

End with `READY` when applicable fix coverage is complete and no supported
`BLOCKING` or `DECISION` remains, otherwise
`NOT READY`. Do not broaden the review or recommend another reviewer.
```
