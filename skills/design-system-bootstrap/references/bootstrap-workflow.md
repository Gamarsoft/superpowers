# Bootstrap workflow

## Goal

Create a reusable `.stitch/DESIGN.md` that reflects a real brownfield product surface closely enough that later Stitch generation and implementation work stay on-system.

## Modes

### Mode A — Reuse an existing Stitch project

Use this when the same product surface already has a Stitch project with representative screens.

Default path:

1. Identify the surface boundary.
2. Reuse the matching Stitch project.
3. List screens.
4. Select representative anchor screens.
5. Fetch HTML and screenshots for those screens.
6. Synthesize or refresh `.stitch/DESIGN.md`.
7. Harden with repo-native facts.
8. Write `.stitch/bootstrap-report.md`.

### Mode B — Create a new Stitch project for an existing surface

Use this when the surface is real and stable, but no suitable Stitch project exists yet.

Default path:

1. Create a Stitch project named after the surface, not the whole repo.
2. Seed the project with representative existing screens.
3. Select anchors only after the seeded set is representative.
4. Synthesize `.stitch/DESIGN.md`.
5. Harden with repo-native facts.
6. Record the project ID and refresh date in `.stitch/bootstrap-report.md`.

### Mode C — Refresh a stale bootstrap

Use this when `.stitch/DESIGN.md` exists but the product has drifted.

Refresh triggers:

- visible redesign of navigation, app shell, or main content density
- token changes or theme overhaul in the repo
- new screen family that exposes missing rules
- `frontend-direction` repeatedly overrides or ignores the file because it lacks needed detail

Default path:

1. Reuse the same Stitch project when the visual system is still the same.
2. Replace outdated anchors with current representative screens.
3. Update `.stitch/DESIGN.md` conservatively.
4. Record what changed in `.stitch/bootstrap-report.md`.

## Project continuity rules

- Reuse the same Stitch project for the same product surface.
- Use a separate Stitch project for a distinct visual system such as a marketing site, admin console, or radical redesign branch.
- Do not mix two intentionally different UI grammars into one `.stitch/DESIGN.md`.

## Retrieval pattern

Use Stitch MCP in this order when available:

1. `list_projects`
2. `create_project` only when no matching project exists
3. `list_screens`
4. `get_screen`
5. optional asset download of `htmlCode.downloadUrl` and `screenshot.downloadUrl`

When the project already exists, prefer **reuse + refresh** over creating a new project.

## Repo-native truth pass

After the first design-system draft, search the repo for the real implementation rules.

Useful search targets:

- `tailwind.config`
- `theme`
- `tokens`
- `variables.css`
- `css variables`
- `ThemeProvider`
- `palette`
- `spacing`
- `radius`
- `elevation`
- `storybook`
- `design system`
- shared button, input, modal, table, card, badge, nav, layout primitives

Use these repo facts to harden the file instead of trusting a purely visual read.

## Degraded mode

If Stitch is not available or the project is missing representative screens:

1. still create `.stitch/DESIGN.md`
2. label it as degraded in the header or source map
3. record exactly which screens or sources are missing
4. keep the file useful for later refresh instead of waiting for perfect conditions
