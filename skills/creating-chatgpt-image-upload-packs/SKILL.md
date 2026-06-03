---
name: creating-chatgpt-image-upload-packs
description: Use when frontend-direction work needs ChatGPT Images 2 reference prompts or upload packs for UI exploration, especially from specs, screen indexes, current screenshots, or visual-truth gaps before implementation.
---

# Creating ChatGPT Image Upload Packs

Create image-native prompt packs for optional high-fidelity UI references. Generated images are references until a human approves them and assigns intent.

## Position In Frontend Direction

Run after these exist or are being drafted:

- design spec or approved feature brief
- frontend-direction draft or packet notes
- `screen-index.md`
- `brownfield-ui-extraction.md` for brownfield work
- current screenshots, browser captures, simulator/device captures, or neighboring-screen references

Stop after writing the upload pack. The human generates images externally, saves approved images beside matching prompts, and confirms which references matter. Do not treat generated images as implementation truth until the frontend packet lists the exact files, approval status, and intent.

## Required References

Before authoring prompts, consult current OpenAI image guidance:

- `https://developers.openai.com/cookbook/examples/multimodal/image-gen-models-prompting-guide`
- `https://developers.openai.com/api/docs/guides/image-generation`

Use OpenAI docs tooling first when available. If current docs cannot be fetched, read `references/openai-image-prompting.md` and note the local fallback.

Then read:

- `references/prompt-pack-structure.md`
- `references/example-ui-prompt.md` when writing the first prompt or when prompt quality feels thin

## Output Shape

```text
docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/
  README.md
  00-shared-image-context.md
  attachment-map.md
  01-{screen-id}-{state-or-goal}.md
  02-{screen-id}-{state-or-goal}.md
```

Generated images later live beside the prompt with the same stem:

```text
01-s1-control-center-active.md
01-s1-control-center-active.png
01-s1-control-center-active--v2.png
```

## Workflow

1. **Inventory inputs**
   - Read the spec, packet notes, `screen-index.md`, `brownfield-ui-extraction.md`, screenshots/captures, `PRODUCT.md`, `DESIGN.md`, and copy deck when present.
   - Classify each screenshot by role: shell, layout, current screen, adjacent pattern, mobile, form, table, statistics, empty/error state, or copy source.

2. **Apply image prompting guidance**
   - Use official OpenAI guidance for model-aware defaults: high quality for dense UI text, explicit reference-image roles, labeled prompt sections, literal visible text, and preserve/avoid constraints.
   - Do not include API code in the upload pack unless the user asks for API execution.

3. **Build coverage from `screen-index.md`**
   - Group rows into screen families before writing prompts.
   - Prefer one prompt per important screen/state row.
   - For each family, choose one canonical parent prompt for the default state.
   - Write a screen-family map before prompts: parent prompt file, child prompt files, child IDs, child state names, and parent invariants each child must preserve.
   - Write child state prompts for disabled, loading, empty, permission, pending, rollout, validation, failure, and success states as inheritance prompts that attach with the parent prompt.
   - Do not merge unrelated desktop, mobile, permission, failure, and rollout states into one prompt.
   - Rollout/backfill/failure prompts must distinguish setup rollout, running backfill, retryable error, partial failure, completed reconciliation, and known terminal states when those states are in scope.
   - Permission prompts must define visible data, hidden actions, disabled actions, read-only copy, allowed navigation, and whether the state must avoid full-page error treatment.

4. **Write shared context**
   - State the output should be a realistic, front-facing, flat product UI screenshot.
   - Define reference-image roles: use baseline screenshots for shell/style/layout only unless the packet says otherwise; do not copy unrelated content.
   - Include product tone, source priority, design constraints, global no-gos, and generated-image approval status.

5. **Write parent and child prompts**
   - Use `writing-ux-copy` before finalizing any prompt with visible UI text.
   - Keep internal meaning in `State Semantics`; keep visible text plain, localized, and operator-facing.
   - Parent prompts include: deliverable, reference handling, goal, `Screen Family Reuse Contract`, child ID-to-state-name map, output style, screen structure, concrete content, typography/spacing constraints, visual direction, and avoid list.
   - Child prompts include: parent prompt to attach, inheritance statement, goal, output style, `Inherit From {parent}`, `State Changes Only`, `State Semantics` when needed, state-specific example visible text, permission affordance rules when relevant, and avoid list.
   - Child prompts may change only state values, messages, row content, enabled/hidden actions, and warning/error emphasis. They must preserve parent layout, shell, section order, density, typography feel, component rhythm, and copy tone unless the state explicitly requires a structural change.
   - Quote important literal UI text. Include concrete table rows, values, status labels, dates, and action labels when they help avoid generic placeholder UI.

