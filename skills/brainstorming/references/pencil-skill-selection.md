# Pencil Skill Selection

Use this file to choose the right Pencil skills for the packet and for downstream implementation.

## Core rule

Always use `pencil-design-core` when `.pen` files, screenshots, extraction, reusable patterns, or design-to-code handoff are in scope.

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

## Packet requirements

The frontend direction packet should explicitly record:

- which Pencil skills were used during packet creation
- which Pencil skills downstream agents should load during implementation
- any skill or framework the downstream agent should **not** assume

## Brownfield default

If the product is brownfield and the UI is a dense business/operator application, default to:

- `pencil-design-core`
- `pencil-design-angular-nebular`

unless the actual production target says otherwise.

## Guardrails

- Do not load the React adapter for an Angular product “just because the prompt library online used React.”
- Do not keep the adapter implicit. Write it down in the packet and handoff.
- Do not let the adapter overrule the packet or the current product system.
