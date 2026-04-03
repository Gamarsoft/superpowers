# Design-system bootstrap guide

This guide explains how to use the new `design-system-bootstrap` skill in a repeatable way for big brownfield products.

## What this skill is for

Use it **before** new screen brainstorming when the product already has a meaningful UI and you want Stitch to inherit that design language instead of inventing one.

The skill creates or refreshes:

- `.stitch/DESIGN.md`
- `.stitch/bootstrap-report.md`

Those files then become first-class inputs for:

- `frontend-direction`
- `gsd-frontend-design`
- Stitch-backed screen generation during brainstorming

## Recommended moment in your workflow

For a brownfield app, use this order:

1. Pick the product surface you are working on.
2. Run `design-system-bootstrap` to create or refresh `.stitch/DESIGN.md`.
3. Run `frontend-direction` to generate the packet, screen index, and Stitch prompt pack.
4. Implement with `gsd-frontend-design` using the packet plus `.stitch/DESIGN.md`.

## Install location

Place the skill in your repo-local skills directory so Codex and compatible agents can discover it:

```text
.agents/skills/design-system-bootstrap/
```

If you already keep your custom skills elsewhere, keep it alongside `brainstorming`, `frontend-direction`, and `gsd-frontend-design`.

## The four common flows

### Flow 1 — I already have a good Stitch project for this surface

Use this when the same product surface already has a Stitch project with representative existing screens.

Example prompt:

```text
Use $design-system-bootstrap to create or refresh .stitch/DESIGN.md for the logged-in product surface.
Reuse the existing Stitch project if it matches the main app UI.
Pick 8 to 12 representative anchor screens, write .stitch/bootstrap-report.md, and mark what is verified versus inferred.
```

Expected result:

- same Stitch project is reused
- representative screens are selected
- `.stitch/DESIGN.md` is refreshed
- the report records the project ID, anchors, and any gaps

### Flow 2 — I do not have a Stitch project yet

Use this when the brownfield surface is real, but Stitch has no project for it yet.

Example prompt:

```text
Use $design-system-bootstrap for the admin surface.
Create a new Stitch project only for that surface, not for the whole monorepo.
If the project is missing representative screens, tell me exactly which current screens should be seeded first and continue with the strongest available context.
```

Expected result:

- a new Stitch project is created for that one surface
- the skill either works from seeded screens or produces a degraded first pass with explicit gaps
- you get a reusable baseline instead of a one-off prompt

### Flow 3 — The repo has multiple distinct surfaces

Examples:

- customer-facing product
- internal admin console
- public marketing site

Use **one bootstrap per coherent visual system**.
Do not try to put all three into one `.stitch/DESIGN.md`.

Example prompt:

```text
Use $design-system-bootstrap for the internal operations console only.
Do not mix the public marketing site or the customer dashboard into this bootstrap.
Reuse an existing Stitch project if one already matches that console.
```

Expected result:

- one `.stitch/DESIGN.md` per surface
- cleaner project reuse on the Stitch side
- less design drift later

### Flow 4 — Refresh after design drift

Use this when `.stitch/DESIGN.md` exists but the app shell, theme, or component language changed enough that new screens would drift.

Example prompt:

```text
Use $design-system-bootstrap to refresh .stitch/DESIGN.md for the billing surface.
Assume the previous file is stale after the navigation redesign and token cleanup.
Keep the same Stitch project if the visual system is still the same, replace stale anchors, and update the report.
```

Expected result:

- same project reused when appropriate
- stale anchors replaced
- report explains what changed and why

## How many anchor screens should I use?

For a large brownfield surface:

- minimum acceptable start: 5
- recommended target: 8–12
- avoid going much beyond 12 in the first pass unless the surface is unusually broad

Good anchor coverage usually includes:

- app shell or navigation
- dense index or dashboard
- detail page
- form or editor
- modal or drawer
- empty/loading/error/validation states
- one constrained or responsive layout

## What makes a `.stitch/DESIGN.md` good?

A strong file is not just colors and fonts.
It should also capture:

- layout rhythm and density
- geometry and corner language
- elevation/shadow style
- app-shell behavior
- component patterns
- states and feedback
- responsive behavior
- motion restraint
- content tone
- must-preserve / may-flex / explicit-no-go rules

## How it works with official Stitch skills

This custom skill is the **orchestrator** for your brownfield workflow.
It does not replace the official Stitch ecosystem.

A practical setup is:

- keep `design-system-bootstrap` as your repo-specific wrapper
- optionally also install the official `design-md` and `stitch-design` skills for raw Stitch operations
- let `frontend-direction` consume the resulting `.stitch/DESIGN.md`

## What to do next after bootstrapping

Once `.stitch/DESIGN.md` and `.stitch/bootstrap-report.md` are ready:

1. run `frontend-direction`
2. generate the packet and selected visual references
3. hand off to `gsd-frontend-design` for implementation

That keeps design-system capture, packet creation, and implementation as three separate but connected steps.
