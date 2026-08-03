# Visual Companion Design Kit Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Deliver the approved dependency-free technical-editorial Visual Companion kit, state-aware shell guidance, three distinct responsive exemplars, authoring guidance, adversarial skill evidence, and the required runtime capture matrix without changing the server or terminal-primary protocol.

**Architecture:** Extend the fragment frame additively with semantic CSS tokens and register/composition hooks; keep `helper.js` as the sole progressive-enhancement owner for choice, connection, and footer state. Fragment exemplars consume the shared kit while preserving subject-specific DOM order and `data-choice`; full documents and legacy classless fragments retain their existing ownership. Deterministic Node tests protect structure and behavior, fresh-context agent evals protect guidance, and real-browser verification produces candidate visual-truth captures for human inspection.

**Tech Stack:** Browser-native HTML/CSS/JavaScript, Node.js `assert`/`vm`, existing `ws` test dependency, shell lifecycle tests, real Chromium browser tooling; no external runtime or build dependencies.

**Global Constraints:**

- Base work is preserved on `codex/visual-companion-design-kit`, created from `gamarsoft`; do not discard, overwrite, stage, or revert unrelated user work or the approved untracked packet artifacts.
- Do not modify `skills/brainstorming/scripts/server.cjs`; do not add React, shadcn, Tailwind, CDN assets, remote fonts, icon packages, a build pipeline, or a required Impeccable dependency.
- Preserve keyed access, containment, WebSocket recovery and event ordering, event persistence, lifecycle, fragment-first wrapping, full-document passthrough, `.options`, `.cards`, `toggleSelect(this)`, authored `role`/`tabindex`, `aria-pressed`, and `data-choice` as the only required interaction metadata.
- Preserve first-visual-turn startup after consent, artifact-first sequencing, terminal question-tool continuity, and an explicitly named plain-text degraded fallback; do not move workflow semantics into `helper.js`.
- Existing fragments without kit classes must continue rendering; non-interactive artifacts contain no fake choices and have no footer in layout or the accessibility tree.
- Use the approved opaque light/dark tokens, exact shell copy, exact retry-policy product copy, system font stacks, minimum 44px targets, visible focus, semantic heading order, accessible SVG names, non-color-only states, and reduced-motion handling.
- Keep meaningful content readable at 320px and 200% text zoom, allow approximately 30% copy expansion, avoid viewport horizontal scrolling, and keep the choice footer to at most two lines at 390px.
- Baseline diagram/editorial captures are `reference-only`; comparison-state captures are `semantic-guidance` for synchronization only. New runtime captures are only candidate `visual-truth` until the human inspects and approves them.
- Every behavior/code change follows superpowers:test-driven-development. Guidance edits follow superpowers:writing-skills: baseline without new guidance, exact failure/rationalization evidence, five-or-more fresh-context wording reps per variant with a no-guidance control when the control fails, same-scenario after tests, loophole refactor, and final pressure re-test.
- Do not push or open a PR. Commit each independently reviewed task using conventional commit subjects, but leave approved untracked spec artifacts uncommitted unless the human later directs otherwise.

**Context7 Findings:**

- N/A. The approved solution is browser-native and uses only repository-local behavior plus established web platform features; no external library, framework, or API is introduced.

---

## Plan Context

**Source of truth:**

- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit.md`
- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--gsd-handoff.md`
- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend-direction.md`
- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screen-index.md`
- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/brownfield-ui-extraction.md`

**Invariants:**

- The shell is quiet infrastructure; diagram, product-mockup, and editorial registers share semantic foundations but use materially different compositions.
- Interaction and security behavior do not depend on kit classes. Legacy fragments render additively and full documents never inherit fragment-shell presentation.
- Footer visibility and exact content derive from two observable predicates: whether choices exist and current connection/selection state.
- Waiting and connection strings remain exact and live-announced: `Waiting for the next visual artifact…`, `Connecting…`, `Reconnecting…`, `Connected`, and `Disconnected`.
- Interactive footer strings remain exact: `Choose an option in this artifact, then return to the conversation.`, `Selected: {label}. Return to the conversation to continue.`, `{count} options selected. Return to the conversation to continue.`, and `Connection lost. Reconnect before choosing an option.`
- Selection labels are escaped before insertion; multiple-selection count wording remains plural-ready; no user copy exposes WebSocket, fragment, event log, or auth key.
- Diagram DOM/reading order is Browser, API, Queue, Worker, Retry, Dead-letter, Database at every width; the narrow presentation recomposes instead of shrinking the desktop map.
- Product actions are the only interactive exemplar controls and preserve mouse, Tab, Shift+Tab, Enter, Space, single-selection, reconnect, and persistence behavior.
- Editorial and diagram exemplars are read-only; terminal interaction owns their continuation.
- Impeccable may supply advisory critique/detector evidence but is never required for building, testing, rendering, or using the Companion.

**Non-goals:**

- No server, HTTP, authentication, persistence, routing, lifecycle, DSL, renderer, browser-primary confirmation, theme editor, historical example restyle, generated imagery, or new workflow archetype.
- No durable product claim for the simulated retry-policy screen and no promotion of new captures to visual truth without human approval.

**Register and screen reference:**

| Screen | Contract |
| --- | --- |
| S0 shell | Compact 40–44px branded header/status, exact waiting/connection copy, conditional footer, actual-height scroll accounting |
| S1 diagram | Payment primary path, retry/dead-letter branch, labeled trust boundary; desktop LTR, `<700px` ordered vertical; no choice/footer |
| S2 product | `Simulated product surface`; retry-policy review; desktop product bar + 208px rail + body + 288–320px evidence rail; `<820px` context row and title → proposed → guardrails → evidence → actions |
| S3 editorial | Conclusion-first export-flow memo; desktop ≤72ch reading column + 224–256px rail; `<760px` conclusion → evidence → open → deferred/assumptions; no choice/footer |
| S4 choice | Discoverable unselected, 3px focus ring/2px offset, marker + boundary + surface + `aria-pressed` selected state, 44px targets |
| S5 disconnect | Choice actions unavailable and recovery footer shown; non-interactive screens retain no footer |
| S6 variants | Light/dark, 1440×1000 and 390×844 captures; explicit audits at 320px, 200% zoom, and reduced motion |

**Approved foundation anchors:**

- Tokens: `--vc-canvas`, `--vc-surface`, `--vc-subtle`, `--vc-boundary`, `--vc-ink`, `--vc-muted`, `--vc-faint`, `--vc-info`, `--vc-success`, `--vc-caution`, `--vc-danger`, `--vc-selected-surface`, `--vc-focus` with exact packet hex values.
- Type roles: display, heading, subheading, body, label, annotation, and tabular/mono; 14px minimum user-facing body/control text and 11px only for short high-contrast uppercase eyebrows.
- Composition hooks: canvas, section, cluster, split, rail, stage, callout, legend, and choice; control/region/stage radii 4/8/12px; static sections have no shadow.
- Motion: 120ms color/border and 180ms disclosure maximum; no ambient motion; nonessential transitions removed under `prefers-reduced-motion: reduce`.
- Product copy: `Simulated product surface`, `Review retry policy change`, `Compare the current safeguards with the proposed limits before deciding.`, `Ready for review`, `Current policy`, `Proposed change`, `Evidence`, `Guardrails`, `Approve change`, `Reject change`.

**Adversarial / boundary cases:**

- Zero choices, choices added at boot, initial authored selection, one selection, true multiselect with one or many choices, choices in different containers, malicious HTML in a selected label, missing fragment footer in a full document, and connection state transitions before and after a selection.
- Authored role/tabindex, native button keyboard behavior, repeated keydown, standalone choice, disconnected queueing/reconnect flush, tombstoned recovery, legacy classless fragment, and full-document helper injection without shell contamination.
- Long copy, system font variance, 320px viewport, 200% zoom, 30% expansion, light/dark, reduced motion, DOM versus visual reading order, unavailable actions, and state communication with color disabled.
- Fresh agents choosing a generic card dashboard, fake choices, one universal layout, decorative styling, or required Impeccable despite the viewing task/register contract.

**Backward compatibility:**

- Existing `--bg-*`, `--text-*`, comparison classes, `.section`, `.label`, `.options`, `.option`, `.cards`, `.card`, `.mockup`, and `.split` usages continue to render; new `--vc-*` tokens and register hooks are additive or aliased where appropriate.
- `server.cjs` remains byte-for-byte untouched; existing runtime, branding, auth, lifecycle, WebSocket, useful-artifact, and live-acceptance suites remain green.

## Cross-Task Invariant Mapping

- Invariant: footer depends only on interaction + connection/selection state and uses exact escaped copy.
  - Implemented in: Task 1.
  - Re-verified in: Tasks 4 and 7.
  - Failure mode if omitted: read-only artifacts mislead users, disconnected choices remain actionable, or labels inject markup.
- Invariant: shared foundation is additive and full-document/legacy compatibility remains intact.
  - Implemented in: Task 2.
  - Re-verified in: Tasks 3–5 and 7.
  - Failure mode if omitted: old fragments regress or full documents acquire fragment presentation.
- Invariant: three registers remain distinct and responsive while sharing tokens.
  - Implemented in: Tasks 3–5.
  - Re-verified in: Tasks 6 and 7.
  - Failure mode if omitted: the kit reproduces a universal SaaS-card layout or loses reading order at narrow widths.
- Invariant: terminal-primary and useful-artifact protocol remains unchanged.
  - Implemented in: Task 6 guidance.
  - Re-verified in: Task 6 pressure evals and Task 7 contract suite.
  - Failure mode if omitted: browser artifacts replace question-tool continuity or fake choices appear.
- Invariant: runtime/security/interaction behavior remains styling-independent.
  - Implemented in: Tasks 1–5 through additive hooks and preserved selectors.
  - Re-verified in: Task 7 full suite and browser interaction matrix.
  - Failure mode if omitted: keyboard, event persistence, reconnect, keyed access, or containment silently regresses.
- Invariant: new captures are evidence candidates, not self-approved visual truth.
  - Implemented in: Task 7 naming/reporting.
  - Re-verified in: final handoff to human inspection.
  - Failure mode if omitted: implementation output incorrectly becomes binding design authority.

## Chunk 1: Shell Behavior and Shared Foundation

### Task 1: Conditional Footer State Machine

**Files:**

- Modify: `skills/brainstorming/scripts/helper.js`
- Modify: `skills/brainstorming/scripts/frame-template.html`
- Modify: `tests/brainstorm-server/helper-selection-clarity.test.js`
- Modify: `tests/brainstorm-server/helper.test.js`

**Interfaces and contracts:**

- `setStatus(state)` continues owning exact connection status and additionally drives footer availability without changing WebSocket timing/order.
- Footer discovery stays optional for full documents; the fragment shell exposes `.indicator-bar` and `#indicator-text` as a polite live status only when real choices exist.
- Choice discovery uses `[data-choice]` only; no required metadata is added. Selection label lookup, container scoping, hydration, and `aria-pressed` remain compatible.

