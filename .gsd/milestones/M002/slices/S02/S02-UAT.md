# S02: Live runtime corroboration and milestone closure — UAT

**Milestone:** M002
**Written:** 2026-03-30

## UAT Type

- UAT mode: live-runtime
- Why this mode is sufficient: R019 can only close on the real companion entrypoint, real browser behavior, and the runtime state files that show whether the authored refresh changed anything below the docs/examples layer.

## Preconditions

- Work from the repo root.
- Node.js is available in the shell.
- No other process is using the session directory you choose for the live check.
- Create a fresh temp project directory, for example `.gsd/tmp/t03-browser`.
- Start the companion with `bash skills/brainstorming/scripts/start-server.sh --project-dir "$PWD/.gsd/tmp/t03-browser" --host 127.0.0.1 --url-host localhost --background` and keep the returned `screen_dir` and `state_dir`.
- Open the returned `url` in the browser after copying the first HTML file into `screen_dir`.

## Smoke Test

Copy `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` into the returned `screen_dir`, open the returned `url`, and confirm the page visibly shows `Annotated recommendation: settings information architecture`.

## Test Cases

### 1. Annotated recommendation still renders and records a real click through the live entrypoint

1. Copy `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` into the live `screen_dir` with a fresh filename such as `annotated-recommendation-live.html`.
2. Open the returned browser URL.
3. Confirm the page shows `click-assisted follow-up`, `Chosen direction: task-grouped settings`, and `Still open alternative: technical-stack sections`.
4. Click the option with `data-choice='technical-stack-settings'`.
5. Inspect `state/events` and `state/server.log` in the live `state_dir`.
6. **Expected:** The page shows `Selected: Still open alternative: technical-stack sections — return to the terminal to continue`, `state/events` records the clicked `technical-stack-settings` payload, and `state/server.log` records the corresponding `source":"user-event"` line.

### 2. A genuinely newer carry-forward screen still clears transient events while keeping continuity explicit

1. Complete Test Case 1 so `state/events` exists.
2. Copy `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` into the same `screen_dir` with a fresher filename or mtime than the annotated screen.
3. Wait for the live browser reload.
4. Confirm the page shows `Decision checkpoint: export flow`, `terminal-only follow-up`, `Chosen direction: drawer-based export flow`, `Still open: permission fallback copy`, and `Degraded mode`.
5. Check that the earlier annotated recommendation heading is no longer present.
6. Inspect `state/events` again.
7. **Expected:** The newer carry-forward screen becomes the served screen, the old annotated heading disappears, and `state/events` is absent because the new screen replaced the earlier click context.

## Edge Cases

### Bare browser 404 stays non-blocking only when it resolves to `/favicon.ico`

1. With the live session open, inspect browser console logs if a bare `404 (Not Found)` message appears.
2. Run `performance.getEntriesByType('resource')` in the page context.
3. Compare the result with `state/server-info`, `state/server.log`, and the visible page assertions.
4. **Expected:** If the only failing path is `http://localhost:<port>/favicon.ico` and the page/state assertions still pass, treat it as auxiliary browser noise rather than runtime drift.

## Failure Signals

- `live-companion-acceptance.test.js`, `windows-lifecycle.test.sh`, `server.test.js`, or `ws-protocol.test.js` fails on the refreshed M002 files.
- The annotated recommendation does not render through the returned `url` or loses the expected recommendation/still-open copy.
- Clicking the option fails to write `state/events` or the selected-state copy never appears.
- A newer carry-forward screen fails to reload, leaves the old annotated heading visible, or keeps the old `state/events` file in place.
- The recurring bare 404 points at anything other than `/favicon.ico`, or the state-file/browser assertions contradict the visible browser result.

## Requirements Proved By This UAT

- R019 — Proves that the M002 routing and example refresh preserved the current runtime contract, `data-choice` interaction boundary, and four-archetype behavior through the real companion entrypoint.

## Not Proven By This UAT

- R020-R023 — This UAT does not prove any deferred follow-on work such as diagram-oriented patterns, a session decision ledger, branching workflow orchestration, or optional full-document helper parity.
- Serving a favicon asset — The live proof tolerates the known `/favicon.ico` 404 only because it is auxiliary to the actual companion runtime behavior.

## Notes for Tester

Use fresh filenames or newer mtimes when promoting the second screen; otherwise the server may not treat it as the newest screen. If the browser reports a bare 404, do not guess: confirm the exact resource path first. Only treat the warning as non-blocking when it resolves to `/favicon.ico` and the runtime proof surfaces remain consistent.
