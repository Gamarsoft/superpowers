# S01: Routing, quality gate, and active example refresh

**Goal:** Tighten the companion’s written routing and pre-display rules, and ship stronger versions of the three active example fragments inside the existing four-archetype contract.
**Demo:** A future agent reading `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and the three active example files can tell when to stay in terminal, when a screen must be blocked, and what a decision-capable fragment looks like without touching runtime code.

## Must-Haves

- `skills/brainstorming/SKILL.md` routes the companion only to genuinely visual questions and keeps conceptual, scope, and text-first turns in terminal.
- `skills/brainstorming/visual-companion.md` contains an explicit pre-display checklist, a hard `no placeholder screens` rule, and revise-or-stay-terminal failure behavior.
- `side-by-side-comparison.html`, `ranked-alternatives.html`, and `annotated-recommendation.html` become more concrete and decision-capable, while `carry-forward-summary.html` remains untouched.
- The tightened rules and active-example boundary are covered by contract-level regression checks.

## Proof Level

- This slice proves: contract
- Real runtime required: no
- Human/UAT required: no

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- If the contract test fails during slice work, inspect the named assertion in stderr/stdout and confirm it points to missing S01 wording or active-example boundary drift.
- `git diff --name-only -- skills/brainstorming/examples/visual-companion`

## Observability / Diagnostics

- Runtime signals: none; this slice closes on doc/example artifacts plus contract-test output
- Inspection surfaces: `tests/brainstorm-server/visual-companion-contract.test.js`, the edited markdown files, and the three active example fragments
- Failure visibility: failing assertion names the missing wording or boundary drift directly in the contract test output
- Redaction constraints: none

## Integration Closure

- Upstream surfaces consumed: M001’s locked four-archetype contract, fragment-first runtime boundary, and existing `visual-companion-contract.test.js` proof surface
- New wiring introduced in this slice: none beyond extending the existing contract-test assertions to cover the stricter routing bar and active-example boundary
- What remains before the milestone is truly usable end-to-end: S02 must corroborate the refreshed docs and examples through the real companion entrypoint and existing lifecycle/acceptance stack

## Tasks

- [x] **T01: Extend the contract regression for the stricter S01 bar** `est:35m`
  - Why: S01 should close on mechanical proof, not a prose-only claim.
  - Files: `tests/brainstorm-server/visual-companion-contract.test.js`
  - Do: Add assertions for genuinely-visual routing language, terminal fallback for conceptual/text-first turns, the committed checklist items, the hard `no placeholder screens` rule, revise-or-stay-terminal failure behavior, and the active-example boundary that keeps `carry-forward-summary.html` out of scope.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the contract test fails on missing S01 requirements and will pass only when the tightened docs and in-scope example boundary are actually present.

- [x] **T02: Tighten routing and pre-display guidance in the skill docs** `est:45m`
  - Why: The browser routing bar and the quality gate both live in authored guidance, not runtime code.
  - Files: `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`
  - Do: Tighten `SKILL.md` so the companion is clearly for genuinely visual questions only; add the committed checklist, `no placeholder screens`, and revise-or-stay-terminal behavior to `visual-companion.md`; keep the four-archetype, `data-choice`, and runtime-boundary language intact; make the active-example boundary explicit.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the docs explicitly encode R013-R016, the active-example boundary is clear, and the contract test passes for the new wording.

- [x] **T03: Refresh the three active example fragments against the new bar** `est:1h`
  - Why: The docs only become trustworthy when the copyable examples embody the stricter quality bar.
  - Files: `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`, `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
  - Do: Rewrite the three in-scope examples so they show concrete, subject-specific visual decisions rather than generic shells; keep flow-style treatment genuinely visual where used; preserve the current archetype count and interaction boundary; do not modify `carry-forward-summary.html`.
  - Verify: `node tests/brainstorm-server/visual-companion-contract.test.js`
  - Done when: the three active examples are more concrete, the contract test still passes, and `git diff --name-only -- skills/brainstorming/examples/visual-companion` shows only the three in-scope example files changed.

## Files Likely Touched

- `tests/brainstorm-server/visual-companion-contract.test.js`
- `skills/brainstorming/SKILL.md`
- `skills/brainstorming/visual-companion.md`
- `skills/brainstorming/examples/visual-companion/side-by-side-comparison.html`
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
