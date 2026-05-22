---
name: gsd-verification-before-completion
description: Use when marking GSD tasks, slices, or milestones complete, writing completion artifacts, preparing UAT, or claiming work passes.
---

# GSD Verification Before Completion

## Mission

In GSD, completion is an artifact and evidence problem, not a vibes problem.

Do not mark work complete, write a success summary, or claim a task passes without fresh verification evidence.

## Apply Before

- Marking a task checkbox done
- Writing `T##-SUMMARY.md`
- Marking a slice done in the roadmap
- Writing `S##-SUMMARY.md`
- Writing `S##-UAT.md`
- Claiming milestone completion or reassessment success
- Saying a fix works, tests pass, build succeeds, or UAT is complete

## The Gate

### 1. Identify proof

Ask: what command, browser flow, or observable check proves this specific claim?

### 2. Run it fresh

Run the real verification now.

Use the full command or the real UI flow, not memory from an earlier run.

### 3. Read the result

Check the exit code, failure count, browser outcome, or produced artifact.

### 4. Record the truth

Write the actual result into the GSD artifact:

- commands run
- what passed or failed
- what behavior was directly observed
- what remains unproven

Write narrative proof in the completion artifact that owns execution evidence, such as:

- `T##-SUMMARY.md`
- `S##-SUMMARY.md`
- `S##-UAT.md`
- review checklists or review artifacts

### 5. Only then mark complete

Only after fresh evidence is in hand should you mark the task, slice, or milestone complete.

## Artifact Boundaries

- `REQUIREMENTS.md` is a capability and coverage contract, not the place for narrative proof logs
- Requirement `Validation` fields should stay compact and reference the real proof artifact, for example `validated via S03-UAT` or `partial: focused test only`
- Traceability tables are reference indexes only; keep cells short and structured, never multi-paragraph evidence dumps
- `DECISIONS.md` records durable architectural or workflow decisions, not per-run test output, browser transcripts, or command histories
- Put the detailed evidence in summaries, UAT, checklists, or review artifacts; if raw logs must be preserved, keep them in ignored or temporary storage unless the task explicitly requires committed evidence

## GSD-Specific Rules

- If verification fails, do **not** write a success artifact
- If the work is partial, write an honest partial summary instead of pretending it is done
- If a human-only check is still required, say so plainly and leave the artifact in that state
- `UAT` must state both what it proved and what it did **not** prove
- If verification changes requirement state, update `REQUIREMENTS.md` with a compact state or reference update only; do not paste the underlying proof narrative there
- If verification surfaces a durable decision, record the decision in `DECISIONS.md` without copying the surrounding test or browser evidence into the register
- A green linter is not a substitute for the relevant proof command
- Review gates must name the required review artifact, recorded verdict, and truthful follow-up state
- Image-backed or Pencil-backed UI also needs the approved reference-intent parity or intent-fit checklist; screenshots alone are not enough
- If visual fixtures were used, separate live runtime proof from fixture visual-state proof and state the claim boundary for each
- Runtime screenshots, traces, console logs, and network dumps are verification inputs, not default commit artifacts. Record the durable conclusion in UAT, summary, checklist, or review files.
- If raw runtime evidence must be saved for replay or review, place it under `/tmp`, another temporary directory, an ignored local path, or an external redaction-safe location unless the task explicitly says to commit those files.

## Not Sufficient

- "The code looks correct"
- "It passed earlier"
- "The agent already said it was done"
- "The diff is small"
- "The happy path worked once"

## Not Allowed

- pasting long proof narratives into `REQUIREMENTS.md` or traceability tables instead of linking to the owning artifact
- using `DECISIONS.md` as a generic execution log

## Evidence Patterns

- **Tests:** command plus pass/fail result
- **Builds:** build command plus exit status
- **UI work:** real browser verification, not assumption
- **Visual fixtures:** fixture evidence can prove state rendering and visual parity, but not live backend integration unless that path also ran live
- **Bug fixes:** original repro no longer fails, plus no obvious regression
- **Artifacts:** the expected file exists and its required contents are truthful
- **Reviews:** review artifact exists, verdict is recorded, and required follow-up state matches the verdict

Raw browser output directories are local evidence storage by default. Do not stage or commit them unless the human or task contract explicitly says they are commit artifacts.

## If You Cannot Prove Completion

Do not force it.

Leave behind the most honest recoverable state:

- partial summary
- remaining risk or blocker
- what was attempted
- what the next unit should verify

## Rule

No GSD completion claims without fresh evidence.
