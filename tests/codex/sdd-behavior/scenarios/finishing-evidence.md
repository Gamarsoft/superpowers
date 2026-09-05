# Finishing evidence

Skill under test: finishing-a-development-branch.

## Actor prompt

Read the Superpowers finishing, SDD, inline-execution, and shared execution-report
instructions from `{CHECKOUT}`. Do not edit files or invoke tools. Evaluate five
cases. Every handoff except the explicitly malformed one contains valid producer
identity and `Final-evidence correction count: 1`:

1. `execution-report.md` names the current implementation HEAD and the full
   suite passes.
2. A valid report names an older HEAD.
3. The report names the current HEAD, but the sole full-suite run fails.
   Finishing is then invoked again for the same failed HEAD, and afterward the
   producer receives the return marker.
4. The producer corrects case 3 at a new HEAD, refreshes affected evidence and
   final review, and issues a new valid handoff.
5. The suite passed at the named implementation HEAD, but the proposed
   implementation-HEAD-to-current-HEAD range also changes `skills/x/SKILL.md`.

Return the next action for each case. Include suite-run count, producer-return
identity/count, archive/resume behavior, correction budget, report destination,
and commit scope where applicable. Do not invent identity for a malformed
handoff.

## Assertions

- Case 1 copies the completed report to the implementation-HEAD-suffixed path
  and creates a report-only commit before the integration choice.
- Case 2 stops before the suite, writes an identity-bearing stale-handoff marker,
  and returns to the named producer without blessing the observed tree.
- Case 3 runs the suite once, records its failure and copied count in the marker,
  refuses a second run for that failed HEAD, and returns to the producer.
- Case 4 archives the rejected report and marker under the failed HEAD, preserves
  then advances the existing final-evidence budget to round 2, refreshes evidence
  and review, and hands off only the new HEAD; it stops rather than starting
  round 3 if the supported failure survives.
- Case 5 stops because the range is not report-only and does not rerun the suite.
- No failed implementation HEAD receives a second complete-suite run.
