# Mobile Dense-Table Adaptations

## Goal

Preserve operational utility on narrow screens without pretending desktop tables can simply shrink forever.

## Preferred variants

### Variant A — Row card
Use when each row needs a clearer status and action hierarchy.

Structure:
- primary row identity
- visible key status
- 1–2 primary actions visible
- secondary details below
- overflow actions behind disclosure only if safe

### Variant B — Compressed row with progressive disclosure
Use when the list must stay scan-dense.

Structure:
- compact summary row
- critical status and one main action visible
- expandable area for lower-priority detail and secondary actions

## Preserve

- critical statuses
- assignment or operational actions
- strong row identity
- filters and summary controls

## Avoid

- horizontally scrollable pseudo-desktop tables as the main answer
- hiding every action behind a menu
- removing warning or urgency information
- compressing typography until scanability fails
