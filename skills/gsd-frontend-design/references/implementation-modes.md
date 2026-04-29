# Implementation Modes

Decide the mode before editing code.

## 1. Preserve and codify _(default brownfield mode)_

Use when:

- no redesign is intended
- the task adds or edits UI inside the current product language
- the goal is consistency, extraction, or cleanup

Load:

- `gsd-frontend-design`
- `pencil-design-core` only if Pencil is the selected visual-truth source
- the correct stack adapter only for Pencil-backed implementation translation

Allowed:

- reuse existing shell and component patterns
- move hard-coded values toward shared tokens
- add missing states, accessibility, and error handling
- consolidate repeated layout patterns

Not allowed:

- new visual thesis
- new palette or typography family
- shell redesign
- speculative component replacement

## 2. Implement approved change

Use when:

- an approved packet and approved image or `.pen` file define a deliberate UI change

Allowed:

- implement the approved screen or pattern faithfully
- adapt details to the actual framework and component APIs
- preserve existing system rules where the packet is silent

Not allowed:

- expand the change beyond approved scope
- use the packet as an excuse to redesign unrelated screens

## 3. Normalize and harden

Use when:

- the task is mostly about drift reduction or implementation quality

Allowed:

- replace repeated local values with shared variables or tokens
- reduce brittle selectors when safe
- improve contrast, focus states, labels, and error states
- tighten spacing toward existing rhythm

Not allowed:

- aesthetic churn in the name of cleanup

## 4. Adapt an existing pattern

Use when:

- mobile, responsive, or dense-data behavior needs improvement
- desktop throughput must stay intact

Allowed:

- progressive disclosure on smaller viewports
- row-card or compressed-row adaptations
- reprioritized actions on narrow screens

Not allowed:

- removing critical operational information
- consumerizing a dense operator UI

## 5. Controlled divergence _(manual exploration only)_

Use when:

- the human explicitly asks for alternatives
- the packet intentionally retains exploratory artifacts

Allowed:

- produce a small number of bounded alternatives
- compare them against current system constraints
- converge back into the approved visual-truth source before production implementation

Not allowed:

- implement speculative exploration directly in production code
