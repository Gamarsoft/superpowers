# Visual Companion Design Kit — Frontend Direction

## 1. Summary

- Linked spec:
  [`2026-07-31--visual-companion-design-kit.md`](./2026-07-31--visual-companion-design-kit.md)
- Linked GSD handoff:
  [`2026-07-31--visual-companion-design-kit--gsd-handoff.md`](./2026-07-31--visual-companion-design-kit--gsd-handoff.md)
- Supporting evidence:
  [`brownfield-ui-extraction.md`](./2026-07-31--visual-companion-design-kit--frontend/brownfield-ui-extraction.md)
  and
  [`screen-index.md`](./2026-07-31--visual-companion-design-kit--frontend/screen-index.md)
- Packet status: **approved 2026-07-31; implementation gate released**
- Brownfield call: **focused refresh** of the fragment shell and three exemplars;
  runtime, protocol, security, and historical full-document behavior stay intact.
- Default visual source: approved packet decisions plus current runtime evidence.
  No generated image is proposed and no pre-implementation screenshot is visual
  truth.
- UX copy source: the exact state copy deck in section 5 of the approved spec,
  existing exemplar subject copy where retained, and the small product-mockup
  copy deck in this packet.

## 2. Source Evidence

- Current UI evidence: eleven retained runtime captures under
  `./2026-07-31--visual-companion-design-kit--frontend/screenshots/`, gathered
  through the real keyed server at 1440 × 1000 and 390 × 844, with explicit
  light/dark emulation and keyboard-driven focus/selection.
- Design-system or component evidence: current frame tokens and shared shell;
  helper state semantics; the diagram, summary, and comparison fragments; and
  the contract/accessibility/branding tests.
- Project design context: no `PRODUCT.md` or `DESIGN.md` exists.
- Optional review evidence: post-baseline `impeccable detect` found three
  sub-12px text instances in `side-by-side-comparison.html`. This is advisory.
- Approved generated images: none. Generated imagery is explicitly deferred.
- Missing/degraded evidence: no durable CalmOps product-mockup capture exists.
  The new mockup therefore uses a packet-defined, honestly simulated scenario
  and must not claim to represent a real product.

## 3. Screens And States

Link:
[`screen-index.md`](./2026-07-31--visual-companion-design-kit--frontend/screen-index.md)

- In scope: shared shell and conditional footer; waiting/connection states;
  one diagram, one simulated product mockup, and one editorial/synthesis
  exemplar; interactive empty/focus/selected/disconnected states.
- Required environment variants: 1440 × 1000 and 390 × 844; light and dark;
  audit down to 320px width.
- Deferred: remaining example restyles, extra registers, generic diagram
  tooling, browser-native confirmation, persistent theming, and generated images.

## 4. Visual References And Intent

The classifications below are the approved visual-reference intents. Approval
of an intent does not approve an implementation or runtime capture that does not
yet exist.

| Screen/state | Reference | Intent | Approval | Binding notes |
| --- | --- | --- | --- | --- |
| Diagram desktop, light | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-diagram-desktop-light.png` | `reference-only` | approved | Problem evidence; current visual treatment does not bind |
| Diagram desktop, dark | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-diagram-desktop-dark.png` | `reference-only` | approved | Theme problem evidence only |
| Diagram narrow, light | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-diagram-narrow-light.png` | `reference-only` | approved | Proves unreadable whole-SVG scaling; do not reproduce |
| Diagram narrow, dark | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-diagram-narrow-dark.png` | `reference-only` | approved | Same narrow failure in dark mode |
| Editorial desktop, light | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-editorial-desktop-light.png` | `reference-only` | approved | Problem evidence for equal-weight containers and footer |
| Editorial desktop, dark | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-editorial-desktop-dark.png` | `reference-only` | approved | Theme problem evidence only |
| Editorial narrow, light | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-editorial-narrow-light.png` | `reference-only` | approved | Problem evidence for narrow density and footer competition |
| Editorial narrow, dark | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-editorial-narrow-dark.png` | `reference-only` | approved | Same narrow problem in dark mode |
| Choice empty | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-comparison-unselected.png` | `semantic-guidance` | approved | A real choice is discoverable before activation; styling may change |
| Choice keyboard focus | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-comparison-focus-visible.png` | `semantic-guidance` | approved | Focus must remain obvious; current double outline/shadow does not bind |
| Choice selected | `2026-07-31--visual-companion-design-kit--frontend/screenshots/baseline-comparison-selected.png` | `semantic-guidance` | approved | Selected visual, `aria-pressed`, event, and footer stay synchronized |
| Redesigned runtime matrix | Post-implementation captures named in section 6 | `visual-truth` candidate | pending future capture | Actual images require inspection after implementation |

