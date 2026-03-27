# M002 / S02 — Research

**Date:** 2026-03-29

## Summary

This slice owns the only remaining **Active** requirement: **R019 — preserve the current runtime, `data-choice` interaction boundary, and four-archetype contract while corroborating the M002 authored refresh through the real companion entrypoint**. S01 already validated the authored routing and quality-gate changes (R013-R018), so S02 should focus narrowly on live-runtime proof, not reopen docs or example content unless a runtime contradiction appears.

The good news is that the repo already contains the exact proof surfaces S02 needs. `tests/brainstorm-server/live-companion-acceptance.test.js` exercises the real `start-server.sh` / `stop-server.sh` entrypoint, serves the refreshed annotated recommendation example, serves the unchanged carry-forward example, verifies fragment-shell injection, `state/events` write-and-clear behavior, and full-document passthrough, then proves teardown. `tests/brainstorm-server/windows-lifecycle.test.sh` independently validates startup metadata parity, helper injection, newest-screen-by-mtime behavior, `state/server.log` diagnostics, and lifecycle shutdown. `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/ws-protocol.test.js` cover the lower-level HTTP/WebSocket/watcher contract that must remain untouched.

A useful surprise: the runtime is still truly thin. `skills/brainstorming/scripts/server.cjs` uses Node built-ins only; the only package dependency in this area is `ws`, and it is test-only under `tests/brainstorm-server/package.json`. Another surprise: a manual browser check against a temporary live session rendered the refreshed annotated recommendation screen correctly but surfaced a single unattributed `404` console warning. The automated acceptance stack still passed cleanly, and the captured server log showed no matching runtime drift signal, so this currently looks more like auxiliary browser noise than contract breakage. If it recurs during execution, capture the exact path before changing server/helper code.

## Recommendation

Treat S02 as an **evidence-and-closure slice**. Use the existing acceptance stack as the authoritative proof, in this order:

1. `node tests/brainstorm-server/live-companion-acceptance.test.js`
2. `bash tests/brainstorm-server/windows-lifecycle.test.sh`
3. `node tests/brainstorm-server/server.test.js`
4. `node tests/brainstorm-server/ws-protocol.test.js`

If all four pass, prefer updating milestone bookkeeping and closure artifacts over editing runtime files. Only reopen `skills/brainstorming/scripts/server.cjs`, `start-server.sh`, `stop-server.sh`, `helper.js`, or the fragment examples if a failing run ties directly to runtime behavior. For human corroboration, use a quick browser preview through `start-server.sh` as a secondary signal only; the authoritative tie-breakers remain `state/server-info`, `state/server.log`, `state/events`, and the existing automated assertions.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Proving the refreshed examples still work through the real entrypoint | `tests/brainstorm-server/live-companion-acceptance.test.js` | Already exercises `start-server.sh` / `stop-server.sh`, the refreshed annotated example, the unchanged carry-forward example, `state/events`, fragment-shell injection, and full-document passthrough. |
| Proving lifecycle behavior and preserving diagnostics on failure | `tests/brainstorm-server/windows-lifecycle.test.sh` | Already validates startup metadata, helper-served HTML, newest-screen selection, `screen-added` logging, and teardown while preserving session artifacts on failure. |
| Proving no low-level runtime drift in HTTP/WebSocket/watch behavior | `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/ws-protocol.test.js` | Already cover the thin runtime contract, including helper injection, fragment/full-document boundary, polling fallback, and zero-dependency WebSocket protocol behavior. |

## Existing Code and Patterns

- `skills/brainstorming/scripts/server.cjs` — authoritative runtime contract: serves the newest `.html` by mtime, wraps fragments but not full documents, injects `helper.js` into both, appends choice events to `state/events`, clears `state/events` on genuinely new screens, logs `screen-added` / `screen-updated`, and falls back from `fs.watch` to polling when needed.
- `skills/brainstorming/scripts/start-server.sh` — required real entrypoint for S02 proof; owns session-dir creation, bind/display host handling, background/foreground behavior, and startup JSON persisted to `state/server-info`.
- `skills/brainstorming/scripts/stop-server.sh` — supported teardown path; removes `server.pid`, deletes ephemeral `/tmp` sessions only, and should be the shutdown path used by S02 acceptance.
- `tests/brainstorm-server/live-companion-acceptance.test.js` — strongest M002-specific proof surface because it renders the refreshed `annotated-recommendation.html`, the unchanged `carry-forward-summary.html`, and a full-document fixture through the real entrypoint.
- `tests/brainstorm-server/windows-lifecycle.test.sh` — best operational proof surface for startup metadata parity, helper injection, newest-screen replacement, `state/server.log`, and `state/events` clearing.
- `tests/brainstorm-server/server.test.js` — semantic regression suite for HTTP serving, helper injection, fragment wrapping, choice persistence, watcher reloads, polling fallback, and frame-template structure.
- `tests/brainstorm-server/ws-protocol.test.js` — low-level guardrail that keeps any future runtime investigation from accidentally breaking the zero-dependency WebSocket implementation.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — refreshed active example currently used by live acceptance; preserves stable `data-choice` IDs while providing more concrete decision content.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — unchanged regression sentinel; S02 should treat it as a canary for accidental scope drift.