6. **Write upload instructions**
   - `README.md` explains what to upload once, which parent prompt starts each screen family, and which parent prompt to attach with each child state prompt.
   - `attachment-map.md` lists each prompt file, parent prompt dependency, required screenshots, optional screenshots, and why each file is attached.
   - Tell the user to generate one prompt at a time and save generated images beside prompt files using matching stems.

7. **Stop for human approval**
   - Ask the human to generate images externally and confirm approved files exist in the prompt folder.
   - Generated images start as `reference-only`; a human may promote them to `visual-truth` or `semantic-guidance`.
   - The frontend packet must list approved image files, intent, approval status, and binding details before implementation uses them.

## Prompt Anatomy

Parent/default screen prompt:

```markdown
# ChatGPT Images Prompt - {screen}

Create a high-fidelity {desktop/mobile} UI mockup for {product surface}.

## Reference Handling
- Use Image A/B/C only to match {shell/sidebar/header/density/component style}.
- Do not copy unrelated content.

## Goal
Render {screen purpose and user decision}.

## Screen Family Reuse Contract
This file is the canonical shared design for all {screen family} states.

Child state map:
- `{child-id-a}` = {state name}
- `{child-id-b}` = {state name}

For child states, preserve shell, navigation, header placement, section order, card/table/form structure, spacing rhythm, typography feel, component choices, and copy tone.

## Output Style
- realistic product UI screenshot
- front-facing flat view
- no device frame
- crisp legible UI text

## Screen Structure
1. {shell/context}
2. {header/panel title}
3. {primary content group with concrete labels, values, dates, and actions}
4. {supporting content group with concrete labels, values, dates, and actions}

## Typography And Spacing
- ...

## Example Content
- ...

## Visual Direction
- ...

## Avoid
- ...
```

Child state prompt:

```markdown
# ChatGPT Images Prompt - {screen state}

Attach this prompt together with `{parent-prompt-file}`. Reuse the parent screen design and apply only the state changes below.

## Reference Handling
- Use the same reference handling as `{parent-prompt-file}`.

## Goal
Render the same {parent screen} layout in the {state} state.

## Output Style
- Same output style, density, typography feel, and component rhythm as `{parent-prompt-file}`.

## Inherit From {parent screen}
Preserve shell, active navigation, header placement, section order, table/card/form positions, spacing, typography, component choices, copy tone, and visual hierarchy unless this state explicitly changes priority.

## State Changes Only
1. {region}
   - keep {parent invariant}
   - change {state-specific value/message/action}

## State Semantics
- {state-specific meaning}
- {permission or affordance rule, if relevant}

## Example Visible Text
- ...

## Avoid
- no new layout
- no alternate section order
- no different component rhythm
- no unrelated copy changes
- no full-page error treatment unless requested
```

## Approval Rules

- Generated images start as `reference-only`.
- A human may promote an image to `visual-truth` or `semantic-guidance`.
- Images with rough, technical, misspelled, unlocalized, or unapproved visible text cannot become visual truth.
- Runtime implementation must still verify approved references against the frontend packet.

## Quality Gate

Before calling the pack complete, verify:

- every P0 screen/state is covered or explicitly deferred
- every related state belongs to a named screen family with a canonical parent prompt
- every child state prompt names its parent prompt and contains explicit inheritance plus `State Changes Only`
- every child state has clear `State Semantics` when it could be confused with another state
- README and `attachment-map.md` explain parent + child attachment rules
- every prompt identifies reference-image roles and screenshots/captures to attach
- every prompt includes concrete content, not only section names
- prompt-visible copy was reviewed with `writing-ux-copy` or an approved copy deck
- child prompts do not drift parent layout, section order, density, typography, component rhythm, or copy tone
- distinct states such as disabled/not-enabled, rollout/backfill, partial failure, completed reconciliation, and unauthorized/read-only remain separate when separately indexed
- permission prompts name visible data, hidden actions, disabled actions, read-only messaging, and full-page error boundaries
