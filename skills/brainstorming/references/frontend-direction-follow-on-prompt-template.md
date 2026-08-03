# Frontend Direction Follow-On Prompt Template

Use when brainstorming determines that UI/UX materially shapes implementation but the frontend-direction phase should run separately.

Keep the prompt short enough to paste into a fresh session.

```text
Use $superpowers:frontend-direction.

Goal:
Create a concise frontend direction packet and supporting evidence for [feature / slug] from the approved neutral spec and route-neutral brainstorming outputs.

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
- Must preserve: [shell, workflow, density, components, behavior]
- May adapt: [safe improvements]
- Explicit no-gos: [do not redesign / do not change navigation / etc.]
- UX writing: [copy deck path / inline decisions / missing states / terminology and i18n notes]

Visual companion carry-forward:
- [Summarize selected options, rejected options, screenshots, or comparison decisions.]
- Treat these as decision context, not durable implementation evidence.
- Capture retained ideas in packet prose, screenshots, browser captures, or approved generated images before implementation uses them.

Frontend-direction requirements:
- Capture brownfield runtime baseline first when current screen truth exists only in the app.
- Produce:
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend-direction.md`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/screen-index.md`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/brownfield-ui-extraction.md` when brownfield
  - retained screenshots under `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/screenshots/` when useful
- For every implementation-facing screenshot, browser capture, generated image, or retained reference, record approved intent:
  - `visual-truth`
  - `semantic-guidance`
  - `reference-only`
- Use `writing-ux-copy` for visible UI text that affects the packet, screenshots, or image prompts.
- If ChatGPT Images 2 prompts are created, audit prompt-visible copy before generation and wait for human approval before treating generated images as references.
- Do not route until the packet is approved. If evidence or implementation-affecting reference intent is degraded, record the constraint and obtain explicit approval inside the packet before routing or implementation.
```

## Quality Bar

A strong follow-on prompt links the approved neutral spec and route-neutral shaping context, carries only settled product decisions, names key screens/states, and states what evidence the frontend-direction packet must produce before routing.