No current screenshot is a visual acceptance target. The binding pre-build
direction is this packet's semantic foundation, register rules, and state
contract. Current product behavior still outranks any stylistic proposal.

## 5. Implementation Contract

### 5.1 Technical-editorial foundation

The shared visual thesis is **technical editorial**: strong type, explicit
sequence, precise alignment, restrained semantic color, purposeful whitespace,
and few containers. The shell is neutral infrastructure; each artifact register
owns the dominant composition.

#### Color tokens

Use opaque CSS values so the system works offline and without color-mixing
support. These values are the approved target.

| Role / proposed token | Light | Dark | Use |
| --- | --- | --- | --- |
| `--vc-canvas` | `#F4F3EF` | `#151614` | page canvas |
| `--vc-surface` | `#FCFBF8` | `#1D1F1C` | primary artifact surface |
| `--vc-subtle` | `#EBE9E3` | `#242721` | grouped region without elevation |
| `--vc-boundary` | `#C8C5BC` | `#44483F` | rules and component boundaries |
| `--vc-ink` | `#181A17` | `#F2F1EC` | primary text |
| `--vc-muted` | `#5F625D` | `#B6B8B1` | secondary text |
| `--vc-faint` | `#7A7E76` | `#8F948B` | nonessential annotation only |
| `--vc-info` | `#2457D6` | `#9AB6FF` | links, information, focus accent |
| `--vc-success` | `#18794E` | `#6EE7B7` | completed/safe state |
| `--vc-caution` | `#8A4B08` | `#F5C26B` | risk/retry state |
| `--vc-danger` | `#B42318` | `#FF8A80` | unavailable/reject/destructive state |
| `--vc-selected-surface` | `#E8EEFF` | `#273555` | selected choice background |
| `--vc-focus` | `#2457D6` | `#B7CAFF` | 3px focus ring |

Verified foreground pairs for normal text meet WCAG AA against their primary
surfaces. Semantic colors always pair with a word, icon, pattern, or state
attribute; color never carries meaning alone.

#### Type roles

- Family: `system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif`.
- Mono/data family:
  `ui-monospace, SFMono-Regular, Menlo, Consolas, monospace`.
- No remote font files. Do not use a faux brand typeface.
- Display: `clamp(2rem, 4vw, 3.5rem) / 1.02`, weight 720 (700 fallback),
  letter-spacing `-0.035em`; only once per artifact when the viewing task merits it.
- Heading: `clamp(1.5rem, 2.4vw, 2.25rem) / 1.1`, weight 700,
  letter-spacing `-0.025em`.
- Subheading: `1.125rem / 1.25`, weight 650 (600 fallback).
- Body: `1rem / 1.55`, weight 400, preferred measure 58–72 characters.
- Label: `0.6875rem / 1.2`, weight 700, uppercase, letter-spacing `0.12em`;
  use sparingly as an eyebrow, not as a pill by default.
- Annotation: `0.8125rem / 1.45`, weight 450 (400 fallback).
- Tabular/mono: `0.8125rem / 1.35`, weight 500, tabular numerals.
- Runtime minimum: user-facing body or control text is never below 14px;
  11px labels are reserved for short uppercase eyebrows with strong contrast.

#### Space, shape, and elevation

- Base unit: 4px. Dense gap 4px; control gap 8px; cluster gap 12px;
  component gap 16px; section gap 24px; major section gap 40px; page rhythm 56px.
