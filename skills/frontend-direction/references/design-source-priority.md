# Scoped Design Authority

Canonical authority and reference-intent contract for direction and implementation.

| Source | Governs |
| --- | --- |
| Approved requirements or standalone brief; verified business behavior | Data, permissions, validation, task, scope and behavior. Resolve genuine conflicts with source behavior. |
| Explicit retained brand/shell and technical/accessibility constraints | Their stated scope, not every neighboring screen's composition. |
| Current approved design delta and exact v2 design source, runtime evidence and captures | Feature hierarchy, layout, density and interactions within the approved scope. These supersede older concepts only where recorded. |
| Existing UI, PRODUCT.md, DESIGN.md, tokens and components | Evidence of anchors, feasibility and unspecified conventions. An old layout does not veto an approved redesign. |
| Critique, audit, generated concepts and early companion sketches | Decision inputs until selected and approved; findings do not grant new scope. |

Reference intent belongs to a specific artifact version and scope:

- `visual-truth`: listed visual treatment binds; compare actual runtime with the exact reference.
- `semantic-guidance`: listed workflow, hierarchy, content priority or state behavior binds; visual treatment may adapt within retained anchors.
- `reference-only`: context or exploration, not acceptance criteria.

Legacy screenshots usually show baseline problems and retained anchors. State which regions are binding. New concepts begin `reference-only`. The final approved v2 target may supersede them; preserve that mapping so an implementer cannot choose a stale attractive image. Intent missing or approval pending is a real uncertainty, not permission to declare visual truth.

Historical packets and their original paths stay untouched as reference material only. They cannot supply a current implementation handoff. Version 1 must return exactly:

`Unsupported packet schema version 1. This workflow requires version 2; historical packets are reference material only.`

Missing or other unsupported versions fail closed. No compatibility branch, automatic conversion, migration or legacy approval fallback. Establish new v2 evidence and approval independently. For all media, temporary brainstorming companion sketches are decision context only; explicit image/mockup overrides become binding only through the approved v2 packet and their recorded scope.

Raster details never override approved copy, behavior or accessibility. Record a supported mismatch and proposed resolution when both sources cannot be honored. Degraded evidence requires explicit approval of its limits; it cannot bypass a required unresolved packet.