**Acceptance criteria:**

- A document with zero choices has no footer in layout/accessibility trees at boot, during connecting/reconnecting/disconnected states, or after content hydration.
- A document with choices shows exact empty copy; one selection shows exact escaped single copy; supported grouped selection shows exact plural copy; connection loss overrides selection copy with exact recovery text until reconnection.
- Reconnection restores the correct empty/single/multiple copy from DOM state; choices are unavailable while disconnected without breaking queued event persistence or recovery.
- Enter/Space, repeated-key suppression, native button behavior, authored role/tabindex, single/multi synchronization, standalone choice behavior, and mouse click event payloads remain unchanged.

**Error handling:**

- Missing footer/status/DOM query APIs are accepted and skipped so full documents remain compatible.
- Unknown connection states fail closed to `Disconnected`; unavailable choices ignore activation while preserving readable state and queued events.
- Selected labels are inserted as text or escaped HTML; malformed markup in a label is displayed literally, never executed.

**Verification:**

- Run RED/GREEN: `cd tests/brainstorm-server && node helper-selection-clarity.test.js && node helper.test.js`
- Expected RED: new footer/copy/disconnect assertions fail against unconditional legacy guidance.
- Expected GREEN: exact-copy, hidden-footer, state-transition, selection, and reconnect tests pass with zero warnings.

