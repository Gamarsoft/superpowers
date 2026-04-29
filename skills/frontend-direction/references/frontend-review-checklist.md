# Frontend Review Checklist

Use this as an additional blocking quality bar when a frontend direction packet exists.

## Blocking review categories

### 1. Input integrity

- Does the packet point back to the current spec, wireframes, and design-system source?
- If brownfield, is preserve-vs-redesign made explicit?
- If degraded mode was used, is that stated honestly?

### 2. Design source integrity

- Does the packet follow the declared source priority instead of letting generated ideas silently dominate?
- Does the packet declare the implementation visual-truth source: approved ChatGPT Images 2 references, Pencil boards, or degraded current UI?
- Are current UI and code-pattern sources clearly represented where relevant?
- If HTML companion screens were used, were they translated back into the approved visual-truth source and packet prose rather than retained as the durable source of truth?

### 3. Brownfield extraction completeness

- Does the packet include `brownfield-ui-extraction.md` when brownfield work is in scope?
- Does that extraction clearly separate must-preserve, safe-to-improve, and no-go areas?
- Does the packet actually honor that extraction?

### 4. Visual thesis and hierarchy

- Is the intended first impression clear?
- Are hierarchy, density, and trust cues explicit?
- Are anti-patterns or no-gos named?

### 5. Screen inventory and state coverage

- Are the key screens or screen families named?
- Are critical loading, empty, error, validation, and permission states covered where relevant?
- Is deferred visual work separated from committed direction?

### 6. Visual-truth reference completeness

- If ChatGPT Images 2 is selected, are approved generated image files named clearly for each key screen/state and is Pencil explicitly omitted?
- If Pencil is selected, does the packet include `pencil-workset.md` and clearly name the key `.pen` files?
- Could another agent tell which image or board/frame is the durable reference for each key screen?
- Is each image, board/frame, or screenshot classified as `visual-truth`, `semantic-guidance`, or `reference-only`?
- Are implementation-affecting visual-reference intent classifications approved by the human?
- Is the selected reference set small, stable, and implementation-usable rather than a vague “we used images/Pencil” note?

### 7. Skills and adapter integrity

- Does the packet name the exact Pencil skills to load downstream only when Pencil is selected?
- If ChatGPT Images 2 is selected, does the packet say not to load Pencil skills or adapters for visual consumption?
- Is the chosen adapter correct for the target stack when Pencil is selected?
- Does the packet explicitly block the wrong framework assumptions when needed?

### 8. Chosen directions for key screens

- Does each key screen explain why the chosen direction won?
- Are selected references linked or clearly named?
- Does each selected reference state what is binding and what is non-binding?
- Is there enough direction to build without guessing the basic layout or hierarchy?

### 9. Design system contract

- Are color, typography, spacing, and component reuse rules clear enough to preserve consistency?
- Are deviations from the existing system explicit and justified?

### 10. Responsive, interaction, and accessibility rules

- Are viewport families or responsive expectations named?
- Are interaction and motion cues explicit where they matter?
- Are accessibility constraints strong enough to avoid obvious regressions?

### 11. Implementation contract

- Are **Must preserve**, **May adapt**, and **Explicit no-gos** clearly separated?
- Could a frontend agent tell where it has freedom and where it does not?
- Are framework/component constraints explicit when the codebase is not greenfield?

### 12. Cross-artifact alignment

- Does the frontend packet match the main spec's scope and behavior?
- Does the GSD handoff treat deferred visual ideas as deferred rather than active requirements?
- Are there contradictions across spec, packet, and handoff?

### 13. Verification readiness

- Are required viewports and screenshot checks named?
- Are visual-truth parity checks separated from semantic-guidance intent-fit checks?
- Are reference-only images or boards excluded from acceptance unless explicitly promoted?
- Are the references strong enough to support visual verification during implementation?
- Can a later agent recover the chosen direction from the packet and repo without guessing?

## Advisory checks

- Could the packet be shorter while preserving the same decision value?
- Are there too many variants and not enough explanation?
- Would one additional screenshot or annotation materially reduce ambiguity?
