# Visual Companion Design Kit — Brownfield UI Extraction

## 1. Source Evidence

- Feature or workflow: secure, fragment-first Visual Companion rendering and
  optional `data-choice` interaction inside the shared shell.
- Routes/screens reviewed: the keyed local Companion root with
  `architecture-data-flow.html`, `carry-forward-summary.html`, and
  `side-by-side-comparison.html`.
- Code areas reviewed:
  `skills/brainstorming/scripts/frame-template.html`, `helper.js`, `server.cjs`,
  `skills/brainstorming/visual-companion.md`, the three example fragments, and
  the relevant `tests/brainstorm-server/` contracts.
- Runtime screenshots/browser captures: Chrome through the Companion's real
  keyed local runtime at 1440 × 1000 and 390 × 844. Light and dark color schemes
  were explicitly emulated. The comparison was captured unselected, with the
  first choice keyboard-focused, and selected by pressing Enter.
- Existing docs or anchoring: the approved design spec, GSD handoff, and
  frontend-direction prompt linked from the parent packet.
- Optional quality evidence: `impeccable detect` was run after baseline capture.
  It reported three sub-12px body-text instances in the comparison mockups. The
  finding is advisory and agrees with the captured legibility issue.
- Missing evidence: no project `PRODUCT.md` or `DESIGN.md` exists; no durable
  CalmOps product-mockup screenshot was found; no existing product-mockup
  baseline is claimed. The previous CalmOps description remains upstream
  `reference-only` problem context, not a retained visual reference.

### Retained baseline captures

Every retained capture's intent was approved on 2026-07-31.

| Capture | Observed truth | Proposed intent |
| --- | --- | --- |
| `screenshots/baseline-diagram-desktop-light.png` | Current diagram shell, light, desktop | `reference-only` |
| `screenshots/baseline-diagram-desktop-dark.png` | Current diagram shell, dark, desktop | `reference-only` |
| `screenshots/baseline-diagram-narrow-light.png` | Whole SVG scales down; labels become unreadable | `reference-only` |
| `screenshots/baseline-diagram-narrow-dark.png` | Same narrow scaling failure in dark mode | `reference-only` |
| `screenshots/baseline-editorial-desktop-light.png` | Current summary hierarchy and unconditional footer | `reference-only` |
| `screenshots/baseline-editorial-desktop-dark.png` | Current summary hierarchy in dark mode | `reference-only` |
| `screenshots/baseline-editorial-narrow-light.png` | Repeated containers dominate the narrow layout | `reference-only` |
| `screenshots/baseline-editorial-narrow-dark.png` | Fixed footer competes with narrow content | `reference-only` |
| `screenshots/baseline-comparison-unselected.png` | Current interactive empty state | `semantic-guidance` for state behavior only |
| `screenshots/baseline-comparison-focus-visible.png` | Visible keyboard focus around the active choice | `semantic-guidance` for focus visibility only |
| `screenshots/baseline-comparison-selected.png` | Selected styling and footer confirmation | `semantic-guidance` for state synchronization only |

The baseline styling is not an acceptance target. The three interaction captures
bind only the clarity and synchronization of unselected, focus-visible, and
selected states; their palette, radii, shadows, and card treatment may change.

## 2. Preserve / Adapt / No-Gos

### Must preserve

- The keyed local runtime, containment, fragment-first wrapping, and existing
  full-document passthrough boundary.
- Prime Radiant / Superpowers shell branding and connection status semantics;
  no server or branding-contract redesign is in this slice.
- Artifact-first browser sequencing followed by the terminal decision or
  confirmation, with the dedicated question tool when available.
- `data-choice` as the only interaction metadata boundary, plus `.options`,
  `.cards`, `toggleSelect(this)`, keyboard activation, `aria-pressed`, event
  persistence, and authored `role`/`tabindex` authority.
- System light/dark behavior, visible focus, accessible live status, honest
  fidelity labels, and non-interactive artifacts without fake choices.
- Browser-native HTML, CSS, and JavaScript with no build step and no required
  network, font, icon, framework, or review-tool dependency.

### May adapt

- Shell density, content padding, type scale, palette, borders, radii, shadows,
  and all non-contract class names added for the kit.
- The visual structure of the diagram and synthesis exemplars.
- Footer presence and copy according to actual choice and connection state.
- Register-specific responsive geometry while preserving authored DOM order.
- Existing generic `.section`, `.card`, `.mockup`, and `.split` presentation when
  migrated additively; untouched historical fragments must still render.

### Explicit no-gos

- React, shadcn, Tailwind, CDNs, remote fonts/assets, icon packages, or a new
  runtime/build dependency.
- Server, HTTP, WebSocket, authentication, persistence, lifecycle, or routing
  changes.
- Default card grids, pill labels everywhere, decorative gradients or grids,
  glass effects, oversized blank space, and shadows used as the primary hierarchy.
- Scaling a complete wide diagram until its labels are unreadable on narrow
  screens.