**Codebase pointers:**

- `skills/brainstorming/scripts/helper.js`: `setStatus`, `hydrateChoices`, `syncIndicator`, `syncIndicatorFromDocument`, click/keydown handlers, and reconnect callbacks.
- `skills/brainstorming/scripts/frame-template.html`: `.indicator-bar`, `#indicator-text`, `.main`, and existing compatibility classes.
- `tests/brainstorm-server/helper-selection-clarity.test.js`: fake DOM harness and exact state synchronization assertions.
- `tests/brainstorm-server/helper.test.js`: mocked WebSocket/reconnect state machine.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 2: Additive Technical-Editorial Frame Kit

**Files:**

- Modify: `skills/brainstorming/scripts/frame-template.html`
- Create: `tests/brainstorm-server/visual-companion-design-kit.test.js`
- Modify: `tests/brainstorm-server/package.json`

**Interfaces and contracts:**

- Add exact `--vc-*` light/dark token hooks and shared type/composition/register selectors without removing legacy tokens/classes or fragment injection markers.
- Register roots identify diagram, product-mockup, and editorial composition; canvas/section/cluster/split/rail/stage/callout/legend/choice hooks remain presentation-only.
- `#claude-content` remains the fragment mount/scroll owner; full-document ownership stays in `server.cjs` and is not changed.

**Acceptance criteria:**

- Deterministic tests assert every approved token/value, type role, composition hook, register hook, focus/selected/unavailable state, 44px target, reduced-motion query, light/dark theme, and responsive breakpoint contract.
- The main-region waiting state remains exactly `Waiting for the next visual artifact…`; deterministic shell coverage compares it character-for-character while runtime browser validation remains in Task 7.
- Shell header is 40–44px, artifact hierarchy dominates, footer space is conditional/actual-height aware, and legacy classes retain usable presentation.
- Hover changes boundary/text without movement; focus is 3px with 2px offset; selected state has marker/boundary/surface plus `aria-pressed`; static sections do not cast shadows.
- No prohibited dependency, remote asset/font, gradient, decorative grid, ambient motion, or server modification is introduced.

**Error handling:**

- Unsupported CSS features degrade to opaque colors, system fonts, one-column flow, and instantaneous state feedback.
- Unknown or absent kit classes retain legacy frame rendering; no class is required for interaction.

**Verification:**

- Run RED/GREEN: `cd tests/brainstorm-server && node visual-companion-design-kit.test.js && node fragment-comparison-defaults.test.js && node branding.test.js && node server.test.js`
- Expected RED: token/register/responsive/accessibility contract assertions fail before frame changes.
- Expected GREEN: new kit assertions, including exact waiting copy and contract-level CSS/DOM breakpoints, pass; fragment/full-document/branding contracts remain green. Real responsive rendering is deferred to Task 7's browser matrix.

**Codebase pointers:**

- `skills/brainstorming/scripts/frame-template.html`: current theme variables and compatibility patterns.
- `tests/brainstorm-server/fragment-comparison-defaults.test.js`: wrapped-fragment and full-document boundary fixtures.
- `tests/brainstorm-server/branding.test.js`: required shell branding/indicator selectors.
- `tests/brainstorm-server/server.test.js`: fragment wrapping and frame injection contracts.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

## Chunk 2: Three Register Exemplars

### Task 3: Responsive Diagram Exemplar

**Files:**

- Modify: `skills/brainstorming/examples/visual-companion/architecture-data-flow.html`
- Modify: `tests/brainstorm-server/visual-companion-design-kit.test.js`
- Modify: `tests/brainstorm-server/visual-companion-contract.test.js`

**Interfaces and contracts:**

