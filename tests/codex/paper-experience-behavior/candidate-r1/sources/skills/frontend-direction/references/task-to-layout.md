# From the task to the layout

Use for substantial layout or interaction decisions before concept generation, then reuse the reasoning during prototype refinement. Record only decisions that materially affect the task in the packet's existing evidence section.

## Frame the experience

For follow-on and standalone work, put a short experience brief in the packet's existing evidence. Reuse the product spec and observed facts; distinguish unknowns from assumptions. Cover:

- Who uses this screen, how often, and with what familiarity.
- Their job, decisions and what they must understand to proceed.
- Essential information now; secondary, contextual or disclosed details.
- Feedback that lets them judge the result, beyond repeating entered values.
- Suitable interaction model, density, vocabulary and visual character.

Ask only about gaps that materially change those choices. Bring a recommendation and its tradeoff, rather than asking the human to invent a layout. Existing product answers need no repeated interview or separate sign-off.

Separate business invariants from inherited presentation and implementation choices. If a business rule creates significant experience friction, surface that rule and its cost for a separate explicit decision. Preserve it meanwhile; paragraphs of help text do not resolve the friction.

Ground visual choices in this product's actual content and audience. In brownfield admin software, use the established typography and spacing vocabulary deliberately, quiet competing emphasis, and remove decoration or repeated copy that serves no task. Subject-specific design does not require a hero, new fonts, motion or rebranding. Plain labels and action/result language should help the user decide; technical implementation terms belong in evidence, not interface copy.

## Establish the information model

Name the user's next decision, the facts needed to make it and what confirms the result. For each prominent value or state, establish its meaning, source and scope: a row, loaded page, filtered set, whole account or particular time period. Separate known product facts from design hypotheses.

A redesign can reposition and emphasize established information. A new subtotal, difference, reconciliation status or automatic filter needs a defined business meaning and supported data. If that is missing, carry it as an unresolved product question and design with the existing values meanwhile. A plausible-looking number in an image or fixture cannot settle the question. Preserve the same supported content across alternatives.

## Choose visual relationships from the task

| Task need | Design choice to compare | Cost to inspect |
| --- | --- | --- |
| Compare two facts repeatedly | Keep them visible together; align corresponding labels and values. | Narrower data space, scan distance, or lost context on small screens. |
| Read many records | Give rows a consistent rhythm; quiet repeated labels and decoration before removing data. | Whether grouping hides a field needed to interpret a row. |
| Find a next action | Place it near its target, distinguish it from secondary actions, explain unavailable states. | Whether emphasis suggests a capability or permission that does not exist. |
| Consult occasional details | Try disclosure or a secondary view for those details. | Extra retrieval steps; information needed for frequent comparisons stays accessible. |

Use the project's type, spacing and color vocabulary to express these relationships. Stronger hierarchy can come from reducing competing emphasis. Distinct concepts should change how the task is performed or information is related, with a named benefit and cost; changing palettes alone does not test those decisions.

## Connect the choice to evidence

For a consequential choice, record: observed problem or hypothesis → affected task and supported facts → proposed relationship and tradeoff → what the prototype established or must still test. Reference existing brief/state evidence rather than producing another report.

Example: operators compare an account total with individual paginated movements. A side rail can keep the existing account total visible alongside the ledger. It costs table width. Test long labels, short heights, paging and narrow reflow. The visible page is not the complete account: a new difference computed from that page would communicate a different, unapproved financial meaning.

A browser walkthrough can establish visibility, navigation, feedback and recovery. It cannot establish a measured productivity gain without user-task evidence. Keep that distinction when recommending and approving a direction.

This method is a focused local synthesis. For reviewed source identities, rejected prescriptions and licensing, see [source review](design-knowledge-sources.md). Optional installed Impeccable knowledge can inform a specific decision through the [existing integration](impeccable-brownfield-quality-layer.md); consultation does not invoke its workflow or establish runtime proof.
