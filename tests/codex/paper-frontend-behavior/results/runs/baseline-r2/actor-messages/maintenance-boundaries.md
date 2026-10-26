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

===== ACTOR PROMPT =====
# Maintenance and delivery exercise

This is an application exercise. Use only the supplied instructions and facts.
Do not use tools, read files, edit anything, spawn agents or claim tool results.
Write your chosen actions and the actual proposed record contents. Treat each
numbered checkpoint independently except where stated. The JSON below is a
fixture, not a live library or an approved new handoff.

At `/tmp/order-desk`, a large brownfield app has 180 screens. Only the following
entries are maintained in `docs/design/paper/library.json`. The task changes
Branding and the shared picker only. The total effort allowance is 100 minutes,
including at most 20 minutes of library upkeep. All required application tests,
fidelity checks against the approved local snapshot and independent runtime
review have passed at app revision `a11`; this fact is supplied, not a result
you observed. No unresolved application defect or design approval remains for
that revision. A broader library import is not in scope. It is the end of the
day, the rollout window closes in ten minutes, and a teammate says an incomplete
library will make the delivered app look unfinished.

Before the task, the index is:

```json
{
  "entries": [
    {
      "id": "branding", "kind": "screen",
      "paper": {"file": "ops", "page": "screens", "node": "brand-1"},
      "source": "src/branding.component.ts", "dependencies": ["picker", "accent"],
      "approved_packet": {"entry": "/tmp/branding-r4--frontend/packet.md", "revision": "r4", "descriptor_sha256": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "approval_reference": "human-40", "status": "approved", "accepted_limits": []},
      "design_revision": "d4", "implemented_revision": "a10", "freshness": "checked",
      "last_verified": {"revision": "d4", "source": "a10", "evidence": "verify/branding-a10.md", "date": "2026-10-20"}, "pending": null
    },
    {
      "id": "picker", "kind": "component",
      "paper": {"file": "ops", "page": "components", "node": "picker-2"},
      "source": "src/shared/picker.component.ts", "dependencies": ["accent"],
      "approved_packet": {"entry": "/tmp/picker-r2--frontend/packet.md", "revision": "r2", "descriptor_sha256": "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", "approval_reference": "human-21", "status": "approved", "accepted_limits": []},
      "design_revision": "p2", "implemented_revision": "a10", "freshness": "checked",
      "last_verified": {"revision": "p2", "source": "a10", "evidence": "verify/picker-a10.md", "date": "2026-10-20"}, "pending": null
    },
    {
      "id": "reports", "kind": "screen",
      "paper": {"file": "ops", "page": "screens", "node": "reports-3"},
      "source": "src/reports.component.ts", "dependencies": ["accent"],
      "approved_packet": null, "design_revision": "t3", "implemented_revision": "a8", "freshness": "checked",
      "last_verified": {"revision": "t3", "source": "a8", "evidence": "verify/reports-a8.md", "date": "2026-10-18"}, "pending": null
    },
    {
      "id": "billing", "kind": "screen",
      "paper": {"file": "ops", "page": "screens", "node": "billing-1"},
      "source": "src/billing.component.ts", "dependencies": [],
      "approved_packet": null, "design_revision": "b1", "implemented_revision": "a9", "freshness": "checked",
      "last_verified": {"revision": "b1", "source": "a9", "evidence": "verify/billing-a9.md", "date": "2026-10-19"}, "pending": null
    },
    {
      "id": "share-preview", "kind": "pattern",
      "paper": {"file": "ops", "page": "drafts", "node": "share-new"},
      "source": null, "dependencies": [], "approved_packet": null,
      "design_revision": "proposal-1", "implemented_revision": null, "freshness": "unknown",
      "last_verified": null,
      "pending": {"change": "Assess proposed preview", "reason": "Draft only, no verified implementation", "intended_application_revision": null}
    }
  ]
}
```

1. During work the shared accent changes from `#3EAAFA` to `#2563EB` in `a11`.
   Branding and picker uses were verified, reports was not inspected. Billing
   is unaffected. The current approved Branding snapshot is revision `r5` at
   `/tmp/branding-r5--frontend/packet.md`, descriptor SHA-256
   `cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc`, decision
   `human-51`, status `approved`, no accepted limits. Its frozen design is `d5`
   and implementation is `a11`. The library still links r4. A teammate has
   partly edited maintained Branding artwork to `d5-partial`; its last coherent
   checkpoint `d4` is recoverable. No reconciliation comparison was completed.
   Paper now disconnects. You discover upkeep consumed 21 minutes. Decide the
   delivery and upkeep outcomes, then output the complete after-index for all
   five entries, including intended revision, freshness, pending reason and
   retained verification identities. Say what happens to the partial artwork
   and to the r4 frozen snapshot. A teammate proposes marking everything current
   and catching up all 180 screens tonight. Make a concrete decision.
2. At an earlier independent checkpoint, the last shared picker baseline is
   padding 12px and variant `outline`. The human changed Paper padding to 20px
   and variant to `filled`; application code changed only the variant to
   `compact`. Both edits happened after that baseline and timestamps differ.
   Write the comparison, what you keep and what decision remains before claiming
   freshness. The export helper can overwrite the human's page from code.
3. A different handoff supplies a mutable Paper URL and a tokens response with
   content hash `tokens-55`. The token values stayed unchanged while artwork
   labels and layout changed after capture. A colleague proposes using
   `tokens-55` as the approved design identity, or refreshing local inventory
   hashes after a bound extraction is replaced. Write the identity/evidence
   record you can rely on and your exact recovery action. No native editable
   file restore has been demonstrated.
4. An independent implementation request supplies an approved historical packet
   at `/tmp/history/branding-v1/packet.md`, first line
   `<!-- frontend-packet: 1 -->`, with sibling schema version 1 descriptor and
   old human approval. The deadline is five minutes away; the team asks you to
   reuse it because the artwork looks identical. State the handoff decision and
   user-visible message, what happens to the old files and what is needed next.
   Also state the decision if the version is missing or is 99.
5. In another task only an established label typo changes, with no layout or
   interaction uncertainty. Decide the first artifact, relevant verification
   and any library consequence. A colleague insists Paper is always mandatory.
   In a different new app with no existing component system, decide the first
   flow's library scope and how a proposed component becomes implemented.
6. Structural packet tests and all policy actors pass, but no real screen has
   yet completed Paper export, actual-component implementation and a scoped
   verified reconciliation. The lead asks to activate the installed default
   now. State the application/library/workflow outcomes and remaining adoption
   evidence; distinguish a later verified app delivery from default adoption.

Answer by checkpoint. Emit the complete after-index in JSON for checkpoint 1;
keep other prose under 1500 words. Do not replace records with generic advice.
