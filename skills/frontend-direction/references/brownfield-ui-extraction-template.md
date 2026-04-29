# Brownfield UI Extraction Template

Use this before visual exploration in brownfield work.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/brownfield-ui-extraction.md`

## Why this exists

Brownfield frontend work fails when the agent starts by inventing.

This artifact forces the agent to:
- inspect the current UI
- name what is already strong
- name what is drifting
- separate safe improvement from accidental redesign

## Authoring rules

- Use current product truth, not aspirational design language.
- Preserve what already works before critiquing what does not.
- Distinguish **must preserve**, **should preserve**, and **safe to improve now**.
- Keep this focused on the current slice. Do not turn it into a full product redesign audit unless that is the actual task.

## Template

```markdown
# [Feature / Project Name] — Brownfield UI Extraction

## 1. Extraction Scope
- Feature or workflow in scope:
- Routes / screens reviewed:
- Code areas reviewed:
- Runtime screenshots reviewed:
- Existing docs / anchoring used:

## 2. Product Truth to Preserve
### Must preserve
- [shell / workflow / state / pattern]

### Should preserve
- [useful but adaptable pattern]

### Safe to improve now
- [specific pain point]

## 3. Foundations Already Present
- Color / theme source:
- Typography source:
- Spacing rhythm:
- Surface / elevation treatment:
- Existing variables / token files:
- Known drift from shared foundations:

## 4. Shared Patterns and Components
| Pattern / component | Where it exists today | Why it matters | Reuse call | Known issues |
| --- | --- | --- | --- | --- |
| [header] | [...] | [...] | preserve | [...] |
| [card layout] | [...] | [...] | preserve + normalize | [...] |
| [table + filters] | [...] | [...] | preserve + adapt mobile | [...] |

## 5. Screen Family Notes

### [Screen family]
- User goal:
- Current layout shape:
- Density / hierarchy notes:
- Primary actions:
- Important states:
- Mobile reality:
- What feels strong:
- What feels weak:

### [Screen family]
- ...

## 6. Drift and Debt Hotspots
- Theming drift:
- Duplicated layout logic:
- Fragile local overrides:
- Accessibility weak points:
- Error-state weaknesses:
- Responsive pain points:

## 7. Modernization Allowed in This Slice
- [improvement that is safe now]
- [improvement that is safe now]

## 8. Explicit No-Gos
- [redesign move that would overreach]
- [pattern break that would increase risk]

## 9. Inputs Required for Visual Truth
- Candidate visual-truth path: ChatGPT Images 2 | Pencil | current UI/degraded
- ChatGPT Images 2 prompts/images to create or approve:
- Shared `.pen` files to create or refresh if Pencil is selected:
- Feature `.pen` files to create or refresh if Pencil is selected:
- Screens to recreate first:
- Variants worth exploring:
- Screenshots to capture:
```

## Quality bar

A strong extraction artifact:
- captures what the current product already knows
- makes preserve-vs-change explicit
- identifies only the most relevant drift and pain points
- gives ChatGPT Images 2 prompts or Pencil boards a grounded starting point
- prevents accidental redesign
