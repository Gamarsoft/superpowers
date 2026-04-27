# Theming and Style Drift

## Goal

Translate approved visual changes without increasing local drift.

## Default approach

1. identify the existing shared token or semantic style
2. use it where possible
3. if the current repo is inconsistent, normalize toward the shared target
4. only add a new semantic token when the system truly needs it

## Nebular theme-system rule

Nebular’s theme system is map-driven.
Use Nebular theme variables and helpers before inventing page-local color or spacing literals.

Prefer:

- existing generic theme variables that already drive multiple components
- component variables such as card, button, header, or form-control theme tokens
- `nb-theme(...)` to read values inside component SCSS
- `nb-install-component()` when the component styles must participate in runtime theme switching

Use the local Nebular docs entrypoint before making component-theme decisions:

- `/Volumes/Workspace/Development/Librairies/nebular/docs/AGENTS.md`
- `docs/articles/concept-theme-system.md`
- `docs/articles/component-theme-variables.md`
- relevant component `_*.theme.scss` under `src/framework/theme/components/`

Source code is the ground truth for selectors, inputs, outputs, module wiring, and which variables drive the rendered CSS.

## Approved delta versus drift

Do not confuse these:

- **Approved visual delta:** the packet or a `visual-truth` Pencil board intentionally changes a local surface, control treatment, spacing rhythm, or action hierarchy.
- **Unapproved drift:** the implementation invents styling that is not in the packet, current product system, or a shared token path.

Approved visual deltas must be implemented when the packet or board intent makes them binding. They are not blocked by brownfield preservation.

Use only approved board intent:

- `visual-truth`: visual deltas are binding.
- `semantic-guidance`: behavior, content priority, states, and workflow are binding; visual treatment adapts to the product system.
- `reference-only`: no implementation obligation unless promoted by the packet or human.

If intent is missing or pending, ask for confirmation before visual changes. Do not infer visual truth from a Pencil board during implementation.

For example, if a `visual-truth` board shows a white framed results pane, neutral compact filters, and only one primary booking action, do not leave a flush pane or primary-blue `nb-select` controls just because Nebular defaults render that way. If that same board is `semantic-guidance`, preserve the results flow, filter priority, and booking action hierarchy without mechanically copying every surface.

## Override order

Use this order when Nebular defaults conflict with a `visual-truth` board:

1. existing shared wrapper or app-specific semantic class
2. existing Nebular component or generic theme variable
3. component-specific Nebular theme variable
4. scoped component SCSS using `nb-theme(...)`
5. narrow selector override only when source inspection proves no cleaner hook exists

Use page-local SCSS only for a bounded page-level delta. If the treatment is repeated across product areas, record it as a candidate shared primitive or theme-token follow-up.

## Prefer

- shared theme variables
- semantic SCSS variables
- shared card/layout partials
- shared status treatments
- shared spacing and surface rules
- Nebular component theme variables when a Nebular primitive already owns the surface

## Avoid

- raw hex values in page-local SCSS
- more `rgba(...)` drift
- repeated local borders, shadows, or radii
- extra `::ng-deep` usage to chase small visual mismatches
- bypassing Nebular theme helpers for a component that already has theme tokens
- preserving a default primary/status treatment when a `visual-truth` board requires a neutral control
- forcing a visual restyle from a `semantic-guidance` board that only demonstrates behavior

## Useful normalization questions

- should this color become a shared semantic token?
- is this spacing value already represented elsewhere?
- is this card layout already solved in a shared partial?
- is this page fixing a shell problem locally instead of centrally?
- is Nebular already exposing the needed variable through `nb-theme(...)`?
- does the current Nebular default match the `visual-truth` board's visual priority, or must it be neutralized?
- is this board `semantic-guidance`, where product-system adaptation is expected?
