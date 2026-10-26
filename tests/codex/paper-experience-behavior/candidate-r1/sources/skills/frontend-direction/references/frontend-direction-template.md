# Frontend Direction Packet Template

Default: `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/packet.md`.
Historical packets remain reference material at their original paths. New delivery uses this version-2 implementation contract; link requirements and evidence rather than duplicating them.

```markdown
<!-- frontend-packet: 2 -->
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
- Experience brief (both entry routes): [user, frequency/familiarity; job/decisions; essential/secondary/contextual/disclosed information; feedback for judging results; interaction, density, vocabulary and visual character; reuse settled facts and identify experience-changing gaps]
- Business/technical invariants:
- Inherited presentation/implementation choices and any business-rule friction requiring a separate decision:
- Retained brand/shell:
- Consequential design rationale: [observed problem or hypothesis, task, supported data meaning/scope, chosen change and tradeoff, evidence/result; link existing decisions instead of duplicating]
- Approved feature design delta:
- Explicit no-gos:

## Exact visual targets
| ID/version | File/artifact | State/viewport | Intent | Binding scope | Approval evidence | Supersedes |
| --- | --- | --- | --- | --- | --- | --- |
| [final desktop-v3] | [path] | [state/size] | visual-truth | [feature layout] | [human decision] | [concept B-v2] |

- Design source medium and reason: [paper | runtime | references-only; decision and scope]
- Selected direction and refinement: [exact files/versions; rough structural comparisons when composition was unresolved, or settled-pattern/direct-path reason; ease, clarity, visual quality, product fit and tradeoff; scoped refinement]
- Design source revision and manifest: [matching revision; design/manifest.json]
- Source provenance: [local record; Paper file/page/nodes or runtime source identity]
- Paper snapshot when selected: [extracted structure, computed styles, frozen resolved tokens, assets, exact approved copy/state mapping, component/source mappings]
- References-only scope when selected: [actual omission reason and human scope decision]
- Final desktop/narrow captures:
- Required runtime check IDs and results: [packet.json.runtime_evidence; retained failed/unavailable checks]
- Runtime records and recoverable code: [seven-field runtime handoff; source revision, dependencies, local source or verified immutable reference, retained dirty changes]
- Synthetic data and concrete state setup:
- Interaction, keyboard/focus and state checks actually exercised: [check IDs and source revision]
- Runtime check omission reason when none required: [specific scoped rationale]
- Feasibility and remaining production translation/integration:
- Actual-stack proof: [sensitive decision → component/token → observed result or required change; unavailable required check → exact explicitly accepted limitation]

## Review evidence
- Rendered quality verdict: [ready for human review | requires changes; exact revision, visible region/state → problem → task consequence → correction; unresolved limits; independent of packet validity]
- Visual approval: [person, decision, exact version and scope]
- Functional verification: [who exercised which tasks/states on which version; actual results]
- Human task observation: [task, person/role, expected outcome, observed outcome/confusion, correction or remaining hypothesis; not observed if unavailable]

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

Use [scoped authority](design-source-priority.md) for `visual-truth`, `semantic-guidance`, and `reference-only`. Approval covers the listed intent/scope; prior selection does not approve later versions. Required failed checks block. Unavailable required checks retain their IDs and local records and need the exact accepted degraded scope. Historical approval does not authorize a new delivery; establish current v2 evidence and approval without changing historical bytes.

Finalize with the [schema and helper](packet-schema.md) using the [finalization recipe](packet-finalization.md). Keep the descriptor SHA-256 outside this payload in the handoff so the inventory has no circular hash dependency.
