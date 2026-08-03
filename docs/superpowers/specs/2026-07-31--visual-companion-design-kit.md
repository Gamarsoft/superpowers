# Visual Companion Design Kit

## 1. Executive Summary

The Visual Companion runtime is useful and secure, but the demonstrated artifacts
look too much like variations of the same generic SaaS dashboard. The first
delivery will add a dependency-free authoring system that makes diagrams, product
mockups, and synthesis artifacts feel intentionally designed for their job.

The chosen direction is a **native Companion Design Kit with an optional
Impeccable quality pass**. The kit borrows the useful ideas behind shadcn-style
systems—semantic tokens, explicit states, and composable primitives—without
adopting React, Tailwind, shadcn, remote assets, or a frontend build pipeline.

The first delivery proves the direction with one browser-verified exemplar in
each of three visual registers. Each exemplar must satisfy its viewing task,
responsive/state checks, accessibility checks, and approved frontend-direction
reference criteria. Frontend implementation is blocked until a separate
frontend-direction packet translates this structural design into approved visual
evidence.

## 2. Framing Brief

- **Primary user / operator:** the agent authoring a brainstorming artifact and
  the human inspecting it in the browser.
- **Job / problem:** communicate a structure, experience, or conclusion visually
  without spending each turn inventing a complete CSS system.
- **Current behavior:** the secure fragment-first runtime and interaction model
  work, but examples depend heavily on per-artifact inline styling. The demo used
  repeated pale surfaces, rounded containers, weak typographic contrast, and
  excessive empty space across materially different artifact types.
- **Desired outcome:** artifacts are polished, relevant, accessible, and visibly
  adapted to their cognitive task while remaining recognizably part of one
  Companion.
- **Success signal:** a diagram, product mockup, and synthesis artifact look
  intentionally different but related; each establishes a clear scan path; a
  fresh author can reproduce the quality using documented primitives; and the
  runtime remains dependency-free.
- **Why now:** the broader useful-artifact model has been implemented and proven
  functionally, exposing presentation quality as the next limiting factor.
- **Constraints:** preserve the secure runtime, fragment-first default,
  full-document compatibility, terminal-primary workflow, `data-choice`
  boundary, accessibility, offline use, and zero-third-party-dependency core.
- **Non-goals:** rebuilding the server, adopting a component framework, creating
  a generic diagram DSL, replacing frontend-direction, or treating temporary
  Companion screens as durable product truth.

## 3. Chosen Direction

### Native kit plus optional Impeccable

Create a small HTML/CSS authoring kit inside the existing frame and examples.
It provides a common foundation and three artifact-specific registers:

1. **Diagram:** relationships, sequence, topology, boundaries, annotations, and
   legends.
2. **Product mockup:** realistic application hierarchy, controls, data density,
   and operational states.
3. **Editorial / synthesis:** conclusions, evidence, open questions, and
   carry-forward decisions.

The visual thesis is **technical editorial**: strong hierarchy, precise grids,
purposeful whitespace, restrained semantic color, fewer containers, and no
default card-grid composition.

Impeccable is an optional authoring and review layer. When installed, it may read
project `PRODUCT.md` and `DESIGN.md`, critique or polish an artifact, and run its
detector against HTML/CSS. Findings must be translated into the native kit.
Neither the Impeccable skill nor CLI is required to render, serve, test, or use
the Companion.

### Why this wins now

- It directly improves visual quality without destabilizing the trusted runtime.
- It fits dynamically authored HTML fragments better than a precompiled utility
  framework.
- It remains portable across supported harnesses and offline sessions.
- It is reversible: individual primitives or registers can evolve without a
  renderer migration.

### Consciously deferred

- Tailwind compilation, shadcn components, React rendering, CDNs, and remote
  font/icon dependencies.
- Automatic Impeccable installation or a required detector gate.
- Restyling every historical example before the visual direction is proven.
- A generalized artifact schema or diagram renderer.

## 4. Scope and Boundaries

### In scope

- Define shared semantic tokens and composition primitives in the fragment shell.
- Make the shell visually quieter than the artifact.
- Make shell instructions conditional on whether `[data-choice]` exists.
- Upgrade `architecture-data-flow.html` as the diagram exemplar.
- Add one realistic product-screen exemplar.
- Upgrade `carry-forward-summary.html` as the editorial exemplar.
- Update authoring guidance with selection rules, composition recipes, and
  anti-patterns for the three registers.
- Update the stale Impeccable initialization wording from `teach` to `init` in
  the relevant frontend-direction reference.
