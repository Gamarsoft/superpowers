# Typography

Use typography to preserve product hierarchy, not to invent a new brand.

## Brownfield defaults

- Keep the existing font family unless the packet explicitly changes it.
- Extend the current type scale conservatively.
- Reuse existing semantic roles before adding new ones.
- In dense operator UI, prefer clarity and scanability over display styling.

## What to preserve

Preserve when present:

- headline levels already used by the shell and feature pages
- body and metadata sizes used in tables, forms, and cards
- numeric treatment used in stats or dense lists
- uppercase or emphasis patterns that already have product meaning

## How to extend safely

When a new text role is needed:

1. Find the closest existing role first.
2. Reuse its size, weight, and spacing if possible.
3. If a new role is necessary, keep it adjacent to the current scale rather than creating a new mini-scale.
4. Use semantic naming, not arbitrary values.

## Dense product guidance

For data-heavy UI:

- use tabular numbers for aligned statistics and tables
- avoid long line lengths inside cards or dense settings pages
- keep headings short and scannable
- do not use display typography where operational scanning matters more than flair

## Accessibility

- preserve readable sizes for body text
- ensure labels remain visible on meaningful fields
- avoid relying on placeholder-only forms
- preserve enough line height for readability, especially in stacked mobile views

## Non-goals during implementation

- swapping font families for taste
- introducing editorial display styles to a utilitarian screen
- compressing type hierarchy until everything looks the same
