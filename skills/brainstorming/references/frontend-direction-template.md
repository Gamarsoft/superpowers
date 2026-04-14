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
- If Stitch is used, record machine-usable source handles, not just preview images.

## Template

```markdown
# [Feature / Project Name] — Frontend Direction Packet

## 1. Packet Summary

- Linked design spec:
- Linked wireframes:
- Design-system source:
- Stitch project ID:
- Stitch design system ID:
- Selected Stitch source manifest: `./{slug}--frontend/stitch-sources.json`
- Stitch retrieval mode: live MCP + local mirror | local mirror only | preview only (degraded)
- Selected screen mirrors: `./{slug}--frontend/selected-direction/`
- Brownfield preserve vs redesign call:
- Packet status: full-fidelity | degraded

## 2. Visual Thesis

- Intended first impression:
- Hierarchy / density bias:
- Visual anchor:
- Tone / trust cues:
- Anti-patterns to avoid:

## 3. Screen Inventory

- Link: `./{slug}--frontend/screen-index.md`
- Key screens / flows covered:
- Critical states covered:
- Still deferred:

## 4. Stitch Source Manifest

- Link: `./{slug}--frontend/stitch-sources.json`
- Purpose: durable machine-usable mapping from packet screen keys to exact Stitch screens and local mirrors
- Use in implementation: prefer live Stitch retrieval by screen ID, then local HTML mirror, then full-resolution screenshot mirror, then packet preview image
- Use in refinement: critique and refine against the strongest available Stitch-backed source rather than the small embedded preview image

## 5. Chosen Directions for Key Screens

### [Screen / flow name]

- User goal:
- Selected reference(s):
- Why this direction won:
- Layout / hierarchy notes:
- Content priority:
- Important states:
- What remains flexible:

**Stitch source**

- Screen key:
- Selection status: preferred | comparison | rejected-but-retained | state-only
- Project ID:
- Screen ID:
- Resource:
- Screen title:
- Device:
- Size:
- Screenshot mirror:
- HTML mirror:
- Metadata:
- Notes:

### [Screen / flow name]

- ...

## 6. Design System Contract

- Color roles:
- Typography roles:
- Spacing / layout rhythm:
- Component patterns to reuse:
- Icon / media / illustration guidance:
- Copy / content voice:

## 7. Interaction and Motion

- Primary transitions:
- Feedback patterns:
- Hover / focus / pressed states:
- Motion constraints:

## 8. Responsive Contract

- Viewport families:
- What reflows:
- What stays fixed:
- Mobile priorities:
- Desktop priorities:

## 9. State Coverage

- Loading:
- Empty:
- Error:
- Validation:
- Permissions / role variants:
- Destructive / confirmation flows:

## 10. Accessibility and Content Constraints

- Heading / landmark structure:
- Focus and keyboard expectations:
- Contrast / non-color cues:
- Copy length / truncation rules:
- Localization or RTL notes:

## 11. Implementation Contract

### Must preserve

- ...

### May adapt

- ...

### Explicit no-gos

- ...

### Source references

- `./{slug}--frontend/stitch-sources.json` — exact Stitch screen mapping
- `./{slug}--frontend/selected-direction/...` — HTML mirrors, full-resolution screenshots, metadata mirrors
- `.stitch/DESIGN.md` — design-system continuity if applicable

## 12. Verification Plan

- Required viewports:
- Screenshot checks:
- Interaction checks:
- Acceptance tie-back to main spec:
- Known visual risks:

## 13. Open Questions and Deferred Design Work

- Open question:
- Deferred improvement:

## Appendix A. Screenshot Preview Index

- `./{slug}--frontend/screenshots/...` — description

## Appendix B. Stitch Source Manifest

- `./{slug}--frontend/stitch-sources.json`

## Appendix C. Stitch Prompt Pack

- `./{slug}--frontend/stitch-prompt-pack.md`

## Appendix D. DESIGN.md Parity Notes

- What this packet inherits from `.stitch/DESIGN.md`
- Any intentional deviations
```

## Quality bar

A strong packet:

- makes the intended visual direction legible without guessing
- covers the main screens and key states
- names what implementation must preserve
- keeps product scope aligned with the main spec
- gives Codex, Copilot, or GSD enough direction to build UI without inventing the design from scratch
- gives implementation and refinement agents enough source metadata to recover exact Stitch screens later
