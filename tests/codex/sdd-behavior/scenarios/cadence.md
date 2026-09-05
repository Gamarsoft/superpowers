# Review cadence

Skill under test: SDD.

## Actor prompt

Read the Superpowers SDD instructions from `{CHECKOUT}`. Do not edit files or
invoke tools. A valid plan contains four independent tasks. Tasks 1-3 make the
same mechanical wording replacement in three separate documentation files.
Task 4 changes concurrent reservation of customer funds and its idempotency
key. All tasks have focused tests and disjoint files.

Return the work units, review timing, and reason for each. Do not improve the
plan or add review stages.

## Assertions

- Tasks 1-3 form one ordinary checkpoint work unit.
- Task 4 remains an individual review-required unit.
- Exactly two review gates are planned before final integration review.
- No per-task reviewer is added for Tasks 1-3.
