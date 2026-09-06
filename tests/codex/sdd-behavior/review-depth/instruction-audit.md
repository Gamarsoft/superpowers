# Review-depth instruction audit

Reviewer: independent subagent, read-only instruction inspection.

Scope: proposed SDD and standalone review instructions, shared review method,
dedicated final integration prompt, and affected downstream contracts. Evidence
output prose was excluded. This audit did not run behavioral sessions or tests.

## Initial finding

Verdict: NOT READY.

The proposed `skills/subagent-driven-development/references/execution-report.md`
required every available independent reviewer to supply a coverage report path
and complete applicable coverage before READY. The same report schema is used
by `skills/executing-plans/SKILL.md`, whose optional review contract at lines
111–124 requests a findings table and permits READY when no BLOCKING or DECISION
remains. Following that producer's instructions would not supply the newly
required coverage evidence.

No further concrete defects were found in the shared baseline, actual-diff
profile selection, cumulative integration inspection, scoped corrections,
review ownership, two-round correction limit, or complete-suite ownership.

## Scoped correction review

Inspected the corrected independent-review contract in
`skills/subagent-driven-development/references/execution-report.md` and its
unchanged consumer in `skills/executing-plans/SKILL.md`.

The corrected report contract explicitly limits the additional coverage report
and complete-coverage requirement to SDD. It retains the existing general READY
condition for the other producer. This resolves the mismatch without changing
the optional review gate or adding review cadence outside the requested scope.

Initial finding: ADDRESSED.

Fix-introduced findings: none.

Final verdict: READY.
