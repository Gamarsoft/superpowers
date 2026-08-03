# Visual Companion Guide

Use the visual companion for temporary, subject-relevant browser artifacts when seeing the structure, sequence, relationship, state, or visual direction materially improves the current brainstorming step.
If a choice survives, carry it into the frontend-direction follow-on prompt. The later frontend-direction session must capture it in packet prose, screenshots, browser captures, or approved generated images before treating it as durable direction.

## Useful-artifact authoring contract

Choose the smallest useful artifact intent for the current viewing task. These intents are examples, not an exhaustive whitelist:

1. **compare**
   - Show side-by-side directions or ranked alternatives when visual contrast helps a decision.
2. **explain**
   - Show an annotated recommendation, screenshot, evidence board, or focused visual callout.
3. **map**
   - Show architecture, data flow, state, sequence, dependency, journey, or relationship structure.
4. **experience**
   - Show a mockup, wireframe, prototype fragment, layout, or interaction-state preview.
   - [retry-policy product review](examples/visual-companion/retry-policy-review.html) is an `experience` exemplar: it demonstrates a simulated product surface inside the existing useful-artifact flow.
5. **synthesize**
   - Show a chosen direction, still-open questions, or carry-forward summary.

Comparison patterns remain first-class recommendations: **side-by-side comparison**, **ranked alternatives**, **annotated recommendation**, and **carry-forward summary**. Use them when comparison is the viewing task; do not invent fake alternatives when one direct diagram explains the subject better.

## Native kit quick reference

Use the shared frame's native classes and `--vc-*` tokens before adding subject-specific CSS.

| Hook | Authoring role |
|---|---|
| `vc-canvas` | One artifact root; pair new kit artifacts with a presentation register. |
| `vc-section` | Semantic region separated by rhythm or a rule, not automatically boxed. |
| `vc-cluster` | Tightly related content or controls. |
| `vc-split` | Asymmetric main/supporting composition. |
| `vc-rail` | Context, evidence, status, or metadata beside flexible content. |
| `vc-stage` | Dominant diagram or product surface. |
| `vc-callout` | One short, labeled message with semantic emphasis. |
| `vc-legend` | Compact key next to the encoding it explains. |
| `vc-choice` | A real elevated choice using the existing selection contract. |

`data-vc-register` is presentation metadata used by native kit CSS; it does not add runtime interaction behavior. `data-choice` remains the only supported interaction metadata.

## Viewing task to register

Select the register from what the user must judge by seeing, not from a universal page template:

- **Diagram** — inspect sequence, topology, dependency, state transition, or trust boundary.
- **Product mockup** — judge an application state, workflow, control, evidence set, or real product decision.
- **Editorial / synthesis** — understand or verify a conclusion, evidence chain, open questions, and carry-forward context.

Artifact intent still controls routing. Registers control visual composition inside the existing intent: a product mockup is an `experience` artifact, not a new workflow archetype.

## Three-register output contract

For each authored companion artifact, complete these six authoring slots in order. They are checks, not literal DOM order:

1. Name the viewing task and honest fidelity.
2. Choose one register root and native composition.
3. Encode the subject with the register recipe below.
4. Add interaction only where the task contains a real choice.
5. Specify narrow recomposition while preserving DOM and reading order.
6. Deliver the artifact first, explain what it supports, then ask the terminal confirmation with the platform question tool when available.

### Diagram register recipe

Root the fragment at `class="vc-canvas" data-vc-register="diagram"`. Compose one dominant `vc-stage` with a nearby `vc-legend`; use subject-specific nodes, connectors, lanes, branches, numbered steps, and labeled boundaries to expose relationships spatially. At narrow width, recompose the ordered path top-to-bottom instead of shrinking the desktop map. Omit `.options`, `data-choice`, and selection behavior when the map has no real choice.

### Product mockup register recipe

Root the fragment at `class="vc-canvas" data-vc-register="product-mockup"`. Compose a coherent application state with a `vc-stage`, contextual `vc-rail`, and `vc-section` / `vc-cluster` groupings; use `vc-split` or rails for the proposed change, guardrails, and evidence. Only real decisions become `.options` containing `.option.vc-choice` elements with `data-choice` and `toggleSelect(this)`. Label the artifact as a simulated product surface and simulated evidence where applicable. At narrow width, preserve context → title → proposed change → guardrails → evidence → actions; put wide data in a labeled scroll region rather than making the viewport scroll sideways.

