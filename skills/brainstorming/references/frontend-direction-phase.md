# Frontend Direction Phase

Use this phase after the product direction, primary flows, and first delivery boundary are stable enough to anchor screens.

This phase exists because implementation agents are much stronger when visual direction is explicit instead of implied.

## Activate when

Activate the phase when **any** of these are true:

- the first release includes new or meaningfully changed pages, screens, dialogs, wizards, dashboards, forms, or visual states
- hierarchy, density, navigation, layout rhythm, or interaction detail materially affects implementation
- the user explicitly asks for UI/UX direction, polished visual references, or Stitch-generated options
- a spec + wireframe combo would still leave the implementation agent guessing about the intended visual language
- brownfield work must preserve or extend an existing design system in a deliberate way

## Skip when

Skip the phase when **all** of these are true:

- the work is backend, API, data, infrastructure, or architecture-only
- UI changes are purely mechanical and fit a stable existing component pattern
- there is already an approved frontend direction packet and it still matches the current scope

## Goals

- make the intended experience visible before implementation starts
- capture what must be preserved from the current product or design system
- create a small number of high-signal visual references for the most important screens
- tell implementation agents what is fixed, what is flexible, and what to avoid

## Tooling preference

- Prefer **direct Stitch MCP** when available.
- Treat a Codex plugin as optional packaging, not a requirement.
- If a local `frontend-direction` skill exists, prefer routing the generation/editing work through it.
- If Stitch or the companion skill is unavailable, stay in **degraded mode**: use repo context, existing screenshots, design notes, and wireframes to create a lower-fidelity packet.
- Remember that the downstream implementation-time `gsd-frontend-design` skill should consume this packet as a primary input, so write for faithful implementation rather than visual poetry.

## Output files

Write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/stitch-prompt-pack.md`

When you generated or gathered reference imagery, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/selected-direction/`

When the work is repo-tied and Stitch MCP is available, optionally refresh:

- `.stitch/DESIGN.md`

## Workflow

1. **Gather inputs**
   - Approved or near-approved framing brief
   - Current design spec draft
   - Existing product screenshots or current UI surfaces if brownfield
   - Durable wireframes if they exist
   - Known design-system guidance, `.stitch/DESIGN.md`, or equivalent

2. **Decide the source of design truth**
   - Brownfield default: preserve and extend the current system.
   - Greenfield default: create a clear visual thesis before asking for variants.
   - If a redesign is intentional, say so explicitly instead of drifting into redesign by accident.

3. **Build the screen inventory**
   - Use `references/screen-index-template.md`.
   - Cover primary screens plus the most important loading, empty, error, validation, and permission states.
   - Do not design every screen in detail before choosing a direction.

4. **Capture design-system truth**
   - If `.stitch/DESIGN.md` exists and is relevant, treat it as primary visual-system context.
   - If it does not exist and Stitch MCP is available for a brownfield project, generate or refresh it.
   - Otherwise, capture equivalent design-system rules inside the frontend direction packet.

5. **Prepare the Stitch prompt pack**
   - Use `references/stitch-prompt-pack-template.md`.
   - Make prompts self-contained.
   - Attach or reference wireframes, screenshots, and design-system sources when available.
   - Keep the prompt pack centered on the **key screens**, not every possible screen.

6. **Generate visual references**
   - Generate or request 2–3 variants for 1–3 key screens or screen families.
   - Focus on the decision axis that matters: hierarchy, density, navigation, trust, onboarding clarity, etc.
   - Avoid generating a huge gallery with no decision purpose.

7. **Review and select a direction**
   - Use the visual companion when the choice is materially easier to judge by seeing.
   - Prefer side-by-side comparison, ranked alternatives, or annotated recommendation.
   - Record why the chosen direction wins and what was rejected.

8. **Expand the contract**
   - Fill in responsive behavior, interaction cues, state coverage, accessibility constraints, and implementation flex points.
   - Separate **must preserve** from **may adapt** so implementation agents know where they have freedom.

9. **Write the packet**
   - Use `references/frontend-direction-template.md`.
   - Link screenshots and prompt-pack entries instead of burying them in prose.
   - Be explicit when the packet is in degraded mode.

10. **Feed the result back into the main artifacts**
    - Link the packet from the design spec.
    - Link the packet from the GSD handoff.
    - Review all artifacts together for drift.

## Quality bar

A strong frontend-direction phase produces:

- a visible visual thesis
- a clear screen inventory
- selected references for the key screens
- explicit state coverage
- a design-system contract or DESIGN.md parity note
- a must-preserve vs may-adapt implementation contract
- a verification plan that can be reused during frontend implementation

## Common mistakes

- asking Stitch or any other tool to invent product requirements
- generating many screens before choosing a direction
- treating wireframes as enough visual guidance when the implementation agent still has to guess tone and hierarchy
- drifting into a redesign when the user really wanted brownfield continuity
- writing a frontend packet with screenshots but no explanation of why they were chosen
- failing to separate fixed constraints from flexible implementation details
