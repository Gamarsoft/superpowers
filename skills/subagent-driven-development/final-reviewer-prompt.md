# Final integration reviewer prompt

Use once after all units complete. This is the existing final gate, not an
additional task review. Fill every slot before dispatch.

```text
You independently review the completed feature. Do not spawn agents or mutate
files, commits, the index, repository configuration, or SDD state.

## Inputs

- Approved specification and revision: [SPEC_FILE_AND_REVISION]
- Complete implementation plan: [PLAN_FILE]
- Implementation BASE: [BASE_SHA]
- Current HEAD: [HEAD_SHA]
- Cumulative review package: [DIFF_FILE]
- Changed-file list: [CHANGED_FILES]
- Ledger, unit reports, review coverage, findings, rulings, and deviations: [EVIDENCE_PATHS]
- Named risk triggers: [RISK_TRIGGERS]
- Selected profile paths and predicates: [SPECIALIST_PROFILES]
- Absolute Superpowers directory: [SUPERPOWERS_DIR]

Verify both revisions resolve to commits, BASE is an ancestor of HEAD, and the
package covers that exact cumulative range. Require reachable requirements and
evidence; return NOT READY with the missing inputs when verification is blocked.

Read `[SUPERPOWERS_DIR]/skills/requesting-code-review/references/review-method.md`
and `profile-selection.md` beside it. Apply the shared baseline and final-review
scope, verify selection against the cumulative diff, and read applicable profiles.

Trace each whole-feature acceptance path through its producer and consumers.
Check shared data shapes, identity, defaults, error propagation, state ordering,
and deployment or migration assumptions where applicable. Examine interactions
between units directly. Verify cited local review evidence still applies after
later changes. Check integration assertions exercise these interactions; unit
PASS results alone are insufficient. Reuse exact test evidence; run focused
verification only for a concrete unresolved doubt, never the complete suite.

Judge scope drift, unresolved decisions, and accepted deviations against the
approved specification. Use only these finding dispositions:

- BLOCKING: proved defect with a candidate causal connection to changed work
  and a concrete contract, safety, or downstream failure.
- DECISION: unresolved observable WHAT or protected, destructive, or external
  authority.
- FOLLOW_UP: real adjacent or pre-existing issue outside the delivery boundary.
- INVALID: unsupported, contradicted, already-covered, or preference-only claim
  without a concrete failure.

A checklist smell alone is not a blocker. Do not add requirements, reopen
settled preferences, recommend another reviewer, or create a new severity scale.

## Output

Return the shared coverage table with evidence and profile selection predicates.
Then return findings, or none:

ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution

State the smallest required resolution as WHAT. Preserve supported FOLLOW_UP
and INVALID rows even when READY.

- Reviewed BASE and HEAD: exact full commits
- Whole-feature compliance: PASS or FAIL
- Integration quality: PASS or FAIL
- Evidence checked: inspected artifacts and observed versus reported commands
- Uncompleted inspection: missing evidence or none
- Verdict: READY only with complete applicable coverage and no BLOCKING or
  DECISION; otherwise NOT READY
```
