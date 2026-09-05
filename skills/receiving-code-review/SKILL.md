---
name: receiving-code-review
description: Use when receiving human, forge, or out-of-band review feedback before changing code
---

# Receiving Code Review

## Boundary

Handle human, forge, or out-of-band findings. This skill verifies external
feedback before mutation; it does not own SDD review or consume the internal
results of an active controller.

**Core principle:** understand, verify, dispose, then act.

## Process

1. Read the complete feedback and identify the requirements/range it claims to
   review.
2. Restate unclear items as precise technical questions before implementing any
   dependent item.
3. Verify each finding before action against the current code, tests, approved
   requirements, compatibility constraints, and exact diff when available.
4. Assign one disposition and record proof.
5. Resolve authority, then implement accepted in-scope fixes one at a time with
   focused tests.

Use only:

- `BLOCKING`: verified defect in the reviewed change that violates the approved
  contract or safety boundary.
- `DECISION`: feedback conflicts with or leaves open observable WHAT, protected,
  destructive, or external authority.
- `FOLLOW_UP`: verified adjacent issue outside the current delivery boundary.
- `INVALID`: technically unsupported, contradicted by evidence, already fixed,
  or preference-only feedback.

For `BLOCKING`, record the code/test evidence and fix before integration. For
`DECISION`, ask the owning human authority one bounded question; do not silently
reinterpret the requirement. Preserve `FOLLOW_UP` without expanding the patch.
Respond to `INVALID` with the evidence that disproves it.

## Source Handling

- An explicit human product decision governs desired WHAT, but technical claims
  about the current implementation still need verification.
- Forge comments and external reviewers may lack local context; check current
  behavior, compatibility, platform/version support, and prior decisions.
- If evidence is inaccessible, say what cannot be verified and ask whether to
  investigate. Do not implement on guesswork.

Feedback does not authorize pushing, publishing, merging, deleting data, or
other external/destructive action unless the human explicitly grants that
authority.

## Applying Accepted Fixes

Clarify interdependent items first. Then fix verified blockers in causal order:

1. add or identify a focused failing test;
2. confirm the failure represents the finding;
3. make the minimum in-scope correction;
4. run focused and affected integration tests; and
5. report the disposition, changed location, and evidence.

Do not mix unrelated follow-ups into the same patch. If a fix exposes an
architectural choice, return it as `DECISION` instead of improvising.

## Communication

Use technical acknowledgments, not performative agreement. Good responses are
“Verified at `file:line`; fixed by …” or “`INVALID`: the compatibility test at
… proves …”. When replying to an inline forge comment, reply in that thread
rather than creating an unrelated top-level comment.