- Artifact inset: `clamp(16px, 4vw, 56px)`; narrow inset 16px.
- Control radius 4px; region radius 8px; stage radius 12px. Fully rounded shapes
  are reserved for status dots or compact status chips.
- Default hierarchy uses type, alignment, rules, and surface tone. A boundary is
  1px. Elevated interactive surfaces may use at most
  `0 2px 8px rgba(0,0,0,.10)`; static sections do not cast shadows.
- Minimum interactive target: 44 × 44px even when the visible control is denser.

#### Composition primitives

- `canvas`: register root and page rhythm; one per artifact.
- `section`: semantic region separated by whitespace or a rule, not automatically
  boxed.
- `cluster`: related items with 8–16px gaps.
- `split`: asymmetric 7/5 or 2/1 columns for evidence/supporting context.
- `rail`: 192–256px contextual navigation or metadata beside flexible content.
- `stage`: dominant diagram or product canvas; may own one boundary and surface.
- `callout`: short message with a 3px semantic edge and visible label.
- `legend`: compact keyed list near the visual encoding it explains.
- `choice`: the only generic elevated interactive surface; it carries current
  `data-choice` behavior without adding metadata.

#### Interaction, icon, and motion policy

- Hover: strengthen the boundary/text; do not move the element.
- Focus-visible: 3px `--vc-focus` ring with 2px offset; never suppress the browser
  focus state without a visible replacement.
- Selected: visible check/marker, stronger boundary, selected surface, and
  `aria-pressed="true"`; do not rely on a shadow or color alone.
- Disabled/unavailable: keep readable contrast, expose the semantic state, block
  activation, and explain recovery where relevant.
- Icons: inline SVG only, 16px or 20px, `currentColor`, 1.5–2px stroke. Decorative
  icons are `aria-hidden`; icon-only controls require an accessible name. No
  emoji as interface icons and no icon package.
- Motion: 120ms color/border transitions and 180ms disclosure transitions only.
  No ambient motion. Under `prefers-reduced-motion: reduce`, remove nonessential
  transitions and preserve instantaneous state feedback.

### 5.2 Shared shell and state direction

- Keep the branded header/status row compact (40–44px target height). It may use
  `--vc-surface`, but the artifact owns the strongest hierarchy and color.
- Preserve current shell injection markers and selectors. Add design-kit classes
  additively so old fragments render without migration.
- `#claude-content` remains the fragment mount and scroll owner. Do not change
  full-document ownership or server behavior.
- Waiting state uses exactly `Waiting for the next visual artifact…` in the main
  region. Connection status uses exactly `Connecting…`, `Reconnecting…`,
  `Connected`, and `Disconnected`, with the existing live announcement.
- The footer is absent from layout and accessibility trees when the artifact has
  no `[data-choice]`.
- When choices exist, the footer is a compact status/action strip, not a permanent
  instruction banner. It uses the exact approved empty/single/multiple/disconnect
  copy and leaves room for text expansion.
- On narrow screens, keep the conditional footer to at most two lines at 390px;
  the artifact scroll region must account for its actual height.
- No visual work may alter keyed access, WebSocket recovery, event ordering,
  selection serialization, containment, or terminal-primary sequencing.

### 5.3 Register: diagram

**Identity:** schematic and spatial. It should read like an annotated engineering
figure, not a dashboard.

- Exemplar viewing task stays the payment request → API → queue → worker →
  database flow, including retry, dead-letter, and the trust boundary.
- Desktop: left-to-right primary path on one stage; retry/dead-letter branch sits
  on a second lane; trust boundary crosses the flow as a labeled rule rather than
  floating text on a connector.
- Narrow (`<700px`): recompose to a top-to-bottom ordered path. Put retry and
  dead-letter immediately after Worker as an indented branch, then return to the
  primary order. Do not shrink the desktop map. DOM/reading order remains Browser,
  API, Queue, Worker, Retry, Dead-letter, Database.
- Node treatment: 4–8px radius, 1px boundary, compact internal padding; node role
  and one-line annotation remain visible without hover.
