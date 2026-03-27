---
estimated_steps: 4
estimated_files: 7
---

# T03: Close M002 from verified runtime evidence

**Slice:** S02 — Live runtime corroboration and milestone closure
**Milestone:** M002

## Description

Turn the passing runtime proof into slice and milestone closure. This task updates the project artifacts only after T01 and T02 have produced concrete evidence that R019 is satisfied.

## Steps

1. Read T01 and T02 results and confirm the slice verification stack is green or that any browser-only warning was explicitly localized as non-blocking.
2. Write `S02-SUMMARY.md`, `S02-UAT.md`, and `M002-SUMMARY.md` with the exact proof surfaces, results, and any limitations that remain.
3. Update `.gsd/REQUIREMENTS.md`, `.gsd/milestones/M002/M002-ROADMAP.md`, and `.gsd/PROJECT.md` so R019 moves to validated and M002 is marked complete only if the evidence justifies it.
4. Update `.gsd/STATE.md` to point at the next real unit of work after milestone closure.

## Must-Haves

- [ ] R019 moves from active to validated only after the passing S02 runtime evidence is cited.
- [ ] Slice and milestone closure artifacts name the real proof surfaces and do not over-claim beyond what T01 and T02 proved.

## Verification

- Read back `.gsd/milestones/M002/slices/S02/S02-SUMMARY.md`, `.gsd/milestones/M002/M002-SUMMARY.md`, `.gsd/REQUIREMENTS.md`, `.gsd/milestones/M002/M002-ROADMAP.md`, and `.gsd/STATE.md` and confirm they agree with the passing S02 verification stack.
- Confirm the closure artifacts explicitly mention the runtime-matrix commands and browser corroboration outcome rather than relying on planned intent.

## Observability Impact

- Signals changed: the authoritative closure evidence now lives in the written slice and milestone summaries, `REQUIREMENTS.md` validation notes, the roadmap checkbox state, and `.gsd/STATE.md`; no runtime signal changes are introduced.
- Inspection path for future agents: start with `.gsd/milestones/M002/slices/S02/S02-SUMMARY.md` and `.gsd/milestones/M002/M002-SUMMARY.md`, then cross-check the cited proof surfaces against `.gsd/milestones/M002/slices/S02/tasks/T01-SUMMARY.md`, `.gsd/milestones/M002/slices/S02/tasks/T02-SUMMARY.md`, `state/server-info`, `state/server.log`, `state/events`, and the exact runtime-matrix commands if a contradiction appears.
- Failure state made visible: any mismatch between the claimed closure state and the verified S02 runtime/browser evidence becomes explicit in the summary artifacts, requirement status, roadmap status, and state handoff instead of remaining an implicit doc-only assumption.

## Inputs

- `.gsd/milestones/M002/slices/S02/tasks/T01-SUMMARY.md` — runtime-matrix results and any localized fixes
- `.gsd/milestones/M002/slices/S02/tasks/T02-SUMMARY.md` — browser corroboration evidence and the `404` disposition if relevant
- `.gsd/REQUIREMENTS.md` — R019 is the only active requirement this task is allowed to close
- `.gsd/milestones/M002/M002-ROADMAP.md` — slice and milestone status artifact that should move only after proof is real

## Expected Output

- `.gsd/milestones/M002/slices/S02/S02-SUMMARY.md` — slice completion summary tied to actual runtime evidence
- `.gsd/milestones/M002/slices/S02/S02-UAT.md` — compact human-visible corroboration record for the live browser pass
- `.gsd/milestones/M002/M002-SUMMARY.md` — milestone closure summary for M002
- `.gsd/REQUIREMENTS.md` — R019 updated from active to validated when proven
- `.gsd/milestones/M002/M002-ROADMAP.md` — S02 marked complete and M002 closed if all proof passes
- `.gsd/PROJECT.md` — current project state refreshed after milestone closure
- `.gsd/STATE.md` — active state advanced to the next unit of work
