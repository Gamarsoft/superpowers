# Frontend Packet Completeness Checklist

Use this as a blocking checklist before handing the packet to GSD or Codex implementation.

## 1. Packet summary and source truth

- Does the packet name the linked spec and handoff?
- Does it declare brownfield preserve vs redesign?
- Does it declare the design source order?
- Does it declare the implementation visual-truth source: `chatgpt-image-2`, `pencil`, or `current-ui/degraded`?
- Is degraded mode called out honestly when relevant?

## 2. Exact frontend references

- Are `brownfield-ui-extraction.md` and `screen-index.md` present when required?
- Is `pencil-workset.md` present only when Pencil is the selected visual-truth source?
- If ChatGPT Images 2 references were requested or needed, is `chatgpt-image-2/` present with prompts, attachment map, and approved generated images saved beside matching prompt files?
- If ChatGPT Images 2 references were used, did the human confirm generation, approve selected images, and choose whether they are image-only visual truth or Pencil inputs?
- If ChatGPT Images 2 is the selected visual-truth source, are the exact approved generated image files listed for each key screen/state, and is Pencil explicitly omitted?
- If Pencil is the selected visual-truth source, are the exact `.pen` files listed?
- If Pencil is the selected visual-truth source, are board/frame names listed for the key screens?
- Are board/image/screenshot intent modes listed and approved?
- Are ambiguous or pending visual-reference intent items marked as blockers or degraded-mode constraints?
- Are retained screenshots or browser captures linked?

## 3. Pencil skills and adapter

- Does the packet say which Pencil skills were used during packet creation only when Pencil was selected?
- Does it say which Pencil skills downstream agents should load only when Pencil was selected?
- If ChatGPT Images 2 is the selected visual-truth source, does the packet say not to load Pencil skills or adapters for visual consumption?
- Is the target adapter explicit when Pencil is selected?
- Does it explicitly say what framework assumptions should **not** leak in?

## 4. Brownfield extraction integrity

- Is current product truth clearly represented?
- Are must-preserve patterns explicit?
- Are safe improvements bounded?
- Are no-go redesign moves explicit?

## 5. Screen and state coverage

- Are the key screens named?
- Are loading, empty, error, validation, permission, and destructive states covered where relevant?
- Are deferred design areas clearly marked as deferred?

## 6. Chosen directions

- Does each important screen explain why the chosen direction won?
- Are alternative ideas either rejected or bounded?
- Does each important screen say whether its board, image, or screenshot is visual truth, semantic guidance, or reference-only?
- Could another agent build the layout and hierarchy without guessing?

## 7. Responsive and accessibility contract

- Are required viewports named?
- Are mobile adaptation rules explicit where density is high?
- Are accessibility-sensitive controls, labels, focus handling, and truncation rules covered?

## 8. Implementation contract

- Are **Must preserve**, **May adapt**, and **Explicit no-gos** clearly separated?
- Is the component/system reuse strategy clear?
- Are risky implementation areas called out?

## 9. HTML companion translation discipline

- If the HTML visual companion was not used, does the packet still stay fully usable?
- If HTML companion screens were used, is every retained idea translated back into the approved visual-truth source or packet prose?
- Does the packet avoid treating raw HTML companion files as the durable implementation reference?

## 10. Handoff readiness

- Could GSD populate `## Frontend References` in `CONTEXT.md` from this packet alone?
- Could Codex or Copilot tell whether to use approved ChatGPT Images 2 references or Pencil boards as the visual truth?
- Could Codex or Copilot tell which image files, `.pen` files, screenshots, and skills to use?
- Could Codex or Copilot tell which images or boards require visual parity and which only demonstrate intent?
- Is there enough evidence to verify implementation on desktop and mobile?