- Connector treatment: 2px primary path, 1.5px branch, 3px trust boundary;
  direction uses arrowheads plus ordered labels. Dashed lines are reserved for
  retry/error paths.
- Palette: neutral structure, information accent for trust/API, caution for
  retry, danger for dead-letter. Do not tint every node.
- Labels: 14px minimum desktop and narrow; annotations 13px minimum; diagram
  title/description remain available to assistive technology.
- The exemplar is non-interactive. It contains no `data-choice` and therefore no
  footer.

### 5.4 Register: product mockup

**Identity:** realistic operator surface. It should read like an application
state, not an explanatory flowchart.

- Exemplar subject: **retry-policy change review**. The operator compares current
  and proposed retry limits, inspects evidence and guardrails, then approves or
  rejects the change.
- Fidelity disclosure: show `Simulated product surface` above the application
  stage. Do not use a real company/customer identity or imply production data.
- Desktop (`>=820px`): compact product bar, 208px navigation/metadata rail,
  flexible review body, and 288–320px evidence rail. The action row belongs to
  the review body; no browser-native confirmation is added.
- Narrow (`<820px`): collapse the navigation rail to a short context row; order
  title → proposed change → guardrails → evidence → actions. Dense data tables
  may scroll inside a labeled region, but the viewport must not scroll sideways.
- Hierarchy comes from alignment, column roles, table rules, and control density.
  Only the stage and real choices may be bounded surfaces; do not wrap each data
  group in a card.
- Use tabular numerals for limits and timestamps. Simulated data is plausible,
  short, and visibly labeled.
- Approve and reject are two real `.options` choices using existing
  `data-choice`, `toggleSelect(this)`, keyboard, `aria-pressed`, and event
  behavior. Reject uses a danger edge/label; both meet the same focus/target-size
  requirements.
- On connection loss, actions become unavailable and the shell footer uses the
  approved recovery copy. Do not invent an in-product WebSocket error.

### 5.5 Register: editorial / synthesis

**Identity:** decision memo. It should read like edited technical writing, not a
grid of cards.

- Lead with the settled export-flow conclusion in a high-contrast decision
  block: eyebrow, concise conclusion, and one-sentence rationale.
- Desktop (`>=760px`): main reading column (maximum 72ch) plus a 224–256px side
  rail for status, assumptions, and carry-forward metadata.
- Narrow (`<760px`): one reading column ordered conclusion → evidence → open
  questions → deferred/assumptions. Side-rail material enters the flow at the
  relevant heading.
- Evidence is a numbered sequence separated by rules. Open questions use a
  visible `Open` word and question mark marker; deferred items use `Deferred` and
  a different marker. Do not encode categories with color alone.
- Use no more than one bounded callout. Other sections are separated by a 1px
  rule and 24–40px rhythm.
- The first exemplar is read-only. It carries decisions visibly, contains no fake
  choices, and has no footer; the terminal owns the next confirmation/question.
- Degraded or simulated fidelity remains visible when applicable and never
  implies temporary output is durable product truth.

### 5.6 Copy and accessibility

#### Approved shell copy

Use the exact strings from section 5 of the approved spec, including safe escaped
`{label}` insertion, plural-ready `{count}`, English source locale, and text
expansion. Do not expose `WebSocket`, `fragment`, `event log`, or `auth key`.

#### Product-mockup copy deck

| State | Element | Final copy | Purpose | i18n / variables | Notes |
| --- | --- | --- | --- | --- | --- |
| fidelity | eyebrow | `Simulated product surface` | Prevent false product fidelity | none | Always visible above the stage |
| default | heading | `Review retry policy change` | Name the operator task | none | Sentence case |
| default | helper | `Compare the current safeguards with the proposed limits before deciding.` | Explain what to inspect | none | Maximum two lines at 390px |
| ready | status | `Ready for review` | Name state without implying approval | none | Pair with a visible icon/word |
| default | section label | `Current policy` | Identify baseline values | none | Visible label |
| default | section label | `Proposed change` | Identify changed values | none | Visible label |
| default | section label | `Evidence` | Identify supporting observations | none | Visible label |
| default | section label | `Guardrails` | Identify protections | none | Visible label |
| choice | CTA | `Approve change` | Select approval | none | Verb + outcome; `data-choice` value stays internal |
| choice | CTA | `Reject change` | Select rejection | none | Danger treatment plus text; not icon-only |

