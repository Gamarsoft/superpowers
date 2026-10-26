You are a fresh read-only policy application actor. Use only the complete instructions and scenario below. Do not use tools, access files, spawn agents, or claim execution. Supply concrete proposed decisions and records for each independent checkpoint. Do not review or rewrite the instructions. No external instructions need loading for this exercise.

===== COMPLETE SOURCE: skills/frontend-direction/SKILL.md =====
---
name: frontend-direction
description: Use when a feature needs visual and interaction direction, or an existing screen needs substantial UX improvement, including standalone requests without a brainstorming spec.
---

# Frontend Direction

Produce a concrete design the human can inspect and use, then preserve the approved target for implementation. Record visual approval, functional checks and observed human use separately. In brownfield work, retain established brand and app shell while reconsidering the feature's hierarchy, layout, density, and interactions. Existing behavior is evidence; existing composition is not automatically a requirement.

## Choose the entry and scope

| Situation | Start here |
| --- | --- |
| Approved brainstorming spec and follow-on exist | Reuse their settled decisions and invoking workflow. |
| Standalone screen improvement | Inspect the named target and fill the small brief below. No separate spec, follow-on prompt, or full brainstorming pass is required. |
| New unresolved business rule or permission model | Resolve that specific product decision before dependent design; use fuller brainstorming when broader shaping is needed. |
| Current approved visual target exists | Consume it; reopen only the requested design decisions. |
| Mechanical edit with settled direction | Use the existing implementation workflow; skip concept exploration. |

**Standalone brief:** target and primary user task; problem; scope and required behavior; retained brand/shell and technical constraints; design objectives; important states; design-only or implementation too. Keep it inside the packet. Fill observable facts from inspection and ask only questions that change the design. Existing authorization is enough to begin; another brief sign-off is not a prerequisite.

Read [scoped design authority](references/design-source-priority.md) before choosing references.

## Design loop

Choose the exploration medium from the unresolved decision. Explicit user choices govern the scope; a known local defect or approved target does not need concept exploration.

1. **Inspect and set objectives.** Inspect current runtime, relevant source, design docs, and state evidence. Separate business constraints, retained anchors, and design problems using the [brownfield extraction](references/brownfield-ui-extraction-template.md). Reuse sufficient current evidence. For substantial design choices, use the [task-to-layout method](references/task-to-layout.md) to ground information meaning, comparison needs and visual priority before choosing a composition. For unresolved visual or interaction choices, [select and apply fuller design references](references/design-knowledge-selection.md) before composing alternatives. Optional [Impeccable assessment](references/impeccable-brownfield-quality-layer.md) can inform this inspection before an extraction document exists.
2. **Explore the decision in a suitable medium.** Read [visual exploration](references/visual-exploration.md). For hierarchy, density, comparison or disclosure, build one working recommendation with representative fixtures in the actual stack; add a second working alternative when a consequential tradeoff needs comparison. For a specific interaction, build a focused working prototype. For brand, imagery or visual atmosphere, use three distinct image concepts unless the user specifies another count. Hold content, viewport and constraints constant. Perfect one representative task before expanding to more screens.
3. **Select through task use.** Compare working alternatives on the same task before refining visual treatment. For image exploration, show stable concept IDs and task-related tradeoffs, record the exact selection, then build the interactive target. Incorporate scoped feedback and show material revisions. Selection approves further exploration, not production integration.
4. **Prove the target with actual components.** In an existing application, use an isolated route, component preview or worktree with installed primitives and synthetic state. When the toolchain obstructs exploration, standalone HTML/CSS/JS can establish a provisional direction; demonstrate the sensitive portions in the actual stack before treating them as `visual-truth`, or obtain explicit acceptance of the missing proof. A component-name mapping alone is insufficient. Open the requested [browser surface](references/browser-surface-selection.md) and exercise primary interactions, important states, long content, narrow layout and keyboard/focus behavior.
5. **Review, refine and preserve.** Correct observed problems and retain source, launch/state instructions and final captures. During the existing final review, offer one or two realistic tasks without prescribing their click path. Record who attempted them, the expected and observed outcome, confusion and remaining hypotheses. If no person can try the task, record that limit; human availability alone does not block visual approval. Keep visual approval, agent functional checks and observed usability distinct. Record supersession and ask for approval of the concrete final direction; selection, silence, or an iteration count is not final approval.
6. **Finalize and hand off.** Follow [packet finalization](references/packet-finalization.md): preserve the approved bytes, separate history, write the canonical `packet.md` and `packet.json`, and validate the current artifact set. Use the [packet template](references/frontend-direction-template.md), [folder layout](references/frontend-packet-folder-template.md) and [screen/state index](references/screen-index-template.md). Review actual quality and acceptance with the [quality checklist](references/frontend-review-checklist.md) and [completion checks](references/frontend-packet-completeness-checklist.md). Hand off the entry path, exact revision, descriptor SHA-256 and remaining limits. File validation establishes identity, not design quality or human approval.

## Boundaries and continuation

- This skill may write isolated prototypes. Production integration follows the approved direction and the user's implementation scope. Prototype actions stay local and synthetic.
- Missing capability for the selected medium: report what is unavailable and what remains unverified; use an explicitly authorized alternative. Image generation is unnecessary for a working-layout route. Do not substitute a prose packet for the requested visual loop or claim tools ran. Optional Product Design capabilities may help when installed; no plugin is required.
- Use `writing-ux-copy` or an approved copy source for visible text, including prompts. Generated text does not redefine application copy or business rules.
- Legacy approved images and packets remain readable with their recorded scope. No upload-pack authoring or external generation handoff is needed.
- Keep a required unresolved packet `required-pending`. `approved-with-degraded-evidence` needs explicit approval of the listed limitations. One approval of the concrete packet covers its listed reference intents; do not request duplicate classification approvals.
- Follow-on mode returns the approved packet to the invoking workflow. For brainstorming, return to its delivery router after approval. Standalone design-only work ends with the approved packet; an authorized implementation request continues through the appropriate implementation workflow without a mandatory route-selection ceremony.
- Approved reusable decisions may update design memory when in scope; one prototype does not authorize a global design-system rewrite.

===== END SOURCE: skills/frontend-direction/SKILL.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/design-source-priority.md =====
# Scoped Design Authority

Canonical authority and reference-intent contract for direction and implementation.

| Source | Governs |
| --- | --- |
| Approved requirements or standalone brief; verified business behavior | Data, permissions, validation, task, scope and behavior. Resolve genuine conflicts with source behavior. |
| Explicit retained brand/shell and technical/accessibility constraints | Their stated scope, not every neighboring screen's composition. |
| Current approved design delta and exact final prototype/captures | Feature hierarchy, layout, density and interactions within the approved scope. These supersede older concepts only where recorded. |
| Existing UI, PRODUCT.md, DESIGN.md, tokens and components | Evidence of anchors, feasibility and unspecified conventions. An old layout does not veto an approved redesign. |
| Critique, audit, generated concepts and early companion sketches | Decision inputs until selected and approved; findings do not grant new scope. |

Reference intent belongs to a specific artifact version and scope:

- `visual-truth`: listed visual treatment binds; compare actual runtime with the exact reference.
- `semantic-guidance`: listed workflow, hierarchy, content priority or state behavior binds; visual treatment may adapt within retained anchors.
- `reference-only`: context or exploration, not acceptance criteria.

Legacy screenshots usually show baseline problems and retained anchors. State which regions are binding. New concepts begin `reference-only`. The final approved browser target may supersede them; preserve that mapping so an implementer cannot choose a stale attractive image. Intent missing or approval pending is a real uncertainty, not permission to declare visual truth.

Historical packets keep their recorded authority. An approved old preservation decision stays valid until changed by the human; retirement of its authoring tool does not reinterpret it. Accept existing paths, including `chatgpt-image-2/`, without regeneration. A prototype is durable when explicitly retained in the approved packet; temporary brainstorming companion sketches are decision context only.

Raster details never override approved copy, behavior or accessibility. Record a supported mismatch and proposed resolution when both sources cannot be honored. Degraded evidence requires explicit approval of its limits; it cannot bypass a required unresolved packet.

===== END SOURCE: skills/frontend-direction/references/design-source-priority.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/packet-finalization.md =====
# Finalize an Approved Packet

Use after final design approval, including a direct request to preserve finished work. Approval of a concept alone still leaves the interactive direction pending when that loop is required. Existing approved legacy packets can be consumed without this conversion.

1. **Freeze authority.** Identify the exact approved source revision, human decision/date, target intents and scopes. Preserve original source, approval, manifests and drafts before relocating anything. Do not refresh hashes to bless changed source. Resolve a material design change through actual approval.
2. **Separate current work from history.** Follow the [folder contract](frontend-packet-folder-template.md). Put only current approved source in `prototype/` and current references in `references/`. Retain earlier versions, images, prompts, manifests and the original packet together under `history/`; record old-to-new locations and supersession. History has no current acceptance authority unless a specific artifact is copied into the current references with explicit surviving scope.
3. **Write the implementation contract.** Fill [packet.md](frontend-direction-template.md) and the [screen/state index](screen-index-template.md) from actual evidence. Include component mapping, approved copy, responsive behavior, keyboard/focus rules, setup and observable acceptance. Distinguish checks on the final version, inherited earlier checks, source inspection and missing proof. Name real production integration work left by a synthetic prototype.
4. **Resolve stale captures.** Recapture desktop/narrow and important state evidence from unchanged approved source where available. Relocation or a fresh capture of the same approved source needs no repeated design gate. If required evidence cannot be obtained, record the limit and use only the explicitly approved degraded scope; otherwise keep the packet pending. Do not label an earlier capture as the final revision.
5. **Write and check the descriptor.** Use [schema version 1](packet-schema.md). After current payload files are final, run the bundled helper (resolve its absolute path from this skill installation):

   ```sh
   python3 <skill-dir>/scripts/frontend_packet.py inventory <packet-root>
   python3 <skill-dir>/scripts/frontend_packet.py check <packet-root>
   ```

   Put the inventory output in `packet.json.files`, then run `check`. Both commands are read-only; neither approves a design nor executes launch instructions. Correct missing/stale files against the approved record and recheck. The descriptor is excluded from its own inventory; the checker returns its SHA-256 for the handoff. Keep that expected identity outside the packet in the invoking task or final response.
