# Pencil Workset Template

Use this to plan the repo-local Pencil workset that will support the frontend direction packet when Pencil is the selected implementation visual-truth source.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/pencil-workset.md`

## Purpose

The workset exists so durable Pencil visual references live in the repo, not only in chat history or generated screenshots. Omit this workset when the human selects approved ChatGPT Images 2 references as the implementation visual truth.

## Recommended default repo structure

```text
design/
  pencil/
    _shared/
      00-foundations.pen
      10-shell.pen
      20-patterns.pen
    {slug}/
      30-{slug}.pen
```

## Authoring rules

- Prefer a few durable `.pen` files over many throwaway files.
- Recreate current reality first.
- Use variants only for real decisions.
- Keep the shared files genuinely reusable.
- State which adapter the workset is optimized for.
- State each board's implementation intent and approval status.
- If ChatGPT Images 2 references were requested or used, do not start this workset until approved generated images exist beside the prompt files and the human selects the `pencil` visual-truth path.
- If the human selects `chatgpt-image-2` as visual truth, do not create this file.

## Template

```markdown
# [Feature / Project Name] — Pencil Workset

## 1. Objective
- What this workset should clarify:
- What it should not try to redesign:

## 2. Skill Plan
- Core skill: `pencil-design-core`
- Adapter: `[pencil-design-angular-nebular | pencil-design-react-tailwind | other]`
- Pencil transport: `CLI interactive`
- Pre-Pencil image reference gate: not used | approved generated references available and Pencil selected
- ChatGPT Images 2 folder: `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/`
- Why this adapter fits:
- What downstream agents should assume:
- What downstream agents should not assume:

## 3. Files to Create or Refresh

| File | Purpose | Status | Skill pairing | Notes |
| --- | --- | --- | --- | --- |
| `design/pencil/_shared/00-foundations.pen` | variables, foundations, tokens | create / refresh / reuse | core + adapter | [...] |
| `design/pencil/_shared/10-shell.pen` | header, nav, layout shell | create / refresh / reuse | core + adapter | [...] |
| `design/pencil/_shared/20-patterns.pen` | cards, tables, forms, dialogs, patterns | create / refresh / reuse | core + adapter | [...] |
| `design/pencil/{slug}/30-{slug}.pen` | feature-specific screens and variants | create / refresh / reuse | core + adapter | [...] |

## 4. Variables and Foundations to Capture
- Colors:
- Typography:
- Spacing:
- Radius / border:
- Surface roles:
- Shadows / separators:
- State colors:
- Responsive breakpoints if needed:

## 5. Patterns to Recreate from the Current Product
- [shell-first page]
- [config card with fixed footer]
- [dense table + filters]
- [mobile adaptation baseline]
- [other pattern]

## 6. Boards / Frames to Maintain

Intent modes:
- `visual-truth`: binding visual treatment; verify parity during implementation.
- `semantic-guidance`: binding behavior, workflow, content priority, or state coverage; adapt visuals to the product system.
- `reference-only`: inspiration or comparison aid; not an acceptance target.

| Board / frame | File | Intent mode | Approval status | Binding details | Non-binding details | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| Baseline current-state board | `design/pencil/{slug}/30-{slug}.pen` | visual-truth / semantic-guidance / reference-only | approved / pending | [...] | [...] | [...] |
| Chosen-direction board | `design/pencil/{slug}/30-{slug}.pen` | visual-truth / semantic-guidance / reference-only | approved / pending | [...] | [...] | [...] |
| Comparison board(s) | `design/pencil/{slug}/30-{slug}.pen` | reference-only | approved / pending | [...] | [...] | [...] |
| State coverage board | `design/pencil/{slug}/30-{slug}.pen` | visual-truth / semantic-guidance | approved / pending | [...] | [...] | [...] |
| Responsive board | `design/pencil/{slug}/30-{slug}.pen` | visual-truth / semantic-guidance | approved / pending | [...] | [...] | [...] |

## 7. Decision Axes to Explore
- [mobile density]
- [settings grouping]
- [header actions]
- [error state clarity]

For each axis:
- baseline
- variant A
- variant B
- why the chosen direction wins

## 8. Prompting Rules for Agents
- Recreate first, then vary.
- Preserve brownfield shell and component language.
- Use the correct adapter.
- Use Pencil CLI interactive mode for downstream GSD work. Do not use Pencil MCP.
- Do not default to React/Tailwind output unless that is the actual target stack.
- Prefer implementation-usable structure over ornamental polish.

## 9. Expected Deliverables from the Workset
- Screenshots for the packet
- Chosen boards / frames
- Notes on what must preserve vs may adapt
- Exact board/frame references for implementation
- Board intent modes and approval status for each implementation reference
- Any unresolved question that still needs human review
```

## Quality bar

A strong Pencil workset:
- is version-control friendly
- has a small number of durable files
- preserves the current system before changing it
- records the right core skill plus adapter
- makes comparisons easy for humans and agents
- is concrete enough that Copilot or Codex can implement from it without guessing
- prevents implementation agents from guessing whether a board is visual truth or semantic guidance