No new error or confirmation dialog copy is needed. Connection loss is owned by
the approved shell copy deck. Editorial and diagram subject copy should reuse the
existing exemplar meaning and may be edited for hierarchy without changing the
decisions or inventing product claims.

#### Accessibility contract

- Preserve semantic heading order, SVG title/description, landmark/region
  labeling, live status, and authored choice semantics.
- Body text contrast is at least 4.5:1; focus and non-text state indicators are
  at least 3:1; selected/open/deferred/unavailable states use more than color.
- Keyboard order follows visual/DOM order. Enter and Space activate only real
  choices. No hover-only labels or content.
- Text zoom to 200% and narrow width must not clip labels, status, actions, or
  decision meaning. Leave room for approximately 30% copy expansion.
- Use `aria-hidden` only for redundant decoration. Every icon-only control, if
  one survives implementation, needs an explicit accessible name.

## 6. Verification

### Required runtime captures after implementation

- Diagram: desktop/narrow × light/dark (4); confirm labels stay readable and the
  non-interactive footer is absent.
- Product mockup: desktop/narrow × light/dark, unselected (4); plus desktop-light
  keyboard focus, selected by Enter, and interactive disconnected state (3).
- Editorial: desktop/narrow × light/dark (4); confirm conclusion-first order and
  no footer.
- Shared shell: waiting light/dark (2) and non-interactive disconnected or
  reconnecting status without a footer (1).

These captures are candidate `visual-truth` and must be reviewed together so the
three registers feel related but clearly optimized for different cognitive tasks.

### Reference-intent checklist

- Baseline diagram/editorial captures are used only to prevent regressions and
  document problems, never as style targets.
- Baseline comparison state captures bind clarity/synchronization only.
- No generated image, temporary HTML concept, or missing CalmOps capture is used
  as authority.
- Any future implementation-facing reference is classified before it can bind.

### Interaction and runtime checks

- Run all existing `tests/brainstorm-server` suites plus deterministic tests for
  conditional footer presence/copy and required kit/register hooks.
- Verify mouse, Tab, Shift+Tab, Enter, Space, focus-visible, single selection,
  supported multi-selection, reconnect, disconnect, and event persistence.
- Verify fragments without kit classes still render, and full documents remain
  untouched by fragment-shell presentation.
- Verify no dependency, build step, CDN, remote font/asset, or required
  Impeccable path was added.

### Accessibility and copy checks

- Compare rendered strings character-for-character with the two approved copy
  decks; test escaped `{label}` and plural-ready `{count}` handling.
- Check 320px width, 200% text zoom, reduced motion, light/dark contrast, heading
  order, live announcements, SVG accessible names, and no color-only meaning.
- Re-run Impeccable only as advisory evidence; record accepted findings and
  intentional exceptions.

### Known visual risks

- A shared system can still flatten the registers; reject implementations that
  reuse one composition with different labels.
- System fonts vary by platform; hierarchy and measures must survive fallback.
- The diagram may be visually attractive but semantically out of order on narrow
  screens; DOM and connector review are both required.
- Product realism can overstate fidelity; the simulation label is mandatory.

## 7. Approval Record

Approved by the human on 2026-07-31:

1. The technical-editorial foundation and exact token/type/spacing direction.
2. The three register contracts, including the simulated retry-policy review as
   the product-mockup exemplar and a read-only editorial exemplar.
3. The visual-reference intents: baseline problem captures are
   `reference-only`; the three comparison-state captures are
   `semantic-guidance` for behavior only; post-implementation runtime captures
   are candidate `visual-truth` and require later inspection.

The frontend implementation gate is released. This approval record does not by
itself start implementation; implementation begins only on an explicit build or
execution request.
