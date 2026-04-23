# Brownfield Frontend Contract Workflow

This document defines a practical workflow for producing high-quality frontend direction in brownfield projects when the current UI truth lives in source code and runtime behavior rather than in existing durable design artifacts.

It is designed to improve two recurring failure modes:

1. poor fidelity when reproducing an existing screen before extending it
2. uneven UI/UX quality when the design direction is under-specified

This workflow separates those concerns on purpose.

- First, reproduce the current truth faithfully.
- Then, improve quality in bounded, reviewable ways.

## Why This Workflow Exists

The standard "generate a visual direction, then implement it" loop works best when strong visual evidence already exists.

Brownfield product work often does not have that.

Instead, the real source of truth is split across:

- frontend source code
- runtime layout behavior
- responsive breakpoints
- existing shared components
- implicit spacing and theming rules
- loading, error, and empty states only visible in a running app

If the agent starts from code alone, both HTML companion artifacts and Pencil worksets tend to drift. They look plausible, but they are not faithful enough to serve as extension-grade contracts.

## Core Principles

### Principle 1: Reproduction before improvement

Before proposing a better screen, create a faithful baseline of the current screen.

No visual improvement pass should start until the current shell, layout rhythm, density, and states have been captured.

### Principle 2: Runtime truth outranks source inference

Source code is necessary, but browser evidence is more trustworthy for layout, spacing, clipping, hierarchy, and responsive behavior.

When source code and runtime presentation disagree, runtime evidence wins unless there is a known bug.

### Principle 3: Separate observed truth from approved change

Each screen should distinguish:

- observed current truth
- normalization opportunities
- approved in-scope change

Do not collapse those into one artifact.

### Principle 4: Durable evidence must converge

Temporary HTML companion artifacts are useful for comparison and decision support.

Durable truth must converge into repo-local artifacts:

- packet prose
- screenshots
- `.pen` files
- extracted screen/state inventories

### Principle 5: Quality work must respect brownfield continuity

Improvements to typography, hierarchy, spacing, copy, accessibility, and motion should refine the existing product family unless redesign is explicitly approved.

## Recommended Skill Stack

Use these skills in this order:

1. `superpowers:brainstorming`
2. `superpowers:frontend-direction` when UI materially shapes implementation
3. `superpowers:webapp-testing` for browser-grounded capture and verification
4. `superpowers:pencil-design-core`
5. exactly one adapter:
   - `superpowers:pencil-design-angular-nebular`
   - `superpowers:pencil-design-react-tailwind`
6. Impeccable skills as a quality layer:
   - `impeccable teach`
   - `impeccable extract`
   - `impeccable critique`
   - `impeccable audit`
   - targeted refinement skills such as `layout`, `typeset`, `clarify`, `harden`, `adapt`, `polish`
7. `superpowers:gsd-frontend-design` for implementation

## Workflow Overview

The workflow has seven phases.

1. Scope and preservation framing
2. Runtime capture of current truth
3. Extraction into durable baseline artifacts
4. Controlled quality analysis
5. Approved change exploration
6. Durable contract finalization
7. Implementation and verification

## Phase 1: Scope and Preservation Framing

Goal:
Define what is being changed and what must remain visually stable.

Use:
- `superpowers:brainstorming`

Required outputs:
- feature scope
- workflow insertion point
- first delivery boundary
- `Must preserve`
- `May adapt`
- `Explicit no-gos`

For brownfield UI work, this phase must explicitly capture:

- shell invariants
- navigation invariants
- density expectations
- existing component vocabulary
- responsive expectations
- states that must continue to exist

If these are not written down early, later quality work will drift.

## Phase 2: Runtime Capture of Current Truth

Goal:
Create a reliable visual and behavioral baseline from the running application.

Use:
- `superpowers:webapp-testing`
- browser automation and screenshots
- source inspection only as support

Capture at minimum:

- full-page desktop screenshot
- full-page mobile or narrow screenshot
- key component close-ups for the changed area
- loading state
- empty state
- validation/error state
- permission or disabled state when relevant
- DOM snapshot references for important controls and regions
- console/network anomalies if the current screen is unstable

Recommended evidence set per screen:

- one baseline screenshot at desktop width
- one baseline screenshot at narrow/mobile width
- one focused screenshot for each high-risk region
- one short note on observed spacing, hierarchy, and interaction behavior

Output location:
- `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screenshots/`

This phase is mandatory when no durable baseline already exists.

## Phase 3: Extraction into Durable Baseline Artifacts

Goal:
Turn raw browser evidence into reusable, durable design truth.

Use:
- `superpowers:frontend-direction`
- `superpowers:pencil-design-core`
- correct Pencil adapter

Create these baseline artifacts before exploring improvements:

- `brownfield-ui-extraction.md`
- `screen-index.md`
- `pencil-workset.md`
- repo-local `.pen` files for:
  - foundations
  - shell
  - shared patterns
  - current feature baseline

The baseline extraction must record three layers for each relevant surface:

### Observed current truth

What the screen actually does and looks like now.

Examples:
- current card structure
- current table density
- visible filters
- action placement
- current spacing rhythm
- status treatment

### Conservative normalization target

Small cleanups that improve consistency without changing product meaning.

Examples:
- token normalization
- spacing cleanup
- type hierarchy tightening
- fixing contrast drift
- aligning repeated field wrappers

### Optional exploration zone

Changes that alter hierarchy or experience meaningfully and therefore require explicit approval.

Examples:
- regrouping settings sections
- changing action prominence
- converting table-heavy layouts into adaptive card flows on mobile

If these layers are not separated, every future artifact becomes ambiguous.

## Phase 4: Controlled Quality Analysis

Goal:
Improve judgment without losing fidelity.

Use Impeccable as a quality layer, not as a replacement source of truth.

Recommended sequence:

1. `impeccable teach`
2. `impeccable extract`
3. `impeccable critique`
4. `impeccable audit`

Interpretation:

- `teach` establishes audience, use case, and tone so quality work is not generic
- `extract` helps surface reusable design patterns and tokens
- `critique` evaluates UX quality, hierarchy, cognitive load, and AI-slop risk
- `audit` evaluates measurable implementation quality: accessibility, responsiveness, theming, performance, anti-patterns

Use the findings to populate two lists:

### Safe quality improvements

Changes that preserve the product family and can usually ship within the current scope.

Examples:
- better spacing rhythm
- clearer labels and helper text
- improved focus states
- better error treatment
- contrast fixes
- tighter typography

### Directional improvements

Changes that alter the visible product contract and need explicit approval.

Examples:
- new visual thesis
- significant shell or layout hierarchy changes
- large density reduction
- broad component restyling

Impeccable should not authorize redesign by itself.

## Phase 5: Approved Change Exploration

Goal:
Explore only the delta that matters for the approved change.

Use:
- `superpowers:frontend-direction`
- `superpowers:pencil-design-core`
- correct adapter
- optional HTML companion artifacts for comparison only

Rules:

- start from the faithful baseline
- vary one meaningful axis at a time
- keep the number of variants small
- compare against both current truth and the written scope

Good decision axes:

- settings grouping
- action prominence
- mobile adaptation strategy
- table-to-card adaptation on narrow screens
- status visibility
- error and helper-text treatment

Bad decision axes:

- random aesthetic reinvention
- palette changes with no product reason
- typography family changes without brand intent
- shell redesign outside approved scope

Every chosen direction must be translated back into:

- `.pen` boards
- packet prose
- updated screenshots when needed

Do not leave the winning idea only in HTML.

## Phase 6: Durable Contract Finalization

Goal:
Produce artifacts that an implementation agent can follow without inventing the UI.

Required final packet contents:

- `--frontend-direction.md`
- `screen-index.md`
- `brownfield-ui-extraction.md`
- `pencil-workset.md`
- retained screenshots
- exact `.pen` paths and board names
- declared downstream Pencil skills
- `Must preserve`
- `May adapt`
- `Explicit no-gos`
- responsive rules
- key states
- accessibility constraints

