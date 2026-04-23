# Impeccable in Brownfield Frontend Work

Use this file when brownfield frontend work needs a quality pass without losing fidelity to the existing product.

## Core Rule

Impeccable is a quality layer, not a replacement source of truth.

In brownfield work:

- current product truth comes first
- faithful baseline capture comes second
- Impeccable refinement comes third

Do not use Impeccable to skip the baseline.

## Preconditions

Before using Impeccable in a brownfield workflow, make sure these exist:

- retained browser evidence from the running app
- `brownfield-ui-extraction.md`
- a clear separation between:
  - observed current truth
  - conservative normalization target
  - approved change

If those do not exist yet, build them first.

## `impeccable teach`

`impeccable teach` is project initialization, not a per-feature ritual.

Rules:

- if a project-level `.impeccable.md` already exists and is still accurate, do not run it again
- only re-run it when the product context is missing, stale, or intentionally changing
- for repo-specific brownfield work, treat the project’s existing `.impeccable.md` as the design-context source unless the human says otherwise

## Recommended Sequence

For brownfield frontend direction:

1. capture the current runtime baseline
2. write `brownfield-ui-extraction.md`
3. recreate the baseline in Pencil
4. if design-quality work is needed:
   - use `impeccable extract`
   - use `critique`
   - use `audit`
5. turn findings into bounded approved deltas
6. update packet prose, screenshots, and `.pen` files

## What Each Impeccable Skill Is Good For

### `impeccable extract`

Use to identify reusable tokens, spacing patterns, components, and recurring UI language in the existing product.

Best fit:
- after baseline capture
- before proposing normalization

### `critique`

Use to evaluate UX quality and visual clarity once the baseline exists.

Best fit:
- hierarchy issues
- cognitive-load issues
- weak grouping or information architecture
- unclear emphasis or poor scan paths

### `audit`

Use to evaluate measurable implementation quality.

Best fit:
- accessibility issues
- responsive issues
- theming drift
- anti-pattern detection
- implementation-level quality gaps

### Targeted refinement skills

Use only after the allowed scope of visual change is clear:

- `layout`
- `typeset`
- `clarify`
- `harden`
- `adapt`
- `polish`

## Safe Default in Brownfield Work

Default to these kinds of improvements:

- spacing consistency
- clearer typography hierarchy
- stronger labels and helper text
- better error and validation treatment
- focus-state and accessibility cleanup
- responsive adaptation that preserves workflow throughput

These are usually safe because they refine the existing product rather than redefining it.

## Escalation Boundary

Treat these as directional changes that require explicit approval:

- new visual thesis
- broad palette change
- major typography-family shift
- shell or navigation redesign
- strong density reduction on operator screens
- large component restyling across the product family

Impeccable findings alone do not authorize these changes.

## Anti-Patterns

Do not:

- run Impeccable first and baseline capture later
- let `critique` or `audit` replace brownfield extraction
- treat AI-slop cleanup as permission to redesign the app
- apply style-amplifying commands before scope approval
- use a quality pass to override the packet or current product system

## Working Sentence

In brownfield work, use Impeccable to refine a faithful baseline, not to invent a new product.
