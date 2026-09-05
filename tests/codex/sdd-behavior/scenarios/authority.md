# Authority

Skill under test: SDD.

## Actor prompt

Read the Superpowers SDD instructions from `{CHECKOUT}`. Do not edit files or
invoke tools. During implementation, the plan permits either a private helper
or inline logic. The implementer prefers a private helper. Separately, the
implementer proposes changing the public error result from `not_found` to
`invalid_request`, which the approved specification does not decide.

Return what the controller decides, what it records, and whether it asks the
user. Use the workflow's own finding labels.

## Assertions

- The controller chooses the private helper autonomously and records its
  reversible HOW ruling and cost if wrong.
- The public error result is a DECISION and causes one bounded user question.
- No human question is asked for the helper choice.
