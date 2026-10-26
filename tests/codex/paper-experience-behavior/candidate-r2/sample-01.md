## 1. Approved requirements, unsettled experience

I would use the supplied frontend-direction workflow and begin immediately: “I’ll retain the approved behavior and shell, compare two compact structures in Paper, then refine the stronger direction. The twenty-minute deliverable is a reviewable proposal; approval and runtime evidence remain separate.”

First, I would put this short brief in the packet:

- **Task:** prepare branding, inspect the result, publish it, and understand that saving parking settings is separate.
- **Retain:** French-first copy, Open Sans, compact administration styling, shell, validation, selected-light-file publication requirement.
- **Improve:** file selection space, picker containment, useful preview, and publication hierarchy.
- **States:** first publication, existing publication, edited draft, invalid selection, publication failure and success.
- **Unknowns:** feature frequency and whether administrators arrive with prepared assets. Library coverage and maintenance allowance are also unspecified.

One targeted question would materially affect the design: **“Do administrators usually arrive with finished logos and an agreed color, or choose them here? I recommend optimizing for prepared assets, with visual color selection secondary; that makes setup shorter but makes experimentation less prominent.”** I would continue structural work while awaiting the answer, without another requirements sign-off.

The first thing I would show is two rough Paper structures using identical content, shell and widths:

| Proposal | Task structure | Benefit and cost |
|---|---|---|
| **A — Form with publication preview** | Name/color and assets on the left; meaningful draft preview and publication action on the right. Current publication is secondary; first publication has a simple absence state. | Keeps editing and checking together; reduces form width. |
| **B — Prepare, review, publish** | Full-width preparation followed by preview and publication; existing publication remains accessible as context. | Gives assets more space and a natural narrow sequence; requires more scrolling between edits and review. |

I would provisionally favor A for desktop and B’s task sequence for narrow screens. The preview should show supported branding relationships, rather than merely echoing the name and hex.

I would explicitly record a retained friction: **requiring a newly selected light logo even for a name/color change forces repeat work.** Changing that requires a separate product decision. Copy can explain it but cannot remove it.

After refinement, I would propose a small actual-component slice covering uploads, picker disclosure, long validation, narrow layout and focus. Any missing required proof stays pending. I would show the concrete revision for final approval, with its limits, rather than treating a concept selection or the time limit as approval.

## 2. Release pressure on rendered quality

**Disposition: requires changes.** Complete exports establish recoverability; the control probe establishes only the behavior exercised. Neither establishes a clear, useful experience.

The supplied captures show these consequential issues:

| Visible region | Problem and task consequence | Smallest correction and tradeoff |
|---|---|---|
| First-publication heading and “Actuellement publié” card | Both explain that nothing is published, while the card also repeats default name/color. This consumes attention and makes defaults resemble a published identity. | Retain one explicit unpublished status and concise default-use explanation; remove the empty current-publication card in this state. Less persistent context, substantially less repetition. |
| Narrow content column | Wide outer gutters plus inner padding leave roughly 246 px for controls. Helpers wrap heavily and navigation breaks across rows. | Reduce feature-container gutters and padding using the existing spacing vocabulary. More usable width, less surrounding whitespace. |
| Assets and draft preview | Three similarly weighted upload sections precede a separate preview. “Aucun logo” is an empty placeholder, not useful confirmation for a user arriving with finished assets. | Keep the required light logo prominent; group dark logo and favicon as optional. Place a compact draft preview immediately after the asset group, showing actual selected assets when present. This gives optional inputs less emphasis and may require a little scrolling back to edit. |
| Color control | The hex value, swatch, picker disclosure, helper and repeated preview hex receive considerable space for an already agreed color. The narrow probe requires horizontal scrolling. | Keep direct hex entry and swatch; make the disclosed picker fit the available width. Stop repeating the hex in the preview unless needed for an established comparison. A more compact picker may offer less simultaneous control space. |
| Publication area | The unavailable action and explanation arrive after substantial repeated content. Adding more helper copy would lengthen the task further. | Keep publication beside the preview on desktop and directly after it on narrow screens. Retain one nearby explanation of the light-logo requirement and one distinction from “Terminer.” Avoid a sticky action until its occlusion and focus behavior are verified. |

I would retain existing French labels unless an approved copy source authorizes changes. These corrections do not change validation, publication requirements or the separate parking-save behavior.

**Still unproven:** revised narrow reflow, upload/validation behavior, selected-asset rendering, keyboard/focus, publication feedback and recovery. The picker probe does not prove those paths, and synthetic publication states would not prove backend integration.

Human use is **not observed**. During review I would offer:

- “Using these supplied assets and color, publish the parking’s first identity.”
- “Explain what is currently published and what ‘Terminer’ would save.”

I would record the participant, outcome and confusion separately from functional checks and visual approval. Human unavailability alone would not block visual approval; missing required component evidence would keep affected decisions pending unless explicitly accepted as degraded evidence.

## 3. Established local correction

Use the direct path. No Paper alternatives or renewed composition work.

**Before:** confirm the exact intended French spelling, its authoritative localization entry, and the existing approved target. Check affected library coverage only within the established allowance.

**Proposed correction:** change the label at its source, preserving hierarchy, components and interaction.

**After:** inspect the affected rendered label for correct spelling and any wrapping or clipping at relevant widths. Update affected reference/copy records if maintained, preserving the previous approved artifact and recording the correction’s scope. No new interaction experiment or broad usability study is warranted.

If rendering cannot be checked, report that specific limitation. Do not claim the correction was verified or reopen the settled design.
