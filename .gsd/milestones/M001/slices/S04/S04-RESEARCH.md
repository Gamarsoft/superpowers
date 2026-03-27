# M001/S04 — Research

**Date:** 2026-03-28

## Summary

S04 owns the two remaining active requirements for M001: **R006** (preserve the current HTML/runtime contract) and **R011** (keep existing screens and terminal-only flows working). The strongest finding is that the core runtime contract is already well covered and currently green. The existing proof surface spans fragment wrapping vs full-document passthrough, helper injection, `state/events` write/clear behavior, polling fallback, carry-forward independence from browser events, and the authored comparison examples. This points S04 toward **integration assembly and milestone-level validation**, not new runtime behavior.

The real companion entrypoint also works in practice. `skills/brainstorming/scripts/start-server.sh` started a live session successfully, the browser rendered authored fragment examples, a browser click wrote `state/events`, and the server logged `screen-added` plus cleared `state/events` when a genuinely newer screen appeared. The main surprise was not a server bug but an observability wrinkle: in the live browser harness, automatic reload evidence lagged once, even though the server had already added the new screen and cleared `state/events`. Manual `browser_reload` then showed the correct later screen. That makes server-side evidence and explicit browser assertions more trustworthy than generic click/reload summaries.

## Recommendation

Treat S04 as a **verification-first slice**.

Use the existing Node test suites as the backbone, then add one milestone-level live acceptance flow through `start-server.sh` and the real browser entrypoint. Reuse the existing authored examples instead of inventing new fixtures where possible. The slice should prove, in order:

1. **Contract stability:** keep `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/ws-protocol.test.js` green.
2. **Fragment comparison defaults:** keep `tests/brainstorm-server/fragment-comparison-defaults.test.js` green.
3. **Carry-forward continuity:** keep `tests/brainstorm-server/carry-forward-behavior.test.js` green.
4. **Real entrypoint acceptance:**
   - start the companion with `skills/brainstorming/scripts/start-server.sh`
   - load a fragment example and verify authored comparison copy is visible
   - click a `data-choice` option and confirm `state/events` is written
   - add a genuinely newer carry-forward screen and confirm `screen-added` plus `state/events` clearing
   - verify the later screen still shows explicit `Chosen direction`, `Still open`, and when applicable `Degraded mode`
   - add a newer full-document fixture and verify compatibility passthrough without fragment-shell contamination

Do **not** hand-roll new workflow memory, server orchestration, or metadata. If S04 needs code changes, they should be limited to closing a compatibility gap that blocks the above proof.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Proving fragment vs full-document compatibility | `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/fragment-comparison-defaults.test.js` | They already assert helper injection, fragment-shell presence, full-document non-contamination, and `state/events` clearing at the real server boundary. |
| Proving carry-forward does not depend on browser history | `tests/brainstorm-server/carry-forward-behavior.test.js` plus the authored examples in `skills/brainstorming/examples/visual-companion/` | They already prove the rendered output stays identical with and without conflicting `state/events`. |
| Starting and observing the real companion runtime | `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`, and `state/server-info` / `state/server.log` | They expose the real session directory, URL, and lifecycle signals without adding new tooling. |

## Existing Code and Patterns

- `skills/brainstorming/scripts/server.cjs` — The thin runtime boundary. It serves the newest `.html` file by mtime, wraps fragments in `frame-template.html`, passes full documents through unchanged, injects `helper.js`, appends choice events to `state/events`, and clears `state/events` only when a **new** screen file appears.
- `skills/brainstorming/scripts/start-server.sh` — The real companion entrypoint. It creates the session directory, persists `server.pid` and `server.log`, auto-selects foreground/background behavior by environment, and returns startup JSON with `url`, `screen_dir`, and `state_dir`.
- `skills/brainstorming/scripts/stop-server.sh` — The supported shutdown path for live validation. It uses the persisted PID file and keeps project-local `.superpowers/` sessions for inspection.
- `skills/brainstorming/scripts/helper.js` — Additive browser behavior only. It captures `data-choice` clicks, updates the indicator from current DOM state, and intentionally avoids workflow copy or `state/events` semantics.
- `skills/brainstorming/scripts/frame-template.html` — The fragment-only comparison shell. It owns the `data-comparison-kit="fragment-shell"` marker and the shared comparison-first defaults.
- `tests/brainstorm-server/server.test.js` — The strongest R006 regression suite. It covers waiting page behavior, helper injection, fragment wrapping, full-document passthrough, WebSocket event relay, `state/events` write/clear behavior, reloads, and polling fallback.
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — The selector-level observability surface for recommendation/current-winner/carry-forward defaults and the anti-dimming guard.
- `tests/brainstorm-server/carry-forward-behavior.test.js` — The strongest R011 proof that authored continuity stays explicit with or without `state/events`.
- `tests/brainstorm-server/helper-selection-clarity.test.js` — Useful adjacent guard that confirms helper behavior stays container-scoped, DOM-derived, and outside workflow semantics.
- `tests/brainstorm-server/ws-protocol.test.js` — Lower-level protocol confidence for the zero-dependency WebSocket transport.
- `tests/brainstorm-server/windows-lifecycle.test.sh` — **Not currently authoritative as written.** It still references `skills/brainstorming/scripts/server.js` and `.server-info`, while the current runtime uses `server.cjs` and `state/server-info`.

