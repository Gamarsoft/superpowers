---
estimated_steps: 4
estimated_files: 4
---

# T02: Corroborate live browser behavior against runtime artifacts

**Slice:** S02 — Live runtime corroboration and milestone closure
**Milestone:** M002

## Description

Use the real companion entrypoint for one quick browser-visible pass, then tie what the browser shows back to the authoritative runtime artifacts so the earlier stray `404` can be dismissed or localized honestly.

## Steps

1. Start a temporary companion session through `skills/brainstorming/scripts/start-server.sh` and load the served screen in the browser.
2. Verify the refreshed annotated recommendation and unchanged carry-forward example render as expected, using explicit browser assertions rather than visual inference alone.
3. Cross-check the browser outcome against `state/server-info`, `state/server.log`, `state/events`, and console/network logs; if the auxiliary `404` recurs, capture the exact request path before changing code.
4. Stop the session through `skills/brainstorming/scripts/stop-server.sh` and record whether the browser corroboration matched the automated matrix or exposed a bounded contradiction.

## Must-Haves

- [ ] Browser corroboration runs through the real entrypoint and checks the refreshed annotated example plus unchanged carry-forward example.
- [ ] Any recurring `404` is recorded with an exact request path or ruled out, rather than being treated as vague suspicion.

## Verification

- Live runtime check from `.gsd/milestones/M002/slices/S02/S02-PLAN.md`, including browser assertions plus server-side tie-breakers from `state/server-info`, `state/server.log`, and `state/events`.
- Confirm the session tears down through `skills/brainstorming/scripts/stop-server.sh` after the corroboration pass.

## Observability Impact

- Signals added/changed: no new runtime signals; this task turns existing browser console/network output plus `state/server-info`, `state/server.log`, and `state/events` into corroboration evidence.
- How a future agent inspects this: rerun the temporary session, check browser assertions first, then compare with server-side files and browser logs if the page behavior is ambiguous.
- Failure state exposed: a recurring browser-only warning becomes attributable to a specific request path, or the evidence ties it back to a real runtime contradiction.

## Inputs

- `.gsd/milestones/M002/slices/S02/tasks/T01-SUMMARY.md` — green matrix results or the bounded contradiction found during T01
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — refreshed active example already validated at the authored-file level in S01
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — unchanged canary example that should still render cleanly

## Expected Output

- `.gsd/milestones/M002/slices/S02/tasks/T02-SUMMARY.md` — browser corroboration result, teardown status, and exact `404` request-path evidence if it appears
- `skills/brainstorming/scripts/start-server.sh` or `skills/brainstorming/scripts/stop-server.sh` — touched only if the browser pass proves a targeted entrypoint compatibility fix is required
