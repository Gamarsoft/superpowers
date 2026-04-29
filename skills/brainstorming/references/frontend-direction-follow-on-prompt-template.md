# Frontend Direction Follow-On Prompt Template

Use this when brainstorming determines that UI/UX materially shapes implementation but the frontend-direction phase must run in a separate session.

The prompt is a handoff artifact. It should be short enough to paste into a fresh Codex session after manual compaction, but specific enough to prevent rediscovery.

## Template

```text
Use $superpowers:frontend-direction with $superpowers:pencil-design-core and the correct Pencil adapter for this target stack.

Goal:
Create the frontend direction packet and supporting artifacts for [feature / slug] from the already-approved brainstorming outputs.

Approved upstream artifacts:
- Design spec: [path]
- GSD handoff: [path]
- Existing frontend packet: none / [path if refreshing]

Target repo / product:
- Repo: [path]
- Stack: [Angular + Nebular / React + Tailwind / other / unknown]
- Likely adapter: [pencil-design-angular-nebular | pencil-design-react-tailwind | decide during frontend-direction]

Product and delivery context:
- Track: [greenfield | brownfield-major-feature | brownfield-small-feature | bugfix-regression | architecture-led-change]
- First delivery boundary: [summary]
- Primary flows: [summary]
- Key screens or screen families: [summary]
- Key states: [loading, empty, error, validation, permission, destructive, mobile, etc.]
- Must preserve: [shell, workflow, density, components, behavior]
- May adapt: [safe improvements]
- Explicit no-gos: [do not redesign / do not change navigation / etc.]

Visual companion carry-forward:
- [Summarize any visual companion decisions, selected options, rejected options, or screenshots.]
- Treat these as brainstorming decision context, not durable design truth.
- Translate any retained idea into packet prose, screenshots, and repo-local `.pen` files before implementation uses it.

Frontend-direction requirements:
- Capture brownfield runtime baseline first when current screen truth exists only in the app.
- Produce:
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend-direction.md`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/screen-index.md`
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/brownfield-ui-extraction.md` when brownfield
  - `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/pencil-workset.md`
  - retained screenshots under `docs/superpowers/specs/YYYY-MM-DD--[slug]--frontend/screenshots/`
  - repo-local Pencil files under `design/pencil/` when Pencil is available
- For every implementation-facing board, screenshot, or retained visual reference, record approved intent:
  - `visual-truth`
  - `semantic-guidance`
  - `reference-only`
- Ask me to approve any board-intent classification that affects implementation.
- Do not hand off to implementation until the frontend packet and board-intent modes are approved.
```

## Quality Bar

A strong follow-on prompt:

- links the approved spec and handoff
- carries product and flow decisions without copying the whole conversation
- preserves visual-companion decisions as context, not durable truth
- names the target repo, likely stack, and adapter candidate
- makes board-intent approval a required frontend-direction output