- Fragment root consumes diagram register and shared canvas/stage/legend hooks; subject-specific geometry may remain local.
- Accessible figure/SVG title and description name the payment request, retry/dead-letter branch, and trust boundary.
- No `data-choice`, inline external resource, or full-document root.

**Acceptance criteria:**

- Desktop shows Browser → API → Queue → Worker → Database left-to-right, retry/dead-letter on a second lane, and a 3px labeled trust-boundary rule.
- `<700px` recomposes to Browser, API, Queue, Worker, Retry, Dead-letter, Database in top-to-bottom DOM/reading order; it does not scale the desktop figure into unreadable text.
- Primary/branch connectors, arrowheads, dashed retry/error encoding, neutral/info/caution/danger semantics, ≥14px labels, and ≥13px annotations are structurally testable.
- Noninteractive rendering produces no footer and preserves the existing payment-flow meaning/assumption.

**Error handling:**

- CSS/SVG feature degradation preserves ordered HTML labels and visible relationship text; no information requires hover, motion, or color.
- Overflow stays within the labeled stage; the viewport never scrolls sideways at 320px.

**Verification:**

- Run RED/GREEN: `cd tests/brainstorm-server && node visual-companion-design-kit.test.js && node visual-companion-contract.test.js && node fragment-comparison-defaults.test.js`
- Expected RED: diagram register/order/recomposition assertions fail on the fixed-viewBox baseline.
- Expected GREEN: diagram structural, accessibility, noninteractive, and compatibility assertions pass.

**Codebase pointers:**

- Existing `architecture-data-flow.html` for subject copy and SVG accessible names.
- Frontend-direction sections 5.3 and 5.6 for geometry, order, labels, and accessibility.
- `tests/brainstorm-server/visual-companion-contract.test.js` for useful-artifact/example assertions.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 4: Simulated Retry-Policy Product Mockup

**Files:**

- Create: `skills/brainstorming/examples/visual-companion/retry-policy-review.html`
- Modify: `tests/brainstorm-server/visual-companion-design-kit.test.js`
- Modify: `tests/brainstorm-server/visual-companion-contract.test.js`
- Modify: `tests/brainstorm-server/helper-selection-clarity.test.js`

**Interfaces and contracts:**

- Fragment consumes product-mockup register, stage, rail, section/cluster, and choice hooks; only approve/reject elements use existing `.options`, `.option`, `data-choice`, and `toggleSelect(this)` behavior.
- `data-choice` values are internal and require no additional metadata; approved visible copy remains character-for-character exact.
- Unavailable connection state is shell/helper-owned, not a product-local WebSocket error.

**Acceptance criteria:**

- `Simulated product surface` is always visible; heading/helper/status/section/action strings exactly match the approved product copy deck.
- Desktop has compact product bar, 208px navigation/metadata rail, flexible review body, 288–320px evidence rail, and actions in the body; `<820px` uses context row and title → proposed change → guardrails → evidence → actions order.
- Current/proposed limits, evidence, guardrails, and plausible short simulated data use tabular/mono roles and do not claim a real customer/company/production state.
- Approve and reject are real equal-size 44px choices; reject adds word + danger treatment; mouse/Tab/Shift+Tab/Enter/Space/focus/selection/event/footer semantics remain synchronized.
- Disconnection makes both actions unavailable and shows only shell recovery copy; reconnection restores correct selection state/copy.

**Error handling:**

- Missing helper preserves readable actions as authored content but cannot invent confirmation; helper hydration adds semantics only through established behavior.
- Narrow tables may scroll inside a labeled region; the viewport does not scroll horizontally and long copy wraps without clipping.

**Verification:**

- Run RED/GREEN: `cd tests/brainstorm-server && node visual-companion-design-kit.test.js && node visual-companion-contract.test.js && node helper-selection-clarity.test.js && node ws-protocol.test.js`
- Expected RED: missing exemplar/copy/register/action-state assertions fail.
- Expected GREEN: exact product copy, real-choice semantics, responsive order, and helper/WebSocket invariants pass.

**Codebase pointers:**