Each changed screen should answer:

- what is unchanged from current truth?
- what is normalized only?
- what is intentionally changed?
- what evidence is binding for implementation?

## Phase 7: Implementation and Verification

Goal:
Implement the approved UI without reopening design discovery.

Use:
- `superpowers:gsd-frontend-design`
- `superpowers:pencil-design-core`
- same adapter used during packet creation

Implementation rules:

- read the packet before touching code
- open the relevant `.pen` files and screenshots first
- extract `Must preserve`, `May adapt`, and `Explicit no-gos`
- reuse real codebase primitives and shell patterns
- fill gaps conservatively
- record any material deviation from packet or baseline truth

Verification must include:

- browser check against retained screenshots
- responsive check for the approved widths
- state verification for loading, empty, error, and validation states where relevant
- accessibility-sensitive checks for focus, labels, and keyboard navigation

## Required Artifact Model

For each brownfield feature with meaningful UI work, maintain this minimum artifact set:

### Packet prose

- feature-level frontend direction packet
- screen index
- brownfield UI extraction note
- Pencil workset note

### Visual evidence

- current-state screenshots
- approved-direction screenshots when they differ materially

### Durable design evidence

- shared foundations `.pen`
- shared shell `.pen`
- shared patterns `.pen`
- feature-specific `.pen`

### Quality evidence

- critique summary
- audit summary
- explicit list of accepted quality improvements for this scope

## Decision Rules

### When fidelity is the main problem

Do more capture and extraction before doing more design.

Symptoms:
- companion artifact feels "close but not the same"
- spacing and density feel off
- shell rhythm is wrong
- shared component vocabulary is inconsistent

Response:
- capture more runtime states
- inspect real components and tokens
- rebuild the baseline in Pencil first

### When quality is the main problem

Run critique and audit on the faithful baseline, then improve in bounded passes.

Symptoms:
- current screen is faithful but still poor
- hierarchy is weak
- copy is confusing
- focus/error/responsive handling is brittle

Response:
- use Impeccable findings to drive targeted improvements
- keep those improvements clearly separated from the current-truth baseline

### When both are problems

Do not solve them in one jump.

Order:
1. make the baseline faithful
2. critique and audit the faithful baseline
3. approve improvement deltas
4. update the durable contract
5. implement

## Practical Impeccable Usage in This Workflow

Use Impeccable selectively:

- `impeccable teach` at the start of quality work
- `impeccable extract` after baseline capture to identify reusable tokens and patterns
- `impeccable critique` after the baseline exists
- `impeccable audit` before implementation and again after implementation
- `layout`, `typeset`, `clarify`, `harden`, `adapt`, `polish` only after the scope of allowed change is explicit

Avoid using:

- `bolder`
- `colorize`
- `delight`
- `overdrive`

unless the user explicitly wants visible stylistic change beyond brownfield preservation.

## Anti-Patterns

Do not do these:

- generate a "better" screen before documenting the current one
- treat source code structure as enough evidence for visual fidelity
- let HTML companion artifacts become the only visual truth
- mix current truth, normalization, and proposed change into one board with no labeling
- use Impeccable to overwrite the product family
- let the stack adapter decide design direction
- implement from memory instead of from packet plus evidence

## Short Operating Model

Use this sentence as the working rule:

Capture the real screen, extract the real system, critique the faithful baseline, approve the bounded delta, converge it into Pencil and packet artifacts, then implement conservatively from that contract.

## Reference Inputs

This workflow aligns with:

- OpenAI guidance to front-load visual direction and verification for GPT-5.4-era frontend work:
  - https://developers.openai.com/blog/designing-delightful-frontends-with-gpt-5-4
  - https://developers.openai.com/api/docs/guides/prompt-guidance#prompting-patterns-for-coding-tasks
- local Superpowers frontend-direction and Pencil workflow skills
- local Impeccable design-quality skills and references
