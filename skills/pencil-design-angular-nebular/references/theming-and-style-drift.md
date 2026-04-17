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

## Useful normalization questions

- should this color become a shared semantic token?
- is this spacing value already represented elsewhere?
- is this card layout already solved in a shared partial?
- is this page fixing a shell problem locally instead of centrally?
- is Nebular already exposing the needed variable through `nb-theme(...)`?