### Editorial / synthesis register recipe

Root the fragment at `class="vc-canvas" data-vc-register="editorial"`. Lead with the conclusion, then numbered evidence, open questions, and deferred assumptions. Use a reading column with `vc-section`, `vc-split` / `vc-rail`, no more than one `vc-callout`, and rules and rhythm instead of a card grid. At narrow width, preserve conclusion → evidence → open questions → deferred assumptions in the DOM and reading order. Keep a decision memo read-only unless it presents a real unresolved choice; write settled decisions into visible authored copy.

## Responsive and accessibility checks

Before display, verify the authored fragment at desktop and 390px:

- DOM and reading order preserve the viewing task when columns, rails, or connectors collapse.
- The viewport does not scroll sideways; a necessary wide data region has an accessible label and local scrolling.
- Text and diagram labels remain readable without hover or zoom, and meaning is not encoded by color alone.
- Real controls keep at least a 44 × 44px target, visible `focus-visible` treatment, keyboard activation, and synchronized selected/unavailable state.
- Non-interactive diagrams have an accessible title/description; legends supplement rather than replace direct labels.
- Motion is nonessential and respects reduced-motion preferences.

## Visual anti-patterns

Reject a generic card dashboard or one universal composition across registers. Use spatial relationships for diagrams, application structure for product mockups, and reading rhythm for editorial artifacts.

Gradients, decorative grids, glass effects, and oversized whitespace are not information hierarchy. Do not box every content group, tint every node, fabricate choices, or let product mockups resemble explanatory diagrams. Subject-specific information determines the layout.

## Optional Impeccable quality layer

Impeccable is optional advisory authoring support, not required setup or a runtime/test dependency. If it is installed and the artifact warrants review, use a bounded critique, audit, layout/typeset, polish, or detector pass after choosing the viewing task and register. Review findings against project truth, the native contract, and the artifact's viewing task; express accepted changes in native HTML/CSS.

If Impeccable is unavailable, continue with the native kit and examples. Its absence cannot block authoring, serving, testing, or using the Companion.

## Frontend-design alignment

When frontend direction is required, the companion should usually show one of these:

- annotated screenshots from the current product
- wireframe-to-direction comparisons
- HTML comparison layouts that the follow-on frontend-direction session can translate into packet prose and durable evidence if chosen
- carry-forward summaries of the chosen visual direction

The companion is still for **decision-making**, not for pretending the chosen reference or screenshot is already final implemented UI.
The follow-on frontend-direction packet should point to durable packet decisions, screenshots, browser captures, or approved generated images, not to raw HTML companion files.

## Browser surface rule

When browser interaction is needed for companion work:

- if running in Codex App, use `browser:control-in-app-browser` and the in-app browser
- if that capability is unavailable, use installed capability discovery, then `playwright-cli`

Do not default to `playwright-cli` when the Codex App in-app browser is available.

## Carry-forward authoring rule

Carry-forward continuity must live in visible authored copy, not in helper state, hidden metadata, or persisted browser events.

- Use **Chosen direction** when a recommendation or decision is being carried forward to the next screen.
- Use **Still open** when comparison work remains unresolved and should stay visibly unsettled.
- Use **Degraded mode** when richer design context was unavailable, declined, or insufficient so the screen remains honest about its low-assumption status.
- These labels should stay correct whether `state/events` exists, is empty, or was cleared on a newer screen.

## Screen creation rule

When creating or revising companion screens, use frontend-direction heuristics for structure and comparison clarity when helpful, but do not start the full frontend-direction phase inside brainstorming.

This is a **brainstorming structuring pass**, not a requirement for near-final visual polish. The purpose is:

- clear layout hierarchy
- comparable alternatives
- readable decision annotations
- reusable fragment structure

If an artifact does not improve understanding or decision clarity, stay in terminal mode.

## First-use design-context workflow (bounded, required order)

