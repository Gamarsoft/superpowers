# app_ui Package Boundaries

Use this before adding or changing shared Flutter UI components.

## Boundary Rule

`app_ui` owns reusable visual language. Feature packages own feature composition and state wiring.

Do not place a reusable design-system primitive inside a feature package just because the first Pencil board shows it in one screen.
Do not place feature-specific business logic, repository calls, routing decisions, or l10n lookup inside `app_ui`.

## Put In app_ui

- reusable buttons, cards, banners, input treatments, badges, chips, dividers, list rows, skeletons, and empty/error surfaces
- app theme builders, theme extensions, spacing/radius/elevation/motion tokens
- shared icon wrappers or asset helpers
- component-level accessibility defaults
- widget tests and golden tests for shared components

## Keep In Feature Code

- feature page/view widgets
- Bloc/Cubit providers, listeners, builders, selectors
- route parameters and navigation decisions
- repository and service data mapping
- localized string lookup through `context.l10n`
- feature-specific copy and validation messages
- composition of shared primitives into a specific flow

## API Shape

Shared widgets should:

- expose named parameters with clear variants
- accept localized strings as parameters instead of reading app l10n directly
- accept callbacks as `VoidCallback`, `ValueChanged<T>`, or specific typedefs
- accept slots as `Widget?` or `List<Widget>` when composition is expected
- derive default color, text style, spacing, radius, and elevation from the theme
- avoid large "kitchen sink" constructors that mirror every Material parameter

## Promotion Criteria

Promote a feature-local widget to `app_ui` when at least one is true:

- the frontend direction packet names it as a design-system pattern
- the same visual pattern appears on multiple approved boards
- another implemented screen already has the same pattern
- accessibility or theming consistency would be risky if every feature reimplements it

Keep it local when it is truly one-off, data-heavy, or inseparable from feature behavior.

## Verification

For `app_ui` changes, add or update:

- widget tests for interaction and state behavior
- golden tests for stable visual variants when the repo supports goldens
- a catalog/gallery entry when the repo has one
- downstream feature tests that prove the component works in context
