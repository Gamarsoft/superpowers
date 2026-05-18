# Material 3 Theme And Tokens

Use this when translating Pencil colors, type, spacing, radius, elevation, or component styles.

## Theme Source

Flutter Material apps should express app-wide color and text through `ThemeData` on `MaterialApp`.
Use `ColorScheme` for semantic color roles and modern Material 3 `TextTheme` names such as `displayLarge`, `headlineSmall`, `titleMedium`, `bodyMedium`, and `labelLarge`.

Use `ThemeExtension` for app-specific tokens that Material does not provide, such as brand gradients, success/warning/info roles, spacing scales, radius scales, or custom surface treatments.

## Translation Order

1. Read existing theme builders and theme extensions.
2. Map Pencil variables to existing semantic tokens.
3. Add a missing token only when the design system needs the concept.
4. Use theme/component defaults before per-widget styling.
5. Keep board-specific pixel values out of feature widgets unless the repo already has an explicit local exception pattern.

## Color Mapping

| Pencil role | Flutter target |
|---|---|
| Primary brand/action | `colorScheme.primary` / `onPrimary` |
| Secondary action/accent | `colorScheme.secondary` or named extension token |
| Background | `colorScheme.surface`, `surfaceContainer*`, or repo extension |
| Card/sheet | `colorScheme.surface`, `surfaceContainer*`, or shared surface token |
| Border/divider | `colorScheme.outline`, `outlineVariant`, or shared divider token |
| Error/destructive | `colorScheme.error` / `onError` |
| Success/warning/info | `ThemeExtension` unless already mapped by repo |

Do not hardcode `Colors.*` or `Color(0x...)` in feature widgets.

## Typography Mapping

- Use `Theme.of(context).textTheme`.
- Map hierarchy to semantic roles, not exact font sizes from Pencil.
- Keep display styles for true hero/header moments; use title/body/label roles inside compact mobile UI.
- Preserve numeric emphasis, status labels, helper text, and CTA hierarchy from `visual-truth` boards.
- Avoid disabling text scaling.

## Spacing, Radius, Elevation

- Use the repo spacing system or a theme extension.
- Prefer directional padding for localized layouts.
- Radius and elevation should come from shared component themes or tokens.
- Avoid copying Pencil offsets into arbitrary `EdgeInsets.fromLTRB` values.
- If a local exception is unavoidable, record it as a visual-truth delta and keep it scoped.

## Component Themes

Prefer theme-level configuration for repeated Material components:

- buttons
- text fields
- cards
- app bars
- navigation bars
- dialogs and sheets
- snackbars

Per-instance styling is acceptable only for a specific board-approved variant or feature-local state that the shared theme cannot express.
