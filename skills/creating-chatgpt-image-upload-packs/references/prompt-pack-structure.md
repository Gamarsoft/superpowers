# Prompt Pack Structure

Create a focused folder, not one mega document.

```text
chatgpt-image-2/
  README.md
  00-shared-image-context.md
  attachment-map.md
  01-{screen-id}-{baseline-state}.md
  02-{screen-id}-{child-state}.md
```

## README.md

Include:

- what to upload once: `PRODUCT.md`, `DESIGN.md`, shared context, baseline screenshots/captures, and relevant packet excerpts
- one-prompt-per-generation instruction
- suggested quality, aspect ratio, and viewport/device target
- screen-family map: parent prompt for each screen, child prompt IDs, child state names, and child prompts that inherit it
- parent + child attachment instructions for state variants
- image naming convention, including variant suffixes such as `--v2`
- approval reminder: generated images remain `reference-only` until the human promotes them to `visual-truth` or `semantic-guidance`
- packet handoff reminder: approved images must be listed in the frontend packet with file path, intent, approval status, and binding notes

Example screen-family map:

| Family | Parent prompt | Child state prompts | Notes |
| --- | --- | --- | --- |
| S1 Control Center | `01-s1-control-center-active.md` | `02-s1a-control-center-disabled.md` = disabled/not-enabled; `03-s1b-control-center-rollout.md` = rollout/backfill running; `04-s1c-control-center-unauthorized.md` = unauthorized/read-only | attach the parent prompt with every child prompt; split degraded, partial failure, retryable error, or completed reconciliation into separate child prompts when separately indexed |
| S2 Customer Profile Loyalty Panel | `05-s2-profile-loyalty-panel.md` | `06-s2a-profile-loyalty-empty.md`; `07-s2b-profile-loyalty-earning.md`; `08-s2c-profile-loyalty-permission.md` | preserve the customer profile shell and panel placement |

## 00-shared-image-context.md

Include:

- reference-image instructions and source priority
- product context, audience, and tone
- design-system summary: shell, density, typography, color roles, surfaces, controls, and spacing rhythm
- global scope and no-gos
- visible-copy rules and copy deck path, if any
- generated image status and approval reminder

## attachment-map.md

Use a table:

| Prompt | Parent prompt | Required screenshots | Optional screenshots | Why |
| --- | --- | --- | --- | --- |
| `01-s1-active.md` | none | `screenshots/00-shell.png` | `screenshots/03-statistics.png` | parent screen baseline |
| `02-s1-disabled.md` | `01-s1-active.md` | same as parent | none | child state; inherit layout and override disabled values |
| `03-s1-rollout.md` | `01-s1-active.md` | same as parent | `screenshots/05-operations-table.png` | child state; inherit layout and override rollout/backfill statuses, messages, and row values |
| `04-s1-unauthorized.md` | `01-s1-active.md` | same as parent | none | child state; inherit layout and override permission affordances without creating a full-page error |

Every attachment must have a role. Do not attach screenshots without saying what they should influence and what they must not influence.

## Parent Screen Prompt Files

Each parent prompt should include:

1. title
2. deliverable sentence
3. reference handling
4. goal
5. `Screen Family Reuse Contract`
6. child ID-to-state-name map
7. output style
8. detailed screen structure with concrete labels, values, rows, dates, and actions
9. typography and spacing with concrete values when known: font family, page padding, card padding, row height or table density, border radius, button height, section gaps, and max content width
10. visual direction
11. avoid list
12. final production-readiness sentence when useful

The parent prompt is the canonical layout source for its child state prompts.

## Child State Prompt Files

Each child state prompt should include:

1. title
2. sentence telling the user to attach this prompt with the parent prompt
3. reference handling that reuses the parent references
4. goal for the state
5. output style inherited from parent
6. `Inherit From {parent}` section
7. `State Changes Only` section organized by parent regions
8. `State Semantics` section when the state can be confused with another state, especially rollout/backfill/failure and permission states
9. state-specific example visible text
10. permission affordance rules when relevant: visible data, hidden actions, disabled actions, read-only copy, and allowed navigation
11. avoid list that blocks new layout, alternate section order, different component rhythm, unrelated copy changes, analytics-dashboard drift, and full-page error treatment

Child prompts should not recreate the parent as a full standalone screen. They preserve layout, shell, section order, density, typography feel, component choices, and copy tone from the parent. They should be as concrete as the parent about state-specific labels, values, messages, disabled/hidden actions, and row content.

Keep child prompts state-pure. Do not mix disabled/not-enabled copy with unauthorized/read-only copy, and do not mix running backfill with completed reconciliation unless the screen index explicitly asks for a combined state.

## Visible Text Quality

Before generation, run `writing-ux-copy` or use an approved copy deck for every visible string in the prompt:

- headings and subtitles
- CTAs and secondary actions
- warning, error, empty, pending, and permission messages
- confirmation dialog copy
- helper text and tooltips
- table column labels and status labels

Keep technical state descriptions in `State Semantics`. `Example Visible Text` should contain only production-quality UI text in the target locale, with correct accents, terminology, and i18n-safe variables.

## Completion Check

- README has upload order, screen-family map, naming convention, and approval reminder.
- Shared context explains source priority, reference roles, global no-gos, and copy source.
- Attachment map names parent prompt dependencies and screenshot roles.
- Parent prompts define reusable layout, screen structure, content, and visual constraints.
- Child prompts inherit from parents and change only the named state details.
- Approved generated images have a clear path back into the frontend packet.
