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

## Template

```markdown
# [Feature / Project Name] — Frontend Direction Packet

## 1. Packet Summary
- Linked design spec:
- Linked wireframes:
- Design-system source:
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

## 4. Chosen Directions for Key Screens
### [Screen / flow name]
- User goal:
- Selected reference(s):
- Why this direction won:
- Layout / hierarchy notes:
- Content priority:
- Important states:
- What remains flexible:

### [Screen / flow name]
- ...

## 5. Design System Contract
- Color roles:
- Typography roles:
- Spacing / layout rhythm:
- Component patterns to reuse:
- Icon / media / illustration guidance:
- Copy / content voice:

## 6. Interaction and Motion
- Primary transitions:
- Feedback patterns:
- Hover / focus / pressed states:
- Motion constraints:

## 7. Responsive Contract
- Viewport families:
- What reflows:
- What stays fixed:
- Mobile priorities:
- Desktop priorities:

## 8. State Coverage
- Loading:
- Empty:
- Error:
- Validation:
- Permissions / role variants:
- Destructive / confirmation flows:

## 9. Accessibility and Content Constraints
- Heading / landmark structure:
- Focus and keyboard expectations:
- Contrast / non-color cues:
- Copy length / truncation rules:
- Localization or RTL notes:

## 10. Implementation Contract
### Must preserve
- ...

### May adapt
- ...

### Explicit no-gos
- ...

### Source references
- `./{slug}--frontend/screenshots/...` — why it matters
- `.stitch/DESIGN.md` — if applicable

## 11. Verification Plan
- Required viewports:
- Screenshot checks:
- Interaction checks:
- Acceptance tie-back to main spec:
- Known visual risks:

## 12. Open Questions and Deferred Design Work
- Open question:
- Deferred improvement:

## Appendix A. Screenshot Index
- `./{slug}--frontend/screenshots/...` — description

## Appendix B. Stitch Prompt Pack
- `./{slug}--frontend/stitch-prompt-pack.md`

## Appendix C. DESIGN.md Parity Notes
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
