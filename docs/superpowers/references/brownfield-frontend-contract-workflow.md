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

If the agent starts from code alone, HTML companion artifacts, generated image references, and Pencil worksets tend to drift. They look plausible, but they are not faithful enough to serve as extension-grade contracts.

## Core Principles

### Principle 1: Reproduction before improvement

Before proposing a better screen, create a faithful baseline of the current screen.

No visual improvement pass should start until the current shell, layout rhythm, density, and states have been captured.

### Principle 2: Runtime truth outranks source inference

Source code is necessary, but browser evidence is more trustworthy for layout, spacing, clipping, hierarchy, and responsive behavior.

When source code and runtime presentation disagree, runtime evidence wins unless there is a known bug.

Browser surface selection:

- in Codex App, use `browser-use:browser` and the in-app browser
- otherwise, use `playwright-cli`

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
- approved ChatGPT Images 2 files when selected as visual truth
- `.pen` files when Pencil is selected
- extracted screen/state inventories

### Principle 5: Quality work must respect brownfield continuity

Improvements to typography, hierarchy, spacing, copy, accessibility, and motion should refine the existing product family unless redesign is explicitly approved.

### Principle 6: Visual truth is selected explicitly

The frontend packet must declare one implementation visual-truth source:

- `chatgpt-image-2`: approved generated images are binding visual references; Pencil is omitted for that scope.
- `pencil`: approved Pencil boards and workset files are binding visual references.
- `current-ui/degraded`: no generated image or Pencil visual truth is approved; preserve current UI conservatively.

Generated images remain `reference-only` until the human approves them and chooses their role.

### Principle 7: Pencil transport is contextual

Pencil MCP and Pencil CLI are transport layers over the same `.pen` truth.

Use MCP for stable local design work when appropriate. For GSD-facing workflows, use Pencil CLI interactive mode only when Pencil is selected. Do not use Pencil MCP or Pencil CLI agent mode in those workflows.

## Recommended Skill Stack

Use these skills in this order:

1. `superpowers:brainstorming`
2. manual compaction or a new session using the frontend-direction follow-on prompt when UI materially shapes implementation
3. `superpowers:frontend-direction`
4. `superpowers:webapp-testing` for browser-grounded capture and verification
5. `superpowers:writing-ux-copy` when labels, CTAs, warnings, errors, empty states, confirmations, helper text, i18n strings, or ChatGPT Images prompt visible text are in scope
6. `superpowers:creating-chatgpt-image-upload-packs` when ChatGPT Images 2 references are requested or needed before visual-truth selection
7. `superpowers:pencil-design-core` only when Pencil is selected
8. exactly one adapter when Pencil is selected:
   - `superpowers:pencil-design-angular-nebular`
   - `superpowers:pencil-design-react-tailwind`
9. Impeccable skills only when a quality layer is in scope:
   - `impeccable extract`
   - `impeccable critique`
   - `impeccable audit`
   - `impeccable document` when `DESIGN.md` is missing or stale
   - targeted refinement skills such as `layout`, `typeset`, `clarify`, `harden`, `adapt`, `polish`
10. `superpowers:gsd-frontend-design` for implementation
11. Fresh-context visual review for non-trivial UI implementation, using the active workflow's reviewer mechanism. In GSD-2, this is a `worker` subagent that reads project instructions first, uses fresh browser isolation when supported, independently opens and recaptures the target route, and writes `VISUAL-REVIEW.md`.

Use `impeccable teach` only when product context is missing, stale, or intentionally changing. If a current `PRODUCT.md` exists, treat it as product/register context instead of rerunning teach.

## Workflow Overview

The workflow has nine phases.

1. Scope and preservation framing
2. Session split / frontend-direction bootstrap
3. Runtime capture of current truth
4. Extraction into durable baseline artifacts
5. Optional ChatGPT Images 2 reference pack
6. Controlled quality analysis
7. Approved change exploration
8. Durable contract finalization
9. Implementation and verification

