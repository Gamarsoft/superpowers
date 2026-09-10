# Frontend Direction Packet Template

Default: `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`.
Use existing approved packet paths when consuming historical evidence. Keep this an implementation contract; link requirements and evidence rather than duplicating them.

```markdown
# [Target] — Frontend Direction

## Brief and scope
- Entry: follow-on | standalone
- Approved spec and follow-on: [links when supplied; otherwise not applicable]
- Standalone brief: [target, task, problem, scope, behavior, constraints, anchors, objectives, states]
- Request scope: design only | implementation also authorized
- Packet status: not-required | required-pending | approved | approved-with-degraded-evidence
- UX copy source and locale:

## Evidence and decisions
- Current UI/source/docs; historical or missing evidence:
- Brownfield inspection: [link when applicable]
- Screen index: [link]
- Business/technical invariants:
- Retained brand/shell:
- Approved feature design delta:
- Explicit no-gos:

## Exact visual targets
| ID/version | File/artifact | State/viewport | Intent | Binding scope | Approval evidence | Supersedes |
| --- | --- | --- | --- | --- | --- | --- |
| [final desktop-v3] | [path] | [state/size] | visual-truth | [feature layout] | [human decision] | [concept B-v2] |

- Selected concept and refinement: [exact files/versions and selection evidence]
- Prototype source/version: [durable path or snapshot]
- Launch command and URL:
- Synthetic data and state setup:
- Final desktop/narrow captures:
- Interaction, keyboard/focus and state checks actually exercised:
- Prototype feasibility and remaining production translation/integration:

## Implementation and verification
- Must preserve / may adapt:
- Approved labels, CTAs, empty/error/helper copy; terminology/i18n variables:
- Responsive reflow and key interactions:
- Accessibility constraints:
- Required runtime comparisons and interaction checks:
- Known mismatches, evidence limitations and approved waivers:
- Final packet approval: [human, decision/date and exact target version; pending until given]
- Continuation: [invoking workflow or standalone scope]
```

Use [scoped authority](design-source-priority.md) for `visual-truth`, `semantic-guidance`, and `reference-only`. Approval covers the listed intent/scope; prior selection does not approve later versions. A legacy packet lacking prototype fields can remain valid under its existing approval; do not invent evidence or require regeneration merely to fit this template.
