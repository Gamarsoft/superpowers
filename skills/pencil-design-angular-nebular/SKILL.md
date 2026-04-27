---
name: pencil-design-angular-nebular
description: Detailed adapter for translating Pencil work into Angular + Nebular brownfield implementation while preserving shell, shared primitives, theme anchors, operator density, and mobile adaptation rules.
---

# Pencil Design for Angular + Nebular

Use this skill with `pencil-design-core` when the target is an Angular + Nebular product.

This adapter restores the missing practical detail:
**how to map Pencil structures into Angular templates, Nebular primitives, shared SCSS, and browser verification rules without smuggling in React/Tailwind assumptions.**

For GSD-facing workflows, use Pencil CLI interactive mode to inspect the approved `.pen` evidence.
Do not use Pencil MCP in this workflow.

For DashPark, the verified stack is Angular `7.2.12` and Nebular `3.5.0`.
Assume Angular 7-era module and forms constraints unless the target repo proves otherwise.

## Use this skill when

- translating approved Pencil work into Angular + Nebular implementation guidance
- refining Pencil boards so they fit an existing Angular + Nebular shell
- adapting dense operator screens or settings screens in a brownfield repo
- deciding what belongs in shared modules, wrappers, theme files, and page-local SCSS

## Core rules

### Rule 1 — Preserve shell and routing scaffolding first
Do not redesign the shell, top header, side navigation, or page framing unless the packet explicitly authorizes it.

### Rule 2 — Prefer existing Angular/Nebular primitives
Before creating new template structures, map the Pencil pattern to the closest existing real primitive:
- existing shared wrapper
- Nebular component
- shared module component
- existing shell pattern
- existing page archetype

Nebular primitives are implementation primitives, not visual authority. If a `visual-truth` board uses a Nebular component in a calmer or more neutral role than the default theme renders, translate the component through theme variables, semantic wrappers, or scoped SCSS instead of accepting the default visual priority.

Not every Pencil board is visual truth. Before restyling Nebular defaults, confirm the board has approved intent as `visual-truth`, `semantic-guidance`, or `reference-only`. If intent is missing or pending, ask for confirmation before visual changes. For `semantic-guidance`, preserve the demonstrated behavior, content priority, and states while adapting the visual treatment to the existing product system.

### Rule 3 — Normalize drift toward shared theme anchors
When a page is inconsistent, pull it toward shared tokens, wrappers, and patterns.
Do not add more page-local drift to imitate the Pencil image mechanically.

This does not block approved visual deltas. A scoped page-level style is acceptable when:
- the packet or a `visual-truth` board explicitly changes a local surface, control treatment, or action hierarchy
- no existing shared primitive expresses that treatment
- the style uses Nebular theme helpers or existing semantic tokens where possible
- the deviation from shared primitives is recorded as local and bounded

### Rule 4 — Respect operational density
Dense screens can remain dense.
Preserve statuses, counts, warnings, filters, action availability, and state visibility.

### Rule 5 — Adapt mobile structure instead of compressing desktop tables forever
For narrow screens, restructure table-heavy flows when necessary.
Do not just shrink everything until it becomes unreadable.

### Rule 6 — Keep implementation idiomatic to Angular + Nebular
Do not emit React, Tailwind, shadcn, CSS-in-JS, or generic dashboard markup.

### Rule 7 — Keep templates idiomatic to Angular 7
Prefer Angular binding and structural-template patterns over imperative DOM work:
- property binding `[]`
- event binding `()`
- two-way binding `[()]` only when the chosen form style actually uses it
- `*ngIf`, `*ngFor`, `ng-container`, and `ng-template` instead of pointless wrapper markup

Template expressions should stay simple and side-effect free.
Do not move presentation logic into template hacks when the component class or a shared helper should own it.

### Rule 8 — Be explicit about module and forms boundaries
Before translating a screen, identify:
- whether the code lives in a root module, feature module, or lazy module
- which module already owns the shared primitives involved
- whether the screen should use reactive forms or template-driven forms