- `side-by-side-comparison.html` and `ranked-alternatives.html` for established fragment choice markup only; do not copy their visual card grammar.
- Frontend-direction sections 5.4–5.6 for the product layout, copy, and accessibility contract.
- `helper-selection-clarity.test.js` fake choice harness for activation/state expectations.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

### Task 5: Editorial Carry-Forward Exemplar

**Files:**

- Modify: `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`
- Modify: `tests/brainstorm-server/visual-companion-design-kit.test.js`
- Modify: `tests/brainstorm-server/carry-forward-behavior.test.js`
- Modify: `tests/brainstorm-server/visual-companion-contract.test.js`

**Interfaces and contracts:**

- Fragment consumes editorial register, canvas, section, split/rail, callout, and annotation hooks without `data-choice`.
- Visible authored copy—not events, helper state, or hidden metadata—owns chosen/open/deferred/degraded carry-forward meaning.

**Acceptance criteria:**

- A high-contrast conclusion block leads with the settled drawer-based export-flow decision and one-sentence rationale; evidence follows as a numbered ruled sequence.
- Desktop uses a ≤72ch reading column plus 224–256px metadata rail; `<760px` reads conclusion → evidence → open questions → deferred/assumptions.
- `Open` plus a question marker and `Deferred` plus a distinct marker communicate category without color; no more than one bounded callout and no nested card grid.
- The artifact remains identical with absent/conflicting `state/events`, visibly names degraded/simulated fidelity where applicable, contains no choices, and has no footer.

**Error handling:**

- Missing state/events is accepted because all carry-forward truth is authored; conflicting persisted events are ignored and never rendered.
- Narrow/zoomed layout puts side-rail information into DOM flow at relevant headings and wraps long labels without clipping.

**Verification:**

- Run RED/GREEN: `cd tests/brainstorm-server && node visual-companion-design-kit.test.js && node carry-forward-behavior.test.js && node visual-companion-contract.test.js && node fragment-comparison-defaults.test.js`
- Expected RED: conclusion-first/read-only/register assertions fail on the selectable boxed baseline.
- Expected GREEN: authored continuity, read-only footer absence, responsive order, and event independence pass.

**Codebase pointers:**

- Existing `carry-forward-summary.html` for settled/open/degraded subject meaning.
- `tests/brainstorm-server/carry-forward-behavior.test.js` for absent/conflicting event fixtures.
- Frontend-direction sections 5.5–5.6 for editorial composition and accessibility.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests from acceptance criteria
- [ ] Step 3: Run tests to verify they fail
- [ ] Step 4: Write minimal implementation to pass tests
- [ ] Step 5: Run tests, self-review, commit

## Chunk 3: Behavior Guidance, Evaluation, and Whole-Feature Proof

### Task 6: Three-Register Authoring Contract and Skill Evaluation

**Files:**

- Modify: `skills/brainstorming/visual-companion.md`
- Modify: `skills/frontend-direction/references/impeccable-brownfield-quality-layer.md`
- Modify: `tests/brainstorm-server/visual-companion-contract.test.js`
- Create: `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--skill-eval-results.md`

**Interfaces and contracts:**

- Guide adds the native kit quick reference, viewing-task-to-register selection, positive three-register output contract, composition recipes, responsive/accessibility checks, anti-pattern rules, and optional Impeccable boundary.
- Existing useful-artifact intents and terminal-first protocol retain their exact routing/sequence meaning; product mockup is registered as an `experience` exemplar, not a new workflow archetype.
- Setup reference changes `/impeccable teach` to `/impeccable init` only where initialization is discussed.

**Acceptance criteria:**

