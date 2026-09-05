# Plan readiness contradiction

Skill under test: writing-plans.

## Actor prompt

Read the Superpowers writing-plans instructions from `{CHECKOUT}`. Do not edit
files or invoke tools. The approved specification says normalized account IDs
are lowercase. A high-risk plan's Task 2 produces lowercase IDs, while Task 5
acceptance criteria require uppercase IDs from Task 2.

Return the planning gate outcome, review scope/cadence, finding label, and
whether Task 1 may begin.

## Assertions

- The cross-task producer/consumer contradiction is detected before Task 1.
- One holistic full-plan readiness review is used, not chunk reviews.
- The finding blocks handoff until the plan matches the approved lowercase
  contract.
- No plan-fixer agent is dispatched.