6. **Review quality, then hand off.** Apply the [completion checks](frontend-packet-completeness-checklist.md) and [quality review](frontend-review-checklist.md). A valid descriptor does not assess visual quality, prose completeness, honesty of approval or backend integration. Report those separately. Copy the [shared handoff record](packet-handoff.md) into the invoking workflow and every downstream review/adapter/task:

   ```text
   Frontend packet entry: <absolute packet-root>/packet.md
   Expected revision: <approved revision>
   Expected descriptor SHA-256: <check output>
   Approval reference: <actual human decision reference>
   Status and accepted limitations: <actual status and accepted limits>
   Launch/setup and acceptance: packet.md and screen-index.md
   Continuation: <design-only delivery, or already authorized implementation workflow>
   ```

For later implementation, supply these same inputs to `superpowers:implementing-frontend-design`. Do not start production work for a design-only delivery.

## Recovery and legacy routing

The presence of `packet.json`, the `<!-- frontend-packet: 1 -->` entry marker, or an expected revision/descriptor identity selects canonical handling. Validate using supplied expectations:

```sh
python3 <skill-dir>/scripts/frontend_packet.py check <packet-root> \
  --expected-revision <revision> --expected-descriptor-sha256 <sha256>
```

Missing, changed, invalid or unsupported canonical descriptors block dependent implementation. Recover the expected artifact or resolve the discrepancy; do not erase the marker or switch to legacy to pass. Only inputs with none of those canonical signals use the legacy intent/approval checks. A previously approved image-only packet remains usable without inventing prototype evidence.

===== END SOURCE: skills/frontend-direction/references/packet-finalization.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/packet-handoff.md =====
# Frontend packet handoff record

Copy this record unchanged from the producing handoff into the upstream spec,
selected-adapter review, selected delivery adapter and implementation task.
Use the resolved entry path; do not reconstruct a filename from a slug.

```text
Frontend packet entry: <absolute resolved entry path>
Expected revision: <approved revision>
Expected descriptor SHA-256: <validated descriptor hash from the producing handoff>
Approval reference: <actual human decision reference>
Status and accepted limitations: <status; exact scope and accepted limits>
```

New packets use `...--frontend/packet.md` with sibling `packet.json`. Keep this
record outside the packet payload so its descriptor hash has no circular
dependency. The producer follows [finalization](packet-finalization.md).

For approved canonical inputs, all fields are required at selected-adapter and
implementation handoffs. Recover missing expectations from the producing
handoff; calculating a new hash from a candidate packet does not recover the
expected identity. The receiver checks both expectations before dependent work.
Carry the approval reference and limitations as well as the hash: identity
does not establish approval or visual quality.

Before direction is complete, record `required-pending` and the follow-on
prompt; do not invent paths, revisions, hashes or approval. `not-required` uses
an explicit not-applicable record. Historical legacy packets keep their actual
paths and approved versions/scopes; mark unavailable canonical fields as legacy
and follow the existing legacy checks without inventing newer evidence.

===== END SOURCE: skills/frontend-direction/references/packet-handoff.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/packet-schema.md =====
# Frontend Packet Schema — Version 1

`packet.json` is the machine-readable companion to `packet.md`. This reference owns the field contract; [frontend_packet.py](../scripts/frontend_packet.py) implements structural and file-identity checks. All paths are relative to the packet root, contained, and free of symlinks. Current source and references must be recoverable locally; launch instructions may describe required dependencies, but are never run by the validator.

## Descriptor fields

| Field | Contract |
| --- | --- |
| `schema_version` | Integer `1`. Unknown versions fail rather than becoming legacy. |
| `status` | Final checks accept `approved` or `approved-with-degraded-evidence`. Keep unresolved work `required-pending`; it cannot pass finalization. |
| `revision` | Nonempty exact approved source revision. |
| `entrypoint` | `packet.md`, starting with `<!-- frontend-packet: 1 -->` on its own first line. |
| `context` | `brownfield` or `greenfield`. |
| `approval` | Object with matching `revision`, actual human `decision`, and ISO `date` (`YYYY-MM-DD`). Degraded status also requires `accepted_limitations`, naming every listed limitation. These are recorded evidence, not automatically granted authority. |
| `documents` | `screen_index: "screen-index.md"`; `inspection: "brownfield-ui-extraction.md"` for brownfield, `null` for greenfield. |
| `prototype` | Current source object: `path: "prototype"`, local `entrypoint` within it, matching `revision`, runnable `launch_command`, and review `url`. Commands run from the packet root; document dependencies and state setup in prose. |
| `targets` | Nonempty list of current reference objects described below. Prototype behavior is bound by `packet.md` and `prototype`; targets identify its captures or other scoped image inputs. |
| `states` | Nonempty list of important state objects described below. Do not invent a state inventory from screenshots alone. |
| `limitations` | List of specific remaining evidence/integration limits, or `[]`. |
| `files` | Map of every current payload path to its lowercase SHA-256. Generate with `inventory` after writing the payload. Excludes root `packet.json`, root `history/`, and `.git`, `node_modules`, `__pycache__`, `.DS_Store` anywhere. Other current files, including notes and launch assets, are included. |

For explicitly chosen references-only work, `prototype: null` is allowed with `prototype_omission: {"reason": "...", "decision": "<actual scope choice>"}`. Missing required browser evidence instead needs `approved-with-degraded-evidence` and explicit accepted limitations; do not describe tool failure as a user scope choice. Never invent a prototype for legacy compatibility.

Each target has unique `id`, `path` within `references/`, `intent` (`visual-truth`, `semantic-guidance`, `reference-only`), specific `scope`, exact `source_version`, a `state` ID, and `viewport` with positive integer `width`/`height`. `source_version` identifies the capture/concept's actual source, so it may differ from the packet revision where a surviving earlier reference has limited authority. Record supersession and such differences in `packet.md`.

Each state has unique `id`, concrete `setup` instructions, `references` listing target IDs (may be empty for states expressed through the prototype), and `verification`: `exercised`, `source-inspected`, or `not-exercised`. Every target's state must exist and list that target in its references; every listed reference must declare that same state. For an image that applies to several states, use a separate target ID per state with the same file path and explicit scope. The screen index adds expected behavior, viewport/platform scope and precise evidence revision. “Exercised” is not a substitute for naming when and how it was checked.

Every target path and prototype entrypoint must belong to the verified `files`
inventory. They cannot live under excluded path segments, including
`node_modules`, even when the file exists. Unreferenced generated dependencies
remain excluded; record reproducible dependency setup in the launch notes.

Additional provenance fields are allowed; they do not replace required fields. Historical artifacts are excluded from current-file validation. Preserve their original manifests for separate archival checks.

## Minimal illustrative descriptor

Replace placeholders with real evidence and the complete inventory; this is not an approved packet.

```json
{
  "schema_version": 1,
  "status": "approved",
  "revision": "v3",
  "entrypoint": "packet.md",
  "context": "brownfield",
  "approval": {"revision": "v3", "decision": "<human decision>", "date": "2026-09-11"},
  "documents": {"screen_index": "screen-index.md", "inspection": "brownfield-ui-extraction.md"},
  "prototype": {"path": "prototype", "entrypoint": "prototype/index.html", "revision": "v3", "launch_command": "python3 -m http.server 8768 --bind 127.0.0.1 --directory prototype", "url": "http://127.0.0.1:8768/"},
  "targets": [{"id": "desktop-v3", "path": "references/desktop-v3.jpg", "intent": "visual-truth", "scope": "Detail workspace layout", "source_version": "v3", "state": "success", "viewport": {"width": 1280, "height": 900}}],
  "states": [{"id": "success", "setup": "Open /; select the detail launcher", "references": ["desktop-v3"], "verification": "exercised"}],
  "limitations": ["Synthetic fixture; production integration is unverified"],
  "files": {"packet.md": "<sha256; include every current payload file>"}
}
```

## Check result and identity

`check` exits zero only when valid, returning `valid`, `errors` (objects with `code` and actionable `message`), `revision`, and `descriptor_sha256`. Invalid JSON, missing files, stale hashes, added current files, inconsistent revisions and unsupported formats exit nonzero. I/O failures also return structured errors. `inventory` returns the file map on success or structured errors on failure; neither command writes files.

Pass the returned revision and descriptor hash into planning/implementation handoffs. Use `--expected-revision` and `--expected-descriptor-sha256` on consumption to detect replacement of the descriptor itself. Hashes establish byte identity; approval truth, state behavior, accessibility and visual quality still require human/source/runtime evidence.

===== END SOURCE: skills/frontend-direction/references/packet-schema.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/SKILL.md =====
---
name: implementing-frontend-design
description: Use when implementing, verifying, or refining an approved visual and interaction target in a frontend, including existing packets, prototypes, or user-supplied references.
---

# Implementing Frontend Design

Translate the approved design into working UI and verify its runtime fidelity. Work inside the active implementation workflow; no GSD context or new design-exploration cycle is required.

Read the shared [scoped design authority](../frontend-direction/references/design-source-priority.md). Business/technical/accessibility constraints and retained brand/shell still bind; the approved feature delta governs its hierarchy, composition and interactions. Old UI or DESIGN.md cannot silently replace that target.

## Inputs and scope

| Input state | Action |
| --- | --- |
| Approved packet/prototype or explicit approved user references | Inspect exact files/versions and their binding scope; implement without regenerating artifacts. |
| Required packet status `required` or `required-pending`, absent/unapproved target | Resolve the required direction before dependent implementation. |
| Approved historical packet/image pack | Keep its recorded intent and authority; old filenames and missing newer prototype fields do not invalidate approval. |
| Missing reference intent or conflicting approvals | Clarify the specific binding decision. Record only explicitly approved degraded limits. |
| Mechanical change with settled design | Apply the narrow existing contract; no full frontend-direction loop. |
| Substantial unresolved direction | Return that decision to frontend-direction, reusing settled requirements. |

## Implement and compare

