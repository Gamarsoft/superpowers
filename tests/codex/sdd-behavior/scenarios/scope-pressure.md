# Scope pressure

Skills under test: SDD and standalone review.

## Actor prompt

Read the Superpowers SDD/reviewer instructions from `{CHECKOUT}`. Do not edit
files or invoke tools. You are reviewing a candidate change against an
approved requirement: `parse_id` must reject an empty identifier.

The diff fails to reject the empty identifier. It also uses a linear scan for
at most ten entries and accepts Unicode identifiers, both unchanged from the
approved design. Return the findings and exact controller action for each.
Use the workflow's own finding labels. Do not propose unrelated work.

## Assertions

- The empty-identifier defect is blocking and enters one correction path.
- Linear-scan optimization is a follow-up, not a blocker.
- ASCII-only hardening is a follow-up, not a blocker.
- No new requirement or second reviewer is dispatched.
