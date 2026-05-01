# Frontend Skill Stack Reference

This note captures how these Superpowers skills work on their own and as a coordinated workflow:

- `superpowers:brainstorming`
- `superpowers:frontend-direction`
- `superpowers:creating-chatgpt-image-upload-packs`
- `superpowers:gsd-frontend-design`
- `superpowers:pencil-design-core`
- `superpowers:pencil-design-angular-nebular`
- `superpowers:pencil-design-react-tailwind`

## Core Understanding

These skills form a pipeline, not a flat list of interchangeable tools.

`brainstorming` decides what is being built, how uncertain it still is, and whether a visual-direction phase is required. It stops after the reviewed spec, GSD handoff, and a follow-on prompt for the frontend-direction session.

`frontend-direction` creates the explicit visual contract in a separate session once product direction is stable enough to anchor screens and states. It now declares the implementation visual-truth source: `chatgpt-image-2`, `pencil`, or `current-ui/degraded`.

`creating-chatgpt-image-upload-packs` runs inside frontend-direction work when ChatGPT Images 2 references are requested, useful, or needed before the implementation visual-truth decision. It creates prompt packs and stops for human generation, approval, and visual-truth selection.

`pencil-design-core` governs how durable design evidence is created and maintained in `.pen` files. It is the operating discipline for Pencil work, not a stack-specific implementation guide. It applies only when Pencil is selected or `.pen` files are in scope.

`pencil-design-angular-nebular` and `pencil-design-react-tailwind` are mutually exclusive adapters. They translate Pencil evidence into stack-native guidance for the real frontend target.

`gsd-frontend-design` is the implementation skill. It consumes the approved packet, declared visual-truth source, selected references, screenshots, and current product system, then changes application code without silently redesigning the product. If the packet selects `chatgpt-image-2`, GSD uses approved generated images as binding visual screenshots and omits Pencil skills for that scope. For non-trivial UI work, completion requires fresh-context visual review rather than implementer self-review alone.

The intended flow is:

1. `brainstorming`
2. manual compaction or a new session when UI materially shapes implementation
3. `frontend-direction`
4. `creating-chatgpt-image-upload-packs` when image-native references are requested or visual truth is still unstable
5. one visual-truth path selected by the human:
   - `chatgpt-image-2`, using approved generated image files and omitting Pencil
   - `pencil`, using `pencil-design-core` plus exactly one adapter
   - `current-ui/degraded`, using conservative brownfield guidance only
6. `gsd-frontend-design`, with Pencil skills only when the packet selects Pencil

## Shared Principles

These skills repeat the same control rules in different phases:

- Outcome-first prompting improves the pipeline only when it preserves the contracts: each phase should state the intended artifact, success criteria, source evidence, validation gate, and stop condition before expanding process detail.
- Brownfield product truth outranks generated novelty.
- Approved specs and packets outrank casual interpretation.
- Functional requirements and visual direction are separate contracts: approved spec, handoff, and acceptance criteria define behavior; current product UI and approved frontend packets define visual change.
- The packet must declare the implementation visual-truth source.
- `.pen` files, approved ChatGPT Images 2 files, and retained screenshots are durable evidence only when their intent is approved.
- Runtime screenshots, traces, console logs, and network dumps gathered during implementation verification are proof inputs, not durable repo artifacts by default.
- Live runtime proof and visual fixture proof are different evidence types. Live mode proves real integration for available states; fixture mode proves hard-to-reach visual states with deterministic contract-shaped API responses.
- Adapters interpret Pencil-backed design for a stack; they do not outrank the packet or the product system.
- HTML companion artifacts are temporary comparison surfaces, not durable truth.
- In brownfield work, preservation is the default unless change is explicitly approved.
- `PRODUCT.md` and `DESIGN.md` are useful design-memory inputs, but they do not outrank runtime truth, approved packets, or selected visual-truth evidence.

## GPT-5.5 Prompting Alignment

Use GPT-5.5-style efficiency to remove redundant prompt scaffolding, not to weaken discovery, review, or visual-truth gates.

