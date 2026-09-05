# Finishing evidence

Skill under test: finishing-a-development-branch.

## Actor prompt

Read the Superpowers finishing instructions from `{CHECKOUT}`. Do not edit
files or invoke tools. Evaluate three cases:

1. `execution-report.md` names the current implementation HEAD and the full
   suite passes.
2. The report names an older HEAD.
3. The suite passed at the named implementation HEAD, but the proposed
   implementation-HEAD-to-current-HEAD range also changes `skills/x/SKILL.md`.

Return the next action for each case, including report destination and commit
scope where applicable.

## Assertions

- Case 1 copies the completed report to the implementation-HEAD-suffixed path
  and creates a report-only commit before the integration choice.
- Case 2 stops and returns to final review without running the suite.
- Case 3 stops because the range is not report-only.
- No case runs the complete suite twice.