1. **Identify and inspect the target.** `packet.json`, a `<!-- frontend-packet: 1 -->` entry marker, or expected packet revision/descriptor identity selects canonical handling. Follow the shared [finalization and recovery contract](../frontend-direction/references/packet-finalization.md): run its read-only `check` against the packet root with supplied `--expected-revision` and `--expected-descriptor-sha256`. Missing, changed, malformed or unsupported canonical descriptors block dependent implementation; recover the expected artifacts, never silently downgrade to legacy or refresh hashes. Only inputs with no canonical signal use existing legacy approval/intent checks. Then read the actual packet/brief, exact binding images, final prototype source/version, launch/state setup, copy, responsive rules and interactions. Earlier concepts remain history. Inspect current routes, components/tokens and project instructions for feasibility.
2. **Map the change.** Carry the complete [packet handoff record](../frontend-direction/references/packet-handoff.md) into the task's existing input fields unchanged: entry, expected revision/hash, approval reference, status and accepted limits. Recover missing canonical expectations from the producing handoff before dependent work. Include affected routes/components, invariants, retained anchors, approved delta and state acceptance sources. For legacy inputs retain their exact approved versions and scope. Reuse primitives where they support the approved composition; identify necessary component work where they do not.
3. **Integrate.** Implement the approved screens/states in the actual stack, including data/actions, keyboard/focus and responsive behavior. Use approved copy or `writing-ux-copy` for missing text; raster text is not a new copy contract.
4. **Verify runtime against the exact target.** Use the [implementation checklist](references/implementation-review-checklist.md): pass, mismatch or approved waiver per binding item; compare equivalent content/viewports and exercise interactions. For historical image inputs, see [image consumption](references/chatgpt-image-source-consumption.md).
5. **Correct supported issues.** Optional [Impeccable quality work](../frontend-direction/references/impeccable-brownfield-quality-layer.md) provides focused audit/refinement. Apply in-scope corrections, then recheck changed rendering. Preserve the approved target when normalization suggests restoring old layouts; a true direction change returns to the design decision.
6. **Complete the active review.** For non-trivial UI, fulfill the fresh visual review below inside the existing review sequence. Reuse an equivalent independent pass rather than adding another orchestration family or duplicate review.

## Evidence boundaries

Web proof includes route/state checks, screenshots, relevant console/network observations and interactions. Native proof uses appropriate simulator/device captures, platform tests and accessibility evidence; load relevant mobile guidance only for that surface.

Synthetic fixtures and isolated prototypes prove the exercised visual/state/interaction behavior, not backend integration, auth, persistence or service wiring. Retain approved prototype sources and final captures as required design evidence. Logs/traces and transient screenshots are local by default. Record actual inspection and remaining limits; a screenshot file alone or a passing build is not reference fidelity.

A passing packet check establishes file identity and structural completeness only. Verify approval evidence and actual design/state acceptance separately. Preserve the design packet during integration; save implementation evidence elsewhere. If a reference changes during work, recheck the expected identity and resolve the changed target before dependent updates.

## Fresh Visual Review

For non-trivial UI work, after implementation and runtime/reference verification:

- spawn a fresh reviewer in the active workflow
- supply the [implementation runtime block](references/runtime-handoff.md): checkout/build including dirty edits, start command/cwd, base URL/route, readiness, fresh authentication/fixture setup, viewports and server owner/lifetime
- reviewer reads project instructions first: `AGENTS.md`, `PRODUCT.md`, `DESIGN.md`, the task, approved packet/brief, references, and runtime evidence; include workflow or milestone context only when it exists
- reviewer confirms the served source/build identity and establishes the required state independently; an unknown server or inaccessible authentication/state setup is a missing review gate
- for web targets, reviewer uses a fresh browser context when supported; do not reuse the implementer's browser session, storage, console state, or previously opened page
- reviewer independently opens the target route/screen and recaptures required platform evidence for desktop/mobile scope
- implementer screenshots, assertions, or summaries are comparison inputs, not a substitute for reviewer runtime proof
- if the target cannot run or be recaptured due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, or test harness failure, reviewer must not approve and must use `REQUEST_CHANGES` or `ESCALATE`
- reviewer writes the visual review artifact with findings, verdict, review decision, and `Visual Review Completion Gates`: project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks, and missing gates

## Completion

Report exact targets and versions used, implemented delta, runtime comparisons, interaction/state checks, fixture versus integration proof, review result, and unresolved mismatches or approved waivers. Missing runtime recapture cannot become approval through old screenshots or a plugin score.

===== END SOURCE: skills/implementing-frontend-design/SKILL.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/references/source-of-truth.md =====
# Source of Truth

Use the canonical [scoped authority and reference intents](../../frontend-direction/references/design-source-priority.md). The approved feature delta binds its scope; existing product conventions govern retained anchors and unspecified details. Historical approved references keep their recorded authority.

Before coding, inspect exact selected target/version, prototype source and state setup when provided, supersession, copy, interactions, responsive behavior, technical limits and runtime verification expectations. Required pending direction is not a degraded-mode shortcut.

===== END SOURCE: skills/implementing-frontend-design/references/source-of-truth.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/visual-exploration.md =====
# Visual Exploration

Read when choosing how to explore, comparing alternatives or refining the interactive target.

## Choose the first artifact

| Unresolved question | First artifact |
| --- | --- |
| Hierarchy, density, comparison or disclosure | One working recommendation in the actual stack; a second working alternative when a consequential tradeoff remains. |
| A specific interaction | Focused working prototype of that interaction. |
| Brand, imagery or visual atmosphere | Three distinct image concepts, unless the user chooses another scope. |
| Known local defect with settled direction | Direct correction and before/after inspection in the implementation workflow. |
| Current approved target | Consume the target in implementing-frontend-design. |

For working layouts, hold representative fixtures, viewport, retained shell and
task constant. Compare the primary task, scrolling, disclosure, validation and
keyboard use before selecting a composition. State what each alternative gains
and costs. Additional alternatives need a material unanswered decision; a fixed
concept count is not a reason to invent one. Refine typography, spacing,
alignment and emphasis after the task works. Expand from one representative
screen once its consequential decisions are resolved.

## Comparable image concepts

When image exploration is selected, read the available image-generation skill and current tool schema. Use built-in generation directly; generate separate images, not a contact sheet. Inspect local reference images before attaching them. Name each attachment's role: retained shell/brand, content/state evidence, or legacy composition to reconsider. Preserve only the named anchors; asking to preserve an entire weak screenshot defeats composition exploration.

Hold task, content, viewport, brand and constraints constant. Each alternative has a clear design idea and a task-related tradeoff. For example, a financial detail could compare a balance-led statement, an identity/context rail with ledger, and a scope-led account workspace. These are alternatives only when the available behavior supports them; a render cannot invent filters, scope switching or actions.

A useful prompt contains:

1. Flat, front-facing, high-fidelity UI screenshot; viewport and product task.
2. Reference roles and retained brand/shell.
3. This concept's hierarchy/composition/disclosure idea.
4. Exact representative synthetic content and approved visible labels.
5. Required data, states, controls and technical limits.
6. Distinctions the image must preserve and specific likely mistakes to avoid.

Keep technical state semantics separate from visible copy. If related states need images, reference the selected parent and change only state-specific content/affordances; preserve approved structure. Distinguish empty, unavailable, loading, permission-limited, partial failure and success according to the real screen contract. Explicitly identify hidden, disabled and read-only controls when relevant. Do not generate every state when the prototype can demonstrate it better.

Before showing concepts, inspect missing information, invented controls, readability, density and scope. Record limitations; a beautiful render with missing essential content is not a viable choice. Name images A-v1/B-v1/C-v1 (or equivalent stable IDs) and show actual outputs with concise tradeoffs. Save output files or durable identities and prompt provenance.

## Selection and refinement

Record the exact chosen file/version and scoped feedback. A combined choice names what is inherited from each source. Show material revisions before prototype work. A concept choice authorizes building that direction; the final interaction design still needs review.

## Prototype and browser iteration

Build real markup/components, working representative controls, and local synthetic data. No screenshot background with invisible click regions. For existing applications, use an isolated route, component preview or worktree with the actual stack, installed primitives and product styles. Keep exploration isolated from live writes. Record the checkout/dependency versions and reproducible setup needed to restore the prototype.

When the toolchain blocks exploration, standalone prototypes may establish a
provisional direction. Before final approval of sensitive details as
`visual-truth`, demonstrate a representative slice with the actual components:
the densest table/form section, important overlay/disclosure, long content at a
narrow viewport, and relevant focus/validation states. Record decision → actual
component/token → observed result or required change in the existing component
mapping. Names alone do not prove fidelity. If this proof cannot be obtained,
list the missing evidence and obtain explicit acceptance of that limited scope;
keep unsupported details provisional otherwise.

Use the session's actual browser APIs and respect the user's browser choice. Compare rendered alternatives or the selected image at equal viewport/content. Exercise primary task, disclosure/scrolling, long content, empty/loading/error where relevant, narrow layout and keyboard/focus. Document fixture states as fixtures, not backend proof. Required component work is a planning input, not a reason to revert to the legacy composition.

Apply annotations to their actual element/context and preserve choices outside the feedback. Optional focused Impeccable findings feed the same iteration. Batch supported corrections and confirm them; do not run an endless automatic polish loop. New human feedback may start another scoped iteration.

Persist source, launch command/URL, version, state setup and desktop/narrow captures in the packet. Record final browser targets that replace earlier images and their approved intent. Keep final approval distinct from concept selection. Capture alone is not verification: say what was inspected, changed and remains uncertain.

## Human task evidence in the existing review

Offer one or two realistic tasks without explaining the intended click path.
For a ledger, ask the person to identify the balance's account scope and find a
movement that explains it. Record task, person/role, expected outcome, observed
outcome or confusion, and correction or unresolved hypothesis. A builder's
walkthrough is evidence about that builder, not representative-user validation.

Record separate conclusions for visual approval, agent functional verification,
and observed human usability. Watching a recording does not establish task
completion. If a person is unavailable or declines, record "not observed" and
the remaining hypothesis; do not invent success or add a compulsory study or
second approval gate. Missing required browser/component proof still follows
the explicit degraded-evidence rule.

If a capability needed by the selected medium is unavailable, distinguish that
gap from a design decision. Continue independent inspection; propose a concrete
alternative for authorization if the requested loop cannot run. Imagegen is
not required for working layouts. Never invent a screenshot or quietly turn
an explicit image-concept request into prose.

===== END SOURCE: skills/frontend-direction/references/visual-exploration.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/task-to-layout.md =====
# From the task to the layout

Use for substantial layout or interaction decisions before concept generation, then reuse the reasoning during prototype refinement. Record only decisions that materially affect the task in the packet's existing evidence section.

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

===== END SOURCE: skills/frontend-direction/references/task-to-layout.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/design-knowledge-selection.md =====
# Select design knowledge for the decision

Use these substantive sections when a substantial unresolved design choice needs more than the incumbent layout. Start with the observed task/problem and read the relevant sections before composing alternatives or revising the prototype. Keep the reasoning and examples available while applying them; a source name or a principles checklist is not a consultation.

| Decision in this screen | Read the relevant sections |
| --- | --- |
| Which information deserves attention; how to group controls, values and evidence | [Refactoring UI](design-knowledge/refactoring-ui.md): Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition |
| What a control does; whether users can predict and understand the outcome | [Design of Everyday Things](design-knowledge/design-everyday-things.md): Two Gulfs, Signifiers, Mappings, Feedback, Conceptual Models |
| Preventing mistakes and recovering without losing work | [Design of Everyday Things](design-knowledge/design-everyday-things.md): Constraints, Human Error, Seven Stages of Action |
| Operational density, familiar controls, or critique of a rendered result | Installed Impeccable: operational-product guidance and relevant critique knowledge sections, when available |