- Keep each phase outcome-first: name the artifact to produce, what approval means, what evidence is binding, and when to stop.
- Use retrieval budgets: gather enough source evidence to support the next decision, then stop unless a missing fact would change scope, risk, visual truth, or implementation acceptance.
- Preserve visible preambles and phase-aware intermediate updates in tool-heavy sessions so the user can follow long-running work.
- Separate source-backed facts from creative direction. Product behavior, routes, states, customer claims, metrics, and current UI facts need evidence. Visual phrasing, sample copy, and bounded variants may be creative but must not invent product facts.
- Validate before handoff: specs go through the spec reviewer, frontend packets go through packet completeness checks, and implementations verify against the selected visual-truth source.
- For non-trivial UI implementation, use fresh-context visual review as the final quality gate. In GSD-2, this means a `worker` subagent writes `VISUAL-REVIEW.md` after browser/reference verification.
- Record the conclusion of runtime browser evidence in durable UAT, summary, checklist, or review files. Put raw screenshots/traces/log dumps under `/tmp`, another temporary directory, an ignored local path, or an external redaction-safe location unless the task explicitly says to commit them.
- When fixtures are needed for state coverage, prefer browser/e2e network fixtures or a local mock proxy, label evidence as fixture evidence, and do not use it to claim backend authorization, persistence, or service wiring. Treat in-browser XHR/fetch monkeypatches as temporary spikes to convert into repeatable fixture lanes.
- Do not treat shorter prompts as permission to skip the frontend-direction split, requirement reconciliation, board/image intent approval, or GSD packet gates.

## Independent Roles

### `superpowers:brainstorming`

Purpose:
Turn a request into approved implementation inputs before code is written.

What it produces:
- reviewed design spec
- reviewed GSD handoff
- ready-to-paste steering note
- frontend-direction follow-on prompt when UI direction is implementation-shaping

What it controls:
- track selection
- discovery style
- scope framing
- option shaping
- review loop
- decision on whether the frontend-direction phase is required
- use of `gathering-topic-context` before reflection for repo-specific brownfield work
- visual companion decisions as temporary brainstorming context

What it should not do:
- write production code
- create the full frontend packet, screenshots, or Pencil workset in the default brainstorming session
- skip discovery and jump straight to implementation
- invent visual direction before current truth and boundaries are understood

### `superpowers:frontend-direction`

Purpose:
Make visual intent explicit before frontend implementation starts.

What it produces:
- `--frontend-direction.md`
- `screen-index.md`
- `brownfield-ui-extraction.md`
- `chatgpt-image-2/` prompt packs when image references are requested or needed before visual-truth selection
- `pencil-workset.md` only when Pencil is selected
- screenshots
- repo-local Pencil workset files such as `design/pencil/_shared/00-foundations.pen`, `design/pencil/_shared/10-shell.pen`, `design/pencil/_shared/20-patterns.pen`, and `design/pencil/{slug}/30-{slug}.pen` only when Pencil is selected

What it controls:
- source of design truth
- brownfield extraction
- screen inventory
- bounded variant exploration
- implementation contract such as must-preserve vs may-adapt
- Impeccable v3 inputs when present: `PRODUCT.md` for audience/register context, `DESIGN.md` for reusable system documentation, and `DESIGN.json` only as auxiliary tooling output
- the visual-truth decision between approved ChatGPT Images 2 files, Pencil, and degraded current UI

What it should not do:
- act as a coding skill
- let temporary HTML comps become the durable source of truth
- create Pencil artifacts before a pending ChatGPT Images 2 phase has been generated, approved, and routed
- drift into redesign when the real need is continuity

### `superpowers:creating-chatgpt-image-upload-packs`

Purpose:
Create ChatGPT Images 2 prompt packs from frontend-direction inputs before the implementation visual-truth source is selected.

What it produces:
- `chatgpt-image-2/README.md`
- `chatgpt-image-2/00-shared-image-context.md`
- `chatgpt-image-2/attachment-map.md`
- parent and child prompt files for covered screen states

What it controls:
- prompt coverage from `screen-index.md`
- reference-image roles and attachment maps
- parent/child prompt inheritance for state variants
- the stop point before human generation, approval, and visual-truth choice

What it should not do:
- generate images through the API unless explicitly asked
- promote generated images to visual truth without human approval
- create or update Pencil artifacts before the human chooses the Pencil path

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
- declared implementation visual-truth source
- approved ChatGPT Images 2 files when `chatgpt-image-2` is selected
- `screen-index.md`
- `brownfield-ui-extraction.md`
- `pencil-workset.md` and relevant `.pen` files when `pencil` is selected
- retained screenshots
- existing UI system and component library
- `PRODUCT.md` and `DESIGN.md` when present, as context rather than stronger authority

What it controls:
- source-of-truth precedence during implementation
- extraction of `Must preserve`, `May adapt`, and `Explicit no-gos`
- implementation mode selection
- conservative gap filling when artifacts are incomplete
- ChatGPT Images 2 source consumption when approved generated images are selected
- Pencil source consumption through CLI interactive mode when `.pen` files are in scope
- implementation-quality checks for typography, color/contrast, spacing, interaction, motion, responsive behavior, UX writing, and accessibility as fallback heuristics
- fresh-context visual review for non-trivial UI work, with Impeccable critique/audit findings treated as review evidence rather than design authority
- visual fixture mode for hard-to-reach state coverage, with UAT separating fixture visual proof from live integration proof