Before the first companion screen in a session, follow this exact order:

1. **Instruction context first**
   - Reuse constraints already present in system/developer/user instructions.
2. **Repo design-context source if present**
   - Reuse repository context files such as anchoring docs, frontend packets, screenshots, browser captures, or approved generated image references when they exist.
3. **One-time minimal session capture**
   - If context is still missing, capture only the minimum needed design cues once, then reuse for the session.
4. **Explicit degraded mode**
   - If context is unavailable, declined, or insufficient, proceed in **degraded mode** and say so explicitly.

Degraded mode means: keep screens low-assumption, emphasize structure over style, and avoid pretending project-specific design context exists.

## Offer rule

Offer the companion once for consent only when the upcoming question is genuinely visual.

Suggested offer message:

> Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons, and other visuals as we go. This feature is still new and can be token-intensive. Want to try it? (Requires opening a local URL)

Wait for acceptance before browser work.

## Per-question decision rule

Even after acceptance, decide per turn whether browser output helps more than text.

Test: **Is this materially easier to judge by seeing than by reading?**

If yes, the first later genuinely visual question starts the companion path instead of remaining terminal-only, and each qualifying visual turn stays artifact-first: author or refresh the visual artifact first, make it viewable, tell the user what they are viewing and what decision it supports, then ask the decision or confirmation in terminal with the platform question tool when available.

Even after earlier browser use, that terminal decision prompt still applies on later qualifying visual turns.

If the platform question tool is unavailable, fall back to plain terminal text with the same framing, and name that as degraded behavior instead of normalizing it.

For conceptual, scope, and text-first turns, stay in terminal.

## Companion stop rule

Stop using the companion for the current decision when the visual artifact has done its job:

- the user can choose, reject, or defer the visible direction
- the remaining decision is textual, behavioral, or implementation-boundary work
- the winning idea can be summarized for the frontend-direction follow-on prompt

Do not keep refreshing browser artifacts to polish presentation, add ornamental variants, or replace guided discovery. If more visual work is still needed, the next artifact must name a specific viewing task and pass the pre-display quality gate.

## Pre-display quality gate

Before showing a screen, name the viewing task: what the user should be able to inspect, understand, compare, or decide after seeing it. Then verify all five checks in order:

1. **Genuinely visual fit**
   - The decision must be materially easier to judge by seeing than by reading.
2. **Concrete subject-specific visual content**
   - The screen must show artifacts tied to the actual subject, workflow, or options under discussion.
3. **Useful visual encoding**
   - The artifact exposes the differences, structure, sequence, state, evidence, or spatial relationship that matters.
4. **Clear viewing task**
   - The user can tell what to inspect, understand, or decide without narration doing all the work.
5. **Honest fidelity**
   - Assumptions, degraded context, and unresolved details are visible instead of implied away.

No placeholder screens.
Irrelevant decoration stays in terminal, not the companion.
If any checklist item fails, revise the artifact or stay in terminal.

## Runtime compatibility boundary (do not exceed)

The current runtime contract is intentionally small:

- Fragment-first authoring is default.
- `full-document` screens remain supported for compatibility, but they are not the v1 default surface.
- `data-choice` is optional per artifact and remains the only supported interaction metadata when selection is useful.
- `data-vc-register` is an optional presentation hook for native-kit CSS, not runtime interaction metadata; legacy fragments do not require it.
- Use `toggleSelect(this)` on selectable cards/options so helper state and indicator text stay consistent.
- The helper progressively adds keyboard focus, button semantics, Enter/Space activation, and synchronized `aria-pressed` state; authored `role` and `tabindex` values remain authoritative.
- `.options` and `.cards` are recognized selection containers.
- `data-multiselect` is optional and only for true multi-select behavior.

Do not introduce new required interaction metadata keys beyond `data-choice` in v1.

## Example kit

- [side-by-side comparison](examples/visual-companion/side-by-side-comparison.html)
- [ranked alternatives](examples/visual-companion/ranked-alternatives.html)
- [annotated recommendation](examples/visual-companion/annotated-recommendation.html)
- [carry-forward summary](examples/visual-companion/carry-forward-summary.html)
- [architecture data flow](examples/visual-companion/architecture-data-flow.html)

