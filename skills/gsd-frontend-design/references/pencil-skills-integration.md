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

## Task-to-skill mapping

### Extract current UI into Pencil
- `pencil-design-core`

### Build shared foundations / shell / patterns in Pencil
- `pencil-design-core`
- `pencil-design-angular-nebular` if the target system is Angular + Nebular

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

## Guardrails

- never load the React/Tailwind adapter for an Angular/Nebular repo just because the online Pencil skill was React-first
- never let the core skill invent a stack-specific output format
- never let the adapter overrule the approved packet or current product system
- never use Pencil MCP in GSD workflows
- never load Pencil skills just because `.pen` files exist elsewhere when the packet explicitly omits Pencil for the current scope