- Before guidance edits, fresh-context baseline scenarios reveal and record whether agents produce generic card dashboards, fake choices, universal compositions, missing narrow behavior, required Impeccable, or protocol drift; exact outputs/rationalizations are retained.
- No-guidance control and each candidate wording variant receive at least five independent fresh-context samples where the control exhibits a failure; every flagged match is manually scored and variance recorded.
- Revised guide leads agents to choose diagram/product/editorial by viewing task, use native hooks, preserve exact interaction boundaries, name honest fidelity, and reject generic-card/gradient/decorative-grid/oversized-whitespace patterns.
- Same-scenario after tests comply without making the Companion mandatory, inventing choices, weakening artifact-first/question-tool/degraded-fallback rules, or requiring Impeccable; new rationalizations are either closed and re-tested or documented as a remaining risk.
- Deterministic doc tests assert new register recipe headings/hooks, exemplar registration, optional Impeccable language, stale-command removal, and preservation of all existing protocol pressure scenario headings.

**Error handling:**

- If the no-guidance control does not fail, do not add corrective guidance for that failure; record N/A evidence instead.
- If fresh agents find a new loophole, revise the positive contract or structural slot that matches the failure shape, then repeat five-rep micro-tests and pressure verification.
- If Impeccable is unavailable, record that and continue; its absence cannot fail the feature.

**Verification:**

- Run RED/GREEN: `cd tests/brainstorm-server && node visual-companion-contract.test.js`
- Run baseline/after fresh-context eval campaign using isolated subagents with `fork_turns: "none"`; expected report includes prompts, raw/verbatim outcomes, manual scoring, variance, failures/rationalizations, revisions, and final verdict.
- Expected GREEN: doc contract passes and after-guidance agents consistently produce distinct register-appropriate, accessible, dependency-free artifacts while preserving protocol boundaries.

**Codebase pointers:**

- `skills/brainstorming/visual-companion.md`: useful-artifact routing, quality gate, runtime boundary, example kit, and terminal-primary sequence.
- `skills/brainstorming/references/test-scenarios.md` and `visual-companion-protocol-pressure-scenarios.md`: reusable pressure-test families.
- `skills/writing-skills/SKILL.md` and `testing-skills-with-subagents.md`: mandatory RED/GREEN/REFACTOR and five-rep micro-test method.
- `tests/brainstorm-server/visual-companion-contract.test.js`: current documentation invariants and example registry.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write failing tests and baseline fresh-context scenarios from acceptance criteria
- [ ] Step 3: Run tests/scenarios to verify deterministic RED and document baseline failures
- [ ] Step 4: Write minimal guidance/reference changes to pass tests and close observed failures
- [ ] Step 5: Run deterministic tests plus after/refactor evals, self-review, commit

### Task 7: Whole-Feature Runtime, Accessibility, Visual, and Review Gate

**Files:**

- Modify as fixes require: files owned by Tasks 1–6, excluding `skills/brainstorming/scripts/server.cjs`
- Create: post-implementation PNG captures under `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/`
- Create: `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--verification.md`

**Interfaces and contracts:**

- Runtime evidence uses the real keyed server and candidate capture naming that clearly separates implementation captures from approved baselines.
- Review uses superpowers:requesting-code-review; completion claims use superpowers:verification-before-completion.

**Acceptance criteria:**

- Complete `tests/brainstorm-server` suite passes, including new deterministic tests; `server.cjs` hash/diff is unchanged and dependency manifests add no new dependency.
- Real browser verifies mouse, Tab, Shift+Tab, Enter, Space, focus-visible, single selection, supported multiselect, disconnect/reconnect, event persistence, legacy fragments, and full-document passthrough.
- Browser audits desktop/narrow light/dark, 320px, 200% text zoom, reduced motion, contrast, heading order, live status, SVG names, 44px targets, no color-only meaning, and no viewport horizontal overflow.
- Capture exactly: diagram desktop/narrow × light/dark (4); product unselected desktop/narrow × light/dark (4), desktop-light focus, Enter-selected, disconnected (3); editorial desktop/narrow × light/dark (4); waiting light/dark (2); noninteractive disconnected/reconnecting without footer (1)—18 images total.
- Fresh-context visual reviewer compares all three registers against the semantic contract/reference-intent checklist, treats baselines only according to approved intent, and reports findings; optional Impeccable findings/intentional exceptions are advisory.
- Independent implementation reviews find no blocking spec-compliance or code-quality issues; fixes receive their own RED/GREEN proof and re-review.
- Verification report lists commands, observed results, capture paths, eval verdict, reviewer findings/fixes, commit IDs, remaining risks, and the explicit statement that captures await human visual approval.

