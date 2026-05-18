# Pencil Skills Integration

## Goal

Load the right Pencil skill combination for the task instead of letting one design skill try to do everything.

Do not use this file when the frontend packet selects `chatgpt-image-2` as the implementation visual-truth source. In that mode, approved generated image files are the binding visual references and Pencil is intentionally omitted.

## Default composition

### If Pencil is selected and `.pen` files are in scope
Load:

- `pencil-design-core`

For GSD workflows, use Pencil CLI interactive mode only.

### If the implementation target is Angular + Nebular or a similar brownfield operator UI
Also load:

- `pencil-design-angular-nebular`

### If the implementation target is explicitly React / Next / Tailwind / shadcn
Also load:

- `pencil-design-react-tailwind`

### If the implementation target is Flutter / Material 3 / app_ui
Also load:

- `pencil-design-flutter-material`

### If the implementation target is native mobile or mobile-first
Load the smallest relevant mobile design skill set:

- `mobile-product-direction` when screen/flow direction is unresolved
- `mobile-interaction-and-usability` when navigation, gestures, forms, permissions, state behavior, text scaling, semantics, or tap targets matter
- `mobile-visual-design` when hierarchy, native polish, visual quality, state visuals, or mobile aesthetic direction matter
- `mobile-design-review` after a concrete artifact exists and review is needed

## Task-to-skill mapping

### Extract current UI into Pencil
- `pencil-design-core`

### Build shared foundations / shell / patterns in Pencil
- `pencil-design-core`
- `pencil-design-angular-nebular` if the target system is Angular + Nebular
- `pencil-design-flutter-material` if the target system is Flutter / Material 3 / app_ui

### Plan a slice from a packet and `.pen` files
- `gsd-frontend-design`
- `pencil-design-core`

### Plan or implement from approved ChatGPT Images 2 visual truth
- `gsd-frontend-design`
- no Pencil skills or adapters for visual consumption

### Translate approved design into Angular + Nebular implementation
- `gsd-frontend-design`
- `pencil-design-core`
- `pencil-design-angular-nebular`

### Translate approved design into React / Tailwind implementation
- `gsd-frontend-design`
- `pencil-design-core`
- `pencil-design-react-tailwind`

### Translate approved design into Flutter / Material 3 implementation
- `gsd-frontend-design`
- `pencil-design-core`
- `pencil-design-flutter-material`
- mobile skills only when the packet or task leaves mobile product direction, interaction/usability, visual quality, or review work in scope

## Guardrails

- never load the React/Tailwind adapter for an Angular/Nebular repo just because the online Pencil skill was React-first
- never load the React/Tailwind adapter for a Flutter repo just because the online Pencil skill was React-first
- never load Angular/Nebular or React/Tailwind adapters when the target is native Flutter / Material 3
- never let the core skill invent a stack-specific output format
- never let the adapter overrule the approved packet or current product system
- never use Pencil MCP in GSD workflows
- never load Pencil skills just because `.pen` files exist elsewhere when the packet explicitly omits Pencil for the current scope
- never load all mobile skills reflexively for trivial UI edits
