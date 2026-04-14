# Stitch Prompt Pack Template

Use this file to prepare reusable prompts for Stitch or another design-generation workflow.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/stitch-prompt-pack.md`

## Authoring rules

- Keep prompts self-contained.
- One prompt block per key screen or screen family.
- Attach or reference screenshots, wireframes, and DESIGN.md sources when available.
- Ask for variants only on the decision axis that matters.
- Do not ask the tool to invent product requirements.
- After a direction is selected, capture machine-usable Stitch source metadata for the retained screens.

## Template

````markdown
# Stitch Prompt Pack

## 1. Project Context

- Feature / project:
- Primary user or operator:
- Job to be done:
- First delivery boundary:
- Brownfield preserve vs redesign call:

## 2. Required Sources

- Main spec:
- Frontend direction packet draft:
- Wireframes:
- Existing screenshots:
- `.stitch/DESIGN.md` or equivalent:

## 3. Global Constraints

- Must preserve:
- Tone / brand cues:
- Layout or density bias:
- Accessibility constraints:
- Avoid:

## 4. Key Screen Prompt Blocks

### Screen [ID] — [name]

**Goal**

- [what this screen must help the user do]

**Sources to attach**

- [wireframe / screenshot / DESIGN.md excerpt]

**Base prompt**

```text
[Self-contained prompt for Stitch]
```

**Variant axis**

- [what should differ across variants]

**Must preserve**

- [fixed constraints]

**Do not do**

- [anti-patterns]

**Expected output**

- [screenshot, html, variant set, notes]

### Screen [ID] — [name]

...

## 5. After Selection Capture

For each retained screen, capture:

- projectId
- screenId
- full resource name
- device type
- width × height
- local full-resolution screenshot mirror
- local HTML mirror when available
- local metadata mirror

## 6. Review Notes

- Current preferred variant:
- Why it is winning:
- Retained screen keys:
- Source capture status: pending | complete | degraded
- What still needs another pass:
````

## Prompt-writing hints

Prefer prompts that say:

- what the screen is for
- who it serves
- what must be visually dominant
- what current design system or screenshots it must align with
- which decision axis should vary
