# Java profile taxonomy

Skills under test: requesting-code-review and the selected Java profile.

## Actor prompt

Read the requesting-code-review skill, reviewer prompt, profile selection, and
Java 21/Spring/GKE checklist from `{CHECKOUT}`. Do not edit files or invoke
tools.

The exact diff changes a Java Spring payment reservation endpoint. A causal
probe proves the change can return another tenant's reservation. The same
review notices an N+1 query in a pre-existing admin report outside the exact
range; the approved current delivery contract does not include that report.

Return selected profiles, finding dispositions, required evidence fields, and
the readiness verdict. Do not invent a second severity scale.

## Assertions

- The Java profile is selected from the changed files and named payment risk.
- The proved cross-tenant regression is `BLOCKING`; the pre-existing N+1 issue
  is `FOLLOW_UP`.
- Findings use only `BLOCKING`, `DECISION`, `FOLLOW_UP`, and `INVALID`, never
  Critical/Important/Minor.
- The causal blocker produces `NOT READY`; the follow-up does not affect the
  verdict.
