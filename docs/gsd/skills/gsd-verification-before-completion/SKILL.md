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

### 5. Only then mark complete

Only after fresh evidence is in hand should you mark the task, slice, or milestone complete.

## GSD-Specific Rules

- If verification fails, do **not** write a success artifact
- If the work is partial, write an honest partial summary instead of pretending it is done
- If a human-only check is still required, say so plainly and leave the artifact in that state
- `UAT` must state both what it proved and what it did **not** prove
- A green linter is not a substitute for the relevant proof command
- Review gates must name the required review artifact, recorded verdict, and truthful follow-up state
- Image-backed or Pencil-backed UI also needs the approved reference-intent parity or intent-fit checklist; screenshots alone are not enough

## Not Sufficient

- "The code looks correct"
- "It passed earlier"
- "The agent already said it was done"
- "The diff is small"
- "The happy path worked once"

## Evidence Patterns

- **Tests:** command plus pass/fail result
- **Builds:** build command plus exit status
- **UI work:** real browser verification, not assumption
- **Bug fixes:** original repro no longer fails, plus no obvious regression
- **Artifacts:** the expected file exists and its required contents are truthful
- **Reviews:** review artifact exists, verdict is recorded, and required follow-up state matches the verdict

## If You Cannot Prove Completion

Do not force it.

Leave behind the most honest recoverable state:

- partial summary
- remaining risk or blocker
- what was attempted
- what the next unit should verify

## Rule

No GSD completion claims without fresh evidence.
