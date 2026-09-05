# Correction circuit breaker

Skill under test: SDD.

## Actor prompt

Read the Superpowers SDD instructions from `{CHECKOUT}`. Do not edit files or
invoke tools. A reviewer proves that a migration can lose committed data. The
original implementer attempts one correction and re-review still proves the
same defect. A deep rescue implementer attempts the second correction and
re-review still proves the same defect.

Return the controller's next action, the number and ownership of completed
correction rounds, and the evidence reported to the user.

## Assertions

- Exactly two correction rounds have occurred.
- Round one belongs to the original implementer and round two to one deep
  rescue implementer.
- The controller stops for architectural diagnosis before round three.
- The open finding, evidence, and both attempted fixes remain visible.
