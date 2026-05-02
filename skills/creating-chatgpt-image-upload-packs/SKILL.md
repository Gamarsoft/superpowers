---
name: creating-chatgpt-image-upload-packs
description: Use when frontend-direction work needs ChatGPT Images 2 reference prompts or upload packs before implementation visual-truth selection, especially for brownfield UI packets with design specs, screen indexes, baseline screenshots, or visual-truth gaps.
---

# Creating ChatGPT Image Upload Packs

## Overview

Create image-native prompt packs that turn a frontend-direction packet into high-fidelity ChatGPT Images 2 reference requests. This skill runs before the frontend visual-truth decision: generated images are reference inputs until the human approves them and chooses whether they become the implementation visual truth or feed a later Pencil translation.

## Position In Frontend Direction

Run after these exist or are being drafted:

- design spec or approved feature brief
- frontend-direction draft or packet notes
- `screen-index.md`
- `brownfield-ui-extraction.md`
- repo screenshots in `design/baseline/`

Run before:

- `pencil-workset.md` when Pencil may still be selected
- shared Pencil foundations/shell/patterns when Pencil may still be selected
- feature `.pen` boards when Pencil may still be selected

**Gate:** Stop after writing the upload pack. The human must generate images externally, save approved images beside the prompts with matching filenames, and choose one visual-truth path:

- `chatgpt-image-2`: approved generated images are the implementation visual truth; omit Pencil artifacts.
- `pencil`: approved generated images are inputs for Pencil translation; create Pencil artifacts only after this choice.
- `regenerate-or-defer`: do not proceed to implementation visual truth yet.

Do not create or update Pencil artifacts unless the human selects the `pencil` path.

## Required References

Before authoring prompts, consult current OpenAI image guidance:

- `https://developers.openai.com/cookbook/examples/multimodal/image-gen-models-prompting-guide`
- `https://developers.openai.com/api/docs/guides/image-generation`

Use `openai-docs` / OpenAI docs MCP first when available. If current docs cannot be fetched, read `references/openai-image-prompting.md` and note that the local fallback was used.

Then read:

- `references/prompt-pack-structure.md`
- `references/example-ui-prompt.md` when writing the first prompt or when prompt quality feels thin

## Output Shape

Default folder:

```text
docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/chatgpt-image-2/
  README.md
  00-shared-image-context.md
  attachment-map.md
  01-{screen-id}-{state-or-goal}.md
  02-{screen-id}-{state-or-goal}.md
```

Generated images must later live in the same folder, using the prompt stem:

```text
01-s1-control-center-active.md
01-s1-control-center-active.png
```

For variants, use suffixes and record which one won:

```text
01-s1-control-center-active--v1.png
01-s1-control-center-active--v2.png
```

When the human selects `chatgpt-image-2` as the visual-truth source, the frontend-direction packet must list the exact approved image files as binding visual references. Pencil files are not created for that screen set.

## Required Workflow

1. **Inventory inputs**
   - Read the spec, frontend-direction packet, `screen-index.md`, and `brownfield-ui-extraction.md`.
   - List `design/baseline/*` screenshots and classify each by role: shell, layout, current screen, adjacent pattern, mobile, statistics, form, table.
   - If `PRODUCT.md` or `DESIGN.md` exists, use them for product/register and visual-system context.

2. **Apply OpenAI image prompting guidance**
   - Use the official docs to set model-aware defaults: high quality for dense UI text, explicit reference-image roles, labeled prompt sections, concrete literal text, and explicit preserve/avoid constraints.
   - Do not include API code in the upload pack unless the user asks for API execution.

3. **Build prompt coverage**
   - Use `screen-index.md` as the source of screen/state coverage.
   - Group related rows into screen families before writing prompts.
   - For each screen family, choose one canonical parent prompt for the baseline/default state.
   - Write an explicit screen-family map before prompts: parent prompt file, child prompt files, child IDs, child state names, and the parent invariants each child must preserve.
   - Write child state prompts for disabled, loading, empty, permission, pending, rollout, validation, and failure states as inheritance prompts that attach with the parent prompt and override only state-specific values, messages, statuses, affordances, and actions.
   - Prefer one prompt per screen/state row, but keep related state prompts dependent on their parent screen prompt instead of making them standalone redesigns.
   - Do not merge unrelated desktop, mobile, permission, and failure states into one prompt.
   - Do not merge distinct operational states into one prompt. Disabled/not-enabled, rollout/backfill, partial failure, completed reconciliation, and unauthorized/read-only states need separate prompts when they appear in `screen-index.md`.
   - For rollout/backfill/failure families, define state semantics before writing prompts: setup rollout, running backfill, partial failure, retryable error, completed reconciliation, and any known terminal state.
   - For permission states, define affordance rules before writing prompts: which actions disappear, which remain disabled, whether data remains visible, what banner/copy appears, and what must not become a full-page error.
   - Do not let state prompts change the parent layout, shell, section order, density, typography feel, component rhythm, or copy tone unless the state explicitly requires that structural change.