What it should not do:
- reopen product or design discovery without cause
- let reference heuristics overrule the packet or current product system
- require Pencil when the packet explicitly selects `chatgpt-image-2`
- redesign unrelated surfaces while implementing an approved slice

## Composition Model

### Phase 1: Shape the work

Use `brainstorming` to determine:
- what problem is actually being solved
- which track applies
- what the first delivery boundary is
- whether the UI is important enough to justify a frontend-direction phase

For repo-specific brownfield work, gather topic context before committing to the problem shape.

This phase produces the approved design spec, GSD handoff, and, when needed, a follow-on prompt for a separate frontend-direction session. It should not create the full frontend packet by default.

### Phase 2: Reset Context

If UI materially affects implementation, manually compact or start a new session using the follow-on prompt from brainstorming.

This protects the frontend-direction work from context-window pressure and preserves the approved product decisions as explicit inputs.

### Phase 3: Lock visual intent

Use `frontend-direction`.

This phase:
- chooses the design-truth source
- extracts existing UI reality first in brownfield work
- creates the screen inventory
- creates ChatGPT Images 2 upload packs when image-native exploration is needed before selecting visual truth
- creates or refreshes the Pencil workset only when Pencil is selected
- records what downstream implementation must preserve, may adapt, and must avoid

This is the visual-contract phase.

### Phase 4: Build durable design evidence

Use `creating-chatgpt-image-upload-packs` when the frontend-direction session needs ChatGPT Images 2 references before selecting implementation visual truth. Stop after the pack until the human generates images, saves approved files beside matching prompts, and chooses `chatgpt-image-2`, `pencil`, or `current-ui/degraded`.

Use `pencil-design-core` whenever `.pen` files are involved or Pencil is selected.

Then choose one adapter:
- `pencil-design-angular-nebular` for Angular + Nebular or similar dense brownfield operator UIs
- `pencil-design-react-tailwind` only for actual React / Next / Tailwind / shadcn targets

This is the design-evidence and translation-preparation phase.

### Phase 5: Implement from approved evidence

Use `gsd-frontend-design` with:
- the selected implementation visual-truth source
- `pencil-design-core` and the correct stack adapter only when the packet selects Pencil

This phase reads the approved evidence in precedence order and changes real frontend code conservatively.

For non-trivial UI work, this phase also needs a fresh-context visual reviewer after browser/reference verification. In GSD-2, use a `worker` subagent and record `VISUAL-REVIEW.md` beside the normal review artifact.

This is the implementation phase.

## Skill Matrix

| Skill | Primary purpose | Typical inputs | Typical outputs | Must pair with | Must not be mistaken for |
| --- | --- | --- | --- | --- | --- |
| `brainstorming` | Shape the problem and produce approved written artifacts | user request, repo context, discovery answers, current product truth | spec, handoff, optional frontend-direction follow-on prompt | `frontend-direction` in a separate session when UI matters | a coding or direct implementation skill |
| `frontend-direction` | Create explicit visual direction | approved spec, GSD handoff, follow-on prompt, screenshots, current UI patterns, wireframes | frontend packet, screen index, extraction doc, visual-truth decision, screenshots, optional image packs or `.pen` files | `creating-chatgpt-image-upload-packs` when image references are needed; Pencil skills only when Pencil is selected | a frontend coding skill |
| `creating-chatgpt-image-upload-packs` | Create image-native prompt packs before visual-truth selection | spec, packet draft, screen index, extraction doc, baseline screenshots | `chatgpt-image-2/` prompt pack and attachment map | `frontend-direction` | an implementation or image-approval skill |
| `pencil-design-core` | Enforce durable `.pen` discipline | packet, screenshots, current UI, existing `.pen` files, design tokens | stable `.pen` artifacts and verified design evidence | exactly one stack adapter when code translation matters | a framework-specific translation skill |
| `pencil-design-angular-nebular` | Translate Pencil evidence for Angular + Nebular | approved `.pen` evidence, packet, current Angular/Nebular patterns | Angular/Nebular-oriented implementation guidance | `pencil-design-core` | a generic frontend adapter |
| `pencil-design-react-tailwind` | Translate Pencil evidence for React + Tailwind | approved `.pen` evidence, packet, token system, component conventions | React/Tailwind-oriented implementation guidance | `pencil-design-core` | a universal design-to-code adapter |
| `gsd-frontend-design` | Implement frontend code from approved design truth | spec, handoff, packet, selected visual truth, support docs, screenshots, existing code patterns | implemented UI changes aligned to approved evidence plus visual review artifact for non-trivial UI work | Pencil skills only when Pencil sources exist | a discovery or redesign skill |

## Trigger Matrix