- Browser-primary confirmation, fake `data-choice` controls, technical runtime
  terms in user-facing copy, or temporary artifacts presented as durable product
  truth.

## 3. Foundations Present

- Color/theme source: CSS custom properties in `frame-template.html`, with an
  Apple-like cool neutral light palette and `prefers-color-scheme` overrides.
- Typography source: system sans stack; headings 600 weight; small uppercase
  blue labels; multiple sub-12px values inside the comparison mockups.
- Spacing rhythm: mostly rem-based, but local fragments contain many one-off
  inline values.
- Surfaces/elevation: pale canvas, white/dark-secondary rounded sections and
  cards, 14px default radii, blue selected tint, and selection/card shadows.
- Variables/token files: only the shared frame CSS variables; exemplar-specific
  geometry and color are largely inline.
- Known drift: distinct viewing tasks share the same rounded-container grammar;
  wide SVGs shrink rather than recompose; helper footer copy is unconditional;
  comparison examples use decorative gradients and very small text; content and
  shell compete for visual weight.

## 4. Shared Patterns And Components

| Pattern/component | Where it exists | Reuse call | Known issue |
| --- | --- | --- | --- |
| Header brand + connection status | frame + server branding injection | Preserve behavior and compact shell role | Must stay quieter than artifacts |
| Scrollable artifact region | `.main`, `#claude-content` | Preserve | Padding and max-width need register-aware rules |
| Selection footer | `.indicator-bar`, `syncIndicator` | Preserve state role; make conditional | Currently shown on non-interactive artifacts |
| Choice hydration | `helper.js` | Preserve exactly at the behavior boundary | Visual state can be simplified |
| Section / label | `.section`, `.label` | Adapt, not default | Repeated card/pill treatment flattens hierarchy |
| Options / cards | `.options`, `.cards`, `[data-choice]` | Preserve compatibility; add kit aliases only | Selection is clear but heavy and card-bound |
| SVG architecture map | `architecture-data-flow.html` | Replace composition, preserve meaning and ARIA | Narrow view scales labels below readable size |
| Carry-forward summary | `carry-forward-summary.html` | Replace with editorial composition | Nested containers obscure conclusion/evidence order |

## 5. Screen Family Notes

### Shared shell and status states

- User goal: know the Companion is live, understand the artifact, then return to
  the terminal for the decision.
- Current layout shape: fixed header, scrollable artifact, fixed footer.
- Density/hierarchy: shell chrome is compact, but the footer is always present
  and the artifact often becomes a large card inside another surface.
- Important states: waiting; connecting; reconnecting; connected; disconnected;
  interactive empty; single/multiple selected; non-interactive.
- Strong points: stable branding, visible status, predictable scroll ownership.
- Weak points: non-interactive screens falsely instruct users to choose; narrow
  footer consumes limited height.

### Diagram

- User goal: trace the primary payment path, retry loop, dead-letter branch, and
  trust boundary.
- Current layout shape: one large rounded section containing a fixed-viewBox SVG.
- Strong points: real subject matter, explicit viewing task, accessible SVG title
  and description, direct connectors.
- Weak points: connector labels collide with nodes on desktop; the whole map
  scales to miniature size on narrow screens; the choice footer appears even
  though the diagram has no choices.

### Product mockup

- User goal: inspect a realistic operational approval surface and choose a safe
  action.
- Current layout shape: no durable baseline exists.
- Directional constraint: label the exemplar `Simulated product surface`; use
  realistic structure and data without implying a real product or production
  state.

### Editorial / synthesis

- User goal: see the conclusion first, then evidence, open questions, and
  deferred items.
- Current layout shape: heading followed by three large rounded sections, with
  options nested inside two sections.
- Strong points: correct carry-forward terminology and explicit degraded-mode
  disclosure.
- Weak points: repeated boxes give chosen/open/degraded equal weight; the title
  does not lead strongly; the fixed footer crowds narrow content.

### Selectable comparison state baseline

- User goal: understand available choices and confirm keyboard/selection state.
- Strong points: focus ring and selected state are visible; Enter synchronizes
  the choice and footer.
- Weak points: double blue outline plus large shadow is visually heavy; tiny
  mockup copy and decorative gradients reduce fidelity and legibility.

## 6. Approved Reference Needs

- Candidate visual-truth source: post-implementation runtime captures only,
  after the packet is approved and the implementation is verified.
- Current retained captures: all eleven files listed above.
- Approved intent: baseline problem evidence is `reference-only`; only the
  behavior expressed by the three interaction-state captures is
  `semantic-guidance`.
- ChatGPT Images 2 prompts/images: none. The approved scope defers generated
  images, and exact HTML/CSS direction can be stated without them.
- States still missing evidence by design: the future product-mockup exemplar,
  conditional-footer shell states, and redesigned register captures do not exist
  before implementation. Their required capture matrix is defined in the parent
  packet.