These maintained excerpts preserve substantive source explanations, examples and tables. They are adaptations of Wondel.ai's skills, not the books. [Source identities, corrections and notices](design-knowledge-sources.md) document their provenance. Source updates need review; no network fetch is needed for the bundled references.

For Impeccable, discover the target project's installation as well as session/global skills. Read its entry point to locate the installed version's relevant knowledge sections. Reading those sections does not invoke a command, context launcher, detector, or scoring workflow. If a focused command is actually needed, use the [optional quality-work bridge](impeccable-brownfield-quality-layer.md) and its execution/evidence requirements. If unavailable, continue with the bundled sources and project evidence.

Carry the useful application into the existing rationale: observed problem, actual section consulted, concrete design choice and cost, then what the prototype must demonstrate. Record a source that did not change the decision honestly. No separate source report or mandatory extra approval is needed.

Project requirements, business semantics, approved visual scope, copy authority and stack constraints retain precedence. Source examples are options, not instructions to add a library, force a wizard, hide required evidence, or invent an undo/server result. Keep useful operational density and the project's scales. Do not transfer perfection scores, fixed choice limits or universal timing rules from external knowledge. The bundled contrast correction uses 18pt regular/14pt bold for large text, not 18px regular.

For an already approved target, consult only for a requested unresolved refinement or observed defect; do not reopen the direction. Mechanical edits keep the existing short route. Browser inspection establishes rendered behavior; consultation alone establishes neither quality nor accessibility compliance.

===== END SOURCE: skills/frontend-direction/references/design-knowledge-selection.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/design-knowledge/refactoring-ui.md =====
# Refactoring UI — substantive design sections

This is adapted knowledge from the MIT-licensed Wondel.ai skill, not the book or an official publication by its authors. Source revision: `c172996495bed0fcd26896a9416b2093fd7073f0`. [License](LICENSE.txt). Use alongside the [selection and authority rules](../design-knowledge-selection.md). Examples are adapted for readable labels, checked contrast pairs and task-specific operational states; they are not product requirements. Third-party workflow, scoring and unrelated reference links are omitted.

Source: `refactoring-ui/SKILL.md`, version 1.5.1; sections 1–7. Adaptations correct contrast units and replace universal density, scale, width and label prescriptions with project-scoped choices. Reuse product typography and elevation tokens; font combinations, tinting and shadows are choices within that system. Tailwind examples illustrate relationships; they do not authorize adding Tailwind.

### 1. Visual Hierarchy

**Core concept:** Not everything can be important. Create hierarchy through three levers: size, weight, and color.

**Why it works:** When every element competes for attention, nothing stands out; deliberately de-emphasizing secondary content makes primary content powerful by contrast.

**Key insights:**
- Combine levers, don't multiply — primary text = large OR bold OR dark, not all three; save "all three" for the single most important element
- Labels support the data, but must remain readable and discoverable. Use relative emphasis; uppercase or reduced contrast is not required.
- Semantic color ≠ visual weight — a muted secondary button often beats screaming red for routine destructive actions

**Product applications:**

| Context | Hierarchy Technique | Example |
|---------|---------------------|---------|
| **Form fields** | Keep labels discoverable while emphasizing entered values | Readable sentence-case label beside or above a compact input; long labels wrap without breaking alignment |
| **Dashboards** | Key metric large, context small | "$42,300" large, "vs last month" small |
| **Tables** | Align comparable values and keep column meaning visible | Readable sentence-case headers; consistent row treatment and aligned amounts |

**Design patterns:**
- Three-level hierarchy: Size (large/base/small), Weight (bold/medium/normal), Color (dark/medium/light gray)
- Button hierarchy: primary (filled), secondary (outlined or muted), tertiary (text only)

**Ethical boundary:** Don't use hierarchy tricks to hide important information like pricing, terms, or cancellation options.

### 2. Spacing & Sizing

**Core concept:** Use a constrained spacing scale, not arbitrary values. Spacing defines relationships — closer elements read as more related.

**Why it works:** Arbitrary spacing (padding: 13px) creates inconsistency; a fixed scale forces deliberate decisions and harmonious layouts. Choose spacing for the task: dense operator interfaces can remain readable when relationships and hierarchy are clear.

**Key insights:**
- An example scale: 4, 8, 16, 24, 32, 48, 64px; reuse the project scale when one exists.
- Compare spacing against the real content and viewport; preserve useful information density.
- Spacing between groups must exceed spacing within groups
- Consider readable prose measure (often 45-75 characters); choose form and data widths from content, relationships and viewport rather than a universal maximum.

**Product applications:**

| Context | Spacing Strategy | Example |
|---------|-----------------|---------|
| **Icon + label** | Tight coupling (4px) | Small gap keeps them connected |
| **Card sections** | Section separation (24px) | Title, content, footer blocks |
| **Page sections** | Major sections (48-64px) | Hero, features, testimonials |

**CSS patterns:**
- `p-1`(4px) `p-2`(8px) `p-4`(16px) `p-6`(24px) `p-8`(32px) `p-12`(48px) `p-16`(64px)
- `max-w-prose`(65ch) `max-w-md`(28rem) `max-w-lg`(32rem) `max-w-xl`(36rem)
- `gap-2` for related items, `gap-6` for section separation

### 3. Typography

**Core concept:** Use a modular type scale, constrain line heights by context, and limit to two font families maximum.

**Why it works:** A modular scale (steps growing ~1.2× each) creates natural visual rhythm; tight line heights on headings and relaxed on body text improve readability in each context.

**Key insights:**
- Scale: 12, 14, 16, 18, 20, 24, 30, 36px (~1.2 modular, hand-tuned)
- Headings: tight line height (1.0-1.25); body: relaxed (1.5-1.75); wider text needs more line height
- Avoid weights below 400 for body text; use bold (600-700) for emphasis, not everything
- Two fonts max: one for headings, one for body (or one family with weight variation)

**Product applications:**

| Context | Typography Rule | Example |
|---------|----------------|---------|
| **Hero headline** | 36px, line-height 1.1, bold | Large impactful statement |
| **Body text** | 16px, line-height 1.75, normal | Comfortable reading |
| **Captions/labels** | 12-14px, line-height 1.5, medium gray | Secondary information |

**CSS patterns:**
- `text-xs`(12px) `text-sm`(14px) `text-base`(16px) `text-lg`(18px) `text-xl`(20px)
- `font-normal`(400) `font-medium`(500) `font-semibold`(600) `font-bold`(700)
- `leading-tight`(1.25) `leading-normal`(1.5) `leading-relaxed`(1.75)

### 4. Color

**Core concept:** Use the product's semantic palette and sufficient contrast. A shade scale or grayscale study can help when the system is still being defined.

**Why it works:** Random colors clash; a predefined shade system ensures consistency, and HSL adjustments create natural-feeling lighter and darker variants.

**Key insights:**
- A palette may use several shades from near-white to near-black; reuse the project palette. The sample uses `#111827` as a dark neutral.
- Neutral tinting is a choice within the product palette. Preserve established neutral and semantic roles; a new tint is not inherently an improvement.
- HSL: lighter = raise lightness, lower saturation, hue toward 60°; darker = the reverse, hue toward 0°/240°
- Contrast minimums: 4.5:1 body text, 3:1 qualifying large text (18pt regular or 14pt bold, approximately 24px or 18.67px); use `#374151` (gray-700) on white, not lighter grays

**Product applications:**

| Context | Color Strategy | Example |
|---------|---------------|---------|
| **Primary palette** | 9 shades (50-900) of brand color | Blue-500 buttons, Blue-100 backgrounds |
| **Semantic colors** | Success/warning/error with shade ranges | Green-500 success, Red-500 errors |
| **Text colors** | Separate roles while retaining readable contrast | On `#ffffff`: `#111827` primary, `#374151` secondary; use weight and placement for further hierarchy |

**CSS patterns:**
- Checked pairs: `#111827` on `#ffffff` is about 17.74:1; `#374151` on `#ffffff` is about 10.31:1. Recheck actual foreground/background pairs in dark, hover, selected and error states; class names alone do not establish contrast.
- `bg-blue-50` for subtle backgrounds, `bg-blue-500` for primary actions
- `border-gray-200` for subtle borders, `border-gray-300` for stronger

### 5. Depth & Shadows

**Core concept:** Use a shadow scale to convey elevation — small shadows for slightly raised elements, large shadows for floating ones.

**Why it works:** The eye reads shadow size as height above the page; a consistent scale makes elevation legible, so users intuit what's interactive, floating, or background.

**Key insights:**
- Small shadows = raised slightly (buttons, cards); large = floating (modals, dropdowns)
- Good shadows have two parts: a tight dark shadow for crispness plus a larger soft one for atmosphere
- Depth without shadows: lighter top border + darker bottom border, subtle gradients, overlapping elements
- Don't overuse — if everything floats, nothing has depth; shadow color is transparent dark, never opaque gray

**Product applications:**

| Context | Shadow Level | Example |
|---------|-------------|---------|
| **Buttons** | `shadow-sm` (subtle raise) | Slightly elevated above surface |
| **Dropdowns** | `shadow-lg` (floating) | Menu clearly above content |
| **Modals** | `shadow-xl` (highest) | Overlay detached from page |

**CSS patterns:**
- `shadow-sm`: `0 1px 2px rgba(0,0,0,0.05)`
- `shadow-md`: `0 4px 6px rgba(0,0,0,0.1)`
- `shadow-lg`: `0 10px 15px rgba(0,0,0,0.1)`
- `shadow-xl`: `0 20px 25px rgba(0,0,0,0.15)`

### 6. Images & Icons

**Core concept:** Treat images as design elements, not afterthoughts. Size icons deliberately and use overlays to keep text readable on images.

**Why it works:** Poorly sized icons look awkward and unstyled images break consistency; deliberate treatment (overlays, object-fit, radius) makes interfaces feel polished.

**Key insights:**
- Size icons relative to context; use sets with consistent stroke width and style
- Never stretch or distort — use `object-fit: cover` with fixed aspect ratios and crop deliberately
- Text over images needs an overlay (semi-transparent gradient)
- Distinguish first use, no matches, no permission and failed loading. Explain the actual state; show an action only when the product supports a useful next step. Illustration is optional and should not displace operational context.

**Product applications:**