4. **Write shared context**
   - State the generated output is a realistic, front-facing, flat product UI screenshot.
   - Define reference-image roles: use baseline screenshots for shell/style/layout only; do not copy unrelated content.
   - Include product tone, design tokens, source priority, and global no-gos.

5. **Write parent and state prompts**
   - Use `writing-ux-copy` before finalizing any prompt that contains literal visible UI text.
   - Treat `Example Visible Text`, labels, CTAs, warning copy, error copy, empty states, confirmations, helper text, table labels, and permission messages as production UI copy, not rough prompt notes.
   - Keep internal semantics in `State Semantics`; keep visible text plain, localized, and operator-facing.
   - Parent screen prompts include: deliverable, reference handling, goal, `Screen Family Reuse Contract`, child ID-to-state-name mapping, output style, exact screen structure, representative UI content, visual direction, typography/spacing constraints, avoid list, and a final production-readiness sentence when useful.
   - Child state prompts include: parent prompt to attach, inheritance statement, goal, output style, `Inherit From {parent}` section, `State Changes Only` section, state semantics when applicable, state-specific example text, and avoid list.
   - Quote important literal UI text.
   - Include concrete table rows, values, status labels, and example dates when they help the image model avoid vague placeholders.
   - For dense admin screens, include enough literal values, row examples, and labels that the image model can render a believable product screenshot rather than generic placeholder UI.
   - Include concrete visual constraints when the source artifacts reveal them: font family, page padding, card padding, row height or density, border radius, button height, section gap, max content width, and table column rhythm.
   - Name the baseline screenshots to attach with parent prompts.
   - For child state prompts, name the parent prompt and any extra state-specific screenshot. Do not duplicate the full parent structure in a way that can drift.
   - Keep each child prompt focused on one state. If a disabled state mentions unauthorized behavior, split the unauthorized behavior into its own permission prompt instead.

6. **Write upload instructions**
   - `README.md` explains what to upload once, which parent prompt starts each screen family, and which parent prompt to attach with each child state prompt.
   - `attachment-map.md` lists each prompt file, required baseline screenshots, parent prompt dependency, optional screenshots, and why each image is attached.
   - Mark generated images as `reference-only` until approved and selected as the visual-truth path.
   - Tell the user to save generated images beside the prompt files using matching stems.

7. **Stop for human approval and visual-truth choice**
   - Ask the human to generate images externally and confirm approved references exist in the prompt folder.
   - Ask the human to choose whether approved references are `chatgpt-image-2` visual truth, `pencil` inputs, or need regeneration/deferment.
   - If `chatgpt-image-2` is chosen, update the frontend-direction packet to omit Pencil and tell GSD implementers to use only the approved generated image files as visual truth.
   - If `pencil` is chosen, `frontend-direction`, `pencil-design-core`, and the stack adapter may create or update Pencil artifacts from the approved references.

## Prompt Anatomy

Use this structure for a parent/default screen prompt:

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
- `{child-id-c}` = {state name}

For these child states, preserve:
- same product shell and navigation context
- same active navigation placement
- same page or panel header placement
- same summary/content region placement and order
- same card/table/form structure
- same spacing rhythm, typography feel, component choices, and copy tone

State prompts may change only state values, messages, row content, enabled/hidden actions, and warning/error emphasis. Do not redesign the screen for state variants.

## Output Style
- realistic product UI screenshot
- front-facing flat view
- no device frame
- crisp legible UI text

## Screen Structure
1. {shell/context}
   - ...
2. {header/panel title}
   - ...
3. {primary content group}
   - concrete labels, values, row examples, dates, and actions
4. {supporting content group}
   - concrete labels, values, row examples, dates, and actions

## Typography And Spacing
- ...

## Example Content
- ...

## Visual Direction
- ...

## Avoid
- ...
```

Use this structure for a child state prompt:

```markdown
# ChatGPT Images Prompt - {screen state}

