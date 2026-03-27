# M001 / S03 — Research

**Date:** 2026-03-28

## Summary

S03 directly owns **R004**, **R005**, and **R010**, and it supports **R006** and **R011**. The good news is that the current runtime already has the right thin seams for this slice: `helper.js` captures `data-choice` clicks and updates the indicator bar, `frame-template.html` gives fragment screens clear comparison surfaces, and `server.cjs` persists browser choices to `state/events` without turning the browser into a workflow engine.

The main constraint is also the biggest surprise: current selected state is deliberately **ephemeral and container-scoped**. `helper.js` updates the indicator text from the clicked `.options` or `.cards` container only, not from page-wide state, and a reload returns the page to its authored `.selected` baseline. On top of that, `server.cjs` deletes `state/events` when a **new** screen file appears. That means S03 cannot safely “carry forward” by replaying browser state. Carry-forward must stay explicit in authored markup and screen copy, with helper behavior limited to additive selected-state clarity.

## Recommendation

Take the narrow path. Keep S03 focused on two proof points:

1. **Click-assisted clarity**: strengthen or verify helper-selected behavior only through the existing `data-choice` + `.selected` contract.
2. **Terminal-only carry-forward**: prove that the next screen can explicitly show either **Chosen direction** or **Still open** even when no browser click happened and `state/events` is absent or stale.

Do **not** add workflow memory, session ledgers, or new required metadata. If helper changes are needed, they should stay presentation-level and derive only from existing DOM structure. The safest implementation direction is: authored carry-forward screens remain the authority, helper text remains lightweight and additive, and tests should lock the non-goals as hard as the happy path.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Browser choice capture | `skills/brainstorming/scripts/helper.js` + `skills/brainstorming/scripts/server.cjs` | Already sends `data-choice` clicks over WebSocket and appends choice events to `state/events` without adding workflow logic. |
| Fragment vs full-document behavior | `isFullDocument()` + `wrapInFrame()` in `skills/brainstorming/scripts/server.cjs` | Preserves the current compatibility contract and keeps fragment-only defaults out of full-document screens. |
| Comparison-first visual surfaces | `skills/brainstorming/scripts/frame-template.html` | S02 already established the selector surfaces for recommendation, ranking, and carry-forward presentation. |
| Runtime regression coverage | `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/fragment-comparison-defaults.test.js` | These already prove the runtime boundary, event clearing, helper injection, and fragment-only comparison defaults. |

## Existing Code and Patterns

- `skills/brainstorming/scripts/helper.js` — Captures clicks on `[data-choice]`, updates the indicator bar after `toggleSelect(this)` runs, tracks `window.selectedChoice`, and exposes `window.brainstorm.send()` / `window.brainstorm.choice()` for custom pages. The indicator logic is container-local: it inspects the nearest `.options` or `.cards`, not the whole document.
- `skills/brainstorming/scripts/server.cjs` — Serves the newest `.html` file, wraps fragments in the shared frame, injects helper code into both fragments and full documents, appends only choice-bearing events to `state/events`, and deletes `state/events` when a **new** screen file is detected.
- `skills/brainstorming/scripts/frame-template.html` — Provides the shared fragment shell, selection indicator bar, and S02 comparison defaults for `.option.selected`, `.card.selected`, `.label`, `.section`, `.mockup`, and `.options[data-multiselect]`.
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` — The clearest current carry-forward reference. It shows one authored **Chosen direction** block plus a separate **Still open** multiselect block, which is exactly the state split S03 needs to preserve.
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html` — Shows the current winner in authored copy and markup, then offers an explicit carry-forward option beneath it. Reuse this pattern when a recommendation is emerging but alternatives still matter.
- `tests/brainstorm-server/server.test.js` — Already proves helper injection, `state/events` persistence, no-write behavior for non-choice events, and the crucial event-clearing behavior on new screens.
- `tests/brainstorm-server/fragment-comparison-defaults.test.js` — Already proves that carry-forward fragment surfaces exist in wrapped output and that lower-ranked options are not hidden by opacity-based dimming.