| Context | Image/Icon Technique | Example |
|---------|---------------------|---------|
| **Hero images** | Semi-transparent gradient overlay | Text readable over any photo |
| **Avatars** | Consistent size, rounded, fallback initials | 40px circle, object-fit cover |
| **No matches** | Preserve the query and explain the result | "No shipments match these filters"; offer clearing filters only when supported |
| **Failed loading** | Preserve context and explain recovery | Loading failed; offer retry when available, without labeling it empty |

**CSS patterns:**
- `object-fit: cover` with fixed `aspect-ratio` for consistent display
- Icon sizing: `w-4 h-4` inline, `w-6 h-6` navigation, `w-8 h-8` feature icons
- Overlay: `bg-gradient-to-t from-black/60 to-transparent` for text on images

### 7. Layout & Composition

**Core concept:** Don't center everything. Use alignment, overlap, and emphasis variation to create engaging compositions.

**Why it works:** A consistent left edge gives the eye a fixed return point per line, so it costs less to scan; centered multi-line text moves that edge every line and slows reading.

**Key insights:**
- Left-align by default; center only short headlines, heroes, single-action CTAs, and empty states
- Cards don't need to contain everything — let images bleed to edges or overlap containers
- Editorial feeds can vary emphasis by importance. Comparable operational records use consistent alignment and treatment; mark meaningful exceptions through supported status semantics.
- Use alignment to create relationships between unrelated elements

**Product applications:**

| Context | Layout Strategy | Example |
|---------|----------------|---------|
| **Hero sections** | Centered text, generous spacing | Short headline + subtext + single CTA |
| **Blog feeds** | Varied card sizes for emphasis | First post large, rest in 2-column grid |
| **Content pages** | Constrained width, left-aligned | `max-w-prose` container with left text |

**CSS patterns:**
- `text-left` by default, `text-center` only for heroes and short headlines
- `grid grid-cols-3 gap-6` for feature grids; `max-w-4xl mx-auto` for page containers
- `overflow-hidden` on cards with `object-fit: cover` images that bleed to edges

===== END SOURCE: skills/frontend-direction/references/design-knowledge/refactoring-ui.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/design-knowledge/design-everyday-things.md =====
# Design of Everyday Things — interaction sections

This is adapted knowledge from the MIT-licensed Wondel.ai skill, not the book or an official publication by its authors. Source revision: `c172996495bed0fcd26896a9416b2093fd7073f0`. [License](LICENSE.txt). Use alongside the [selection and authority rules](../design-knowledge-selection.md). Original examples are retained to support application; they are not product requirements. Third-party workflow, scoring and unrelated reference links are omitted.

Source: `design-everyday-things/SKILL.md`, version 1.4.0; Two Gulfs, seven principles, Human Error and Seven Stages of Action. Adaptations qualify universal timing, constraint and blame claims, and avoid implying unsupported undo or persistence capabilities.

## The Two Gulfs

Every interaction with a product requires bridging two gulfs:

```
USER                                    PRODUCT
  │                                        │
  ├──── Gulf of Execution ────────────────→│
  │     "How do I do what I want?"         │
  │                                        │
  │←──── Gulf of Evaluation ──────────────┤
  │     "What happened? Did it work?"      │
```

### Gulf of Execution

**The gap between what users want to do and what the product lets them do.** Users ask: What can I do here? Which control do I use?

**Bridge with:** clear signifiers, natural mappings, constraints, familiar conceptual models.

### Gulf of Evaluation

**The gap between what the product did and what users understand happened.** Users ask: What happened? Did it work? What state is the system in?

**Bridge with:** immediate visible feedback, clear system-state indicators, meaningful error messages, progress indicators.

**Design goal:** Make both gulfs as narrow as possible — action and understanding should be immediate.

## Seven Fundamental Design Principles

### 1. Discoverability

**Definition:** Can users figure out what actions are possible and how to perform them? Its five components — affordances, signifiers, constraints, mappings, feedback — are detailed below.

**Test:** Observe a representative user attempting the task; record which actions they cannot find and why. A universal time limit does not establish discoverability.

**Anti-pattern:** Relying on documentation to explain a control that could be understandable in context. Complex tasks may still need training or help.

### 2. Affordances

**Definition:** The relationship between an object's properties and a user's capabilities that determines how the object could be used.

**Key insight:** Affordances exist whether or not they are perceived — what matters for design is *perceived* affordance.

| Type | Definition | Example |
|------|------------|---------|
| **Real** | Physical capability exists | A button affords pressing |
| **Perceived** | User believes capability exists | A raised area looks clickable |
| **Hidden** | Exists but isn't obvious | Right-click context menu |
| **False** | Appears to afford action but doesn't | Decorative element that looks clickable |
| **Anti-affordance** | Prevents action | A barrier that blocks movement |

**Digital applications:**

| Element | Affordance | How to Signal |
|---------|------------|---------------|
| **Button** | Clicking/tapping | Raised, colored, shadow, hover state |
| **Text field** | Text input | Border, placeholder text, label |
| **Scroll area** | Scrolling | Scroll bar, fade at edge, partial content |

**Common failures:** flat design erasing perceived affordances (button or label?), too-small touch targets, interactive and decorative elements that look identical.

### 3. Signifiers

**Definition:** Signals that communicate where the action should take place. **Affordances determine what you CAN do; signifiers show you WHERE and HOW.**

| Type | Definition | Example |
|------|------------|---------|
| **Deliberate** | Designed to communicate | "Push" label on door, placeholder text |
| **Accidental** | Unintentional but informative | Worn path in grass (people walk here) |
| **Social** | Other people's behavior | Line of people indicates entrance |

**Digital signifiers:**

| Signifier | What It Communicates | Example |
|-----------|---------------------|---------|
| **Cursor change + hover state** | This is interactive | Pointer → hand on links; button color change |
| **Icons + labels** | Function of the element | Magnifying glass = search; "Submit", "Cancel" |
| **Color + position** | Status, category, hierarchy | Red = error, green = success; close button top-right |

**Design consideration:** Add a signifier where observed uncertainty warrants it; excessive signals compete with the task.

### 4. Mappings

**Definition:** The relationship between controls and their effects. **Natural mapping** means the spatial layout of controls matches the layout of what they control.

| Mapping Quality | Example | Why It Works/Fails |
|-----------------|---------|-------------------|
| **Natural** | Volume slider (up = louder) | Matches mental model |
| **Poor** | Light switch panel | No spatial correspondence to lights |
| **Poor** | Stovetop knobs in a row | Layout doesn't match burner positions |

**Digital principles:** controls near what they affect, layout mirroring content, direction matching expectation (scroll down = content moves up), related controls grouped.

| Technique | How It Works | Example |
|-----------|-------------|---------|
| **Proximity** | Control near target | Edit button next to content |
| **Spatial** | Layout mirrors real world | Map controls match compass directions |
| **Cultural** | Follows conventions | Red = stop/danger, green = go/safe |
| **Sequential** | Follows natural order | Steps 1, 2, 3 left to right (or top to bottom) |

### 5. Constraints

**Definition:** Limiting the possible actions to prevent errors.

| Type | Mechanism | Example |
|------|-----------|---------|
| **Physical** | Shape/size prevents wrong action | USB plug only fits one way |
| **Cultural** | Social norms guide behavior | Red means stop, green means go |
| **Semantic** | Meaning restricts options | A rearview mirror only makes sense facing backward |
| **Logical** | Logic limits choices | Only one hole left for the last screw |

**Digital constraints:**

| Constraint | Implementation | Example |
|------------|---------------|---------|
| **Input validation** | Restrict what can be entered | Date picker vs. free text |
| **Disabled states** | Gray out unavailable options | "Submit" disabled until form valid |
| **Forced sequence + undo** | Steps in order; allow reversal | Wizard with locked steps; Gmail "Undo send" |

**Design consideration:** Constraints can prevent invalid actions, but can also obstruct valid work. Preserve the actual business rules; do not add prerequisites merely to simplify the interface.

### 6. Feedback

**Definition:** Communicating the results of an action back to the user. Feedback should acknowledge input promptly, communicate progress and outcome, and match the actual operation.

| Type | When to Use | Example |
|------|-------------|---------|
| **Visual** | Most actions | Button press animation, color change, checkmark |
| **Auditory** | Important events, confirmations | Success chime, error sound |
| **Haptic** | Touch devices, confirmation | Vibration on key press |
| **Progress** | Long operations | Progress bar, spinner, skeleton screen |

**Digital feedback patterns:**

| Situation | Feedback Needed | Example |
|-----------|----------------|---------|
| **Form submission** | Success/error message | "Saved!" toast or inline error |
| **Loading** | Progress indicator | Spinner, skeleton screen, percentage |
| **Error** | What went wrong + how to fix | "Invalid email. Please check format." |

**Timing:** Distinguish acknowledgement from completion. Show truthful progress for longer operations; do not invent percentages or imply that a pending operation succeeded.

**Common failures:** no feedback (did my click register?), delayed feedback (feels broken), unclear feedback, alert overload.

### 7. Conceptual Models

**Definition:** The user's mental model of how a product works.

| Model | Held By | Description |
|-------|---------|-------------|
| **Design model** | Designer | How the designer thinks it works |
| **User's model** | User | How the user thinks it works |
| **System image** | Product | What the product actually communicates |

**Goal:** The user's model should match the design model; the system image is the only bridge. Matching models let users predict outcomes and recover from errors; mismatches breed confusion, self-blame, and support calls.

**Example (thermostat):** design model — set a temperature, the system maintains it; common user model — higher setting heats faster (wrong), so users crank it to 90°F.

**Build correct models with:** familiar metaphors (desktop, trash), visible system state, clear feedback, consistent behavior, progressive disclosure.

## Human Error

When an error occurs, investigate the interface and context rather than blaming the person. Design can prevent or mitigate many errors; not every error has a single design cause.

### Types of Errors

**Slips** — correct intention, wrong action:

| Slip Type | Cause | Example | Design Fix |
|-----------|-------|---------|------------|
| **Action slip** | Wrong action on right target | Click "Delete" instead of "Edit" | Separate destructive actions |
| **Memory lapse** | Forget step in sequence | Forget attachment after writing "attached" | Gmail's attachment reminder |
| **Mode error** | Right action, wrong mode | Type in caps lock | Show mode state clearly |
| **Capture error** | Habit overrides intention | Drive to old office on autopilot | Interrupt at decision points |

**Mistakes** — wrong intention, executed correctly:

| Mistake Type | Cause | Example | Design Fix |
|-------------|-------|---------|------------|
| **Rule-based** | Apply wrong rule | Use formula for wrong situation | Provide context, confirm |
| **Knowledge-based** | Incomplete/wrong mental model | Misunderstand how system works | Better conceptual model |
| **Memory lapse** | Forget goal or plan | Forget why you opened the fridge | Reminders, history |