Create a high-fidelity {desktop/mobile} UI mockup for {state}.

Attach this prompt together with `{parent-prompt-file}`. Reuse the parent screen design as the shared screen family and apply only the state changes below.

## Reference Handling
- Use the same reference handling as `{parent-prompt-file}`.
- Do not copy unrelated content.

## Goal
Render the same {parent screen} layout in the {state} state.

## Output Style
- Same output style, density, typography feel, and component rhythm as `{parent-prompt-file}`.

## Inherit From {parent screen}
Preserve from `{parent-prompt-file}`:
- shell, page/sidebar/header layout, and surrounding product context
- same active navigation and header/panel placement
- same section order, table/card/form positions, and column structure
- same spacing, typography, component choices, and copy tone
- same visual hierarchy unless this state explicitly changes priority

## State Changes Only
1. {region}
   - keep {parent invariant}
   - change {state-specific value/message/action}

## State Semantics
- {state-specific meaning, such as running backfill vs partial failure}
- {permission or affordance rule, if relevant}

## Example Visible Text
- ...

## Avoid
- no new layout
- no alternate section order
- no different component rhythm
- no unrelated copy changes
- no new marketing or dashboard language
```

## Quality Gate

Before calling the pack complete, verify:

- every `screen-index.md` P0 screen/state is covered or explicitly deferred
- every related state belongs to a named screen family with a canonical parent prompt
- every screen family maps child IDs to concrete state names before the prompts
- every child state prompt names its parent prompt and contains explicit inheritance plus `State Changes Only`
- README and `attachment-map.md` tell the user to attach parent + child prompts for state variants
- every prompt identifies reference-image roles and baseline screenshots to attach
- `attachment-map.md` maps prompt files to screenshot paths and attachment roles
- every prompt has concrete content, not only section names
- child prompts do not restate or alter parent layout, section order, density, typography, component rhythm, or copy tone except where the state explicitly requires it
- child prompts do not blend distinct states such as disabled/not-enabled, rollout/backfill, partial failure, and unauthorized/read-only
- rollout/backfill prompts distinguish setup rollout, running work, retryable failure, partial failure, and completed reconciliation when those states are in scope
- permission prompts state visible data, hidden/disabled actions, read-only messaging, and explicitly avoid full-page 403/error treatment unless the screen index asks for it
- prompts follow `references/openai-image-prompting.md` or fresher official OpenAI guidance
- prompt-visible UI text has been reviewed with `writing-ux-copy` or an equivalent copy deck
- prompt-visible UI text is in the final target locale, with correct accents, punctuation, and product terminology
- prompt-visible UI text does not expose backend service names, internal state names, or technical terms unless those are established product-facing terms
- prompt-visible UI text has i18n-safe variables and formatting notes when dates, counts, currencies, names, or statuses appear
- generated imagery is labelled `reference-only` until the human approves images and selects the visual-truth path
- the README explains both valid paths: image-only visual truth with Pencil omitted, or Pencil translation
- current baseline screenshots outrank unapproved generated images in brownfield work; approved visual-truth images bind only the intentional in-scope deltas
- the README contains the visual-truth choice gate and image filename convention
- no prompt asks for production code, a redesign, a marketing page, or implementation details

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Starting Pencil immediately after prompts | Stop until the human confirms approved generated images exist beside the prompts and selects the Pencil path. |
| Assuming images must always become Pencil boards | Ask for the visual-truth path; omit Pencil when the human chooses approved images as implementation visual truth. |
| One giant prompt for all screens | Split by screen/state or tightly coupled state family. |
| Standalone divergent state prompts | Create a screen-family parent prompt and make each state prompt inherit it, changing only state-specific values, messages, statuses, affordances, and actions. |
| Child prompts restating a full alternate layout | Replace with `Inherit From {parent}` and `State Changes Only` sections. |
| Uploading every screenshot blindly | Attach only screenshots with a stated role. |
| Letting generated images silently outrank runtime truth | Baseline screenshots remain higher authority until the human approves selected images and chooses their visual-truth role. |
| Writing spec prose instead of image instructions | Use render target, viewpoint, layout, sample content, and avoid list. |
| Letting rough or technical copy into generated images | Run `writing-ux-copy` first; quote only approved visible text in prompts. |
| Putting backend semantics in visible text | Keep semantics in `State Semantics`; show the operator-facing effect in visible UI copy. |
| Generating images yourself | Only author the upload pack unless the user explicitly asks for image generation. |
