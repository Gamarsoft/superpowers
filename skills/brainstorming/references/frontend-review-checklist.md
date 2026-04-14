# Frontend Review Checklist

Use this as an additional blocking quality bar when a frontend direction packet exists.

## Blocking review categories

### 1. Input integrity

- Does the packet point back to the current spec, wireframes, and design-system source?
- If brownfield, is preserve-vs-redesign made explicit?
- If degraded mode was used, is that stated honestly?

### 2. Visual thesis and hierarchy

- Is the intended first impression clear?
- Are hierarchy, density, and trust cues explicit?
- Are anti-patterns or no-gos named?

### 3. Screen inventory and state coverage

- Are the key screens or screen families named?
- Are critical loading, empty, error, validation, and permission states covered where relevant?
- Is deferred visual work separated from committed direction?

### 4. Chosen directions for key screens

- Does each key screen explain why the chosen direction won?
- Are selected references linked or clearly named?
- Is there enough direction to build without guessing the basic layout or hierarchy?

### 5. Stitch source completeness _(when Stitch is used)_

- Does the packet include `stitch-sources.json`?
- Are retained screens mapped to `screenKey`, `projectId`, `screenId`, and full resource names?
- Are full-resolution screenshot mirrors linked?
- Are HTML mirrors or explicit gaps recorded honestly?
- Are embedded markdown previews clearly treated as previews rather than the primary machine-readable source?

### 6. Design system contract

- Are color, typography, spacing, and component reuse rules clear enough to preserve consistency?
- Is `.stitch/DESIGN.md` alignment or deviation made explicit when relevant?

### 7. Responsive, interaction, and accessibility rules

- Are viewport families or responsive expectations named?
- Are interaction and motion cues explicit where they matter?
- Are accessibility constraints strong enough to avoid obvious regressions?

### 8. Implementation contract

- Are **Must preserve**, **May adapt**, and **Explicit no-gos** clearly separated?
- Could a frontend agent tell where it has freedom and where it does not?

### 9. Cross-artifact alignment

- Does the frontend packet match the main spec's scope and behavior?
- Does the GSD handoff treat deferred visual ideas as deferred rather than active requirements?
- Are there contradictions across spec, packet, and handoff?

### 10. Verification readiness

- Are required viewports and screenshot checks named?
- Are the references strong enough to support visual verification during implementation?
- If Stitch was used, can a later agent recover the exact selected screens without guessing?

## Advisory checks

- Could the packet be shorter while preserving the same decision value?
- Are there too many variants and not enough explanation?
- Would one additional screenshot or annotation materially reduce ambiguity?