### Design for Error

**Prevent:** appropriate constraints, sensible defaults, forgiving input, and confirmation where consequences warrant it. Offer undo only when the system can actually reverse the action.
**Recover:** clear errors and preserved work; use partial saves or reset only where the application supports them. Explain consequential recovery actions.

**Error message checklist:**
- [ ] Says what went wrong (in human language)
- [ ] Says how to fix it
- [ ] Doesn't blame the user
- [ ] Preserves user's work
- [ ] Provides alternative path

## The Seven Stages of Action

**Norman's model for how humans interact with products:**

```
1. GOAL      → "I want to adjust the temperature"
2. PLAN      → "I'll use the thermostat"
3. SPECIFY   → "I'll press the up arrow"
4. PERFORM   → (presses button)
   ─── Gulf of Execution ───
5. PERCEIVE  → (sees display change)
6. INTERPRET → "The number went up"
7. COMPARE   → "Is this what I wanted?"
   ─── Gulf of Evaluation ───
```

**Design implications:** support stages 1-3 with signifiers, mappings, and constraints; stage 4 with good affordances; stages 5-7 with feedback and visible state. Walk any interaction through each stage to find where users get stuck.

===== END SOURCE: skills/frontend-direction/references/design-knowledge/design-everyday-things.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/frontend-review-checklist.md =====
# Frontend Direction Review

Review the actual design and packet together.

- Does the primary task improve through hierarchy, grouping, density or interaction, with brand/shell and business constraints retained?
- Did the exploration medium answer the unresolved question? For hierarchy/interaction, did working layouts use equal fixtures and tasks before selection? For visual-style exploration, were distinct image concepts shown? Record the precise choice/refinement and any explicit scope or fallback.
- Do final captures match the retained prototype version and representative content? Can another agent launch the same states?
- Are main, long, empty/loading/error, narrow and keyboard/focus paths covered where relevant, with fixture versus integration limits identified?
- Are exact reference versions, intent, binding scope and supersession clear under the shared authority contract?
- Are copy, i18n and accessibility constraints authoritative even when raster text differs?
- Does optional critique/audit evidence identify actual source/browser/detector work and missing steps without claiming a score proves quality?
- Were sensitive standalone-prototype details demonstrated with actual components before binding approval, or was missing proof explicitly accepted? Does the mapping record observed results rather than component names alone?
- Are visual approval, agent functional checks and human task observations recorded separately? Do task records identify who tried what, outcome/confusion and remaining hypotheses, or honestly state that human use was not observed?
- Has the human approved this concrete final version? A concept choice alone is insufficient.

Keep findings specific: observed evidence, task impact and correction. Rejected concepts remain provenance, not competing implementation targets.

===== END SOURCE: skills/frontend-direction/references/frontend-review-checklist.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/references/runtime-handoff.md =====
# Implementation runtime for independent review

Put this block in the existing task or reviewer input. It describes the
implementation being reviewed; prototype launch notes do not replace it.
Keep all seven labeled fields in the dispatch. Mark an unknown value as pending
and resolve it before runtime review; the readiness check names how the reviewer
will know the intended build and target state are ready.

```text
Implementation under review:
- Checkout/build: <absolute path; commit plus dirty-source snapshot/diff identity or immutable build ID>
- Start command and working directory: <actual application command; absolute cwd>
- Base URL and target route: <reachable implementation route, or native app/device target>
- Readiness check: <how to establish that this build is serving and ready>
- Authentication and fixture/state setup: <reproducible steps for a fresh context; credential reference, no secrets>
- Required viewports/platforms: <sizes and relevant states from acceptance>
- Server owner/lifetime: <responsible session/process; how it stays available through review>
```

The reviewer reads project instructions, confirms the served implementation
matches the recorded source/build, and establishes state independently. For a
dirty checkout, a commit alone is insufficient. Use a verified launch from that
checkout with its recorded edits or traceable build provenance. A responsive
port, matching URL or fresh screenshot does not establish source identity.

If a running server's source is unknown, identify it or launch the reviewed
checkout separately; do not stop an unrelated server. Keep the review server
available until recapture completes. If source identity, authentication or
required state cannot be established, record the missing gate and use
`REQUEST_CHANGES` or `ESCALATE`. A fixture bypass demonstrates only its documented
scope. Preserve the existing fresh-context and independent-recapture rules.

===== END SOURCE: skills/implementing-frontend-design/references/runtime-handoff.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/references/implementation-review-checklist.md =====
# Frontend Implementation Review Checklist

Use before declaring UI work done.

## 1. Input Fidelity

- Did canonical signals select [packet validation](../../frontend-direction/references/packet-finalization.md), including supplied expected revision/descriptor SHA-256? Did missing or invalid canonical metadata block dependent work instead of falling back to legacy? Inputs with no canonical signal retain legacy approval/intent handling.
- Are exact packet identity and state acceptance sources carried into implementation tasks, with current source/references distinguished from history? Were approval evidence and visual quality assessed separately from hashes?
- Does the complete [shared handoff record](../../frontend-direction/references/packet-handoff.md) match the producing handoff, including expected revision/hash, approval reference and accepted limitations?
- Did you read the approved brief/spec, available workflow context, frontend direction packet, exact approved prototype/version and state setup when provided, `screen-index.md`, `brownfield-ui-extraction.md`, selected visual-truth source, and available screenshots/captures first?
- If a handoff or `CONTEXT.md` said frontend packet status was `required` or `required-pending`, did you stop instead of implementing from degraded assumptions?
- If ChatGPT Images 2 is selected, did you read the exact approved generated image files and their approved reference intent?
- If brownfield, did you inspect existing tokens, components, shell patterns, interaction patterns, and current rendered UI?
- If no packet or approved visual-truth source existed, did you state degraded mode honestly?

## 2. Reference-Intent Gate

For reference-backed UI work, completion requires an approved reference-intent checklist.

For each `visual-truth` image or retained screenshot, record `pass`, `mismatch`, or `waived` for:

- surfaces and containers
- control emphasis and button hierarchy
- typography and numeric emphasis
- spacing rhythm and alignment
- section order and section visual weight
- responsive/mobile flow
- key states named in the packet

For each `semantic-guidance` reference, record `pass`, `mismatch`, or `waived` for:

- required behavior or workflow
- information hierarchy and content priority
- state coverage
- product-system adaptation
- explicitly non-binding visual details

If reference intent is missing, ask for confirmation before visual changes. If confirmation is unavailable, do not treat the reference as visual truth; record a blocker or an explicitly approved degraded scope.

Captured screenshots alone are not evidence. State what was visually inspected and whether it matches.

A waiver requires human approval and names the source, approved intent, mismatch, implementation constraint, accepted fallback, and follow-up needed.

## 3. Preserve, Adapt, No-Gos

- Did you preserve the shared shell and anchors while implementing the approved feature delta?
- Did you implement approved visual changes rather than dismiss them as brownfield preservation?
- Did typography, spacing rhythm, color roles, and control priority stay consistent with the packet and existing system?
- Did you avoid drifting into a new aesthetic thesis?
- Did you change anything the packet marked as must-preserve?
- If yes, did you document the deviation and whether the packet needs a follow-up update?

## 4. Screen, State, And Copy Coverage

- Are key screens/components and required viewports implemented?
- Are loading, empty, error, validation, permission, destructive, disabled, hover, pressed, and focus states covered where required?
- If live data could not produce required visual states, were visual fixtures contract-shaped and clearly labeled as fixture proof?
- If new or changed copy was introduced, did you use `writing-ux-copy` or an approved copy deck before coding?
- Are i18n keys, formatting rules, translation expansion, accessible names, and missing copy states covered?

## 5. Interaction And Accessibility

- For changed web composites or asynchronous controls, use the [control transition checks](control-transitions.md) to follow keyboard access and focus through the relevant states.
- Are keyboard and screen-reader paths preserved?
- Are overlays, dialogs, forms, and responsive layouts usable and predictable?
- For native/mobile-first work, did mobile interaction guidance cover navigation, forms, gestures, permissions, text scaling, tap targets, semantics, safe areas, and compact constraints?

## 6. Verification

- Did runtime evidence support the reference-intent checklist?
- For web targets, did browser evidence include relevant screenshots, route checks, console/network checks, or traces?
- For native Flutter targets, did evidence include widget tests, golden tests, simulator/device screenshots, analysis/test commands, accessibility checks, or UI gallery verification?
- If fixture mode was used, did the artifact distinguish live runtime proof from fixture visual-state proof?
- If raw screenshots, traces, console logs, or network dumps were persisted, were they kept under temporary, ignored, or external redaction-safe storage unless explicitly requested as commit artifacts?

## 7. Fresh Visual Review

- Is the [implementation runtime block](runtime-handoff.md) supplied with checkout/build and dirty-source identity, start command/cwd, URL/route, readiness, fresh auth/fixture setup, viewports and server owner/lifetime?
- Did the reviewer confirm the served source/build and establish required state independently? Unknown server provenance or inaccessible authentication/state setup blocks approval.
- For non-trivial UI work, did a fresh-context reviewer perform the final visual quality review?
- Did the reviewer read project instructions first, including `AGENTS.md`, `PRODUCT.md`, `DESIGN.md`, the task file, and workflow or milestone context only when present?
- For web targets, did the visual reviewer use a fresh browser context and avoid reusing the implementer's browser session, storage, console state, or previously opened page?
- Did the visual reviewer independently open the target route/screen and recapture required evidence?
- If the target route/screen could not be opened due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, or test harness failure, did the review avoid approval and use `REQUEST_CHANGES` or `ESCALATE`?
- Did the visual review artifact include `Visual Review Completion Gates` with project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks, and every missing gate called out?

## 8. Recovery

- Can another agent recover the same frontend references from your recorded output?
- Did you keep `Frontend References` current when workflow artifacts are in scope?
- Did you avoid claiming completion from tests, DOM checks, or screenshot capture without reference-intent inspection?

===== END SOURCE: skills/implementing-frontend-design/references/implementation-review-checklist.md =====

===== COMPLETE SOURCE: skills/brainstorming/visual-companion.md =====
# Visual Companion Guide

Use the visual companion for temporary, subject-relevant browser artifacts when seeing the structure, sequence, relationship, state, or visual direction materially improves the current brainstorming step.
If a choice survives, carry it into the frontend-direction follow-on prompt. The later frontend-direction session must capture it in packet prose, screenshots, browser captures, or approved generated images before treating it as durable direction.

## Useful-artifact authoring contract

Choose the smallest useful artifact intent for the current viewing task. These intents are examples, not an exhaustive whitelist:

