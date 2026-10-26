# Frontend Direction Follow-On Prompt Template

Use when brainstorming determines that UI/UX materially shapes implementation but the frontend-direction phase should run separately.

Keep the prompt short enough to paste into a fresh session.

```text
Use $superpowers:frontend-direction.

Goal:
Resolve substantial composition in Paper and behavior/feasibility risks in focused actual-component slices, then create a concise version-2 frontend direction packet and supporting evidence for [feature / slug] from the approved neutral spec and route-neutral brainstorming outputs.

Approved upstream artifacts:
- Approved neutral spec: [path]
- Follow-on context: [path or the settled context below]
- Existing frontend packet: none / [path if refreshing]
- Frontend packet status: required-pending | approved | approved-with-degraded-evidence
- Routing boundary: finish and approve the packet before returning to the delivery router; no route or adapter exists yet

Target repo / product:
- Repo: [path]
- Stack: [Angular / React / Flutter / other / unknown]

Product and delivery context:
- Track: [greenfield | brownfield-major-feature | brownfield-small-feature | bugfix-regression | architecture-led-change]
- First delivery boundary: [summary]
- Primary flows: [summary]
- Key screens or screen families: [summary]
- Key states: [loading, empty, error, validation, permission, destructive, mobile, etc.]
- Must preserve: [business/technical constraints and retained brand/shell, each with source and scope]
- May adapt: [feature hierarchy, layout, density, disclosure and interactions to reconsider]
- Explicit no-gos: [explicit limits such as unchanged app shell or business behavior]
- Library scope: [initial useful coverage and agreed maintenance allowance; affected entries only]
- UX writing: [copy deck path / inline decisions / missing states / terminology and i18n notes]

Visual companion carry-forward:
- [Summarize selected options, rejected options, screenshots, or comparison decisions.]
- Treat these as decision context, not durable implementation evidence.
- Capture retained ideas in approved v2 design source and scoped evidence before implementation uses them; temporary artifacts never become a parallel handoff.

Frontend-direction requirements:
- Capture brownfield runtime baseline first when current screen truth exists only in the app.
- Produce:
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/packet.md`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/packet.json`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/screen-index.md`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/brownfield-ui-extraction.md` when brownfield
  - current scoped captures under `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/references/`, with superseded evidence under `history/`
- For every implementation-facing screenshot, browser capture, generated image, or retained reference, record approved intent:
  - `visual-truth`
  - `semantic-guidance`
  - `reference-only`
- Use `writing-ux-copy` for visible UI text that affects the packet, screenshots, or image prompts.
- Choose by the unresolved decision: Paper for substantial composition; focused actual-app slices for interaction and component-sensitive feasibility; image assets or deliberate brand exploration when authorized. Start with one recommendation and add comparison only for consequential unresolved tradeoffs or explicit requests. Honor explicit medium/count choices; no routine generated UI screenshots, Companion screen composition or complete standalone recreation. Compare the same task and fixtures, refine the selected direction, and record actual-component proof and separate visual, functional and human-task evidence. Audit visible copy before authoring.
- Finalize new packets using frontend-direction’s canonical packet.md + packet.json contract, v2 design_source manifest/payload, separate runtime_evidence and preserved history. Run the bundled validation and return entry path, revision and descriptor SHA-256. Retain exact selected versions, design extraction and recoverable runtime source/launch/state setup, final captures, supersession and concrete final approval. Existing layout/density/components are not requirements merely because they exist.
- Reconcile affected library entries within allowance, preserving last verified identities for pending work. Do not block verified app delivery on housekeeping or treat missing evidence as verified.
- Do not route until the packet is approved. If evidence or implementation-affecting reference intent is degraded, record the constraint and obtain explicit approval inside the packet before routing or implementation.
```

## Quality Bar

A strong follow-on prompt links the approved neutral spec and route-neutral shaping context, carries only settled product decisions, names key screens/states, and states what evidence the frontend-direction packet must produce before routing.
