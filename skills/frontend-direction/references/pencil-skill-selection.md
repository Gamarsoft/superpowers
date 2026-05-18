# Pencil Skill Selection

Use this file to choose the right Pencil skills for the packet and for downstream implementation when Pencil remains possible or selected.

## Core rule

Use `pencil-design-core` when Pencil is selected and `.pen` files, screenshots, extraction, reusable patterns, or design-to-code handoff are in scope.

If the packet selects approved ChatGPT Images 2 references as implementation visual truth, omit Pencil skills and adapters for that scope.

Then choose **one** adapter for the target stack.

## Adapter choices

### `pencil-design-angular-nebular`
Use this when the target is:

- Angular + Nebular
- an older Angular brownfield product
- a dense operator / admin / B2B workflow UI
- a product where preserving the shell and shared patterns matters more than visual reinvention

This adapter emphasizes:
- shell preservation
- shared primitive reuse
- theme drift normalization
- operator density
- mobile adaptation for dense tables
- avoiding React / Tailwind leakage

### `pencil-design-react-tailwind`
Use this only when the target is genuinely:

- React / Next.js
- Tailwind
- shadcn/ui or similar component patterns

This adapter emphasizes:
- Tailwind / token discipline
- design-to-code mapping for React
- responsive mapping
- component API thinking for that stack

### `pencil-design-flutter-material`
Use this when the target is:

- Flutter mobile app
- Material 3 / custom Material theme
- shared Flutter UI package such as `packages/app_ui`
- Very Good CLI / Melos / package-based Flutter architecture
- mobile-first flows where native feel, accessibility, and responsive constraints matter

This adapter emphasizes:
- mapping Pencil components to reusable Flutter widgets
- using `ThemeData`, `ColorScheme`, `TextTheme`, and `ThemeExtension`
- avoiding raw `Color`, `TextStyle`, spacing, radius, and shadow values outside the UI package
- translating boards into idiomatic Flutter layouts, not absolute-positioned mockups
- checking text scaling, semantics, tap targets, and golden/screenshot parity
- keeping implementation inside the correct package boundary

## Packet requirements

The frontend direction packet should explicitly record:

- which Pencil skills were used during packet creation
- which Pencil skills downstream agents should load during implementation
- whether Pencil is omitted because approved ChatGPT Images 2 references are the visual truth
- any skill or framework the downstream agent should **not** assume

## Brownfield default

If Pencil is selected and the product is brownfield and the UI is a dense business/operator application, default to:

- `pencil-design-core`
- `pencil-design-angular-nebular`

unless the actual production target says otherwise.

## Greenfield Flutter mobile default

If Pencil is selected and the target is a Flutter mobile app, default to:

- `pencil-design-core`
- `pencil-design-flutter-material`

Do not use the React/Tailwind adapter just because Pencil examples online are web-first.
Treat this as greenfield mobile UI with brownfield brand/reference inputs when the repo is a new mobile app guided by existing product or brand evidence.

## Guardrails

- Do not load the React adapter for an Angular product “just because the prompt library online used React.”
- Do not load the React adapter for a Flutter product “just because the prompt library online used React.”
- Do not keep the adapter or Pencil omission implicit. Write it down in the packet and handoff.
- Do not let the adapter overrule the packet or the current product system.
