---
estimated_steps: 3
estimated_files: 4
---

# T01: Refresh lifecycle compatibility diagnostics

**Slice:** S04 — Compatibility and integrated validation
**Milestone:** M001

## Description

Bring the stale lifecycle proof surface back in line with the current runtime contract. This task updates `windows-lifecycle.test.sh` so operational verification uses the supported `start-server.sh` / `stop-server.sh` flow, current `state/server-info` location, and the real event-clearing behavior from `server.cjs`.

## Steps

1. Update `tests/brainstorm-server/windows-lifecycle.test.sh` to use the current runtime entrypoints and persisted state paths instead of the outdated `server.js` and `.server-info` assumptions.
2. Add explicit lifecycle assertions for startup metadata, helper-served HTML, newest-screen selection, and transient `state/events` clearing on a genuinely newer screen.
3. Tighten failure messages so the script points directly to lifecycle drift instead of failing with opaque shell output.

## Must-Haves

- [ ] The lifecycle script validates the current supported start/stop contract and state-file locations.
- [ ] The script exposes compatibility failures clearly enough that a future agent can tell whether startup, served HTML, newest-screen selection, or event clearing drifted.

## Verification

- `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`
- `cd tests/brainstorm-server && node server.test.js`

## Observability Impact

- Signals added/changed: the operational lifecycle check now verifies current startup metadata and `state/events` transitions instead of stale file paths.
- How a future agent inspects this: run `cd tests/brainstorm-server && bash windows-lifecycle.test.sh`, then inspect `state/server-info`, `state/server.log`, and the served HTML for the failing scenario.
- Failure state exposed: entrypoint drift, stale server-info paths, incorrect newest-screen selection, or missing event-clearing on fresh screens.

## Inputs

- `tests/brainstorm-server/windows-lifecycle.test.sh` — stale operational script that currently points at the wrong runtime surface
- `skills/brainstorming/scripts/start-server.sh` — supported startup contract and returned session metadata
- `skills/brainstorming/scripts/stop-server.sh` — supported shutdown contract for live validation
- `skills/brainstorming/scripts/server.cjs` — authoritative newest-screen and `state/events` behavior the script must reflect

## Expected Output

- `tests/brainstorm-server/windows-lifecycle.test.sh` — refreshed lifecycle compatibility script aligned with the current runtime contract
- `skills/brainstorming/scripts/start-server.sh` — only if a tiny compatibility fix is required to support the refreshed lifecycle assertions
- `skills/brainstorming/scripts/stop-server.sh` — only if a tiny compatibility fix is required to keep shutdown behavior aligned with the refreshed script
