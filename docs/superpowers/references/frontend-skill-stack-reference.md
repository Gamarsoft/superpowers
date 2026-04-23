# Frontend Skill Stack Reference

This note captures how these Superpowers skills work on their own and as a coordinated workflow:

- `superpowers:brainstorming`
- `superpowers:frontend-direction`
- `superpowers:gsd-frontend-design`
- `superpowers:pencil-design-core`
- `superpowers:pencil-design-angular-nebular`
- `superpowers:pencil-design-react-tailwind`

## Core Understanding

These skills form a pipeline, not a flat list of interchangeable tools.

`brainstorming` decides what is being built, how uncertain it still is, and whether a visual-direction phase is required.

`frontend-direction` creates the explicit visual contract once product direction is stable enough to anchor screens and states.

`pencil-design-core` governs how durable design evidence is created and maintained in `.pen` files. It is the operating discipline for Pencil work, not a stack-specific implementation guide.

`pencil-design-angular-nebular` and `pencil-design-react-tailwind` are mutually exclusive adapters. They translate Pencil evidence into stack-native guidance for the real frontend target.

`gsd-frontend-design` is the implementation skill. It consumes the approved packet, `.pen` workset, screenshots, and current product system, then changes application code without silently redesigning the product.

The intended flow is:

1. `brainstorming`
2. `frontend-direction` when UI materially shapes implementation
3. `pencil-design-core` plus exactly one adapter while creating or refining durable design evidence
4. `gsd-frontend-design` plus `pencil-design-core` plus the same adapter during implementation

## Shared Principles

These skills repeat the same control rules in different phases:

- Brownfield product truth outranks generated novelty.
- Approved specs and packets outrank casual interpretation.
- `.pen` files and retained screenshots are durable evidence.
- Adapters interpret design for a stack; they do not outrank the packet or the product system.
- HTML companion artifacts are temporary comparison surfaces, not durable truth.
- In brownfield work, preservation is the default unless change is explicitly approved.

## Independent Roles

### `superpowers:brainstorming`

Purpose:
Turn a request into approved implementation inputs before code is written.

What it produces:
- design spec
- GSD handoff
- frontend direction packet and supporting artifacts when UI direction is implementation-shaping

What it controls:
- track selection
- discovery style
- scope framing
- option shaping
- review loop
- decision on whether the frontend-direction phase is required

What it should not do:
- write production code
- skip discovery and jump straight to implementation
- invent visual direction before current truth and boundaries are understood

### `superpowers:frontend-direction`

Purpose:
Make visual intent explicit before frontend implementation starts.

What it produces:
- `--frontend-direction.md`
- `screen-index.md`
- `brownfield-ui-extraction.md`
- `pencil-workset.md`
- screenshots
- repo-local Pencil workset files

What it controls:
- source of design truth
- brownfield extraction
- screen inventory
- bounded variant exploration
- implementation contract such as must-preserve vs may-adapt

What it should not do:
- act as a coding skill
- let temporary HTML comps become the durable source of truth
- drift into redesign when the real need is continuity

### `superpowers:pencil-design-core`

Purpose:
Provide framework-agnostic discipline for `.pen` work.

What it controls:
- reusable component reuse
- variable and token use
- overflow and layout correctness
- screenshot-based verification
- asset reuse
- brownfield-first extraction
- transport choice between Pencil MCP and Pencil CLI

What it should not do:
- decide framework-specific code structure
- replace the need for a stack adapter during implementation translation

### `superpowers:pencil-design-angular-nebular`

Purpose:
Translate approved Pencil evidence into Angular + Nebular implementation guidance.

What it emphasizes:
- shell preservation
- reuse of existing Nebular or shared primitives
- Angular 7-era idioms where relevant
- module and forms discipline
- operator density
- conservative mobile adaptation for dense workflows

What it should not do:
- import React or Tailwind assumptions into an Angular brownfield repo
- simplify dense operational interfaces into consumer-style layouts

### `superpowers:pencil-design-react-tailwind`

Purpose:
Translate approved Pencil evidence into React + semantic-token Tailwind guidance.

What it emphasizes:
- reusable React component mapping
- token-aware Tailwind class usage
- mobile-first layout structure
- semantic utilities instead of arbitrary values

What it should not do:
- get used in Angular/Nebular products
- treat raw utility literals as acceptable when the repo already has semantic tokens

### `superpowers:gsd-frontend-design`

Purpose:
Implement UI from the strongest approved design truth.

What it consumes:
- approved spec and handoff
- approved frontend direction packet
- `screen-index.md`
- `brownfield-ui-extraction.md`
- `pencil-workset.md`
- relevant `.pen` files
- retained screenshots
- existing UI system and component library

What it controls:
- source-of-truth precedence during implementation
- extraction of `Must preserve`, `May adapt`, and `Explicit no-gos`
- implementation mode selection
- conservative gap filling when artifacts are incomplete

What it should not do:
- reopen product or design discovery without cause
- let reference heuristics overrule the packet or current product system
- redesign unrelated surfaces while implementing an approved slice

## Composition Model

### Phase 1: Shape the work

Use `brainstorming` to determine:
- what problem is actually being solved
- which track applies
- what the first delivery boundary is
- whether the UI is important enough to justify a frontend-direction phase

