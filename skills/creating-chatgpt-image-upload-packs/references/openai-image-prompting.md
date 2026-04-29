# OpenAI Image Prompting Guidance

Use this as the local fallback/checklist after trying to consult current OpenAI docs.

Official sources:

- https://developers.openai.com/cookbook/examples/multimodal/image-gen-models-prompting-guide
- https://developers.openai.com/api/docs/guides/image-generation

## Rules To Apply

| Need | Prompting rule |
| --- | --- |
| Set the right mode | State the deliverable: "high-fidelity UI mockup", "realistic product screenshot", "front-facing flat view". |
| Keep prompts controllable | Use labeled sections and a stable order: reference handling, goal, output style, structure, content, visual direction, constraints. |
| Use screenshots well | Number or name each reference image and define its role. Example: "Image A: shell and density reference only". |
| Prevent drift | Explicitly list what to preserve and what to avoid. Repeat invariants in follow-up edit prompts. |
| Improve UI text | Put literal UI text in quotes. Use high quality for dense UI text, tables, infographics, and detailed panels. |
| Improve realism | Ask for a realistic product UI screenshot, crisp typography, clean alignment, subtle borders, compact spacing, and no device frame. |
| Reduce vague output | Provide representative values, row labels, statuses, dates, and table columns. |
| Iterate safely | Prefer one screen/state prompt first; later edits should ask for one change and restate invariants. |

## GPT Image 2 Notes

- Use `gpt-image-2` for new prompt packs unless the user specifies another model.
- Prefer high quality for final reference images with dense UI text.
- Use landscape for desktop UI references and portrait for mobile references.
- Reference-image workflows can cost more because image inputs are processed at high fidelity.
- Do not request transparent backgrounds for `gpt-image-2`.

## UI Prompt Defaults

Use these phrases when they match the product:

- "realistic product UI screenshot"
- "front-facing flat view"
- "no perspective distortion"
- "no device frame"
- "no browser chrome"
- "crisp, legible UI text"
- "dense but readable enterprise admin UI"
- "subtle borders, light surface separation, minimal shadows"

## Follow-Up Edit Template

```text
Revise the previous image with one change: {change}.

Preserve: product shell, sidebar, header, spacing density, typography feel, screen state, and all approved content hierarchy.
Do not add: marketing visuals, unrelated navigation, device frame, perspective view, extra charts, or new product features.
```

