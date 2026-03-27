# S03: Selection clarity and carry-forward behavior — UAT

**Milestone:** M001
**Written:** 2026-03-28

## UAT Type

- UAT mode: mixed
- Why this mode is sufficient: S03 changes both authored artifacts and live helper/runtime behavior, so the acceptance check needs one real browser-plus-server flow and one explicit carry-forward artifact check.

## Preconditions

- Work from the repo root.
- No process is already bound to port `3340`.
- Create a fresh temp session root, for example `/tmp/brainstorm-uat-s03`, with `content/` and `state/` subdirectories.
- Start the real companion server with `BRAINSTORM_PORT=3340 BRAINSTORM_DIR=/tmp/brainstorm-uat-s03 node skills/brainstorming/scripts/server.cjs`.
- Open `http://localhost:3340` in the browser after copying the first screen file into `/tmp/brainstorm-uat-s03/content/`.

## Smoke Test

Copy `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` to `/tmp/brainstorm-uat-s03/content/t03-click-assisted-annotated.html`, load the page, and confirm the browser shows the annotated recommendation screen with the neutral indicator guidance before any click.

## Test Cases

### 1. Click-assisted selection becomes clearer without turning the helper into workflow memory

1. Copy `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` to `/tmp/brainstorm-uat-s03/content/t03-click-assisted-annotated.html`.
2. Open `http://localhost:3340` and confirm the page shows `Annotated recommendation: settings information architecture`.
3. Verify the indicator still shows neutral guidance before interaction.
4. Click the option labeled `Still open alternative: technical-stack sections`.
5. Check that the clicked card now has the `.selected` state.
6. Inspect `/tmp/brainstorm-uat-s03/state/events`.
7. **Expected:** The indicator reads `Selected: Still open alternative: technical-stack sections — return to the terminal to continue`, the selected state stays local to that options group, and `state/events` contains the clicked `technical-stack-settings` choice.

### 2. Terminal-only carry-forward stays explicit after a fresh later screen clears browser events

1. Complete Test Case 1 so `/tmp/brainstorm-uat-s03/state/events` exists.
2. Copy `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` to `/tmp/brainstorm-uat-s03/content/t03-terminal-only-carry-forward.html` with a newer filename or mtime than the first screen.
3. Wait for the live browser reload.
4. Do not click anything on the new screen.
5. Confirm the page visibly shows `Decision checkpoint: export flow`, `Degraded mode`, `Chosen direction: drawer-based export flow`, and `Still open: permission fallback copy`.
6. Inspect `/tmp/brainstorm-uat-s03/state/events` again.
7. **Expected:** The later screen is still explicit about what is chosen and what remains open without any new click, and `state/events` has been cleared because the new screen replaced the earlier click context.

## Edge Cases

### Conflicting stale events do not override authored carry-forward meaning

1. Stop the server and remove the temp directory.
2. Recreate `/tmp/brainstorm-uat-s03/content` and `/tmp/brainstorm-uat-s03/state`.
3. Write a fake `/tmp/brainstorm-uat-s03/state/events` entry with a conflicting choice such as `technical-stack-settings`.
4. Copy only `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` into `/tmp/brainstorm-uat-s03/content/t03-terminal-only-carry-forward.html`.
5. Restart the server and load `http://localhost:3340`.
6. **Expected:** The page still shows the authored `Degraded mode`, `Chosen direction: drawer-based export flow`, and `Still open` copy exactly as written in the HTML instead of reflecting the stale event file.

## Failure Signals

- The indicator mentions workflow copy, reads from prior screens globally, or shows a cross-container count.
- Clicking a `data-choice` option fails to add `.selected` state or does not write the clicked choice to `state/events`.
- Loading a fresh later screen leaves the old `state/events` file in place.
- The later screen requires a new browser click to reveal `Chosen direction`, `Still open`, or `Degraded mode`.
- The carry-forward screen changes meaning when stale `state/events` content is present.

## Requirements Proved By This UAT

- R004 — Later screens explicitly carry forward a chosen or still-open direction in visible authored copy.
- R005 — The browser remains an additive decision aid while the terminal/authored screen remains the continuity authority.
- R010 — Degraded mode is explicit and visible instead of being silently implied.

## Not Proven By This UAT

- R006 — It does not exhaustively prove every fragment/full-document compatibility case across the full runtime contract.
- R011 — It does not cover the broader catalog of existing authored screens that S04 still needs to validate.

## Notes for Tester

- Use fresh filenames or newer mtimes for the second screen; otherwise the server may not treat it as a genuinely new screen.
- Ignore the existing favicon 404 noise in browser diagnostics unless other console or network failures appear.
- If the browser does not reload after the second file lands, confirm the server is watching the same `BRAINSTORM_DIR` you are writing into.