- Add deterministic contract tests and perform browser checks at desktop and
  narrow widths.
- Run skill-behavior pressure testing because the work changes behavior-shaping
  guidance.

### Out of scope

- HTTP, WebSocket, authentication, persistence, lifecycle, or server routing
  changes.
- New required interaction metadata beyond `data-choice`.
- A new production dependency or build step.
- Rewriting the comparison, ranked-alternative, or annotated-recommendation
  exemplars in the first slice.
- Persisting a user theme editor or arbitrary design-kit configuration.
- Using temporary demo screens as frontend implementation truth.

### Invariants

- The Visual Companion remains optional and per-question.
- After the user accepts it, the first later genuinely visual turn starts the
  Companion path rather than remaining terminal-only.
- Artifact-first browser sequencing and terminal question-tool continuity remain
  unchanged.
- Every qualifying visual turn authors or refreshes the artifact, makes it
  viewable, and explains it before asking the terminal decision or confirmation.
- The terminal decision uses the dedicated question tool when available; plain
  terminal text is allowed only as an explicitly named degraded fallback.
- Non-interactive artifacts remain valid and do not need fake choices.
- Keyboard, focus-visible, ARIA, selection, and event behavior remain intact.
- Existing full-document screens remain compatible.
- Light and dark rendering remain legible.
- No visual change weakens keyed access, containment, or security behavior.

### Rabbit holes and no-gos

- Do not wrap every content group in a rounded card.
- Do not use gradients, decorative grids, glass effects, or oversized empty
  space as substitutes for information hierarchy.
- Do not make diagrams resemble application dashboards.
- Do not make product mockups resemble explanatory diagrams.
- Do not let a linter or design skill override the artifact's viewing task.

## 5. User Experience and Behavior

### Primary flow

1. The agent names the viewing task and selects an artifact intent using the
   existing Visual Companion routing rules.
2. The author selects one of the three visual registers.
3. The author composes the artifact from shared primitives and register-specific
   recipes, using real subject matter and honest fidelity labels.
4. If Impeccable is available and the artifact warrants it, the author may apply
   a bounded critique, layout/typeset, polish, or detector pass.
5. The artifact is shown before the terminal decision or confirmation prompt.
6. The shell shows interaction guidance only when the artifact contains choices.

### Shared foundation

The frontend-direction packet must define durable visual values for:

- type roles: display, heading, body, label, annotation, and tabular/mono data;
- spatial roles: page rhythm, section gap, cluster gap, and dense control gap;
- surfaces: canvas, subtle region, elevated interactive surface, and boundary;
- semantic color: neutral, information, success, caution, danger, and selected;
- composition: canvas, section, cluster, split, rail, stage, callout, and legend;
- interaction: choice, hover, focus-visible, selected, disabled, and unavailable;
- responsive rules for narrow diagrams, mockups, and synthesis layouts.

### Register behavior

#### Diagram

- Prefer direct spatial encoding over panels describing relationships in prose.
- Support nodes, connectors, lanes, numbered steps, trust boundaries, legends,
  and compact annotations.
- Preserve reading order when connectors collapse at narrow widths.
- Keep labels readable without requiring hover.

#### Product mockup

- Use recognizable application structure only when the viewing task is about an
  experience or interaction.
- Distinguish navigation, content, controls, evidence, and actions by hierarchy,
  not by placing every item in a card.
- Show realistic states and copy; clearly label simulated data or fidelity.
- Keep approval or destructive actions visually distinct and keyboard reachable.

#### Editorial / synthesis

- Lead with the conclusion or decision, then evidence and unresolved questions.
- Prefer typographic hierarchy, dividers, and annotation over nested cards.
- Make chosen, open, and deferred information distinguishable without relying on
  color alone.
- Do not imply that temporary visual output is durable design truth.

### Key states

- waiting for the next artifact;
- connected, connecting, reconnecting, and disconnected;
- non-interactive artifact;
- interactive artifact with no selection;
- single selected choice;
- multiple selected choices within a supported group;
- keyboard focus-visible;
- narrow viewport reflow;
- light and dark color schemes;
- degraded or simulated fidelity disclosure.

### UX writing contract