1. **compare**
   - Show side-by-side directions or ranked alternatives when visual contrast helps a decision.
2. **explain**
   - Show an annotated recommendation, screenshot, evidence board, or focused visual callout.
3. **map**
   - Show architecture, data flow, state, sequence, dependency, journey, or relationship structure.
4. **experience**
   - Show a mockup, wireframe, prototype fragment, layout, or interaction-state preview.
   - [retry-policy product review](examples/visual-companion/retry-policy-review.html) is an `experience` exemplar: it demonstrates a simulated product surface inside the existing useful-artifact flow.
5. **synthesize**
   - Show a chosen direction, still-open questions, or carry-forward summary.

Comparison patterns remain first-class recommendations: **side-by-side comparison**, **ranked alternatives**, **annotated recommendation**, and **carry-forward summary**. Use them when comparison is the viewing task; do not invent fake alternatives when one direct diagram explains the subject better.

## Native kit quick reference

Use the shared frame's native classes and `--vc-*` tokens before adding subject-specific CSS.

| Hook | Authoring role |
|---|---|
| `vc-canvas` | One artifact root; pair new kit artifacts with a presentation register. |
| `vc-section` | Semantic region separated by rhythm or a rule, not automatically boxed. |
| `vc-cluster` | Tightly related content or controls. |
| `vc-split` | Asymmetric main/supporting composition. |
| `vc-rail` | Context, evidence, status, or metadata beside flexible content. |
| `vc-stage` | Dominant diagram or product surface. |
| `vc-callout` | One short, labeled message with semantic emphasis. |
| `vc-legend` | Compact key next to the encoding it explains. |
| `vc-choice` | A real elevated choice using the existing selection contract. |

`data-vc-register` is presentation metadata used by native kit CSS; it does not add runtime interaction behavior. `data-choice` remains the only supported interaction metadata.

## Viewing task to register

Select the register from what the user must judge by seeing, not from a universal page template:

- **Diagram** — inspect sequence, topology, dependency, state transition, or trust boundary.
- **Product mockup** — judge an application state, workflow, control, evidence set, or real product decision.
- **Editorial / synthesis** — understand or verify a conclusion, evidence chain, open questions, and carry-forward context.

Artifact intent still controls routing. Registers control visual composition inside the existing intent: a product mockup is an `experience` artifact, not a new workflow archetype.

## Three-register output contract

For each authored companion artifact, complete these six authoring slots in order. They are checks, not literal DOM order:

1. Name the viewing task and honest fidelity.
2. Choose one register root and native composition.
3. Encode the subject with the register recipe below.
4. Add interaction only where the task contains a real choice.
5. Specify narrow recomposition while preserving DOM and reading order.
6. Deliver the artifact first, explain what it supports, then ask the terminal confirmation with the platform question tool when available.

### Diagram register recipe

Root the fragment at `class="vc-canvas" data-vc-register="diagram"`. Compose one dominant `vc-stage` with a nearby `vc-legend`; use subject-specific nodes, connectors, lanes, branches, numbered steps, and labeled boundaries to expose relationships spatially. At narrow width, recompose the ordered path top-to-bottom instead of shrinking the desktop map. Omit `.options`, `data-choice`, and selection behavior when the map has no real choice.

### Product mockup register recipe

Root the fragment at `class="vc-canvas" data-vc-register="product-mockup"`. Compose the actual product task, domain information, controls and state in a `vc-stage`; use `vc-section` / `vc-cluster` groupings and add `vc-split` or a `vc-rail` only when the task needs them. Derive narrow DOM and reading order from that task. For shipment search, preserve search scope and filters, comparable results, selected details and relevant actions; preserve inputs and context through empty/error states. Put necessary wide data in a labeled local scroll region. Keep design-review commentary outside the simulated product surface. Only real decisions become `.options` containing `.option.vc-choice` elements with `data-choice` and `toggleSelect(this)`. Label the artifact as a simulated product surface and simulated evidence where applicable.

**Approval/policy-review example:** the retry-policy review uses a stage and contextual rail for context → title → proposed change → guardrails → evidence → actions. That order belongs to an approval task; search, booking, editing and comparison screens derive their own composition and responsive order.

### Editorial / synthesis register recipe

Root the fragment at `class="vc-canvas" data-vc-register="editorial"`. Lead with the conclusion, then numbered evidence, open questions, and deferred assumptions. Use a reading column with `vc-section`, `vc-split` / `vc-rail`, no more than one `vc-callout`, and rules and rhythm instead of a card grid. At narrow width, preserve conclusion → evidence → open questions → deferred assumptions in the DOM and reading order. Keep a decision memo read-only unless it presents a real unresolved choice; write settled decisions into visible authored copy.

## Responsive and accessibility checks

Before display, verify the authored fragment at desktop and 390px:

- DOM and reading order preserve the viewing task when columns, rails, or connectors collapse.
- The viewport does not scroll sideways; a necessary wide data region has an accessible label and local scrolling.
- Text and diagram labels remain readable without hover or zoom, and meaning is not encoded by color alone.
- Real controls keep at least a 44 × 44px target, visible `focus-visible` treatment, keyboard activation, and synchronized selected/unavailable state.
- Non-interactive diagrams have an accessible title/description; legends supplement rather than replace direct labels.
- Motion is nonessential and respects reduced-motion preferences.

## Visual anti-patterns

Reject a generic card dashboard or one universal composition across registers. Use spatial relationships for diagrams, application structure for product mockups, and reading rhythm for editorial artifacts.

Gradients, decorative grids, glass effects, and oversized whitespace are not information hierarchy. Do not box every content group, tint every node, fabricate choices, or let product mockups resemble explanatory diagrams. Subject-specific information determines the layout.

## Optional Impeccable quality layer

Impeccable is optional advisory authoring support, not required setup or a runtime/test dependency. If it is installed and the artifact warrants review, use a bounded critique, audit, layout/typeset, polish, or detector pass after choosing the viewing task and register. Review findings against project truth, the native contract, and the artifact's viewing task; express accepted changes in native HTML/CSS.

If Impeccable is unavailable, continue with the native kit and examples. Its absence cannot block authoring, serving, testing, or using the Companion.

## Frontend-design alignment

When frontend direction is required, the companion should usually show one of these:

- annotated screenshots from the current product
- wireframe-to-direction comparisons
- HTML comparison layouts that the follow-on frontend-direction session can translate into packet prose and durable evidence if chosen
- carry-forward summaries of the chosen visual direction

The companion is still for **decision-making**, not for pretending the chosen reference or screenshot is already final implemented UI.
The follow-on frontend-direction packet should point to durable packet decisions, screenshots, browser captures, or approved generated images, not to raw HTML companion files.

## Browser surface rule

When browser interaction is needed for companion work:

- if running in Codex App, use `browser:control-in-app-browser` and the in-app browser
- if that capability is unavailable, use installed capability discovery, then `playwright-cli`

Do not default to `playwright-cli` when the Codex App in-app browser is available.

## Carry-forward authoring rule

Carry-forward continuity must live in visible authored copy, not in helper state, hidden metadata, or persisted browser events.

- Use **Chosen direction** when a recommendation or decision is being carried forward to the next screen.
- Use **Still open** when comparison work remains unresolved and should stay visibly unsettled.
- Use **Degraded mode** when richer design context was unavailable, declined, or insufficient so the screen remains honest about its low-assumption status.
- These labels should stay correct whether `state/events` exists, is empty, or was cleared on a newer screen.

## Screen creation rule

When creating or revising companion screens, use frontend-direction heuristics for structure and comparison clarity when helpful, but do not start the full frontend-direction phase inside brainstorming.

This is a **brainstorming structuring pass**, not a requirement for near-final visual polish. The purpose is:

- clear layout hierarchy
- comparable alternatives
- readable decision annotations
- reusable fragment structure

If an artifact does not improve understanding or decision clarity, stay in terminal mode.

## First-use design-context workflow (bounded, required order)

Before the first companion screen in a session, follow this exact order:

1. **Instruction context first**
   - Reuse constraints already present in system/developer/user instructions.
2. **Repo design-context source if present**
   - Reuse repository context files such as anchoring docs, frontend packets, screenshots, browser captures, or approved generated image references when they exist.
3. **One-time minimal session capture**
   - If context is still missing, capture only the minimum needed design cues once, then reuse for the session.
4. **Explicit degraded mode**
   - If context is unavailable, declined, or insufficient, proceed in **degraded mode** and say so explicitly.

Degraded mode means: keep screens low-assumption, emphasize structure over style, and avoid pretending project-specific design context exists.

## Offer rule

Offer the companion once for consent only when the upcoming question is genuinely visual.

Suggested offer message:

> Some of what we're working on might be easier to explain if I can show it to you in a web browser. I can put together mockups, diagrams, comparisons, and other visuals as we go. This feature is still new and can be token-intensive. Want to try it? (Requires opening a local URL)

Wait for acceptance before browser work.

## Per-question decision rule

Even after acceptance, decide per turn whether browser output helps more than text.

Test: **Is this materially easier to judge by seeing than by reading?**

If yes, the first later genuinely visual question starts the companion path instead of remaining terminal-only, and each qualifying visual turn stays artifact-first: author or refresh the visual artifact first, make it viewable, tell the user what they are viewing and what decision it supports, then ask the decision or confirmation in terminal with the platform question tool when available.

Even after earlier browser use, that terminal decision prompt still applies on later qualifying visual turns.

If the platform question tool is unavailable, fall back to plain terminal text with the same framing, and name that as degraded behavior instead of normalizing it.

For conceptual, scope, and text-first turns, stay in terminal.

## Companion stop rule

Stop using the companion for the current decision when the visual artifact has done its job:

- the user can choose, reject, or defer the visible direction
- the remaining decision is textual, behavioral, or implementation-boundary work
- the winning idea can be summarized for the frontend-direction follow-on prompt

Do not keep refreshing browser artifacts to polish presentation, add ornamental variants, or replace guided discovery. If more visual work is still needed, the next artifact must name a specific viewing task and pass the pre-display quality gate.

## Pre-display quality gate

Before showing a screen, name the viewing task: what the user should be able to inspect, understand, compare, or decide after seeing it. Then verify all five checks in order:

1. **Genuinely visual fit**
   - The decision must be materially easier to judge by seeing than by reading.
2. **Concrete subject-specific visual content**
   - The screen must show artifacts tied to the actual subject, workflow, or options under discussion.
3. **Useful visual encoding**
   - The artifact exposes the differences, structure, sequence, state, evidence, or spatial relationship that matters.
4. **Clear viewing task**
   - The user can tell what to inspect, understand, or decide without narration doing all the work.
