---
name: design-system-bootstrap
description: Create or refresh `.stitch/DESIGN.md` for a brownfield product before new UI work when the agent needs to extract an existing design language from a Stitch project, representative current screens, screenshots, or repo-native UI tokens and turn it into a reusable design-system source of truth. Use when bootstrapping Stitch for an existing app, choosing whether to reuse or create a Stitch project, selecting anchor screens, hardening DESIGN.md with codebase facts, or recording project continuity for later frontend-direction work.
---

# Design System Bootstrap

Create a reusable Stitch-ready design-system baseline before generating new screens.

This skill is for brownfield products with meaningful existing UI. It bootstraps or refreshes `.stitch/DESIGN.md` so later `frontend-direction` and implementation work can reuse the current visual language instead of inventing it.

Do **not** use this skill for final frontend implementation or for net-new greenfield ideation unless the user explicitly wants a design-system file first.

## Outputs

Write:

- `.stitch/DESIGN.md`
- `.stitch/bootstrap-report.md`

When available, also update:

- `.stitch/designs/`
- `.stitch/screenshots/`

## Read order

1. Read `references/bootstrap-workflow.md`.
2. Read `references/anchor-screen-rubric.md`.
3. Read `references/output-template.md` when drafting the files.
4. Read `references/design-md-hardening-checklist.md` before finalizing.

## Workflow

1. Define the surface boundary.
   - Bootstrap **one coherent visual system** at a time.
   - Reuse the same Stitch project for the same product surface.
   - Use a new Stitch project only for a clearly distinct surface or a deliberate redesign branch.

2. Decide project continuity.
   - If a matching Stitch project already exists, reuse it.
   - If none exists, create one and record that decision in `.stitch/bootstrap-report.md`.
   - If the product has multiple visual systems, pick one surface and defer the others.

3. Ensure representative screens exist.
   - Prefer a Stitch project that already contains representative existing screens.
   - If the project is missing strong anchors, seed it first from the live product, URL extraction, screenshots, or manually created screens.
   - If Stitch inputs are still incomplete, produce a degraded bootstrap from repo context and call out the exact gaps.

4. Select anchor screens.
   - Minimum: 5 anchor screens.
   - Target for a large brownfield surface: 8–12 anchor screens.
   - Use `references/anchor-screen-rubric.md`.
   - Prefer stable, high-traffic, representative screens over flashy or one-off screens.

5. Retrieve Stitch design context.
   - Use Stitch MCP to find the target project, list screens, and fetch representative screen metadata and assets.
   - Prefer project-level continuity over ad hoc single-screen extraction.
   - Download representative HTML and screenshots when that improves synthesis or later reuse.

6. Draft `.stitch/DESIGN.md`.
   - Start from the representative Stitch screens.
   - Translate raw CSS or utility-class facts into semantic design language.
   - Keep exact hex values where precision matters.
   - Preserve brownfield continuity instead of upgrading the aesthetic by default.

7. Harden the draft with repo-native truth.
   - Merge in the actual design facts that only exist in the repo: tokens, CSS variables, theme files, Storybook, component primitives, spacing rules, icon systems, and state conventions.
   - Do not let the Stitch draft override verified repo conventions without calling that out.

8. Record continuity and confidence.
   - Write `.stitch/bootstrap-report.md` with the surface name, Stitch project name and ID, anchor screens, repo sources used, verified facts, inferred facts, and refresh date.
   - Make it obvious whether the result is production-trustworthy or still needs more representative screens.

9. Finalize or stop honestly.
   - If the file is strong enough, declare it ready for `frontend-direction`.
   - If not, still save the best draft, label degraded mode clearly, and list the next screens or sources needed.

## Rules

- One `DESIGN.md` per coherent visual system.
- Same product surface -> same Stitch project.
- New project only for a distinct surface or intentional redesign branch.
- Do not average contradictory legacy and redesigned areas into one system.
- Prefer stable, frequently used screens over demos, experiments, and marketing one-offs.
- Keep semantic descriptions plus exact hex codes.
- Mark major inferred sections explicitly when they are not directly verified from Stitch or repo sources.
- Preserve the existing product language by default.
- After bootstrapping, later skills should treat `.stitch/DESIGN.md` and `.stitch/bootstrap-report.md` as first-class inputs.

## Quality bar

A strong bootstrap result:

- captures the real brownfield design language instead of a generic summary
- makes Stitch project reuse explicit and repeatable
- covers the main layout, component, state, and responsive patterns
- distinguishes verified facts from inference
- gives `frontend-direction` enough continuity to generate new screens without drifting off-system
