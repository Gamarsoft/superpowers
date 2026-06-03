# Implementation Modes

Choose one mode before editing UI code.

## 1. Preserve And Codify

Default brownfield mode. Use when no redesign is intended and the task adds, extracts, or hardens UI inside the current product language.

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

## 2. Implement Approved Change

Use when an approved packet plus image, screenshot, or runtime capture defines a deliberate UI change.

Allowed:
- implement the approved screen or pattern faithfully
- adapt details to the actual framework and component APIs
- preserve existing system rules where the packet is silent

Not allowed:
- expand the change beyond approved scope
- use the packet as an excuse to redesign unrelated screens

## 3. Normalize And Harden

Use when the task is mostly drift reduction or implementation quality.

Allowed:
- replace repeated local values with shared variables or tokens
- reduce brittle selectors when safe
- improve contrast, focus states, labels, and error states
- tighten spacing toward existing rhythm

Not allowed:
- aesthetic churn in the name of cleanup

## 4. Adapt An Existing Pattern

Use when mobile, responsive, or dense-data behavior needs improvement while desktop throughput stays intact.

Allowed:
- progressive disclosure on smaller viewports
- row-card or compressed-row adaptations
- reprioritized actions on narrow screens

Not allowed:
- removing critical operational information
- consumerizing a dense operator UI

## 5. Controlled Divergence

Use only when the human explicitly asks for alternatives or the packet intentionally keeps exploration open. Ask whether a `frontend-direction` refresh is needed before implementing direction-setting changes.