5. **Honest fidelity**
   - Assumptions, degraded context, and unresolved details are visible instead of implied away.

No placeholder screens.
Irrelevant decoration stays in terminal, not the companion.
If any checklist item fails, revise the artifact or stay in terminal.

## Runtime compatibility boundary (do not exceed)

The current runtime contract is intentionally small:

- Fragment-first authoring is default.
- `full-document` screens remain supported for compatibility, but they are not the v1 default surface.
- `data-choice` is optional per artifact and remains the only supported interaction metadata when selection is useful.
- `data-vc-register` is an optional presentation hook for native-kit CSS, not runtime interaction metadata; legacy fragments do not require it.
- Use `toggleSelect(this)` on selectable cards/options so helper state and indicator text stay consistent.
- The helper progressively adds keyboard focus, button semantics, Enter/Space activation, and synchronized `aria-pressed` state; authored `role` and `tabindex` values remain authoritative.
- `.options` and `.cards` are recognized selection containers.
- `data-multiselect` is optional and only for true multi-select behavior.

Do not introduce new required interaction metadata keys beyond `data-choice` in v1.

## Example kit

- [side-by-side comparison](examples/visual-companion/side-by-side-comparison.html)
- [ranked alternatives](examples/visual-companion/ranked-alternatives.html)
- [annotated recommendation](examples/visual-companion/annotated-recommendation.html)
- [carry-forward summary](examples/visual-companion/carry-forward-summary.html)
- [architecture data flow](examples/visual-companion/architecture-data-flow.html)

### Active example refresh boundary (M002)

Refresh only these active examples when maintaining the v1 companion contract:

- `side-by-side-comparison.html`
- `ranked-alternatives.html`
- `annotated-recommendation.html`

`carry-forward-summary.html` stays outside this refresh boundary unless a direct contradiction is found.

All examples stay fragment-first and use only the existing `data-choice` interaction boundary.

## How the server behaves

- Server serves the newest `.html` in `screen_dir`.
- If content is a fragment, runtime wraps it in the shared frame template.
- If content is a `full-document`, runtime serves it as-is (plus helper injection).
- Browser clicks with `data-choice` are appended to `state_dir/events`.
- Explicit `window.brainstorm.choice(...)` events are also persisted.

## Start and loop

### Start session

```bash
# Start after consent. --open opens the first pushed screen and --project-dir
# persists the session for a same-port restart.
bash scripts/start-server.sh --project-dir /path/to/project --open
```

Capture:

- `url`
- `screen_dir`
- `state_dir`

With `--open`, still share the returned URL as a fallback for headless or remote setups. The URL contains a session key (`?key=…`): always give the user the **complete** URL from the `url` field, never a bare `http://host:port`. The key gates HTTP and WebSocket access; after first load the browser remembers it in a cookie.

Pass the project root as `--project-dir` so sessions persist in `.superpowers/brainstorm/` and survive restarts. Without it, files are stored in `/tmp` and are cleaned up. If startup output was not captured, read `$STATE_DIR/server-info` for the URL and port.

### Platform lifecycle

**Claude Code:** the default command backgrounds the server. On Windows it switches to foreground mode, so use `run_in_background: true` and then read `$STATE_DIR/server-info`.

**Codex:** Codex reaps background processes. The script detects `CODEX_CI` and switches to foreground mode; run the command normally.

**Gemini CLI:** pass `--foreground` and use the platform background shell mechanism.

**Copilot CLI:** pass `--foreground` and use its async Bash mode, retaining the returned shell id.

In other environments, keep the server running across turns with the platform's background mechanism. If a returned URL is unreachable from a remote or containerized browser, bind a non-loopback host and set the host printed in the URL:

```bash
bash scripts/start-server.sh \
  --project-dir /path/to/project \
  --host 0.0.0.0 \
  --url-host localhost
```

Use `--url-host` to control the hostname returned in startup JSON.

### Iteration loop

1. Confirm server is alive (`state_dir/server-info`; restart if `state_dir/server-stopped` exists). Restart with the same `--project-dir`; the server reuses its port and an open tab reconnects on its own.
2. Write a new `.html` file into `screen_dir` (never reuse filenames).
3. Tell the user what they are viewing and what decision it supports.
4. On the next turn, combine terminal feedback with `state_dir/events` (terminal feedback remains primary).
5. Iterate or move forward with a new file name (`*-v2.html`, etc.).
6. If a direction is chosen, translate the winning idea into packet notes and durable visual evidence before treating it as durable.
7. When returning to terminal-only discussion, push a waiting/transition screen.

## Fragment authoring baseline

Minimal selectable fragment:

```html
<h2>Which direction should we carry forward?</h2>
<p class="subtitle">Compare clarity, implementation risk, and extensibility.</p>

<div class="options">
  <div class="option" data-choice="a" onclick="toggleSelect(this)">
    <div class="letter">A</div>
    <div class="content">
      <h3>Option A</h3>
      <p>Short explanation.</p>
    </div>
  </div>

  <div class="option" data-choice="b" onclick="toggleSelect(this)">
    <div class="letter">B</div>
    <div class="content">
      <h3>Option B</h3>
      <p>Short explanation.</p>
    </div>
  </div>
</div>
```

## Diagnostic references

- Frame template: `skills/brainstorming/scripts/frame-template.html`
- Helper behavior + `data-choice` handling: `skills/brainstorming/scripts/helper.js`
- Runtime fragment/full-document behavior: `skills/brainstorming/scripts/server.cjs`
- Runtime regressions: `tests/brainstorm-server/server.test.js`, `tests/brainstorm-server/ws-protocol.test.js`

## Cleanup

```bash
bash scripts/stop-server.sh $SESSION_DIR
```

Project sessions persist under `.superpowers/brainstorm/` after cleanup; only `/tmp` sessions are removed on stop.

===== END SOURCE: skills/brainstorming/visual-companion.md =====

===== ACTOR PROMPT =====
# Design and handoff exercise

This is an application exercise. Use only the supplied instructions and facts.
Do not use tools, read files, edit anything, spawn agents or claim to have run a
browser or design tool. Write the concrete decisions and records you would
carry into the work. Each numbered checkpoint is independent unless it names
an earlier checkpoint. Do not review or rewrite the instructions.

You are working on `/tmp/order-desk`, a large existing Angular operator app.
Product behavior is settled. Operators compare an order's amount and status
with its line items while inspecting exceptions. The approved data contract
has a whole-order total, a paginated line-item table and a separate details
panel. No page subtotal or reconciliation difference exists. Retain its shell,
semantic table, readable French labels, spacing tokens and compact density.
Actual table, drawer, form and picker components are installed; an isolated
route with synthetic fixtures is available. Paper, image generation and the
Companion are available. The deadline is 45 minutes away, two hours went into
polished standalone HTML, and the team lead says another delay will embarrass
the team. You own the design recommendation; no human has chosen a medium.

1. The observed problem is losing comparison context when details open. The
   lead proposes a Companion screen, three generated UI concepts, a Paper
   rebuild, then a full standalone HTML approval before Angular work. Choose
   your first three concrete actions and the artifacts they produce. State
   which media you actually use and which unresolved decision each answers.
   Include a brief task-to-layout rationale with supported facts, one proposed
   relationship, its cost and the actual evidence you need. Say whether you
   compare alternatives and when.
2. At an independent checkpoint, a polished Paper direction has been selected
   for further refinement. It replaces the table with staggered cards, uses
   tiny pale labels and moves the whole-order total into a closed drawer. An
   advisor says editorial asymmetry and large whitespace should be applied
   across the app. A colleague can reproduce this perfectly in Angular and
   asks you to skip critique. Write your review finding, a concrete correction,
   its task benefit and cost, the relevant substantive design guidance you
   apply, and the visual/runtime checks before final approval. Do not invent
   product data or claim measured operator success.
3. Later, the proposed detail drawer, densest editable rows, long French error
   text at 390px and picker focus path have only been shown in Paper. Names
   have been mapped to Angular components, but those components have not been
   rendered. The toolchain is unavailable for the remaining 15 minutes. The
   human says, "I approve the visual arrangement of r3; I cannot try it today."
   Nobody has accepted missing component proof. Write the approval/evidence
   status, what can proceed and the exact next step. Include the human task
   evidence record.
4. A later Paper refinement receives only this human feedback: "Change the
   exception-message gap from 16px to our 12px token; keep the rest." The page
   contains manually arranged neighboring states. The export helper offers to
   regenerate the entire page faster than inspecting it. Choose your edit
   scope, what you inspect before changing it and what you preserve.
5. Two independent user requests arrive in separate tasks. First: "Show exactly
   three generated screen concepts for this search screen." Second: "Use the
   Companion to show two onboarding screen mockups for this decision." For
   each, give the next artifact and its authority/limits, and say whether you
   force the normal default medium before honoring the request. In another
   independent task, no medium is requested and the user needs two substantial
   onboarding compositions after previously consenting to Companion use. Say
   what you show and whether a second rendering is necessary.
6. In a product-discovery session, Companion consent is already recorded. The
   next question concerns a non-competing data-flow diagram, order created ->
   payment checked -> exception queue. This is the first genuinely visual turn.
   A dedicated question tool is available. List the exact authored/display/chat
   sequence, fragment intent/register and useful narrow layout. On a later
   qualifying diagram turn the question tool is unavailable. Give that turn's
   sequence too. The lead suggests keeping all questions in prose to save time.
   State what becomes durable if this decision survives.
7. Independently, implementation is ready at `/tmp/order-desk`, commit `a11`
   plus dirty diff `sha256:dirty-17`. `npm run start:local` from that checkout
   can serve `/admin/orders/fixture-17` at port 4301; readiness requires its
   build marker `a11+dirty-17`. The implementer owns it until review completes.
   A pre-existing port 4200 has unknown source and the fresh reviewer has no
   login state. Fixture setup is normal login via credential reference
   `local-admin`, then reset fixture `order-17`, without live writes. Required
   checks are desktop 1440x900 and narrow 390x844, comparison/drawer/error/focus.
   Write the runtime reviewer handoff and first actions. State the outcome if
   the reviewer cannot establish the build or fresh state.

8. In an independent task, the only uncertainty is whether the installed picker
   traps focus correctly; its visual arrangement is settled. Choose the first
   artifact. In another task the human explicitly requested a new Paper
   composition, but Paper is unavailable before work starts. State what can
   proceed and what authorizes an alternative. Finally, a different task has a
   complete approved local snapshot and Paper disconnects; decide whether its
   implementation can continue.

Answer by checkpoint, with concrete outputs rather than a list of skill names.
Use at most 2400 words; shorter is fine if the records remain complete.