| State | Element | Final copy | Purpose | Variables / notes |
| --- | --- | --- | --- | --- |
| waiting | body | `Waiting for the next visual artifact…` | Explain the empty runtime state | English source string |
| connecting | status | `Connecting…` | Name current connection activity | `aria-live` remains enabled |
| reconnecting | status | `Reconnecting…` | Name recovery activity | No false success promise |
| connected | status | `Connected` | Confirm live connection | Do not add redundant footer copy |
| disconnected | status | `Disconnected` | Name unavailable connection | Pair with recovery instruction when choices exist |
| disconnected interactive | footer | `Connection lost. Reconnect before choosing an option.` | Explain consequence and recovery | Footer absent for read-only artifacts |
| interactive, empty | footer | `Choose an option in this artifact, then return to the conversation.` | Give the next action | Replaces generic “above” wording |
| single selected | footer | `Selected: {label}. Return to the conversation to continue.` | Confirm outcome and next action | Escape `{label}` before insertion |
| multiple selected | footer | `{count} options selected. Return to the conversation to continue.` | Confirm grouped selection | Localizable plural form if localization is added |
| non-interactive | footer | No footer | Avoid false interaction instructions | Terminal prompt owns the next step |

Terminology uses **artifact**, **option**, **selected**, and **conversation**.
Do not expose internal terms such as WebSocket, fragment, event log, or auth key.
English is the current source locale; implementation must leave room for text
expansion and preserve accessible status announcements.

## 6. System Design

### Units and responsibilities

- `frame-template.html`: shared tokens, primitives, shell layout, theme behavior,
  and baseline responsive rules.
- `helper.js`: progressive interaction semantics, connection state, selection
  state, and conditional footer content/visibility.
- exemplar fragments: show how each register composes the shared system without
  embedding a new standalone design system.
- `visual-companion.md`: viewing-task gate, register selection, composition
  recipes, anti-patterns, and optional Impeccable workflow.
- tests: protect runtime invariants, class/state contracts, copy states,
  accessibility, and example registration.

### Dependency boundary

The shipped path remains browser-native HTML, CSS, and JavaScript. Impeccable,
Tailwind, shadcn, React, icon packages, and remote assets are outside the runtime
dependency graph. Optional development review may call an installed Impeccable
tool, but normal tests and usage cannot depend on it.

### Compatibility and rollout

- Existing fragment HTML continues to render even when it uses none of the new
  classes.
- Existing `data-choice` behavior remains progressively enhanced by `helper.js`.
- Full-document artifacts continue to own their complete presentation.
- Introduce the kit additively, migrate the three exemplars, and validate before
  considering the remaining examples.
- The first delivery requires no session-data migration.

## 7. Risks and Unknowns

- **Kit becomes another generic component system.** Mitigate with register-specific
  recipes, fewer container primitives, and exemplars judged by distinct viewing
  tasks.
- **Authoring guidance becomes too large to follow.** Keep a compact quick
  reference in the main guide and move detailed recipes into focused examples.
- **Inline artifact CSS drifts from the kit.** Prefer shared classes and permit
  local CSS only for subject-specific geometry.
- **Impeccable creates workflow collision.** Limit it to optional critique and
  refinement after the artifact intent and register are already chosen.
- **Styling breaks behavior.** Preserve selectors and test interaction semantics
  independently from presentation.
- **Snapshot taste becomes subjective.** The frontend-direction packet must define
  reference intent and visual acceptance evidence before implementation.

No blocking product questions remain. Exact tokens, typefaces, icon treatment,
and motion values are intentionally owned by the frontend-direction packet.

## 8. Validation Plan

- Run all existing `tests/brainstorm-server` contract, branding, accessibility,
  lifecycle, auth, and live acceptance suites.
- Add deterministic tests for conditional footer behavior and required shared
  primitive/register hooks.
- Verify the three exemplars in a real browser at representative desktop and
  narrow widths, in light and dark modes.
- Verify keyboard traversal, focus visibility, single and grouped selections,
  reconnect/disconnect copy, and no footer on non-interactive artifacts.
- Run the repository's `writing-skills` behavior-change workflow, including
  adversarial before/after sessions, because the authoring instructions shape
  agent behavior.
- If Impeccable is installed, run its critique/detector as advisory evidence;
  record findings and intentional exceptions. Do not make installation a pass
  condition.
- Retain approved frontend-direction screenshots or captures with explicit
  `visual-truth`, `semantic-guidance`, or `reference-only` intent.

## 9. Open Questions

None block frontend-direction. The packet must resolve exact visual tokens and
reference evidence before UI implementation begins.

## Appendix A. Options Considered

### Native kit plus optional Impeccable — chosen

