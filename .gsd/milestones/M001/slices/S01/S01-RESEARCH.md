# M001/S01 — Research

**Date:** 2026-03-27

## Summary

S01 owns the authoring-contract side of M001: **R001, R007, R008, R009, and R012**. It also materially supports **R006** and the future delivery of **R010** by making the fragment/full-document boundary and degraded-mode language explicit before runtime work begins. The main finding is that the current companion stack is already stable and deliberately small: `visual-companion.md` explains the existing browser loop, `server.cjs` preserves a thin fragment/full-document contract, `helper.js` is additive and `data-choice`-based, and `server.test.js` already locks those boundaries in place. That means S01 should stay mostly documentation-and-example driven, not runtime driven.

The biggest gap is not capability but contract clarity. The current `skills/brainstorming/visual-companion.md` is still a broad “show visuals when helpful” guide. It includes generic fragments, cards, split layouts, and `data-choice` rules, but it does **not** yet define the four comparison-first archetypes, does **not** yet bind screen creation to `/frontend-design` or `$frontend-design`, and does **not** yet explain a bounded first-use design-context workflow. A second important finding is that this repo currently has **no `.impeccable.md`** in the root, so the “reuse repo design context if present” rule matters as a contract but will usually fall through to one-time session capture or degraded mode in the repo’s current state.

## Recommendation

Take a **contract-first, examples-backed documentation pass** in `skills/brainstorming/visual-companion.md`, not a runtime rewrite. S01 should explicitly define exactly four archetypes, show one concrete authored fragment example for each, and state that companion screen creation routes through `/frontend-design` or `$frontend-design` as a **screen-structuring** step for brainstorming rather than a near-final mockup step.

Document the first-use workflow in one bounded order and keep it operationally light: **(1) current instruction context, (2) repo design-context source if present, (3) minimal one-time session capture, else (4) explicit degraded mode**. Because the current repo has no `.impeccable.md`, S01 should also be explicit that repo-context reuse is opportunistic, not assumed. Finally, keep the full-document rule prominent: fragment screens are the default and the place where downstream comparison-kit defaults will land; full documents remain valid but compatibility-only in v1.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Fragment vs full-document rendering boundary | `skills/brainstorming/scripts/server.cjs` (`isFullDocument`, `wrapInFrame`) | This already enforces the compatibility contract S01 must preserve; docs should explain it, not replace it. |
| Choice capture and visible selected state | `skills/brainstorming/scripts/helper.js` with `data-choice`, `toggleSelect(this)`, `.options` / `.cards` | This is the only required metadata boundary in M001 and keeps helper behavior additive instead of workflow-driven. |
| Regression safety for runtime behavior | `tests/brainstorm-server/server.test.js` and `tests/brainstorm-server/ws-protocol.test.js` | These already protect helper injection, fragment wrapping, full-document passthrough, reload behavior, and event persistence. S01 should align with these constraints. |

## Existing Code and Patterns

- `skills/brainstorming/visual-companion.md` — current operating guide for offering the companion, running the server, authoring fragments, and using `data-choice`. Strong on baseline usage, weak on comparison-first product contract.
- `skills/brainstorming/scripts/server.cjs` — serves the newest `.html`, wraps fragments in the shared frame, injects `helper.js` into both wrapped fragments and full documents, and writes choice events to `state/events`.
- `skills/brainstorming/scripts/helper.js` — click capture is keyed off `[data-choice]`; indicator text and selected state stay additive and local to authored markup.
- `skills/brainstorming/scripts/frame-template.html` — already exposes the basic authoring kit (`.options`, `.cards`, `.split`, `.pros-cons`, `.mockup`) that S02 can extend; S01 should reference these as the fragment surface area, not invent a new DSL.
- `tests/brainstorm-server/server.test.js` — verifies that full HTML documents are served as-is except for helper injection, while fragments are wrapped and get the shared frame. This is the clearest proof that full-document parity must remain explicit and limited.
- `tests/brainstorm-server/package.json` — runtime tests only depend on `ws` as a test client; the actual server remains zero-dependency, which reinforces the “small additive changes only” boundary.

## Constraints