### Active example refresh boundary (M002)

Refresh only these active examples when maintaining the v1 companion contract:

- `side-by-side-comparison.html`
- `ranked-alternatives.html`
- `annotated-recommendation.html`

`carry-forward-summary.html` stays outside this refresh boundary unless a direct contradiction is found.

All examples stay fragment-first and use only the existing `data-choice` interaction boundary.

## How the server behaves

- Server serves the newest `.html` in `screen_dir`.
- If content is a fragment, runtime wraps it in the shared frame template.
- If content is a `full-document`, runtime serves it as-is (plus helper injection).
- Browser clicks with `data-choice` are appended to `state_dir/events`.
- Explicit `window.brainstorm.choice(...)` events are also persisted.

## Start and loop

### Start session

```bash
# Start after consent. --open opens the first pushed screen and --project-dir
# persists the session for a same-port restart.
scripts/start-server.sh --project-dir /path/to/project --open
```

Capture:

- `url`
- `screen_dir`
- `state_dir`

With `--open`, still share the returned URL as a fallback for headless or remote setups. The URL contains a session key (`?key=…`): always give the user the **complete** URL from the `url` field, never a bare `http://host:port`. The key gates HTTP and WebSocket access; after first load the browser remembers it in a cookie.

Pass the project root as `--project-dir` so sessions persist in `.superpowers/brainstorm/` and survive restarts. Without it, files are stored in `/tmp` and are cleaned up. If startup output was not captured, read `$STATE_DIR/server-info` for the URL and port.

### Platform lifecycle

**Claude Code:** the default command backgrounds the server. On Windows it switches to foreground mode, so use `run_in_background: true` and then read `$STATE_DIR/server-info`.

**Codex:** Codex reaps background processes. The script detects `CODEX_CI` and switches to foreground mode; run the command normally.

**Gemini CLI:** pass `--foreground` and use the platform background shell mechanism.

**Copilot CLI:** pass `--foreground` and use its async Bash mode, retaining the returned shell id.

In other environments, keep the server running across turns with the platform's background mechanism. If a returned URL is unreachable from a remote or containerized browser, bind a non-loopback host and set the host printed in the URL:

```bash
scripts/start-server.sh \
  --project-dir /path/to/project \
  --host 0.0.0.0 \
  --url-host localhost
```

Use `--url-host` to control the hostname returned in startup JSON.

### Iteration loop

1. Confirm server is alive (`state_dir/server-info`; restart if `state_dir/server-stopped` exists). Restart with the same `--project-dir`; the server reuses its port and an open tab reconnects on its own.
2. Write a new `.html` file into `screen_dir` (never reuse filenames).
3. Tell the user what they are viewing and what decision it supports.
4. On the next turn, combine terminal feedback with `state_dir/events` (terminal feedback remains primary).
5. Iterate or move forward with a new file name (`*-v2.html`, etc.).
6. If a direction is chosen, translate the winning idea into packet notes and durable visual evidence before treating it as durable.
7. When returning to terminal-only discussion, push a waiting/transition screen.

## Fragment authoring baseline

Minimal selectable fragment:

```html
<h2>Which direction should we carry forward?</h2>
<p class="subtitle">Compare clarity, implementation risk, and extensibility.</p>

<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Option A</h3>
      <p>Short explanation.</p>
    </div>
  </div>

  <div class="option" data-choice="b" onclick="toggleSelect(this)">
    <div class="letter">B</div>
    <div class="content">
      <h3>Option B</h3>
      <p>Short explanation.</p>
    </div>
  </div>
</div>
```

## Diagnostic references

- Frame template: `skills/brainstorming/scripts/frame-template.html`
- Helper behavior + `data-choice` handling: `skills/brainstorming/scripts/helper.js`
- Runtime fragment/full-document behavior: `skills/brainstorming/scripts/server.cjs`
- Runtime regressions: `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`

## Cleanup

```bash
scripts/stop-server.sh $SESSION_DIR
```

Project sessions persist under `.superpowers/brainstorm/` after cleanup; only `/tmp` sessions are removed on stop.
