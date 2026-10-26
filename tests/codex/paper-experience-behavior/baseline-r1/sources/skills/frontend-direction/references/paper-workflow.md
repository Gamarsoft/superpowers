# Paper composition and recoverable handoff

Load this reference when Paper is the chosen authoring medium. Frontend-direction owns the design loop; Paper supplies editable composition. Use [visual exploration](visual-exploration.md) to choose the medium and [library upkeep](paper-library.md) to bound maintained coverage.

## Establish the baseline

Read the brief, current app and relevant source/tokens, affected library entries and applicable v2 approvals. Use [task-to-layout](task-to-layout.md) and the relevant substantive [design knowledge](design-knowledge-selection.md) before composing. Name the next user decision, supported facts and their meaning/source/scope, proposed grouping or action placement, benefit and cost. A plausible fixture cannot invent business semantics.

Load the installed Paper guide and tool schemas. Inspect `get_basic_info`, selection, affected tree/nodes, tokens and fonts before editing. Use explicit file/page identifiers where supported and verify returned file identity. Read current token values with `get_tokens`; a changed token content hash means reread tokens. That hash identifies token state, not the complete artwork. Check the installed font information before first typographic edits.

Follow the guide's canvas and tool restrictions while preserving product requirements, anchors, copy, accessibility and the installed component system. Aesthetic suggestions are not authority to choose arbitrary palettes, asymmetric data rows, unreadable labels or new component APIs. Paper canvas restrictions do not prohibit semantic tables or the application's grid system in production.

If Paper is unavailable before requested design, report the missing capability and obtain an explicit available-medium decision. Continue independent app/source inspection meanwhile. An already approved local snapshot remains consumable offline without reconnecting to Paper.

## Compose and critique

Start with one recommendation using actual content and retained shell. Add a comparison only for a consequential unresolved tradeoff or explicit user request. Keep task, fixtures, widths and content equal. Use the smallest useful foundation and affected components; do not backfill a product catalog.

Preserve a checkpoint before changing maintained artwork. Read current affected nodes and source again when edits may have changed. Apply small targeted mutations; preserve manual organization and unaffected regions. Clone only to retain an approved baseline or useful comparison. Chat is the primary feedback channel. Direct canvas edits also count as evidence; compare concurrent code/canvas changes to their shared baseline before reconciling. Narrow annotations reopen only their affected choice.

Use screenshots after meaningful changes for critique, not as substitutes for source extraction. Apply the [frontend review checklist](frontend-review-checklist.md): hierarchy, grouping, useful density, typography, spacing, alignment, contrast, action clarity, feedback/recovery, copy and accessibility. Test long content and actual relevant container widths. A scaled screenshot cannot establish reflow. Record observed defect, task impact and correction; fix consequential defects before approval. Complete the tool's node-working lifecycle when done.

## Resolve runtime risks

Before binding approval, use the smallest actual-component slice for interaction-dependent or component-sensitive visual decisions. Examples include dense tables beside detail panels, long validation messages, overlays, focus movement and narrow containers. A known unchanged component within verified constraints needs no new experiment just because Paper was used.

Record each risk, actual installed component/token, observed result, evidence identity and remaining limitation. Keep the slice reusable in implementation where practical and isolate it from live writes. Synthetic state proves only its recorded scope. Required missing proof leaves the affected decision provisional unless the human explicitly accepts that degraded scope. Failed required checks remain failures; do not relabel them as unavailable or drop them. A standalone prototype is an explicitly scoped fallback when the real toolchain is unavailable, not a second full composition stage.

## Freeze the selected design

Use the exact [version-2 schema](packet-schema.md) and [finalization recipe](packet-finalization.md). A complete snapshot record names all three evidence groups below, whether proposing an export, freezing it or recovering a damaged handoff. Use the existing v2 fields; these are not additional descriptor fields.

| Existing packet location | Required retained evidence |
| --- | --- |
| `targets` and `references/` | Captures of the selected design, each bound to target intent, state, viewport, exact source version and supersession. |
| `design_source.manifest` and its inventoried files | Source provenance with Paper file/page/node locators, captured revision and extraction method; direct structure, computed styles, frozen resolved token values, usable assets, exact approved copy/state mapping and actual application component/source mappings. |
| `runtime_evidence` and its inventoried records | Separate required-check results, recoverable code, dependency setup, retained dirty changes and all seven [runtime handoff fields](../../implementing-frontend-design/references/runtime-handoff.md), or the schema's substantive scoped not-required reason. |

Retain captures alongside the direct extraction as one coherent approved revision. Inventory and hash the actual capture files as well as every extraction and runtime binding file. Captures provide visual comparison evidence; direct extraction supplies structure and values; actual-app records establish only the behavior exercised. Missing required evidence remains pending under the existing finalization rules.

Use `get_jsx`, `get_computed_styles`, token inspection and available asset/export tools rather than reconstructing code from screenshots. Check the installed schema: `get_fill_image` may return a resized inspection image and an original locator; an inspection rendition alone is not necessarily the required production asset. Retain the required usable assets locally. Missing required extraction or asset evidence stays pending; do not claim native editable-file restoration. Extracted JSX explains structure; translate it into the project's framework and conventions rather than replacing Angular or copying a generated div tree.

The manifest under `design/` binds provenance and every extraction/asset path. `resolved_tokens` contains frozen values, not just token names or live bindings. Inventory and hash the actual local payload. A mutable Paper URL, token hash or live duplicate cannot identify the complete approved snapshot. Register additional binding files through the schema's defined paths or `supporting_files`; external locators never exempt local files from containment/inventory checks.

Converge through the existing final design approval. Concept selection is not final approval; no separate canvas/library/packet approvals are needed for the same decision. Keep visual approval, agent checks and human task outcomes separate, with unobserved human use stated honestly. Hand off the exact entry, revision, descriptor SHA-256, human approval reference, status and accepted limits unchanged. Hash validity does not certify approval, runtime execution or design quality.
