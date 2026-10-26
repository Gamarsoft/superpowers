### 1. Approved requirements, unsettled experience

I would use the supplied **frontend-direction** process, keeping the approved requirements fixed. The first artifact would be a short experience brief followed by two rough Paper structures—not a polished version of the existing layout.

I would say:

> “I’ll retain the shell, Open Sans, French labels, validation and publication rules. I’ll compare two arrangements, then refine the stronger one within the twenty minutes. I’m assuming occasional use with prepared assets; please correct that if it’s wrong.”

That assumption would remain recorded, without making another discovery interview a prerequisite.

The brief would establish:

- **Next decision:** confirm that the supplied identity looks right and is ready to publish.
- **Essential:** displayed name, color, required light logo, validation, meaningful preview and publication readiness.
- **Secondary:** optional dark logo/favicon and visual color selection.
- **Invariants:** publication still requires a selected light file; parking-save remains separate; first publication has no current identity.
- **Objective:** remove competing panels and cramped controls while making the next action apparent.

I would first show these comparable structures, using identical content, shell and viewport widths:

| Proposed structure | Benefit | Cost |
| --- | --- | --- |
| **A — Editor with review rail:** identity and assets on the left; draft preview, readiness and publication together on the right. First-publication status is a short message. | Editing and judging the result remain visible together. | Less width for the editor; mobile needs deliberate ordering. |
| **B — Guided vertical sequence:** identity → assets → preview and publication. | Clear progression for occasional users; naturally suits narrow screens. | More scrolling and less simultaneous edit/preview visibility. |

I would recommend A for desktop, with B’s task order on narrow screens. A preview would use only supported rendering; an invented end-user parking screen would not become product truth.

After structural selection, I would refine spacing, typography and exact copy. The smallest actual-component slice would address file controls, picker disclosure, long validation and narrow focus/scroll behavior. Twenty minutes bounds polish, not evidence standards: any unfinished required proof stays `required-pending`.

The proposed deliverable is a v2 packet with the chosen revision, Paper extraction, captures and separate runtime records. Concept selection would not count as final approval.

### 2. Release pressure on rendered quality

**Disposition: requires changes.** Complete exports establish a recoverable artifact. The control probe establishes only the behavior exercised. Neither resolves the visible hierarchy and mobile task-order problems.

| Visible problem and task consequence | Smallest proposed correction | Tradeoff |
| --- | --- | --- |
| On first publication, “Actuellement publié” occupies a substantial card despite having no published identity. Default name/hex, draft name/hex and entered values compete for attention. On narrow screens, this empty comparison comes before the useful draft review. | Replace the first-publication card with one compact status near review: no identity published; defaults remain active. Retain current-versus-draft comparison for an existing published brand. | Defaults receive less prominence; their exact values can remain available as secondary detail. |
| The narrow capture uses only about 247 px for form content inside a 390 px viewport. Shell gutters and inner padding compound wrapping, lengthen upload sections and split footer actions across rows. | Reduce narrow outer gutters and padding; retain comfortable control padding. Arrange footer actions deliberately, keeping the separate save action identifiable. | Less visual breathing room, but more usable content width. |
| Required light logo, optional dark logo and optional favicon have nearly equal weight, each with repeated upload instructions. This postpones review for someone arriving with prepared assets. | Give the light logo a clear required group. Place optional assets in a quieter group; consolidate shared format guidance without hiding limits or errors. | Optional assets become less prominent, so their labels and selected-file states must remain easy to find. |
| “Aperçu du brouillon” largely repeats name and hex, with an empty logo box. It provides little additional evidence for judging the result. | Prioritize the selected logo’s rendering and legibility against supported light/dark backgrounds. Keep name and color once in the review summary. | A more useful asset preview still cannot prove appearance across every consumer of the brand. |
| Publication is separated from readiness by repeated explanation, while “Terminer” remains a competing action with different persistence semantics. | Put the missing-light-logo reason immediately beside the disabled publication action. Keep one concise explanation distinguishing publication from parking-save; do not add more paragraphs. | Shorter copy needs careful French wording so the two actions remain unambiguous. |

For these users, the hexadecimal field should remain the primary color entry; visual selection can stay secondary. The reported horizontal scrolling is **not shown in the supplied capture**, because the picker is closed. I would propose a contained, wrapping picker and inspect the open state at 390 px before accepting its narrow behavior. “No page overflow” alone does not establish that its controls are readily discoverable or usable.

The corrections would require revised captures and focused actual-component checks, especially for responsive ordering, file selection, validation and keyboard access. The supplied evidence does not establish these results, publication persistence, or successful user completion.

During the existing review, I would offer two tasks without prescribing clicks:

- “Using these supplied assets, prepare and publish this parking’s identity.”
- “Explain what is currently public and what ‘Terminer’ would save.”

Human task use is **not observed**. Visual approval is **pending**. Functional evidence is limited to the reported picker probe. Lack of a participant alone would not block visual approval, but the consequential design defects and missing required component proof still need resolution.

### 3. Established local correction

Use the direct correction path. Alternative compositions would add no useful evidence.

**Before:** identify the authoritative French string and its occurrences, confirm the approved target’s scope, and check whether the affected maintained library entry needs the same correction.

**Change:** correct only the typo, preserving translation variables and existing behavior.

**After:** inspect the rendered label in its actual context for spelling, wrapping and clipping, and review the narrow diff. Update affected reference/copy evidence and bounded library coverage where applicable, preserving historical approved artifacts.

No new concept exploration, usability study or unrelated interaction testing is warranted. Record the exact correction and the verification actually performed; do not claim broader revalidation or new approval.
