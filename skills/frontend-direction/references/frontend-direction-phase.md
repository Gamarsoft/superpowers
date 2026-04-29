# Frontend Direction Phase

Use this phase after the product direction, primary flows, and first delivery boundary are stable enough to anchor screens.

This phase exists because implementation agents are much stronger when visual direction is explicit instead of implied.

In the split workflow, `brainstorming` produces the approved spec, GSD handoff, and follow-on prompt first. Run this phase in a fresh or manually compacted session to preserve context-window budget.

## Activate when

Activate the phase when **any** of these are true:

- the first release includes new or meaningfully changed pages, screens, dialogs, wizards, dashboards, forms, or visual states
- hierarchy, density, navigation, layout rhythm, or interaction detail materially affects implementation
- the user explicitly asks for UI/UX direction, polished visual references, or a comparison of possible directions
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
- keep the durable visual truth in repo-local artifacts: approved ChatGPT Images 2 files, `.pen` files when selected, and packet docs

## Tooling preference

- Prefer an explicit, human-approved visual-truth source.
- Pencil is the default durable board path; approved ChatGPT Images 2 references are valid when the human selects the image-only path.
- Prefer repo-local `.pen` files when Pencil is selected.
- Choose the correct adapter via `references/pencil-skill-selection.md` only when Pencil is selected.
- Treat GitHub Copilot and Codex as the main implementation-facing agents.
- Treat HTML visual-companion screens as temporary comparison artifacts, not as durable packet evidence.
- If Pencil is unavailable, stay honest about degraded mode and still produce a usable packet from repo context, screenshots, and wireframes.

## Output files

Write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/brownfield-ui-extraction.md` _(brownfield default)_

When ChatGPT Images 2 references are requested or needed before visual-truth selection, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/`

When Pencil is selected as the visual-truth source, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/pencil-workset.md`

When you generated or gathered reference imagery, also write:

- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`

When Pencil is selected as the visual-truth source, also create or refresh:

- `design/pencil/_shared/00-foundations.pen`
- `design/pencil/_shared/10-shell.pen`
- `design/pencil/_shared/20-patterns.pen`
- `design/pencil/{slug}/30-{slug}.pen`

## Workflow

1. **Gather inputs**
   - Approved design spec
   - Approved GSD handoff
   - Frontend-direction follow-on prompt from brainstorming, when present
   - Existing product screenshots or current UI surfaces if brownfield
   - Durable wireframes if they exist
   - Anchoring docs, audits, or prior approved packets
   - `PRODUCT.md` and `DESIGN.md` when the repo uses Impeccable v3

2. **If the work is brownfield and durable evidence is missing, capture a runtime baseline first**
   - Apply `references/browser-surface-selection.md` before starting browser interaction.
   - Use browser-grounded evidence from the running app before inferring layout from code alone.
   - Capture desktop and narrow/mobile views for the current screen.
   - Capture the key local states for the changed area: loading, empty, validation/error, disabled/permission when relevant.
   - Treat the first design artifact as a faithful baseline of the current screen, not as an improved redesign.

3. **Decide the source of design truth**
   - Read `references/design-source-priority.md`.
   - Brownfield default: preserve and extend the current system.
   - Greenfield default: still converge to a human-approved visual-truth source instead of scattered generated images.
   - If a redesign is intentional, say so explicitly instead of drifting into redesign by accident.

4. **Identify target stack and possible Pencil skills**
   - Read `references/pencil-skill-selection.md`.
   - Pick the core skill plus the correct adapter for the target stack only if Pencil remains possible or selected.
   - Record the chosen visual-truth source and any chosen skills in the packet and handoff.

5. **Run brownfield extraction first** _(brownfield default)_
   - Use `references/brownfield-ui-extraction-template.md`.
   - Capture what is already strong, what must be preserved, and what is safe to improve now.
   - Separate `observed current truth`, `conservative normalization target`, and `optional exploration`.
   - Do not start variant generation before this exists.

6. **Build the screen inventory**
   - Use `references/screen-index-template.md`.
   - Cover primary screens plus the most important loading, empty, error, validation, and permission states.
   - Do not design every screen in detail before choosing a direction.

