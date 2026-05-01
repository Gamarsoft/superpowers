---
name: gsd-systematic-debugging
description: Use when GSD verification fails, behavior is unexpected, a regression appears, UAT fails, or a task no longer matches reality.
---

# GSD Systematic Debugging

## Mission

When a GSD task fails, do not thrash.

Find the root cause before changing code, and leave behind artifacts the next GSD unit can trust.

## Use When

- a task verification step fails
- a test fails unexpectedly
- a bug reproduces during execution or UAT
- a task appears complete but the observed behavior disagrees
- a replan is needed because the current task shape no longer matches reality

## Best Place In GSD

Mostly an **execution-phase** skill, but it also applies during:

- UAT failures
- resume/continue work
- replan decisions triggered by real blockers

## Rule

No fixes without root-cause investigation first.

## Workflow

### 1. Re-read the task boundary

Before changing code, re-read the current:

- `T##-PLAN.md`
- relevant slice plan
- recent summaries
- `.gsd/DECISIONS.md` if the area is architecture-sensitive

Make sure you know:

- expected behavior
- actual behavior
- what must remain unchanged

### 2. Reproduce the failure cleanly

Get to a stable repro:

- exact command
- exact browser flow
- exact failing assertion
- exact build/runtime error

If the failure is not reproducible yet, gather more evidence instead of guessing.

### 3. Gather the right evidence

Read the whole relevant function or flow, not just the line that looks suspicious.

Collect:

- failing output
- nearby code path
- config and environment assumptions
- existing observability signals

Prefer concrete evidence over intuition.

### 4. Form one hypothesis at a time

State what you think is wrong and why.

Then test that hypothesis with the smallest possible check.

Do not stack multiple speculative fixes into one attempt.

### 5. Fix only after the cause is clear

Once the evidence points to a root cause, make the smallest change that addresses it.

Then rerun the original proof path plus the most obvious regression surface.

### 6. Leave a durable trail in GSD

If the debugging work materially changes what the next unit needs to know, capture it in:

- `T##-SUMMARY.md`
- `continue.md` when incomplete
- `.gsd/DECISIONS.md` when the fix changes a durable technical assumption

## GSD-Specific Guidance

- If the task boundary was wrong, prefer replanning over forcing a bad task shape
- If the fix is not proven, do not mark the task complete
- If two fix attempts fail, stop and reassess the task or slice plan instead of continuing to thrash
- If the real proof surface is browser behavior, debug against the browser rather than pretending unit tests alone are enough

## Anti-Patterns

- fixing symptoms before reproducing the issue
- changing code before reading the full failing path
- treating `STATE.md` as the source of truth instead of the real artifacts
- writing a success summary when the bug is only “probably fixed”
- hiding uncertainty from the next GSD unit

## Completion Standard

A GSD debugging task should end with:

- a clear repro
- a defensible root cause
- a verified fix or an honest blocker
- artifacts the next agent can continue from immediately
