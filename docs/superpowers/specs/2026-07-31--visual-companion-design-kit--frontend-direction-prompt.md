Use `$superpowers:frontend-direction`.

Goal:
Create a concise frontend direction packet and supporting evidence for the
Visual Companion Design Kit from the approved brainstorming outputs.

Approved upstream artifacts:
- Design spec:
  `docs/superpowers/specs/2026-07-31--visual-companion-design-kit.md`
- GSD handoff:
  `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--gsd-handoff.md`
- Existing frontend packet: none

Target repo / product:
- Repo: `/Users/gamarsoft/.codex/superpowers`
- Stack: browser-native HTML, CSS, and JavaScript fragments wrapped by the
  existing Node Visual Companion runtime

Product and delivery context:
- Track: `brownfield-major-feature`
- First delivery boundary: a dependency-free shared design kit, conditional shell
  guidance, and one browser-verified diagram, product-mockup, and
  editorial/synthesis exemplar.
- Primary flows: choose an artifact intent and visual register; author from shared
  primitives; optionally critique/polish with Impeccable; display artifact first;
  continue the decision in the terminal.
- Screen families: shared shell/waiting state, diagram exemplar, product-screen
  exemplar, and editorial/synthesis exemplar.
- Key states: waiting; connecting/reconnecting/connected/disconnected;
  non-interactive; interactive empty/single/multiple selection; focus-visible;
  narrow viewport; light/dark; degraded/simulated fidelity.
- Must preserve: secure runtime, fragment-first behavior, full-document
  compatibility, `data-choice`, keyboard/ARIA/event semantics, terminal-primary
  workflow, first-visual-turn startup after consent, artifact-first sequencing,
  dedicated terminal question-tool continuity, explicitly named degraded fallback,
  honest fidelity, and offline operation.
- May adapt: shell density, typography, semantic token values, composition
  primitives, responsive treatment, and the three exemplar layouts.
- Explicit no-gos: React, shadcn, Tailwind, CDNs, remote fonts/assets, new runtime
  dependencies, generic card grids, decorative gradients/grids, fake choices, or
  temporary artifacts treated as durable product truth.
- UX writing: use the approved inline copy deck in section 5 of the spec. Preserve
  exact strings, safe `{label}` insertion, plural-ready `{count}`, accessible live
  announcements, and room for text expansion.

Visual Companion carry-forward:
- Chosen foundation: native kit plus optional Impeccable.
- Chosen range: one shared foundation with diagram, product-mockup, and
  editorial/synthesis registers.
- Chosen thesis: technical editorial—strong type, precise grids, restrained
  semantic color, purposeful whitespace, and fewer containers.
- Chosen first slice: shared kit plus three exemplars.
- The previous CalmOps demo screenshots are problem evidence only: they exposed
  repeated pale rounded cards, weak hierarchy, excess empty space, and an
  unconditional footer on a non-interactive summary.
- Treat all temporary demo artifacts as `reference-only` decision context until
  approved ideas are recaptured in durable packet prose or screenshots.

Frontend-direction requirements:
- Capture these exact brownfield baselines before proposing a replacement visual
  world:
  - the current shared shell with `architecture-data-flow.html` at desktop and
    narrow widths in light and dark modes;
  - the current shared shell with `carry-forward-summary.html` at desktop and
    narrow widths in light and dark modes;
  - the current shared shell with one selectable existing comparison example,
    including unselected, keyboard-focus, and selected states;
  - the CalmOps product-mockup demo capture as `reference-only` problem evidence
    if it is still available; otherwise record that no durable current product-
    mockup baseline exists rather than inventing one.
- Read project `PRODUCT.md` and `DESIGN.md` if present. If Impeccable is available,
  use it only as a quality layer after baseline capture; it must not replace
  runtime truth or become a required dependency.
- Produce:
  - `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend-direction.md`
  - `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screen-index.md`
  - `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/brownfield-ui-extraction.md`
  - retained captures under
    `docs/superpowers/specs/2026-07-31--visual-companion-design-kit--frontend/screenshots/`
    when they materially guide implementation
- Define the semantic visual foundation and demonstrate how each register differs
  without becoming an unrelated theme.
- Include desktop and narrow layouts, light/dark behavior, interaction/focus
  states, and the conditional footer behavior.
- For every implementation-facing screenshot, browser capture, generated image,
  or retained reference, record approved intent as `visual-truth`,
  `semantic-guidance`, or `reference-only`.
- Use `writing-ux-copy` if any visible string changes from the approved deck.
- If image generation is proposed, audit all prompt-visible copy and wait for
  human approval before treating output as a reference.
- Do not hand off to implementation until the packet and all
  implementation-affecting reference intents are approved or explicitly marked
  degraded.