When live data cannot produce all visual states on demand, implementation verification may use dual runtime data modes: live mode for integration truth and visual fixture mode for deterministic state coverage.

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
- reviewed design spec
- reviewed GSD handoff
- frontend-direction follow-on prompt when UI direction is required
- UX copy deck or explicit missing copy states when user-visible text shapes the workflow

For repo-specific brownfield work, `brainstorming` should prefer `gathering-topic-context` before reflection so the scope is grounded in the current codebase and workflow.

For brownfield UI work, this phase must explicitly capture:

- shell invariants
- navigation invariants
- density expectations
- existing component vocabulary
- responsive expectations
- states that must continue to exist

If these are not written down early, later quality work will drift.

## Phase 2: Session Split / Frontend-Direction Bootstrap

Goal:
Preserve context by starting frontend-direction after the spec and handoff are approved.

Use:
- the follow-on prompt from `superpowers:brainstorming`
- `superpowers:frontend-direction`

The follow-on prompt should carry:

- approved spec path
- approved GSD handoff path
- first delivery boundary
- screen families and key states
- brownfield invariants
- visual-companion decisions as non-durable context
- UX writing decisions, copy deck path or copy gaps, and prompt-visible-text requirements
- likely stack and adapter candidates
- whether ChatGPT Images 2 references may be useful before visual-truth selection
- visual-reference intent approval requirement

Do not start frontend implementation while packet status is `required`.

## Phase 3: Runtime Capture of Current Truth

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

## Phase 4: Extraction into Durable Baseline Artifacts

Goal:
Turn raw browser evidence into reusable, durable design truth.

Use:
- `superpowers:frontend-direction`
- `superpowers:pencil-design-core` only when Pencil is selected
- correct Pencil adapter only when Pencil is selected

For Angular + Nebular targets, confirm the repo's Angular and Nebular versions before applying adapter assumptions. Use `context7-research` for Angular guidance and the local Nebular checkout/source for Nebular component APIs when available.

Create these baseline artifacts before exploring improvements:

- `brownfield-ui-extraction.md`
- `screen-index.md`
- `pencil-workset.md` only when Pencil is selected
- repo-local `.pen` files only when Pencil is selected:
  - `design/pencil/_shared/00-foundations.pen`
  - `design/pencil/_shared/10-shell.pen`
  - `design/pencil/_shared/20-patterns.pen`
  - `design/pencil/{slug}/30-{slug}.pen`

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

## Phase 5: Optional ChatGPT Images 2 Reference Pack

Goal:
Create image-native references before implementation visual truth is selected, when pictures would clarify the approved direction better than prose alone.

Use:
- `superpowers:creating-chatgpt-image-upload-packs`
- `superpowers:writing-ux-copy` for every prompt-visible UI string

Run this phase when:

- the user requests ChatGPT Images 2 or generated UI references
- exact visual direction is still unstable after baseline capture and extraction
- generated image references are intended to become candidates for implementation visual truth
- baseline screenshots need image-native exploration before Pencil or image-only truth is chosen

Rules:

- write the pack under `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/`
- include `README.md`, `00-shared-image-context.md`, `attachment-map.md`, and prompt files
- use screen families and parent/child state prompts so state variants inherit the same layout
- quote production-quality visible copy in the target locale before generation; do not let generated images bake in rough, technical, or unapproved microcopy
- stop after the pack until the human generates images externally
- require approved images to be saved beside matching prompt files
- keep generated images `reference-only` until the human approves them and chooses their visual-truth role

Human visual-truth choices:

- `chatgpt-image-2`: approved generated images bind implementation; omit Pencil artifacts for that scope.
- `pencil`: approved generated images feed later Pencil boards; create Pencil artifacts only after this choice.
- `current-ui/degraded` or defer: no generated or Pencil visual truth is approved; continue conservatively or wait.

Do not create `pencil-workset.md`, shared Pencil files, feature `.pen` boards, or Pencil screenshots while this choice is pending.