## Constraints

- R019 is a **constraint** slice: it must prove the M002 authored refresh did **not** change the runtime contract, the `data-choice` boundary, or the four-archetype surface.
- S02 must exercise the **real entrypoint** (`start-server.sh` / `stop-server.sh`), not only direct `node server.cjs` coverage.
- Fragment/full-document compatibility remains part of the preserved contract: fragments must still receive the shared shell, while full documents must stay passthrough except for helper injection.
- `carry-forward-summary.html` remains intentionally unchanged unless a live contradiction proves otherwise.
- The browser is corroborative, not authoritative; closure should rely on `state/server-info`, `state/server.log`, `state/events`, and the automated acceptance matrix.
- The runtime here is intentionally thin; avoid introducing new metadata, orchestration, or archetype behavior while investigating failures.

## Common Pitfalls

- **Treating a browser-only warning as proof of runtime drift** — cross-check `state/server.log`, `state/server-info`, `state/events`, and the automated acceptance artifacts before editing server/helper code.
- **Verifying only docs/examples again** — S01 already closed the authored-contract layer; S02 must prove the real runtime path.
- **Using only `node server.cjs`** — that misses the startup JSON, session-dir contract, and supported teardown flow that S02 explicitly needs to corroborate.
- **Forgetting the mtime-based newest-screen rule** — tests intentionally offset mtimes when copying files; ad hoc manual checks can get misleading results if two files share near-identical timestamps.
- **Fixing the wrong layer** — if a failure is limited to acceptance artifacts or session management, do not reopen the example fragments or guidance files first.

## Open Risks

- The auxiliary `404` seen during manual browser preview could recur. Right now it looks non-authoritative because the automated matrix passed and no matching runtime error surfaced, but S02 should capture the exact request path if it appears again.
- `start-server.sh` has environment-sensitive process-lifecycle behavior (`--background`, owner-PID monitoring, foreground fallbacks). Cross-environment failures may come from process reaping rather than authored-content drift.
- The newest-file-by-mtime contract is simple but timing-sensitive; any ad hoc live verification that copies multiple files too quickly can create ambiguous results if timestamps are not controlled.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| WebSocket runtime / debugging | `jeffallan/claude-skills@websocket-engineer` | available via `npx skills add jeffallan/claude-skills@websocket-engineer` |
| Browser automation / Playwright-style verification | `currents-dev/playwright-best-practices-skill@playwright-best-practices` | available via `npx skills add currents-dev/playwright-best-practices-skill@playwright-best-practices` |
| Node / JavaScript testing | `martinholovsky/claude-skills-generator@javascript-expert` | available via `npx skills add martinholovsky/claude-skills-generator@javascript-expert` (lower relevance than the existing in-repo test harnesses) |

## Sources

- Live entrypoint acceptance already covers the refreshed annotated example, unchanged carry-forward example, `state/events` write/clear behavior, fragment wrapping, and full-document passthrough (source: `tests/brainstorm-server/live-companion-acceptance.test.js`).
- Lifecycle proof already covers startup metadata parity, helper-served HTML, newest-screen selection, `state/server.log` diagnostics, and supported teardown (source: `tests/brainstorm-server/windows-lifecycle.test.sh`).
- The preserved runtime contract remains: newest `.html` by mtime, fragment wrapping only for fragments, helper injection into all served HTML, `state/events` clearing on new screens, watch fallback to polling, and owner-PID lifecycle monitoring (source: `skills/brainstorming/scripts/server.cjs`).
- The runtime area remains thin and zero-dependency at runtime; `ws` appears only as a test dependency (source: `package.json`, `tests/brainstorm-server/package.json`).
- Today’s verification run passed cleanly: `node tests/brainstorm-server/live-companion-acceptance.test.js`, `bash tests/brainstorm-server/windows-lifecycle.test.sh`, `node tests/brainstorm-server/server.test.js`, and `node tests/brainstorm-server/ws-protocol.test.js` all returned green.
- Manual browser corroboration through a temporary `start-server.sh` session rendered the refreshed annotated recommendation screen correctly and surfaced one unattributed `404` console warning without a corresponding acceptance failure or server-log drift signal (source: local browser session against `http://localhost:51103`).
