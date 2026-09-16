# Frontend Direction Packet Template

Default: `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/packet.md`.
Use existing approved packet paths when consuming historical evidence. Keep this an implementation contract; link requirements and evidence rather than duplicating them.

```markdown
<!-- frontend-packet: 1 -->
# [Target] — Frontend Direction

## Brief and scope
- Entry: follow-on | standalone
- Approved spec and follow-on: [links when supplied; otherwise not applicable]
- Standalone brief: [target, task, problem, scope, behavior, constraints, anchors, objectives, states]
- Request scope: design only | implementation also authorized
- Packet status: not-required | required-pending | approved | approved-with-degraded-evidence
- Revision and descriptor: [exact approved revision; packet.json]
- UX copy source and locale:

## Evidence and decisions
- Current UI/source/docs; historical or missing evidence:
- Brownfield inspection: [link when applicable]
- Screen index: [link]
- Business/technical invariants:
- Retained brand/shell:
- Consequential design rationale: [observed problem or hypothesis, task, supported data meaning/scope, chosen change and tradeoff, evidence/result; link existing decisions instead of duplicating]
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
- Affected routes/components and supported primitive mapping:
- Must preserve / may adapt:
- Approved labels, CTAs, empty/error/helper copy; terminology/i18n variables:
- Responsive reflow and key interactions:
- Accessibility constraints:
- Observable acceptance by important state: [screen-index.md]
- Required runtime comparisons and interaction checks:
- Known mismatches, evidence limitations and approved waivers:
- Final packet approval: [human, decision/date and exact target version; pending until given]
- Continuation: [invoking workflow or standalone scope]
- History/provenance: [relocation and supersession; never competing current targets]
```

Use [scoped authority](design-source-priority.md) for `visual-truth`, `semantic-guidance`, and `reference-only`. Approval covers the listed intent/scope; prior selection does not approve later versions. A legacy packet lacking prototype fields can remain valid under its existing approval; do not invent evidence or require regeneration merely to fit this template.

Finalize with the [schema and helper](packet-schema.md) using the [finalization recipe](packet-finalization.md). Keep the descriptor SHA-256 outside this payload in the handoff so the inventory has no circular hash dependency.
