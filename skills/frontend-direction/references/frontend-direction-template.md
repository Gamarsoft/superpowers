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
- Treat repo-local Pencil files as primary visual references when available.
- If HTML companion screens were used during decision-making, capture only the translated outcome here, not the raw HTML artifact path.

## Template

```markdown
# [Feature / Project Name] — Frontend Direction Packet

## 1. Packet Summary

- Linked design spec:
- Linked wireframes:
- Design source priority: current UI → code patterns → extraction docs → Pencil → wireframes → temporary HTML companion artifacts
- Brownfield preserve vs redesign call:
- Packet status: full-fidelity | degraded
- Packet folder: `./{slug}--frontend/`
- Screen index: `./{slug}--frontend/screen-index.md`
- Brownfield extraction: `./{slug}--frontend/brownfield-ui-extraction.md`
- Pencil workset: `./{slug}--frontend/pencil-workset.md`
- Repo-local Pencil files:
  - `design/pencil/_shared/00-foundations.pen`
  - `design/pencil/_shared/10-shell.pen`
  - `design/pencil/_shared/20-patterns.pen`
  - `design/pencil/{slug}/30-{slug}.pen`
- Retained screenshots:
  - `./{slug}--frontend/screenshots/...`
- HTML companion status: not used | used and translated into Pencil

## 2. Downstream Skill Plan

### Skills used to create this packet
- `pencil-design-core`
- `[chosen adapter]`

### Skills downstream implementation should load
- `gsd-frontend-design`
- `pencil-design-core`
- `[chosen adapter]`

### Explicit non-assumptions
- [e.g. do not assume React/Tailwind]
- [e.g. do not invent a new shell]

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

## 5. Screen Inventory

- Link: `./{slug}--frontend/screen-index.md`
- Key screens / flows covered:
- Critical states covered:
- Still deferred:

## 6. Chosen Directions for Key Screens

### [Screen / flow name]

- User goal:
- Selected reference(s):
- Primary visual source:
- Pencil file and board/frame:
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
- [what not to generate or assume]

## 13. Verification Plan

- Required viewports:
- Screenshot checks:
- Interaction checks:
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
- `./{slug}--frontend/pencil-workset.md`
- `design/pencil/_shared/...`
- `design/pencil/{slug}/30-{slug}.pen`

## Appendix D. Screenshot Preview Index
- `./{slug}--frontend/screenshots/...`

## Appendix E. Companion Translation Notes
- [Optional. Summarize any HTML companion decision that was translated into Pencil and packet prose.]
```

## Quality bar

A strong packet:

- makes the intended visual direction legible without guessing
- covers the main screens and key states
- names what implementation must preserve
- names the exact downstream Pencil skills and adapter
- keeps product scope aligned with the main spec
- gives Copilot, Codex, or GSD enough direction to build UI without inventing the design from scratch
- points to stable repo-local visual references instead of ephemeral generation output
