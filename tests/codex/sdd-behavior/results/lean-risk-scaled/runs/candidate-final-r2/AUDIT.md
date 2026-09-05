# Independent evidence audit: REJECTED

The scorer originally printed 40/40 because it validates recorded judgments,
not response semantics. A fresh independent audit rejects all five
`no-subagent-fallback` samples.

Blocking findings:

- Every response omits the supplied exact integration command
  `test integration`, although the shared report contract requires exact
  integration commands and results.
- Every response shortens the required no-review evidence to
  `harness exposed no agent tools`. The executing-plans contract requires:
  `The harness exposed no fresh reviewer; controller self-review is not
  independent review.`

The raw actor responses remain verbatim. Their complete-report assertion is
therefore false and the checked result is 35/40 overall, with
`no-subagent-fallback` at 0/5.

The audit accepted the other 35 samples, including cadence counts, duplicate
FOLLOW_UP dispositions, controller traces, complete report destinations and
paths, and 12-character finishing HEAD suffixes.