This is the product-shaping and artifact-authoring phase.

### Phase 2: Lock visual intent

If UI materially affects implementation, use `frontend-direction`.

This phase:
- chooses the design-truth source
- extracts existing UI reality first in brownfield work
- creates the screen inventory
- creates or refreshes the Pencil workset
- records what downstream implementation must preserve, may adapt, and must avoid

This is the visual-contract phase.

### Phase 3: Build durable design evidence

Use `pencil-design-core` whenever `.pen` files are involved.

Then choose one adapter:
- `pencil-design-angular-nebular` for Angular + Nebular or similar dense brownfield operator UIs
- `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets

This is the design-evidence and translation-preparation phase.

### Phase 4: Implement from approved evidence

Use `gsd-frontend-design` with:
- `pencil-design-core`
- the same stack adapter used to shape or consume the workset

This phase reads the approved evidence in precedence order and changes real frontend code conservatively.

This is the implementation phase.

## Skill Matrix

| Skill | Primary purpose | Typical inputs | Typical outputs | Must pair with | Must not be mistaken for |
| --- | --- | --- | --- | --- | --- |
| `brainstorming` | Shape the problem and produce approved written artifacts | user request, repo context, discovery answers, current product truth | spec, handoff, optional frontend packet request path | `frontend-direction` when UI matters | a coding or direct implementation skill |
| `frontend-direction` | Create explicit visual direction | approved or near-approved spec, screenshots, current UI patterns, wireframes | frontend packet, screen index, extraction doc, workset plan, screenshots, `.pen` files | `pencil-design-core` plus one adapter when Pencil work is real | a frontend coding skill |
| `pencil-design-core` | Enforce durable `.pen` discipline | packet, screenshots, current UI, existing `.pen` files, design tokens | stable `.pen` artifacts and verified design evidence | exactly one stack adapter when code translation matters | a framework-specific translation skill |
| `pencil-design-angular-nebular` | Translate Pencil evidence for Angular + Nebular | approved `.pen` evidence, packet, current Angular/Nebular patterns | Angular/Nebular-oriented implementation guidance | `pencil-design-core` | a generic frontend adapter |
| `pencil-design-react-tailwind` | Translate Pencil evidence for React + Tailwind | approved `.pen` evidence, packet, token system, component conventions | React/Tailwind-oriented implementation guidance | `pencil-design-core` | a universal design-to-code adapter |
| `gsd-frontend-design` | Implement frontend code from approved design truth | spec, handoff, packet, support docs, `.pen` files, screenshots, existing code patterns | implemented UI changes aligned to approved evidence | `pencil-design-core` and the correct adapter when Pencil sources exist | a discovery or redesign skill |

## Trigger Matrix

| Situation | Correct skill choice |
| --- | --- |
| The request is still ambiguous and needs scope/options/spec work | `brainstorming` |
| The product direction is mostly stable but implementation would still be guessing visually | `frontend-direction` |
| A `.pen` workset must be created, updated, verified, or consumed | `pencil-design-core` |
| The target repo is Angular + Nebular, especially dense brownfield/admin UI | `pencil-design-angular-nebular` with `pencil-design-core` |
| The target repo is React / Next / Tailwind / shadcn | `pencil-design-react-tailwind` with `pencil-design-core` |
| Approved artifacts exist and the task is now to implement frontend code | `gsd-frontend-design` plus Pencil skills if `.pen` files are in scope |

## Source-of-Truth Ladder

When these skills work correctly together, they preserve the same hierarchy:

1. approved spec and approved handoff for functional intent
2. current product UI and design system for brownfield baseline truth
3. approved frontend direction packet for intentional visual change
4. packet support files such as `brownfield-ui-extraction.md`, `screen-index.md`, and `pencil-workset.md`
5. relevant repo-local `.pen` files
6. retained screenshots and exports treated as binding evidence
7. existing component library, tokens, shell conventions, and shared primitives
8. skill references and adapters as interpretation tools
9. freeform invention only for genuinely unspecified gaps

## Adapter Selection Rule

Always use `pencil-design-core` when `.pen` files, extraction, screenshots, or design-to-code handoff are in scope.

Then choose one adapter only:

- Angular + Nebular or similar operator-heavy brownfield UI: `pencil-design-angular-nebular`
- React / Next / Tailwind / shadcn: `pencil-design-react-tailwind`

Do not load the React adapter for an Angular product just because a design workflow elsewhere was React-first.

## Common Failure Modes

- Using `gsd-frontend-design` before spec, packet, or design truth is stable.
- Using `frontend-direction` as if it were an implementation skill.
- Using `pencil-design-core` alone, then quietly making stack-specific assumptions.
- Loading both adapters for one target stack.
- Letting HTML companion artifacts become durable truth instead of translating the chosen direction back into `.pen` files and packet prose.
- Treating the adapter as higher priority than the packet or current product system.
- Using a modern consumer-dashboard aesthetic to overwrite a dense brownfield operator UI.

## Short Mental Model

- `brainstorming` decides the work
- `frontend-direction` decides the intended UI
- `pencil-design-core` makes the UI evidence durable
- the adapter translates that evidence for the real stack
- `gsd-frontend-design` builds it without drifting