7. **Run ChatGPT Images 2 reference generation when needed**
   - Use `creating-chatgpt-image-upload-packs` when the user wants image references or visual truth is unstable.
   - Stop after the prompt pack until the human generates images, saves approved images beside matching prompts, and chooses the visual-truth path.
   - If approved ChatGPT Images 2 references are selected as visual truth, omit Pencil and record the exact image files as binding references.

8. **Create or refresh the Pencil workset when Pencil is selected**
   - Use `references/pencil-workset-template.md`.
   - Recreate current foundations, shell, and shared patterns first.
   - Put durable design references in repo-local `.pen` files.
   - Keep the workset small and reusable.

9. **Explore bounded variants in the selected source**
   - Use `pencil-design-core` plus the chosen adapter only in the Pencil path.
   - Explore only the decision axis that matters:
     - hierarchy
     - density
     - mobile adaptation
     - settings grouping
     - action visibility
     - trust / clarity / error treatment
   - Prefer baseline + 1–2 variants, not large galleries.

10. **Review and select a direction**
   - Use the visual companion when the choice is materially easier to judge by seeing.
   - Use `/impeccable live` only as an optional refinement surface on supported stacks after the baseline and packet direction already exist.
   - Prefer side-by-side comparison, ranked alternatives, or annotated recommendation.
   - Record why the chosen direction wins and what was rejected.

11. **Companion-assisted comparison** _(optional)_
   - Use the visual companion only when a very specific visual question is materially easier to judge in HTML than in prose.
   - Keep the comparison bounded to the decision axis that matters.
   - Translate any selected concept back into the approved visual-truth source before treating it as real design direction.

12. **Expand the implementation contract**
    - Fill in responsive behavior, interaction cues, state coverage, accessibility constraints, and implementation flex points.
    - Separate **must preserve** from **may adapt** so implementation agents know where they have freedom.
    - Classify every board, approved ChatGPT Images 2 image, screenshot, or retained visual reference as `visual-truth`, `semantic-guidance`, or `reference-only`.
    - Get human approval for any classification that will affect implementation. Do not leave classification for downstream implementation agents to infer.
    - Record the exact Pencil skills to load downstream only when Pencil is selected.

13. **Write the packet**
    - Use `references/frontend-direction-template.md`.
    - Link approved ChatGPT Images 2 files, screenshots, and Pencil files when selected instead of burying them in prose.
    - Be explicit when the packet is in degraded mode.

14. **Run completeness checks**
    - Review against:
      - `references/frontend-review-checklist.md`
      - `references/frontend-packet-completeness-checklist.md`

15. **Feed the result back into the main artifacts**
    - Link the packet from the design spec.
    - Link the packet from the GSD handoff.
    - Review all artifacts together for drift.

## Quality bar

A strong frontend-direction phase produces:

- a visible visual thesis
- a clear screen inventory
- a brownfield extraction summary when applicable
- a declared implementation visual-truth source
- approved ChatGPT Images 2 references or a Pencil workset that holds the durable design truth
- selected references for the key screens
- approved intent modes for all implementation references
- explicit state coverage
- a must-preserve vs may-adapt implementation contract
- exact downstream skill and adapter guidance
- a verification plan that can be reused during frontend implementation

## Common mistakes

- asking a design tool to invent product requirements
- generating many screens before choosing a direction
- treating wireframes as enough visual guidance when the implementation agent still has to guess tone and hierarchy
- drifting into a redesign when the user really wanted brownfield continuity
- treating `PRODUCT.md`, `DESIGN.md`, or `/impeccable live` output as permission to skip baseline capture or packet convergence
- writing a frontend packet with screenshots but no explanation of why they were chosen
- relying on generated screenshots without approval, matching filenames, and a recorded visual-truth role
- leaving a winning HTML companion idea in HTML instead of translating it back into the approved visual-truth source
- failing to separate fixed constraints from flexible implementation details
- leaving image or board intent ambiguous and forcing implementation agents to guess whether a reference is visual truth or semantic guidance
- failing to state whether Pencil is omitted or selected, causing implementation drift