| Situation | Correct skill choice |
| --- | --- |
| The request is still ambiguous and needs scope/options/spec work | `brainstorming` |
| The product direction is mostly stable but implementation would still be guessing visually | `frontend-direction` |
| Frontend direction needs ChatGPT Images 2 references before selecting visual truth | `creating-chatgpt-image-upload-packs` inside `frontend-direction` |
| A `.pen` workset must be created, updated, verified, or consumed | `pencil-design-core` |
| The target repo is Angular + Nebular, especially dense brownfield/admin UI | `pencil-design-angular-nebular` with `pencil-design-core` |
| The target repo is React / Next / Tailwind / shadcn | `pencil-design-react-tailwind` with `pencil-design-core` |
| Approved artifacts exist and the task is now to implement frontend code | `gsd-frontend-design`, plus Pencil skills only if `.pen` files are in scope |

## Source-of-Truth Ladder

When these skills work correctly together, they preserve the same hierarchy:

Functional contract:

1. approved spec, handoff, and acceptance criteria
2. current product behavior when the approved functional contract is silent

Visual contract:

1. existing product UI and design system for brownfield baseline truth
2. approved frontend direction packet for intentional in-scope visual change
3. declared implementation visual-truth source: `chatgpt-image-2`, `pencil`, or `current-ui/degraded`
4. approved visual-reference intent metadata
5. approved ChatGPT Images 2 generated image files when selected
6. `pencil-workset.md` and relevant repo-local `.pen` files when Pencil is selected
7. packet support files such as `brownfield-ui-extraction.md` and `screen-index.md`
8. retained screenshots, browser captures, and Pencil exports treated as binding evidence
9. `PRODUCT.md` and current `DESIGN.md` as product/register and documented-system context
10. existing component library, tokens, shell conventions, and shared primitives
11. fresh-context visual review artifacts as quality review evidence
12. Impeccable critique/audit findings as quality review evidence, not design authority
13. skill references and adapters as interpretation tools
14. freeform invention only for genuinely unspecified gaps

`DESIGN.json` is auxiliary Impeccable tooling output, not a primary durable contract.

## Adapter Selection Rule

Use `pencil-design-core` when `.pen` files, Pencil extraction, Pencil screenshots, or Pencil-backed design-to-code handoff are in scope.

Then choose one adapter only:

- Angular + Nebular or similar operator-heavy brownfield UI: `pencil-design-angular-nebular`
- React / Next / Tailwind / shadcn: `pencil-design-react-tailwind`

The actual production target wins. If earlier packet guidance selected the wrong adapter, correct it during implementation and record the mismatch.

For Angular + Nebular work, confirm Angular and Nebular versions before applying adapter assumptions. Use `context7-research` for Angular and the local Nebular checkout/source for Nebular APIs when available.

Do not load any Pencil adapter when the packet selects `chatgpt-image-2` and omits Pencil. Do not load the React adapter for an Angular product just because a design workflow elsewhere was React-first.

## Pencil Transport Rule

Pencil MCP and Pencil CLI are transport layers over the same `.pen` truth.

- general Pencil design work may use MCP when the local session is stable
- GSD-facing workflows must plan around Pencil CLI interactive mode only when Pencil is selected
- do not use Pencil MCP or Pencil CLI agent mode in GSD workflows when Pencil is selected
- prefer distinct output paths when editing `.pen` files through CLI interactive mode, then replace deliberately after verification
- if CLI interactive persistence fails, declare degraded mode instead of silently direct-editing `.pen` JSON

## Common Failure Modes

- Using `gsd-frontend-design` before spec, packet, or design truth is stable.
- Using `frontend-direction` as if it were an implementation skill.
- Treating ChatGPT Images 2 prompts or unapproved generated images as implementation visual truth.
- Creating Pencil artifacts while a ChatGPT Images 2 visual-truth choice is still pending.
- Loading Pencil skills when the packet explicitly selects `chatgpt-image-2` and omits Pencil.
- Using `pencil-design-core` alone, then quietly making stack-specific assumptions.
- Loading both adapters for one target stack.
- Letting HTML companion artifacts become durable truth instead of translating the chosen direction back into the selected visual-truth source and packet prose.
- Treating the adapter as higher priority than the packet or current product system.
- Using a modern consumer-dashboard aesthetic to overwrite a dense brownfield operator UI.
- Using Pencil MCP in a GSD-facing workflow when the current skills require CLI interactive mode.
- Treating implementer self-review as enough visual QA for non-trivial UI implementation.

## Short Mental Model

- `brainstorming` decides the work
- `frontend-direction` decides the intended UI
- `creating-chatgpt-image-upload-packs` creates image references before visual-truth selection when needed
- `pencil-design-core` makes `.pen` evidence durable when Pencil is selected
- the adapter translates Pencil evidence for the real stack
- `gsd-frontend-design` builds it without drifting