## Constraints

- Preserve the thin runtime contract: fragment wrapping, full-document passthrough, helper injection, `screen_dir`, and `state_dir/events` behavior must remain intact.
- Do not add new required metadata beyond existing `data-choice`.
- Keep helper behavior presentation-only and DOM-derived; carry-forward meaning must stay in visible authored copy.
- Fresh-screen validation depends on **genuinely newer filenames or mtimes**. `server.cjs` clears `state/events` only on `screen-added`, and it serves the newest `.html` file by mtime.
- Full-document screens remain compatibility-supported only; they must not inherit fragment-shell behavior automatically.
- The browser harness can lag on automatic reload visibility. For live proof, explicit browser assertions and server-side log/file checks are more reliable than generic browser summaries.

## Common Pitfalls

- **Reusing filenames or racing mtimes** — If a live validation step does not create a genuinely newer screen, `getNewestScreen()` and new-screen clearing can look flaky. Use monotonically newer filenames or ensure distinct mtimes.
- **Treating browser click summaries as authoritative** — A click can write `state/events` and update the DOM even when the browser tool reports a soft “no observable state change.” Verify with the indicator text, DOM-selected state, and the actual `state/events` file.
- **Assuming auto-reload evidence is immediate in the harness** — In live validation, the server may already have processed the new screen while the browser harness still shows the old one. Use `state/server.log`, `state/events`, and explicit `browser_reload` / `browser_assert` when needed.
- **Relying on stale adjacent scripts** — `tests/brainstorm-server/windows-lifecycle.test.sh` is out of sync with the current runtime surface and can create false alarms unless refreshed first.

## Open Risks

- Live milestone acceptance could produce false negatives if the browser harness misses an automatic reload even though the server contract is correct.
- The Windows lifecycle script may distract S04 if treated as required proof before it is updated to the current `server.cjs` and `state/server-info` contract.
- Because S04 is mostly an assembly slice, it is easy to drift into redundant verification without closing the real milestone gap: the final live comparison-first acceptance path.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| Browser runtime validation | `skills/webapp-testing/SKILL.md` | installed (project-local) |
| Node.js server runtime | `wshobson/agents@nodejs-backend-patterns` | available via `npx skills add wshobson/agents@nodejs-backend-patterns` |
| WebSocket transport | `jeffallan/claude-skills@websocket-engineer` | available via `npx skills add jeffallan/claude-skills@websocket-engineer` |
| Browser testing | `incept5/eve-skillpacks@eve-web-ui-testing-agent-browser` | available via `npx skills add incept5/eve-skillpacks@eve-web-ui-testing-agent-browser` |

## Sources

- Runtime boundary, fragment wrapping, full-document passthrough, helper injection, `state/events` write/clear behavior, and polling fallback (source: `skills/brainstorming/scripts/server.cjs`, `tests/brainstorm-server/server.test.js`).
- Selector-level fragment comparison defaults and fragment-shell boundary proofs (source: `skills/brainstorming/scripts/frame-template.html`, `tests/brainstorm-server/fragment-comparison-defaults.test.js`).
- Carry-forward independence from `state/events` presence and conflicting stale events (source: `tests/brainstorm-server/carry-forward-behavior.test.js`).
- Helper workflow-boundary and container-scoped selected-state behavior (source: `skills/brainstorming/scripts/helper.js`, `tests/brainstorm-server/helper-selection-clarity.test.js`).
- Real entrypoint behavior, session directory contract, and supported shutdown path (source: `skills/brainstorming/scripts/start-server.sh`, `skills/brainstorming/scripts/stop-server.sh`).
- Verification evidence gathered during research: `node tests/brainstorm-server/fragment-comparison-defaults.test.js`, `node tests/brainstorm-server/carry-forward-behavior.test.js`, `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js` all passed; live `start-server.sh` validation also confirmed click-written `state/events`, `screen-added` logging, and later-screen event clearing.
