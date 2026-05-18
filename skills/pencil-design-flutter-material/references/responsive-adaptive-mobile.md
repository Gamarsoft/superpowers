# Responsive And Adaptive Mobile

Use this when Pencil boards must become mobile layouts across device families.

## Device Families

The frontend direction packet should name the required families. If it does not, use these defaults for mobile work:

- compact iPhone
- compact Android
- large phone
- tablet or landscape only when the feature scope requires it

Do not treat a single Pencil phone frame as the only valid size.

## Mobile Layout Rules

- Respect safe areas, system gestures, keyboard insets, and platform chrome.
- Keep primary actions reachable and stable across compact devices.
- Let content scroll instead of shrinking text or clipping containers.
- Use responsive constraints, not viewport-scaled fonts.
- Use `LayoutBuilder`, `MediaQuery`, `OrientationBuilder`, and existing breakpoint helpers only where they simplify real adaptation.
- Preserve content priority from the board when reflowing.

## Common Adaptations

| Board pattern | Mobile adaptation |
|---|---|
| Fixed card grid | single column, horizontal carousel only when swipe browsing is intended |
| Dense table | row cards, grouped details, filters, or progressive disclosure |
| Wide form | vertical sections with sticky or repeated primary action when needed |
| Sidebar navigation | bottom navigation, tabs, drawer, or shell route pattern from repo |
| Large hero/header | compress to native header scale unless the packet requires a true hero |
| Multi-pane comparison | stacked sections, tabs, segmented controls, or drill-in flow |

## Text Scaling

- Test at larger text scale before completion.
- Avoid fixed-height text containers.
- Let labels wrap where possible.
- Use ellipsis only for low-risk secondary metadata, not critical actions or errors.
- Confirm buttons and chips keep readable labels at compact widths.

## Keyboard And Form Insets

- Verify fields remain visible when the keyboard opens.
- Avoid primary actions hidden behind system navigation.
- Use scrollable form bodies and safe footer actions when necessary.
- Preserve validation text and helper text at large text scale.

## Tablet And Landscape

Only add tablet/landscape structure when required by packet or product.
When required, adapt by adding useful space, not by stretching phone UI:

- two-pane layouts for list/detail flows
- wider max-width content columns
- persistent filters or summaries
- larger touch targets and comfortable spacing, not desktop density by default