## Constraints

- S03 owns **R004**, **R005**, and **R010**; it must also avoid violating **R006** and **R011**.
- Do not add new required metadata beyond existing `data-choice`.
- The browser remains a decision aid. The terminal stays the primary reasoning channel.
- `state/events` is useful context, but it is **not durable carry-forward state**. The server clears it when a new screen file is added.
- Authored `.selected` markup is the only durable selection state on reload. Helper-managed selection is transient.
- Full-document screens remain compatibility-supported only. Any S03 behavior that depends on fragment shell structure must not leak into full-document assumptions.
- The project has no configured language server in this workspace and no DOM-test framework like Playwright, JSDOM, Jest, or Vitest installed at the repo root. Verification should stay lightweight and targeted.

## Common Pitfalls

- **Treating the indicator bar as authoritative carry-forward state** — It is not. The helper computes indicator text from the clicked container only. In the carry-forward example, the page can have three `.selected` items overall while the indicator correctly shows `2 selected` because it only counts selections inside the clicked `data-multiselect` block.
- **Trying to drive the next screen from `state/events`** — New-screen detection deletes `state/events`, so terminal-only flows and browser-click flows both still need explicit authored carry-forward copy on the next screen.
- **Reusing the same filename during slice verification** — `server.cjs` clears `state/events` only when a **new** file appears, not when an existing file is merely updated. The guide already says never reuse filenames; follow that rule in S03 tests too.
- **Inferring workflow semantics from presentation text** — Reading labels like `Chosen direction` or `Still open` inside helper code would drift toward hidden workflow behavior. Keep those semantics authored and visible, not runtime-inferred.

## Open Risks

- If S03 tries to make helper code infer “chosen” versus “still open” from surrounding copy or section labels, it will blur the explicit `data-choice` boundary and violate D006.
- If verification relies only on server-side string checks, helper behavior may look correct on paper while still being confusing in the browser. At least one live runtime check or tight helper-focused regression is warranted.
- If tests start asserting exact indicator copy too broadly, small wording improvements could create brittle failures. Prefer testing semantics: default prompt, single selected label, multiselect count, and no dependence on persisted events.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| HTML/CSS/JS screen structuring | `frontend-design` | installed / available |
| Node.js runtime patterns | `wshobson/agents@nodejs-backend-patterns` | none installed; promising via `npx skills add wshobson/agents@nodejs-backend-patterns` |
| WebSocket transport | `jeffallan/claude-skills@websocket-engineer` | none installed; promising via `npx skills add jeffallan/claude-skills@websocket-engineer` |

## Sources

- Helper-selected state is container-scoped, not page-global, and resets to authored `.selected` state on reload (source: `skills/brainstorming/scripts/helper.js`; live browser check against `skills/brainstorming/examples/visual-companion/carry-forward-summary.html` served through `skills/brainstorming/scripts/server.cjs`).
- Choice events append to `state/events`, but new-screen detection clears the file, so carry-forward cannot depend on event persistence (source: `skills/brainstorming/scripts/server.cjs`; `tests/brainstorm-server/server.test.js`).
- Carry-forward fragment surfaces already exist in the shared frame, including `.options[data-multiselect]` and selected-item emphasis, with proof coverage in regression tests (source: `skills/brainstorming/scripts/frame-template.html`; `tests/brainstorm-server/fragment-comparison-defaults.test.js`).
- The authored carry-forward archetype already models the exact two-state split S03 needs: one explicit chosen direction plus separate unresolved items (source: `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`; `skills/brainstorming/visual-companion.md`).
- The runtime contract still forbids new required metadata beyond `data-choice` and keeps full-document screens in compatibility mode only (source: `skills/brainstorming/visual-companion.md`; `tests/brainstorm-server/visual-companion-contract.test.js`).
