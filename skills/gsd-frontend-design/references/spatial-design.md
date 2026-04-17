# Spatial Design

Use spacing and composition to preserve the product’s operating model.

## Brownfield defaults

- Preserve the current shell first.
- Reuse known card, table, panel, and form structures.
- Prefer extracting recurring layout patterns over inventing new ones.
- In operator screens, optimize for scanning and action throughput, not empty-space aesthetics.

## Shared structures to preserve

Look for these before creating anything new:

- title or summary row with actions on the right
- filters above data
- dense table or split-panel work area
- config card with scrolling body and fixed footer action
- grouped settings sections with essential-first ordering

## Layout discipline

When extending a page:

1. Start from the closest existing shell pattern.
2. Reuse the existing card and scroll containment strategy.
3. Keep alignment and spacing rhythms consistent with neighboring screens.
4. Avoid one-off wrappers that solve only a local visual issue.

## Density guidance

Dense screens are allowed to stay dense when the workflow demands it.

Improve them by:

- clarifying hierarchy
- grouping related actions
- reducing accidental visual noise
- making mobile disclosure more intentional

Do not improve them by removing important information just to look cleaner.

## Non-goals during implementation

- converting operational pages into airy marketing layouts
- replacing every page-local structure with a brand-new layout system mid-slice
- introducing decorative whitespace that harms scanning