## Phase 6: Controlled Quality Analysis

Goal:
Improve judgment without losing fidelity.

Use Impeccable as a quality layer, not as a replacement source of truth.

Recommended sequence:

1. read current `PRODUCT.md` and `DESIGN.md` when they exist
2. use `impeccable document` if `DESIGN.md` is missing or stale
3. use `impeccable extract` after baseline capture to identify reusable tokens and patterns
4. use `impeccable critique` after the faithful baseline exists
5. use `impeccable audit` before implementation and again after implementation when measurable implementation quality is in scope

Interpretation:

- `PRODUCT.md` establishes audience, use case, tone, and register so quality work is not generic
- `DESIGN.md` documents the reusable system; `DESIGN.json` is auxiliary tooling output, not the durable contract
- `extract` helps surface reusable design patterns and tokens
- `critique` evaluates UX quality, hierarchy, cognitive load, and AI-slop risk
- `audit` evaluates measurable implementation quality: accessibility, responsiveness, theming, performance, anti-patterns

Use `impeccable teach` only when product context is missing, stale, or intentionally changing. Do not let Impeccable output outrank runtime truth, the approved packet, screenshots, or the selected visual-truth source.

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

## Phase 7: Approved Change Exploration

Goal:
Explore only the delta that matters for the approved change.

Use:
- `superpowers:frontend-direction`
- `superpowers:pencil-design-core` only when Pencil is selected
- correct adapter only when Pencil is selected
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

- the selected visual-truth source
- packet prose
- updated screenshots when needed

Do not leave the winning idea only in HTML. If `chatgpt-image-2` is selected, list exact approved generated image files. If Pencil is selected, translate the decision into `.pen` boards.

## Phase 8: Durable Contract Finalization

Goal:
Produce artifacts that an implementation agent can follow without inventing the UI.

Required final packet contents:

- `--frontend-direction.md`
- `screen-index.md`
- `brownfield-ui-extraction.md`
- implementation visual-truth source: `chatgpt-image-2`, `pencil`, or `current-ui/degraded`
- `chatgpt-image-2/` files and approved generated image references when selected
- `pencil-workset.md` when Pencil is selected
- retained screenshots
- exact `.pen` paths and board names when Pencil is selected
- declared downstream Pencil skills only when Pencil is selected
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
- is Pencil selected, omitted by image-only visual truth, or unavailable in degraded mode?

## Phase 9: Implementation and Verification

Goal:
Implement the approved UI without reopening design discovery.

Use:
- `superpowers:gsd-frontend-design`
- `superpowers:pencil-design-core` and the correct adapter only when the packet selects Pencil

Implementation rules:

- read the packet before touching code
- determine the declared implementation visual-truth source before touching code
- when `chatgpt-image-2` is selected, open approved generated image files first and do not require Pencil
- when `pencil` is selected, open the relevant `.pen` files and screenshots first
- extract `Must preserve`, `May adapt`, and `Explicit no-gos`
- reuse real codebase primitives and shell patterns
- fill gaps conservatively
- record any material deviation from packet or baseline truth
- when `.pen` files are in scope, use Pencil CLI interactive mode only
- prefer distinct output paths for CLI interactive `.pen` edits, then replace deliberately after verification
- do not use Pencil MCP or Pencil CLI agent mode in GSD-facing workflows when Pencil is selected
- fall back to direct `.pen` text editing only in explicit degraded mode
- use implementation-quality references for typography, color/contrast, spacing, interaction, motion, responsive behavior, UX writing, and accessibility as fallback heuristics, not as design authority

Verification must include:

- browser check against retained screenshots and approved generated images when `chatgpt-image-2` is selected
- responsive check for the approved widths
- state verification for loading, empty, error, and validation states where relevant
- separate live runtime proof and fixture visual-state proof when deterministic fixtures are needed
- accessibility-sensitive checks for focus, labels, and keyboard navigation
- fresh-context visual quality review for non-trivial UI work
- review artifact recording project instructions read, fresh browser isolation or fallback, independent runtime recapture, evidence inspected, Impeccable critique/audit checks applied when available, findings by severity, verdict, and review decision
- no visual review approval when the target route cannot be opened because of `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, or equivalent runtime blockage
- raw runtime screenshots, traces, console logs, and network dumps treated as `/tmp`, other temporary, ignored local, or external redaction-safe verification inputs unless explicitly approved as commit artifacts

## Required Artifact Model

For each brownfield feature with meaningful UI work, maintain this minimum artifact set:

### Packet prose

- feature-level frontend direction packet
- screen index
- brownfield UI extraction note
- declared implementation visual-truth source
- Pencil workset note only when Pencil is selected

### Visual evidence

- current-state screenshots
- approved-direction screenshots when they differ materially
- approved ChatGPT Images 2 files when selected

### Durable design evidence

- approved ChatGPT Images 2 files with matching prompt stems when image-only truth is selected
- shared foundations `.pen` when Pencil is selected
- shared shell `.pen` when Pencil is selected
- shared patterns `.pen` when Pencil is selected
- feature-specific `.pen` when Pencil is selected
- approved intent for every implementation-facing image, board, or screenshot

### Quality evidence

Include this when quality refinement beyond faithful reproduction was in scope:

- critique summary
- audit summary
- explicit list of accepted quality improvements for this scope
- fresh-context visual review artifact for non-trivial UI implementation, such as `VISUAL-REVIEW.md`
- persisted raw runtime evidence path only when it was needed for review or replay; default to `/tmp`, another temporary directory, an ignored local path, or external redaction-safe storage
- fixture catalog or harness references when visual fixture mode was used, with a claim boundary separating fixture visual proof from live integration proof

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
- rebuild the baseline in the selected visual-truth source first

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
4. choose and record the visual-truth source
5. update the durable contract
6. implement

## Practical Impeccable Usage in This Workflow

Use Impeccable selectively:

- `impeccable teach` only when `PRODUCT.md` is missing, stale, or intentionally changing
- `impeccable document` when `DESIGN.md` is missing or stale
- `impeccable extract` after baseline capture to identify reusable tokens and patterns
- `impeccable critique` after the baseline exists
- `impeccable audit` before implementation and again after implementation when measurable quality checks are in scope
- `impeccable live` only as a bounded refinement surface on supported stacks after the baseline and packet direction exist
- `layout`, `typeset`, `clarify`, `harden`, `adapt`, `polish` only after the scope of allowed change is explicit

Treat `PRODUCT.md` as product/register context, `DESIGN.md` as reusable system documentation, and `DESIGN.json` as auxiliary tooling output. None of them outrank current runtime truth in brownfield work.

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
- treat ChatGPT Images 2 prompts or unapproved generated images as implementation visual truth
- create Pencil artifacts while ChatGPT Images 2 approval and visual-truth selection are still pending
- require Pencil when the packet explicitly selects `chatgpt-image-2`
- start frontend implementation while the GSD handoff still says frontend packet status is `required`
- mix current truth, normalization, and proposed change into one artifact with no labeling
- use Impeccable to overwrite the product family
- treat implementer self-review as the final visual quality gate for non-trivial UI implementation
- claim fixture-rendered states as live backend integration proof
- let the stack adapter decide design direction
- implement from memory instead of from packet plus evidence

## Short Operating Model

Use this sentence as the working rule:

Capture the real screen, extract the real system, critique the faithful baseline, approve the bounded delta, select visual truth, converge it into approved image or Pencil plus packet artifacts, implement conservatively from that contract, then require fresh-context visual review before completion.

## Reference Inputs

This workflow aligns with:

- local Superpowers frontend-direction and Pencil workflow skills
- local Superpowers ChatGPT Images 2 upload-pack workflow
- local Impeccable design-quality skills and references
