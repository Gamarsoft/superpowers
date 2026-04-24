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
4. `gsd-frontend-design` plus `pencil-design-core` plus the correct adapter for the implementation target, normally the same adapter selected during packet creation

## Shared Principles

These skills repeat the same control rules in different phases:

- Brownfield product truth outranks generated novelty.
- Approved specs and packets outrank casual interpretation.
- Functional requirements and visual direction are separate contracts: approved spec, handoff, and acceptance criteria define behavior; current product UI and approved frontend packets define visual change.
- `.pen` files and retained screenshots are durable evidence.
- Adapters interpret design for a stack; they do not outrank the packet or the product system.
- HTML companion artifacts are temporary comparison surfaces, not durable truth.
- In brownfield work, preservation is the default unless change is explicitly approved.
- `PRODUCT.md` and `DESIGN.md` are useful design-memory inputs, but they do not outrank runtime truth, approved packets, or repo-local Pencil evidence.

## Independent Roles

### `superpowers:brainstorming`

Purpose:
Turn a request into approved implementation inputs before code is written.

What it produces:
- reviewed design spec
- reviewed GSD handoff
- ready-to-paste steering note
- reviewed frontend direction packet and supporting artifacts when UI direction is implementation-shaping
- repo-local Pencil workset when UI-heavy work has Pencil available

What it controls:
- track selection
- discovery style
- scope framing
- option shaping
- review loop
- decision on whether the frontend-direction phase is required
- use of `gathering-topic-context` before reflection for repo-specific brownfield work

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
- repo-local Pencil workset files such as `design/pencil/_shared/00-foundations.pen`, `design/pencil/_shared/10-shell.pen`, `design/pencil/_shared/20-patterns.pen`, and `design/pencil/{slug}/30-{slug}.pen`

What it controls:
- source of design truth
- brownfield extraction
- screen inventory
- bounded variant exploration
- implementation contract such as must-preserve vs may-adapt
- Impeccable v3 inputs when present: `PRODUCT.md` for audience/register context, `DESIGN.md` for reusable system documentation, and `DESIGN.json` only as auxiliary tooling output

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
- transport choice between Pencil MCP and Pencil CLI for general Pencil work
- GSD-facing Pencil work via CLI interactive mode only

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
- preflight against the real repo: confirm Angular/Nebular versions, use `context7-research` for Angular guidance, and inspect local Nebular docs/source for component APIs and module wiring

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
- approved spec, handoff, and acceptance criteria
- approved frontend direction packet
- `screen-index.md`
- `brownfield-ui-extraction.md`
- `pencil-workset.md`
- relevant `.pen` files
- retained screenshots
- existing UI system and component library
- `PRODUCT.md` and `DESIGN.md` when present, as context rather than stronger authority

What it controls:
- source-of-truth precedence during implementation
- extraction of `Must preserve`, `May adapt`, and `Explicit no-gos`
- implementation mode selection
- conservative gap filling when artifacts are incomplete
- Pencil source consumption through CLI interactive mode when `.pen` files are in scope
- implementation-quality checks for typography, color/contrast, spacing, interaction, motion, responsive behavior, UX writing, and accessibility as fallback heuristics

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

For repo-specific brownfield work, gather topic context before committing to the problem shape.

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
- the correct stack adapter for the implementation target, normally the same adapter used to shape or consume the workset

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

Functional contract:

1. approved spec, handoff, and acceptance criteria
2. current product behavior when the approved functional contract is silent

Visual contract:

1. existing product UI and design system for brownfield baseline truth
2. approved frontend direction packet for intentional in-scope visual change
3. packet support files such as `brownfield-ui-extraction.md`, `screen-index.md`, and `pencil-workset.md`
4. relevant repo-local `.pen` files
5. retained screenshots, browser captures, and Pencil exports treated as binding evidence
6. `PRODUCT.md` and current `DESIGN.md` as product/register and documented-system context
7. existing component library, tokens, shell conventions, and shared primitives
8. skill references and adapters as interpretation tools
9. freeform invention only for genuinely unspecified gaps

`DESIGN.json` is auxiliary Impeccable tooling output, not a primary durable contract.

## Adapter Selection Rule

Always use `pencil-design-core` when `.pen` files, extraction, screenshots, or design-to-code handoff are in scope.

Then choose one adapter only:

- Angular + Nebular or similar operator-heavy brownfield UI: `pencil-design-angular-nebular`
- React / Next / Tailwind / shadcn: `pencil-design-react-tailwind`

The actual production target wins. If earlier packet guidance selected the wrong adapter, correct it during implementation and record the mismatch.

For Angular + Nebular work, confirm Angular and Nebular versions before applying adapter assumptions. Use `context7-research` for Angular and the local Nebular checkout/source for Nebular APIs when available.

Do not load the React adapter for an Angular product just because a design workflow elsewhere was React-first.

## Pencil Transport Rule

Pencil MCP and Pencil CLI are transport layers over the same `.pen` truth.

- general Pencil design work may use MCP when the local session is stable
- GSD-facing workflows must plan around Pencil CLI interactive mode only
- do not use Pencil MCP or Pencil CLI agent mode in GSD workflows
- prefer distinct output paths when editing `.pen` files through CLI interactive mode, then replace deliberately after verification
- if CLI interactive persistence fails, declare degraded mode instead of silently direct-editing `.pen` JSON

## Common Failure Modes

- Using `gsd-frontend-design` before spec, packet, or design truth is stable.
- Using `frontend-direction` as if it were an implementation skill.
- Using `pencil-design-core` alone, then quietly making stack-specific assumptions.
- Loading both adapters for one target stack.
- Letting HTML companion artifacts become durable truth instead of translating the chosen direction back into `.pen` files and packet prose.
- Treating the adapter as higher priority than the packet or current product system.
- Using a modern consumer-dashboard aesthetic to overwrite a dense brownfield operator UI.
- Using Pencil MCP in a GSD-facing workflow when the current skills require CLI interactive mode.

## Short Mental Model

- `brainstorming` decides the work
- `frontend-direction` decides the intended UI
- `pencil-design-core` makes the UI evidence durable
- the adapter translates that evidence for the real stack
- `gsd-frontend-design` builds it without drifting
