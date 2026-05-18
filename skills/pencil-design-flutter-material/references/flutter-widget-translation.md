# Flutter Widget Translation

Use this when converting Pencil evidence into Flutter widget structure.

## Mapping Principles

- Translate visual intent, not Pencil node mechanics.
- Prefer existing app widgets, then Material widgets, then new shared widgets.
- Keep screens declarative and composed from small widgets.
- Avoid direct one-to-one frame-to-widget translation when a Flutter primitive expresses the behavior better.
- Use `const` constructors where possible.

## Common Mappings

| Pencil intent | Flutter direction |
|---|---|
| Screen shell | Existing app shell, `Scaffold`, nested shell route, or feature page pattern |
| Mobile top bar | Existing header component or `AppBar` variant |
| Bottom navigation | Existing shell nav or Material `NavigationBar` |
| Primary action | Shared app button or Material `FilledButton` styled by theme |
| Secondary action | Shared app button variant, `OutlinedButton`, or `TextButton` |
| Form field | Shared field or Material `TextField` / `TextFormField` with theme-driven decoration |
| Card/surface | Shared card/surface component or Material `Card`/`Material` with theme roles |
| Lists | `ListView.builder`, slivers, or existing list components |
| Long screen | `CustomScrollView` or `ListView`, not a fixed-height `Column` |
| Overlay | Dialog, bottom sheet, menu, snackbar, or repo-approved overlay pattern |

## Layout Rules

- Use `SafeArea` or repo shell insets for notches, status bars, and bottom gestures.
- Use `Expanded`, `Flexible`, `Wrap`, and constraints instead of fixed board dimensions.
- Use `SingleChildScrollView` only for finite static content; use lazy lists for repeated data.
- Use `Sliver` structure for long, mixed-content mobile screens when the repo already does.
- Avoid `IntrinsicHeight` and `IntrinsicWidth` unless the existing codebase uses them deliberately for small, bounded cases.
- Use `Positioned` only for true overlays, badges, maps, and art-directed layers that cannot be expressed by normal layout.

## Component Boundary

Feature widgets may own:

- state-specific composition
- route-specific layout
- localized copy selection
- feature data mapping

Shared UI widgets should own:

- reusable cards, buttons, input treatments, chips, banners, and empty/error surfaces
- visual variants used by multiple features
- tokenized spacing, radius, elevation, and motion choices
- accessibility defaults that every instance needs

## Acceptance Check

Before coding, write the target widget tree in words:

- page/shell
- scroll container
- main sections
- repeated items
- actions
- overlays
- state-specific branches

If the description reads like a Pencil layer tree instead of a Flutter screen, simplify it.
