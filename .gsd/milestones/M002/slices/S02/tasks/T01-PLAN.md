---
estimated_steps: 5
estimated_files: 6
---

# T01: Run the real-entrypoint runtime matrix and localize any drift

**Slice:** S02 — Live runtime corroboration and milestone closure
**Milestone:** M002

## Description

Run the existing authoritative runtime checks against the refreshed M002 authored files, treat any failure as a localization exercise first, and keep the fix surface inside the current runtime contract.

## Steps

1. Run `live-companion-acceptance.test.js`, `windows-lifecycle.test.sh`, `server.test.js`, and `ws-protocol.test.js` in the research-defined order so the real entrypoint is checked before lower-level runtime suites.
2. If any check fails, inspect the preserved temp-session artifacts, logs, and rendered HTML snapshots before changing code.
3. Localize whether the contradiction is in `start-server.sh`, `server.cjs`, helper injection, lifecycle handling, or an authored example boundary, and only edit the smallest proven surface.
4. Rerun the affected check first, then rerun the full matrix until it is green.
5. Leave a crisp execution trail for T02 and T03: either a green matrix or a clearly bounded runtime fix with the proof rerun attached.

## Must-Haves

- [ ] The four authoritative runtime checks pass against the refreshed M002 examples through the existing contract.
- [ ] Any failure is localized from preserved artifacts before runtime or authored files are changed.

## Verification

- `node tests/brainstorm-server/live-companion-acceptance.test.js && bash tests/brainstorm-server/windows-lifecycle.test.sh && node tests/brainstorm-server/server.test.js && node tests/brainstorm-server/ws-protocol.test.js`
- If a check fails, confirm the rerun after the smallest proven fix passes and that the failure evidence points to a real contract contradiction rather than browser-only noise.

## Observability Impact

- Signals added/changed: none in the intended green path; this task relies on existing `state/server-info`, `state/server.log`, `state/events`, and preserved temp-session artifacts as the authoritative runtime signals.
- How a future agent inspects this: rerun the matrix commands, then inspect the preserved paths emitted by `live-companion-acceptance.test.js` or `windows-lifecycle.test.sh` on failure.
- Failure state exposed: startup drift, fragment/full-document contamination, event write/clear regressions, lifecycle issues, and WebSocket/runtime contract drift should each surface in a named test or preserved session artifact.

## Inputs

- `.gsd/milestones/M002/slices/S02/S02-PLAN.md` — defines the required runtime proof stack for R019
- `.gsd/milestones/M002/slices/S02/S02-RESEARCH.md` — fixes the runtime-check order and the “localize before edit” rule
- `.gsd/milestones/M002/slices/S01/S01-SUMMARY.md` — confirms the authored refresh already passed doc/example-level proof and should not be reopened casually

## Expected Output

- `.gsd/milestones/M002/slices/S02/tasks/T01-SUMMARY.md` — exact runtime-matrix results, any localized contradiction, and the rerun evidence
- `tests/brainstorm-server/live-companion-acceptance.test.js` or runtime files under `skills/brainstorming/scripts/` — touched only if a failing check proves a targeted compatibility fix is required