- S01 must preserve the existing HTML/runtime contract: fragments are wrapped, full documents are passed through, and helper injection applies in both cases.
- S01 cannot rely on new required metadata beyond existing `data-choice`; authored examples and rules must fit the current helper boundary.
- The current repo root has no `.impeccable.md`, so the “reuse repo design context” rule must be written as a conditional path, not as an assumed happy path.
- The current `frontend-design` and `teach-impeccable` skill materials are enough to justify a one-time design-context workflow, but the brainstorming guide will need to restate the workflow explicitly so authors do not have to infer it from transitive skill lore.
- S01 should treat `/frontend-design` or `$frontend-design` as a **screen-structuring** pass for comparison screens; if phrased too broadly, authors may drift into generic visual polish instead of decision support.

## Common Pitfalls

- **Turning S01 into a styling slice** — avoid adding frame/helper/runtime behavior here unless a documentation claim cannot be supported otherwise. The gap is contract clarity, not missing transport infrastructure.
- **Documenting archetypes without authored examples** — the current guide already has generic patterns; S01 needs concrete comparison-first examples or authors will keep improvising.
- **Implying full-document parity** — `server.cjs` and `server.test.js` clearly preserve full-document validity without frame wrapping. S01 should repeat that full documents stay valid but do not automatically inherit fragment defaults.
- **Making `frontend-design` feel mandatory-and-heavy on every turn** — the requirement is first-use bounded context plus reuse, not a repeated questionnaire. Keep the one-time session capture minimal and reusable.
- **Hiding degraded mode** — if design context is unavailable or declined, the docs must say the screen is being produced in explicit degraded mode rather than pretending `/frontend-design` ran.

## Open Risks

- The installed local `frontend-design` skill text is aesthetics-heavy, while neighboring design skills assume a stronger context-gathering protocol and `.impeccable.md` fallback. If S01 does not restate the brainstorming-specific workflow clearly, different agents may apply the rule inconsistently.
- Because the repo currently lacks a checked-in design-context file, live sessions may hit the first-use context path often. If the minimal capture is not tightly bounded, runtime friction could undermine the whole authoring rule.
- The current guide is broad enough that authors could keep producing generic mockups, diagrams, or layout screens unless the four archetypes are named as the default M001 product surface.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| Comparison-screen authoring / frontend composition | `frontend-design` | installed (`/Users/gamarsoft/.gsd/agent/skills/frontend-design/SKILL.md`) |
| Persistent design-context capture | `teach-impeccable` | installed (`/Users/gamarsoft/.gsd/agent/skills/teach-impeccable/SKILL.md`) |
| Frontend design ecosystem fallback | `anthropics/skills@frontend-design` | available via `npx skills add anthropics/skills@frontend-design` |
| WebSocket runtime work (not primary for S01) | `jeffallan/claude-skills@websocket-engineer` | available via `npx skills add jeffallan/claude-skills@websocket-engineer` |
| Design-context search fallback | no clearly better external skill than installed local skills | none found worth preferring |

## Sources

- The current guide is still general-purpose: offer rule, server loop, fragment/full-document explanation, generic option/card/split patterns, and `data-choice` rules exist, but the four M001 archetypes and `frontend-design` workflow do not. (source: `skills/brainstorming/visual-companion.md`)
- Fragment wrapping and full-document passthrough are hard-coded in the runtime via `isFullDocument()` and `wrapInFrame()`, with helper injection appended to the served page either way. (source: `skills/brainstorming/scripts/server.cjs`)
- Choice tracking is intentionally additive and `data-choice`-based: click capture finds `[data-choice]`, indicator text reflects selected items, and `toggleSelect` only manages local selection classes. (source: `skills/brainstorming/scripts/helper.js`)
- The shared frame already provides the reusable fragment authoring kit surface: header, indicator bar, typography helpers, `.options`, `.cards`, `.split`, `.pros-cons`, and mockup primitives. (source: `skills/brainstorming/scripts/frame-template.html`)
- Compatibility is already protected by tests: full documents are served as-is except for helper injection, fragments are wrapped, and `state/events` persists only choice-bearing interactions. (source: `tests/brainstorm-server/server.test.js`)
- The repo currently has no `.impeccable.md` at the root, so repo-context reuse is a future/conditional path rather than a present default. (source: repo root inspection)
- `teach-impeccable` writes project design context to `.impeccable.md`, which makes it the natural repo design-context source when one exists. (source: `/Users/gamarsoft/.gsd/agent/skills/teach-impeccable/SKILL.md`)
- External skill discovery confirms `frontend-design` is the strongest directly relevant ecosystem skill by install count and topic fit; WebSocket-focused skills exist but are secondary for this slice. (source: `npx skills find "frontend design"`; `npx skills find "websocket"`; `npx skills find "design context"`)
