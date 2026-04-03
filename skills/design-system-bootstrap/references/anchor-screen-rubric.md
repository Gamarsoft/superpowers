# Anchor screen rubric

## Purpose

Choose a small set of screens that actually define the current design language.

For a large brownfield surface, target **8–12 anchor screens**. Minimum acceptable starting point is **5**.

## Coverage categories

Select anchors that cover as many of these categories as possible:

1. **App shell / navigation**
   - top nav, side nav, breadcrumbs, page header, global actions
2. **Dense index or dashboard**
   - tables, cards, metrics, filters, search, sorting, pagination
3. **Detail page**
   - read-heavy page, summary panel, metadata blocks, key actions
4. **Form or editor**
   - create/edit flows, field spacing, labels, validation, submit patterns
5. **Overlay pattern**
   - modal, drawer, popover, command palette, flyout
6. **State coverage**
   - empty, loading, error, validation, permission, success feedback
7. **Responsive or constrained layout**
   - narrow viewport, tablet, mobile, or dense side-panel layout
8. **Critical workflow screen**
   - screen used frequently enough to reveal the real design system under load

## What to prefer

Prefer screens that are:

- stable, not experimental
- frequently used
- current, not legacy
- representative of the main product surface
- visually dense enough to reveal spacing, hierarchy, and component rules

## What to avoid

Avoid selecting anchors that are:

- marketing one-offs when bootstrapping a product UI
- legacy pages scheduled for replacement
- highly branded campaign pages that distort the product baseline
- duplicate screens that add no new pattern information
- a hero-only page with no evidence of form, state, or dense data patterns

## Selection method

For each candidate screen, note:

- why it is representative
- which coverage categories it satisfies
- whether it is stable or likely to drift soon
- whether it belongs to the chosen surface boundary

A good final set usually includes:

- 1 shell/navigation anchor
- 1 dense data anchor
- 1 detail anchor
- 1 form/edit anchor
- 1 overlay anchor
- 2–4 state or responsive anchors
- 1 extra screen for the most important workflow

## Confidence scoring

Rate the chosen anchor set:

- **High confidence** — covers shell, dense content, forms, overlays, states, and at least one constrained layout
- **Medium confidence** — covers the main UI grammar but misses one meaningful category
- **Low confidence** — mostly vanity or duplicate screens, missing forms/states/dense content

Do not call the bootstrap complete at low confidence.
