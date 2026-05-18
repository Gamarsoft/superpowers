# Frontend Direction Packet Template

Use this template when UI/UX materially shapes implementation.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`

Supporting folder:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/`

## Authoring rules

- Write for the implementation agent first.
- Explain **why** each visual direction was chosen.
- Keep product requirements in the main spec; keep visual-system, screen, and implementation-UX guidance here.
- Separate **must preserve** from **may adapt**.
- If the packet is in degraded mode, say so explicitly.
- Declare the implementation visual-truth source explicitly: `chatgpt-image-2`, `pencil`, or `current-ui/degraded`.
- Treat repo-local Pencil files as primary visual references only when Pencil is the selected source.
- Treat approved ChatGPT Images 2 files as primary visual references only when the human selected the image-only path.
- Classify every board, screenshot, or retained visual reference that may guide implementation as `visual-truth`, `semantic-guidance`, or `reference-only`.
- Get human approval for board/image/screenshot intent classifications before handing the packet to implementation.
- If HTML companion screens were used during decision-making, capture only the translated outcome here, not the raw HTML artifact path.

## Template

```markdown
# [Feature / Project Name] — Frontend Direction Packet

## 1. Packet Summary

- Linked design spec:
- Linked wireframes:
- Implementation visual-truth source: chatgpt-image-2 | pencil | current-ui/degraded
- Visual-truth approval status: approved | pending | incomplete
- Design source priority: current UI → code patterns → extraction docs → approved visual-truth source → wireframes → temporary HTML companion artifacts
- Brownfield preserve vs redesign call:
- Visual reference intent approval status: approved | pending | incomplete
- Packet status: full-fidelity | degraded
- Packet folder: `./{slug}--frontend/`
- Screen index: `./{slug}--frontend/screen-index.md`
- Brownfield extraction: `./{slug}--frontend/brownfield-ui-extraction.md` | not used for greenfield mobile
- Greenfield mobile foundation notes: `./{slug}--frontend/mobile-foundation-notes.md` | not used
- UX copy source: spec copy deck | packet copy deck | existing i18n | pending
- UX copy approval status: approved | pending | incomplete
- ChatGPT Images 2 pack: not used | pending generation | generated pending approval | approved references available
- ChatGPT Images 2 folder: `./{slug}--frontend/chatgpt-image-2/`
- Pencil status: selected | omitted by human visual-truth decision | not used | pending
- Pencil workset: `./{slug}--frontend/pencil-workset.md` | not created
- Repo-local Pencil files:
  - not used
  - or `design/pencil/_shared/00-foundations.pen`
  - or `design/pencil/_shared/10-shell.pen`
  - or `design/pencil/_shared/20-patterns.pen`
  - or `design/pencil/{slug}/30-{slug}.pen`
- Retained screenshots:
  - `./{slug}--frontend/screenshots/...`
- HTML companion status: not used | used and translated into approved visual-truth source

## 2. Downstream Skill Plan

### Skills used to create this packet
- `mobile-product-direction` (if native/mobile-first flow direction was shaped here)
- `mobile-interaction-and-usability` (if mobile interaction, state behavior, or accessibility was shaped here)
- `mobile-visual-design` (if mobile visual direction was shaped here)
- `mobile-design-review` (if a mobile design review was run before handoff)
- `creating-chatgpt-image-upload-packs` (if ChatGPT Images 2 references were used)
- `pencil-design-core` (only when Pencil was selected)
- `[chosen Pencil adapter]` (only when Pencil was selected)

### Skills downstream implementation should load
- `gsd-frontend-design`
- `mobile-product-direction` (only when mobile screen/flow direction remains unresolved)
- `mobile-interaction-and-usability` (when implementing or verifying mobile navigation, forms, gestures, permissions, states, text scaling, semantics, or tap targets)
- `mobile-visual-design` (when implementing or refining mobile hierarchy, visual polish, native feel, motion, or state visuals)
- `mobile-design-review` (for non-trivial mobile UI review)
- `pencil-design-core` (only when Pencil is the visual-truth source)
- `[chosen Pencil adapter]` (only when Pencil is the visual-truth source)
  - use `pencil-design-flutter-material` for Flutter / Material 3 / app_ui targets

### Explicit non-assumptions
- [e.g. do not assume React/Tailwind]
- [e.g. do not invent a new shell]
- [e.g. do not assume browser evidence for native Flutter]
- [e.g. do not load Pencil skills when ChatGPT Images 2 is the selected visual-truth source]
- [e.g. do not treat a native mobile app as a web page squeezed into a phone]

## 3. Visual Thesis

- Intended first impression:
- Hierarchy / density bias:
- Visual anchor:
- Tone / trust cues:
- Anti-patterns to avoid:

## 4. Brownfield Extraction Summary

- Strong patterns to preserve:
- Known drift / pain points:
- Safe improvements in this slice:
- Explicit no-gos:
- If greenfield mobile, record brand/reference inputs instead of pretending a brownfield UI baseline exists:
  - Existing brand/product references:
  - Design-system foundations to establish:
  - Native mobile assumptions:
  - Reference inputs that are non-binding:

## 5. Screen Inventory

- Link: `./{slug}--frontend/screen-index.md`
- Key screens / flows covered:
- Critical states covered:
- Still deferred:

## 6. Chosen Directions for Key Screens

### Board intent modes

- `visual-truth`: binding visual treatment; implementation must verify board parity.
- `semantic-guidance`: behavior, content priority, workflow, or state coverage is binding; visual treatment may adapt to the product system.
- `reference-only`: inspiration or comparison aid; not an acceptance target unless promoted later.

These modes apply to Pencil boards, approved ChatGPT Images 2 generated images, screenshots, and browser captures.

### [Screen / flow name]

- User goal:
- Selected reference(s):
- ChatGPT Images 2 reference status: not used | reference-only | visual-truth | approved for Pencil translation | rejected
- Primary visual source: ChatGPT Images 2 approved image | Pencil board | current UI/browser capture
- Approved ChatGPT Images 2 file(s):
- Pencil file and board/frame: not used | path + board/frame
- Reference intent: visual-truth | semantic-guidance | reference-only
- Intent approved by: [human / date / pending]
- If semantic-guidance, binding intent:
- If reference-only, why retained:
- Why this direction won:
- Layout / hierarchy notes:
- Content priority:
- Component reuse:
- Important states:
- What remains flexible:

### [Screen / flow name]

- ...

## 7. Design System Contract

- Color roles:
- Typography roles:
- Spacing / layout rhythm:
- Component patterns to reuse:
- Icon / media / illustration guidance:
- Copy / content voice:
- Approved terminology:
- Copy deck / visible text source:
- i18n variable and formatting rules:
- Known normalization targets:
- Things that must stay implementation-native to the target stack:

## 8. Interaction and Motion

- Primary transitions:
- Feedback patterns:
- Hover / focus / pressed states:
- Motion constraints:

## 9. Responsive Contract

- Viewport families:
- What reflows:
- What stays fixed:
- Mobile priorities:
- Desktop priorities:
- Dense-data adaptation rules:

## 10. State Coverage

- Loading:
- Empty:
- Error:
- Validation:
- Permissions / role variants:
- Destructive / confirmation flows:

## 11. Accessibility and Content Constraints

- Heading / landmark structure:
- Focus and keyboard expectations:
- Contrast / non-color cues:
- Approved labels, CTAs, helper text, warnings, empty states, errors, confirmations, and permission copy:
- Copy length / truncation rules:
- Localization or RTL notes:

## 12. Implementation Contract

### Must preserve
- ...

### May adapt
- ...

### Explicit no-gos
- ...

### Stack / framework notes
- [Angular / Nebular / existing component or CSS constraints]
- [Flutter / Material 3 / app_ui constraints when target is Flutter]
- [what not to generate or assume]

### Flutter / Mobile Implementation Notes
- Target app:
- Target package:
- Mobile product mode:
- Primary mobile jobs:
- Navigation model:
- Screen inventory and primary action per screen:
- Critical mobile states:
- Permission moments and denied-state fallbacks:
- Offline/degraded behavior:
- Native-vs-web risks:
- Design-system package: `packages/app_ui` | not used | unknown
- Theme source:
  - Material Theme Builder export:
  - `ThemeData` location:
  - `ColorScheme` source:
  - `TextTheme` source:
  - `ThemeExtension` source:
- Existing UI gallery / catalog:
- Navigation system:
- State-management system:
- l10n source:
- Required device families:
  - compact iPhone:
  - compact Android:
  - large phone:
  - tablet / landscape, if relevant:
- Text scaling requirements:
- Tap target / reachability requirements:
- Semantics / screen reader expectations:
- Gesture alternatives:
- Golden/widget test expectations:
- Runtime screenshot expectations:

## 13. Verification Plan

- Required viewports:
- Required mobile device families:
- Screenshot checks by reference intent:
  - visual-truth parity checks against approved ChatGPT Images 2 images or Pencil boards:
  - semantic-guidance intent-fit checks:
  - reference-only items excluded from acceptance:
- Interaction checks:
- Mobile usability checks:
- Mobile design review status:
- Acceptance tie-back to main spec:
- Known visual risks:

## 14. Open Questions and Deferred Design Work

- Open question:
- Deferred improvement:

## Appendix A. Screen Index
- `./{slug}--frontend/screen-index.md`

## Appendix B. Brownfield UI Extraction
- `./{slug}--frontend/brownfield-ui-extraction.md`

## Appendix C. Pencil Workset
- Pencil selected: yes | no
- If yes:
  - `./{slug}--frontend/pencil-workset.md`
  - `design/pencil/_shared/...`
  - `design/pencil/{slug}/30-{slug}.pen`
- If no: omitted by human visual-truth decision; implementation must not require Pencil boards for this scope.

## Appendix D. ChatGPT Images 2 References
- `./{slug}--frontend/chatgpt-image-2/`
- Approved generated references:
- References selected as implementation visual truth:
- Rejected generated references:
- Human approval note/date:

## Appendix E. Screenshot Preview Index
- `./{slug}--frontend/screenshots/...`

## Appendix F. Companion Translation Notes
- [Optional. Summarize any HTML companion decision that was translated into the approved visual-truth source and packet prose.]
```

## Quality bar

A strong packet:

- makes the intended visual direction legible without guessing
- covers the main screens and key states
- names what implementation must preserve
- names the selected implementation visual-truth source
- names the exact downstream Pencil skills and adapter only when Pencil is selected
- keeps product scope aligned with the main spec
- gives Copilot, Codex, or GSD enough direction to build UI without inventing the design from scratch
- points to stable repo-local visual references, including approved generated images saved in the packet folder when image-only visual truth is selected