**Error handling:**

- Browser/capture infrastructure failures are diagnosed and retried without weakening required states; missing evidence blocks completion rather than being inferred.
- Review findings are fixed within approved scope; genuine spec contradiction, destructive action, or missing implementation-shaping decision is escalated to the human.
- Visual reviewer or Impeccable preference that conflicts with the packet is recorded and rejected with rationale; packet semantics outrank generic taste.

**Verification:**

- Run: `cd tests/brainstorm-server && npm test`
- Run: `git diff --exit-code -- skills/brainstorming/scripts/server.cjs`
- Run repository searches proving no remote/runtime dependency or stale `/impeccable teach` setup reference was introduced.
- Run the 18-state real-browser capture/audit matrix through the real keyed server.
- Expected: all automated suites green, all required evidence present, two review gates approved, no server/dependency drift, and captures presented—not self-approved—for human inspection.

**Codebase pointers:**

- `tests/brainstorm-server/package.json` for the canonical full suite.
- Frontend-direction section 6 for the complete capture/interaction/accessibility matrix and reference-intent checklist.
- `skills/requesting-code-review/SKILL.md` and `skills/verification-before-completion/SKILL.md` for final gates.
- `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/` for approved baseline evidence and post-implementation destination.

- [ ] Step 1: Read codebase pointers and understand existing patterns
- [ ] Step 2: Write any missing failing verification/regression tests before fixes
- [ ] Step 3: Run tests to verify each added regression test fails for the expected reason
- [ ] Step 4: Write minimal fixes required by integration/browser/review findings
- [ ] Step 5: Run full verification, reviews, self-review, commit, and present evidence for human inspection

## Requirement-to-Task Coverage

| Requirement | Task coverage | Whole-feature proof |
| --- | --- | --- |
| R1 dependency-free shared kit | Task 2 | token/dependency/full-suite checks |
| R2 three distinct registers | Tasks 3–6 | capture matrix + fresh visual review |
| R3 conditional exact footer | Task 1 | helper/browser disconnect matrix |
| R4 three browser-verified exemplars | Tasks 3–5 | 15 exemplar captures + audits |
| R5 runtime/security/compat/accessibility/terminal invariants | Tasks 1–7 | complete suite + interaction/accessibility matrix |
| R6 optional Impeccable | Task 6 | absence-compatible tests + advisory report |
| R7 behavior-shaping before/after evidence | Task 6 | retained eval report + deterministic docs test |
| S0 waiting/connection shell | Tasks 1–2 | 3 shell captures + live-status audit |
| S1 diagram | Task 3 | 4 captures + DOM/SVG/no-footer audit |
| S2/S4/S5 product/choice/disconnect | Tasks 1 and 4 | 7 captures + full interaction/persistence audit |
| S3 editorial | Task 5 | 4 captures + event-independence/no-footer audit |
| S6 narrow/dark/zoom/motion | Tasks 2–5 | 320px, 390px, dark, 200%, reduced-motion audit |
| First-visual/artifact-first/question-tool/degraded protocol | Task 6 | existing named pressure scenarios + full doc suite |
| Exact shell/product copy and a11y | Tasks 1–5 | character tests + browser accessibility/copy audit |
| Candidate visual-truth only after inspection | Task 7 | verification report and human handoff |

## Final Completion Gate

- [ ] All seven tasks have task-scoped implementation review approval and their commits are recorded.
- [ ] Full `npm test` output is fresh and green; no claim relies on an earlier run.
- [ ] All 18 captures exist and were inspected together by a fresh-context reviewer.
- [ ] Skill eval evidence includes baseline RED, after GREEN, refactor/retest, and manual scoring.
- [ ] Final diff is reviewed for scope, `server.cjs` is unchanged, approved user artifacts remain preserved, and no push/PR occurred.
- [ ] Human receives the complete diff summary, test/eval/review results, commits, risks, and candidate captures for visual approval.
