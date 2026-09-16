# Reference-loading holdouts

## 1. Approved dialog; only error association is open

Keep the approved dense two-column desktop composition and the server-authoritative preview unchanged. Treat the request as a narrow defect/refinement, not a reason to restart concept exploration or reconsider client-side preview behavior. Inspect the approved packet's exact final revision and the rendered form/error state, then associate every field error with its control using the native label relationship plus a stable error ID referenced by `aria-describedby` (or the framework's equivalent). Mark invalid controls semantically, keep the message adjacent to the field, preserve entered values, and ensure a submission-level error summary, if the product already uses one, links/focuses to the affected controls. Test keyboard focus, screen-reader announcement, repeated submission, and multiple simultaneous errors against the approved target.

References needed: the approved packet and verified behavior are the binding sources; `design-source-priority.md` and the closing rule in `design-knowledge-selection.md` establish that only the requested unresolved refinement may be reopened. For the refinement itself, consult `design-everyday-things.md` — **Human Error / Design for Error** and, where server feedback is involved, **Feedback**. There is no need to load the hierarchy/layout sources, generate three new concepts, or consult optional Impeccable merely to preserve the already-approved layout.

## 2. New operator form; hierarchy and control/result mapping unresolved; no Impeccable

Yes, the workflow can proceed. Impeccable is explicitly optional. Build the standalone brief from project/runtime evidence, establish each value's meaning and scope, and use `task-to-layout.md` to map the operator's next decision, required evidence, controls, and server-confirmed result. Then use the bundled maintained knowledge before composing alternatives:

- `design-knowledge/refactoring-ui.md`, **Visual Hierarchy** and **Layout & Composition**, to decide what receives emphasis, what can be quieter, and which alignments/groupings make the scan path legible.
- `design-knowledge/design-everyday-things.md`, **The Two Gulfs**, **Signifiers**, **Mappings**, **Feedback**, and **Conceptual Models**, to keep controls near their effects, distinguish requested input from returned result, and make the authoritative outcome understandable.
- Add **Constraints** and **Human Error / Design for Error** when invalid combinations or recovery affect the form.

Apply those sections as decision inputs under the product's business semantics, retained shell, components, copy, and accessibility constraints. Their examples do not authorize invented data, a client-authoritative result, a new dependency, or a wizard. Continue through the normal visual alternatives, selected-prototype, exercised-state, and approval loop with the available built-in capabilities; report only any actually missing image/browser capability.

## 3. DashPark manual-adjustment dialog; installed optional knowledge

The target project contains Impeccable **version 4.3.1** at:

- `/Volumes/Workspace/Development/SolutionPark/DashPark/.agents/skills/impeccable/SKILL.md`

For this operator dialog, the directly relevant installed knowledge I consulted is:

- `/Volumes/Workspace/Development/SolutionPark/DashPark/.agents/skills/impeccable/reference/operate.md` — **The product slop test**, **Typography**, **Color**, **Layout**, **Components**, **Product constraints**, and **Product permissions**. It supports earned familiarity, restrained state semantics, consistent controls, full component states, and useful operator density.
- `/Volumes/Workspace/Development/SolutionPark/DashPark/.agents/skills/impeccable/reference/harden.md` — **Assess Hardening Needs**, **Error Handling**, **Input Validation & Sanitization**, **Accessibility Resilience**, and **Verify Hardening**. It supports inline field errors, specific recovery, preserved input, status-aware API handling, retry where real, semantic descriptions, and keyboard/screen-reader checks.
- `/Volumes/Workspace/Development/SolutionPark/DashPark/.agents/skills/impeccable/reference/clarify.md` — **Set the message hierarchy**, **Forms**, **Errors and permissions**, and **Verify**. It supports stating what failed, the known useful cause, and the available recovery without inventing a server explanation.

This was direct knowledge consultation only. No Impeccable context command, sub-command, launcher, detector, audit, or scoring workflow was run, so these sources provide design guidance rather than runtime evidence or a quality score.

## Sources read and limits

Maintained frontend-direction sources read: `SKILL.md`; `references/design-source-priority.md`; `references/design-knowledge-selection.md`; `references/task-to-layout.md`; `references/impeccable-brownfield-quality-layer.md`; `references/design-knowledge/refactoring-ui.md` (**Visual Hierarchy**, **Layout & Composition**); and `references/design-knowledge/design-everyday-things.md` (**Two Gulfs** through **Seven Stages of Action**). Installed DashPark sources read are the four absolute paths identified above.

These are bounded design answers. I did not inspect an actual approved packet or implementation for requests 1–2, and I did not inspect or exercise the DashPark dialog runtime for request 3. Therefore I make no claim about the current DOM associations, server behavior, accessibility conformance, visual quality, or implementation correctness.
