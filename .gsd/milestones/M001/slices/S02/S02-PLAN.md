---
estimated_steps: 7
estimated_files: 6
---

# S02: Fragment comparison defaults

**Goal:** Upgrade the shared fragment frame so comparison-first screens make the recommendation, current winner, visible alternatives, and carry-forward scan clearer by default without changing the current HTML/runtime contract.
**Demo:** The S01 fragment archetypes render through the shared frame with clearer comparison emphasis and honest ranked visibility, while existing full-document screens still pass through unchanged and do not inherit the fragment comparison kit.

## Description

This slice directly owns **R002** and **R003**, and it supports **R006**. I’m grouping the work into two tasks because the main risks are clear and tightly related: first, fragment-only defaults could leak into full-document screens unless the boundary is explicitly tested; second, styling could overemphasize the winner and accidentally hide the alternatives. So the slice starts by locking a fragment-only proof surface, then applies the comparison-kit styling pass to the existing S01 archetype structures instead of inventing new metadata or helper behavior. Verification centers on one dedicated regression test plus the existing server/WebSocket suites, because this slice changes the shared frame at a real integration boundary even though it should not require a server rewrite.

## Must-Haves

- Wrapped fragment screens make recommendation, current winner, and visible alternatives easier to parse at a glance by default.
- Ranked fragment screens show a visible current winner while keeping lower-ranked options readable enough for honest comparison.
- Carry-forward sections and comparison labels scan more clearly in fragment screens using the existing authored structures and without introducing new required metadata beyond `data-choice`.
- Full-document screens remain compatibility-supported and do not automatically inherit the fragment comparison defaults.

## Proof Level

- This slice proves: integration
- Real runtime required: no
- Human/UAT required: no

## Observability / Diagnostics

- Runtime signals: wrapped fragment HTML and passthrough full-document HTML remain the inspectable outputs; `state/events` stays unchanged because this slice must not add workflow logic.
- Inspection surfaces: `skills/brainstorming/scripts/frame-template.html`, `tests/brainstorm-server/fragment-comparison-defaults.test.js`, and `tests/brainstorm-server/server.test.js`.
- Failure visibility: regression failures should name the missing fragment-only comparison hook, the missing ranking/carry-forward selectors, or an unexpected full-document contamination path.
- Redaction constraints: keep fixtures and assertions synthetic; do not add secrets, user content, or new runtime logging.

## Verification

- `node tests/brainstorm-server/visual-companion-contract.test.js`
- `node tests/brainstorm-server/fragment-comparison-defaults.test.js`
- `cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
- `node -e "const fs=require('fs');const hook='data-comparison-kit=\"fragment-shell\"';const template=fs.readFileSync('skills/brainstorming/scripts/frame-template.html','utf8');if(!template.includes(hook)){throw new Error('Missing fragment-only shell hook '+hook);}console.log(JSON.stringify({check:'fragment-shell-hook',status:'present',hook}));"`

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/scripts/frame-template.html`, `skills/brainstorming/scripts/server.cjs`, `skills/brainstorming/scripts/helper.js`, `skills/brainstorming/examples/visual-companion/*.html`, `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/visual-companion-contract.test.js`
- New wiring introduced in this slice: fragment-only shared-frame comparison hooks and a dedicated regression test that proves those hooks appear only on wrapped fragments.
- What remains before the milestone is truly usable end-to-end: S03 must make chosen vs still-open state explicit in click-assisted and terminal-only flows, and S04 must validate the assembled behavior against the real companion entrypoint.

## Tasks

- [x] **T01: Lock the fragment-only proof surface** `est:45m`
  - Why: S02 supports R006, and the highest-risk failure is leaking comparison-kit behavior into full-document screens. The slice needs a stable proof surface before broader CSS changes land.
  - Files: `skills/brainstorming/scripts/frame-template.html`, `tests/brainstorm-server/fragment-comparison-defaults.test.js`, `tests/brainstorm-server/server.test.js`
  - Do: Add a stable fragment-only shell hook inside the shared frame that does not require any new author metadata, then create a dedicated regression test that renders representative fragment and full-document inputs through the existing server path and asserts that only wrapped fragments expose the comparison-kit shell. Extend `server.test.js` only where needed to keep the compatibility boundary coverage adjacent and explicit.
  - Verify: `node tests/brainstorm-server/fragment-comparison-defaults.test.js && cd tests/brainstorm-server && node server.test.js`
  - Done when: there is a passing regression test that fails if fragment wrapping loses the comparison-kit shell or if full-document passthrough starts receiving fragment-only hooks.
- [x] **T02: Implement the shared comparison-kit defaults** `est:1h`
  - Why: R002 and R003 are the slice’s core value. The shared frame already has the right primitives; it now needs comparison-first emphasis that stays honest about lower-ranked alternatives.
  - Files: `skills/brainstorming/scripts/frame-template.html`, `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`, `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`, `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`, `tests/brainstorm-server/fragment-comparison-defaults.test.js`
  - Do: Upgrade the shared-frame tokens and CSS for the existing S01 structures (`.subtitle`, `.label`, `.section`, `.mockup`, `.options`, `.cards`, `.option.selected`, `.card.selected`, `.letter`, and `.options[data-multiselect]`) so recommendation, current winner, ranked order, and carry-forward scanning are clearer by default. Keep non-winning options readable, avoid helper or server behavior changes, and make only minimal example edits if one of the shipped archetypes needs an optional hook for the new styles.
  - Verify: `node tests/brainstorm-server/fragment-comparison-defaults.test.js && node tests/brainstorm-server/visual-companion-contract.test.js && cd tests/brainstorm-server && node server.test.js && node ws-protocol.test.js`
  - Done when: wrapped fragment examples inherit clearer comparison defaults from the shared frame, the current winner is visibly distinct without suppressing alternatives, carry-forward sections scan cleanly, and the full regression chain passes.

## Files Likely Touched

- `skills/brainstorming/scripts/frame-template.html`
- `tests/brainstorm-server/fragment-comparison-defaults.test.js`
- `tests/brainstorm-server/server.test.js`
- `skills/brainstorming/examples/visual-companion/ranked-alternatives.html`
- `skills/brainstorming/examples/visual-companion/annotated-recommendation.html`
- `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