- **Optimizes for:** codebase fit, portability, authoring quality, reversibility.
- **Makes harder:** importing a large catalog of ready-made components.
- **Main risk:** insufficient discipline could still produce generic artifacts.
- **Why now:** it improves the real bottleneck without expanding the runtime.

### Tailwind build layer — rejected for this slice

- **Optimizes for:** fast utility composition and a large styling vocabulary.
- **Makes harder:** dynamic fragment generation, zero-dependency packaging, and
  build-free operation.
- **Main risk:** build complexity becomes part of a temporary brainstorming aid.

### React plus shadcn — rejected

- **Optimizes for:** mature interactive component primitives.
- **Makes harder:** almost every current runtime and packaging invariant.
- **Main risk:** a presentation improvement becomes a renderer rewrite.

## Appendix B. Brownfield Context and Requirement Lineage

- Reuse the secure runtime and integration invariants in
  `2026-07-31-origin-main-integration.md` unchanged.
- Reuse the useful-artifact intents, non-interactive artifact support, and
  terminal-primary contract in
  `2026-07-31--visual-companion-useful-artifacts.md` unchanged.
- Narrow the first visual-quality delivery to three exemplars; the remaining
  existing comparison examples stay active and unchanged.
- Preserve the March comparison-first, routing, and protocol-hardening decisions
  wherever they do not conflict with the later useful-artifact expansion.
- Reuse validated `.gsd/REQUIREMENTS.md` items R001-R015, R017-R018, and
  R034-R040 as unchanged protocol, comparison, routing, quality-gate,
  compatibility, review, and skill-eval constraints.
- Reactivate the diagram portion of deferred R020 for the diagram register and
  exemplar. A generalized diagram catalog or renderer remains deferred.
- Supersede milestone-specific refresh boundary R016 only for this new scope so
  `carry-forward-summary.html` may become the editorial exemplar.
- Supersede milestone-specific R019 only for this new scope: preserve the runtime
  and `data-choice` contract, while allowing three register-driven exemplars and
  bounded presentation/state-copy changes in `helper.js` and
  `frame-template.html`.
- Supersede milestone-specific R045 only for this new scope: bounded
  `helper.js` and `frame-template.html` changes are active, while `server.cjs`
  remains unchanged.
- Keep R021-R023, R042-R044 deferred and R030-R033, R046-R047 out of scope.

## Appendix C. Example Mapping

### Shared kit and shell state

**Rules**

- Existing fragments render without migration.
- The footer is present only when it communicates an actionable choice or
  connection recovery.
- Interaction and security behavior do not depend on styling classes.

**Examples**

1. Given a non-interactive architecture diagram, when it renders in the shell,
   then no option-selection instruction is shown.
2. Given an interactive mockup whose connection drops, when the user attempts to
   decide, then the shell names the loss and tells them to reconnect first.

**Deferred**

- User-configurable themes and runtime design-kit configuration.

### Three visual registers

**Rules**

- Each register shares semantic foundations but uses a distinct composition.
- Subject-specific information determines the layout.
- Narrow layouts preserve reading order and meaning.

**Examples**

1. Given a Browser → API → Queue → Worker → Database flow, when the diagram
   exemplar renders, then connectors, retries, and trust boundaries are encoded
   spatially rather than as a row of generic cards.
2. Given an approval decision, when the product mockup renders, then evidence,
   proposed action, guardrails, and approve/reject actions read like a coherent
   application surface.
3. Given a completed brainstorm decision, when the synthesis exemplar renders,
   then the conclusion leads, evidence supports it, and open questions remain
   visibly secondary.

**Deferred**

- Additional registers unless repeated real use demonstrates a need.

### Optional Impeccable quality layer

**Rules**

- Impeccable never becomes a runtime or test dependency.
- Project truth and approved frontend direction outrank generic recommendations.
- Findings must be reviewed, not applied blindly.

**Examples**

1. Given Impeccable is installed, when an exemplar is ready for review, then a
   critique or detector pass may identify hierarchy or anti-pattern issues and
   accepted fixes are expressed in native HTML/CSS.
2. Given Impeccable is absent, when an agent authors an artifact, then the full
   workflow remains available through the native kit and examples.

**Deferred**

- Automatic installation, hooks, CI enforcement, and Live Mode integration.

## Appendix D. Frontend Direction

- Follow-on prompt:
  `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend-direction-prompt.md`
- Packet status: **required before implementation**.

## Appendix E. GSD Handoff Seed

See
`docs/superpowers/specs/2026-07-31--visual-companion-design-kit--gsd-handoff.md`.