For this stack, reactive forms are the default for dense settings and operator flows.
Do not mix `[(ngModel)]` with `formControlName` on the same control.

## Required docs preflight

Before translating Pencil into Angular/Nebular guidance:

1. confirm the Angular and Nebular versions from the target repo when possible
2. use `superpowers:context7-research` for Angular guidance before relying on memory
3. for Nebular docs, use the local Nebular checkout in this order:
   - `/Volumes/Workspace/Development/Librairies/nebular/docs/AGENTS.md`
   - relevant article under `docs/articles/`
   - matching component source under `src/framework/theme/components/`
4. treat Nebular component source as ground truth for inputs, outputs, selectors, and module wiring
5. treat DashPark product language as authoritative over Nebular defaults

## Required workflow

1. load `pencil-design-core`
2. run the required docs preflight for Angular and Nebular
3. read the relevant packet, `.pen` files, and screenshots
4. inspect the current Angular/Nebular primitives, module ownership, and theme anchors
5. use Pencil CLI interactive mode for deterministic reads, screenshots, exports, and bounded edits
6. read approved board intent:
   - `visual-truth`
   - `semantic-guidance`
   - `reference-only`
   - ask for confirmation if intent is missing or pending
7. choose the implementation mode:
   - preserve and codify
   - implement approved change
   - normalize and harden
   - mobile dense-data adaptation
8. translate the design into:
   - component choice
   - template structure
   - Angular binding and structural-directive shape
   - module/import implications
   - theme/token usage
   - shared-vs-local responsibility
   - visual-truth deltas that must override Nebular defaults
   - semantic-guidance behavior that should not force visual redesign
   - browser verification points
9. verify the result still reads like the current product family

## Translation checklist

Before proposing implementation:

- [ ] what existing shell or wrapper already solves this?
- [ ] what real Nebular primitive is the closest fit?
- [ ] what module already owns this pattern?
- [ ] should this be reactive forms instead of template-driven forms?
- [ ] what should be shared versus page-local?
- [ ] what token or semantic style should be reused?
- [ ] which board-level surfaces, controls, or action priorities intentionally differ from the current page?
- [ ] which boards are visual truth versus semantic guidance?
- [ ] are those board intent modes approved, or do you need confirmation before visual changes?
- [ ] which Nebular defaults must be neutralized or restyled to match `visual-truth` boards?
- [ ] which semantic-guidance boards should preserve behavior without forcing a redesign?
- [ ] are runtime states and action priorities preserved?
- [ ] does mobile behavior still support the operator workflow?

## Common mistakes to avoid

| Mistake | Better approach |
|---|---|
| rebuilding a shared card or page shell from scratch | map to existing wrapper and Nebular structure |
| copying a Pencil screenshot literally into page-local SCSS | translate to existing shared primitives and token usage |
| preserving a Nebular default that contradicts a `visual-truth` board | restyle through theme variables, semantic wrappers, or scoped SCSS and record the local delta |
| restyling Nebular globally to match a board that was only semantic guidance | keep the existing product visual system and implement the demonstrated behavior/state/content priority |
| treating "brownfield preservation" as "keep the flawed current page styling" | preserve shell and behavior, then implement the approved local visual correction |
| replacing a dense operator screen with a “cleaner” consumer layout | preserve operational density and information priority |
| solving every pixel mismatch with `::ng-deep` | fix shared primitives, wrapper classes, or theme tokens where possible |
| emitting Tailwind utilities in an Angular/Nebular repo | use Angular templates, Nebular APIs, and SCSS tied to the repo’s theme strategy |
| mixing `[(ngModel)]` and `formControlName` on one control | pick one form style per control; prefer reactive forms for dense admin/settings screens |
| guessing Nebular inputs or module wiring from memory | read the local Nebular component source first |

## Read order

1. `references/angular-nebular-translation.md`
2. `references/shell-preservation.md`
3. `references/theming-and-style-drift.md`
4. `references/operator-density.md`
5. `references/settings-and-forms.md`
6. `references/mobile-dense-table-adaptations.md`
7. `references/verification-in-browser.md`
