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
| Approved brainstorming spec and follow-on exist | Reuse their settled decisions and invoking workflow; translate them into the experience brief below. |
| Standalone screen improvement | Inspect the named target and fill the small brief below. No separate spec, follow-on prompt, or full brainstorming pass is required. |
| New unresolved business rule or permission model | Resolve that specific product decision before dependent design; use fuller brainstorming when broader shaping is needed. |
| Current approved visual target exists | Consume it; reopen only the requested design decisions. |
| Mechanical edit with settled direction | Use the existing implementation workflow; skip concept exploration. |

**Standalone brief:** target and primary user task; problem; scope and required behavior; retained brand/shell and technical constraints; design objectives; important states; design-only or implementation too; initial library coverage and agreed maintenance allowance. Keep it inside the packet. Fill observable facts from inspection and ask only questions that change the design. Existing authorization is enough to begin; another brief sign-off is not a prerequisite.

**For both entry routes:** record the short [experience brief](references/task-to-layout.md#frame-the-experience) in existing packet evidence before substantial design. Reuse settled product facts; discuss only gaps that change the experience, with a recommendation and tradeoff. A product spec supplies constraints, not a finished experience. No additional brief approval is required.

Read [scoped design authority](references/design-source-priority.md) before choosing references.

## Design loop

Choose the exploration medium from the unresolved decision. Explicit user choices govern the scope; a known local defect or approved target does not need concept exploration.

1. **Inspect and set objectives.** Inspect current runtime, relevant source, design docs, and state evidence. Separate business constraints, retained anchors, and design problems using the [brownfield extraction](references/brownfield-ui-extraction-template.md). Reuse sufficient current evidence. For substantial design choices, use the [task-to-layout method](references/task-to-layout.md) to ground information meaning, comparison needs and visual priority before choosing a composition. For unresolved visual or interaction choices, [select and apply fuller design references](references/design-knowledge-selection.md) before composing alternatives. Optional [Impeccable assessment](references/impeccable-brownfield-quality-layer.md) can inform this inspection before an extraction document exists.
2. **Compose in the medium that resolves the uncertainty.** Read [visual exploration](references/visual-exploration.md). For substantial hierarchy, density, typography or screen composition, use [Paper](references/paper-workflow.md) with actual content and established anchors. When substantial composition remains unresolved, compare a small useful set of rough sketches or Paper structures before polishing the selected direction. Differentiate task flow, hierarchy or interaction; choose by ease, clarity, visual quality and product fit. Settled patterns keep the direct path. Interaction uncertainty may enter the app first. Routine corrections stay in code. No fixed image or artboard count, routine generated UI screenshots, Companion composition or full standalone screen recreation.
3. **Refine the task relationships.** Keep task, fixtures, retained shell, content and widths comparable. Apply the consulted design guidance to grouping, action placement, disclosure and readability; explain the benefit and cost. Apply chat feedback to its affected scope and preserve other choices and manual canvas edits. Explicit image-concept or Companion mockup requests override the medium for that task, not the approval or runtime-proof contract.
4. **Prove sensitive decisions with actual components.** Interaction-dependent or component-sensitive visual decisions require the smallest actual-component slice in the app, isolated from live writes. Record risk → installed component/token → observed result → evidence identity and limits. Known unchanged components within verified constraints need no new experiment. Paper screenshots and component names alone cannot prove behavior. When the real toolchain is unavailable, a standalone prototype is an explicitly scoped provisional fallback; missing required proof keeps the affected decision provisional unless the human explicitly accepts the degraded scope. Use the requested [browser surface](references/browser-surface-selection.md), relevant states, long content, real container widths and keyboard/focus checks.
5. **Review, refine and preserve.** Correct observed problems and retain the extracted design source, actual-component runtime records, launch/state instructions and final captures. Record the [rendered quality verdict](references/frontend-review-checklist.md) in existing review evidence; a packet-valid design can require changes. Ground each consequential defect in a visible problem, task consequence and correction before approval. During the existing final review, offer one or two realistic tasks without prescribing their click path. Record who attempted them, the expected and observed outcome, confusion and remaining hypotheses. If no person can try the task, record that limit; human availability alone does not block visual approval. Keep visual approval, agent functional checks and observed usability distinct. Record supersession and ask for approval of the concrete final direction; selection, silence, or an iteration count is not final approval.
6. **Finalize and hand off.** Follow [packet finalization](references/packet-finalization.md): preserve the approved bytes, separate history, write the canonical `packet.md` and `packet.json`, and validate the current artifact set. Use the [packet template](references/frontend-direction-template.md), [folder layout](references/frontend-packet-folder-template.md) and [screen/state index](references/screen-index-template.md). Review actual quality and acceptance with the [quality checklist](references/frontend-review-checklist.md) and [completion checks](references/frontend-packet-completeness-checklist.md). Hand off the entry path, exact revision, descriptor SHA-256 and remaining limits. File validation establishes identity, not design quality or human approval.

## Boundaries and continuation

- This skill may write isolated prototypes. Production integration follows the approved direction and the user's implementation scope. Prototype actions stay local and synthetic.
- Missing capability for the selected medium: report what is unavailable and what remains unverified; use an explicitly authorized alternative. Image generation is unnecessary for a working-layout route. Do not substitute a prose packet for the requested visual loop or claim tools ran. Optional Product Design capabilities may help when installed; no plugin is required.
- Use `writing-ux-copy` or an approved copy source for visible text, including prompts. Generated text does not redefine application copy or business rules.
- Generate and consume version-2 packets only. Historical packets remain untouched reference material, never a current implementation handoff. Use the exact unsupported-version response in the shared schema; no conversion, migration or legacy fallback.
- Keep a required unresolved packet `required-pending`. `approved-with-degraded-evidence` needs explicit approval of the listed limitations. One approval of the concrete packet covers its listed reference intents; do not request duplicate classification approvals.
- Follow-on mode returns the approved packet to the invoking workflow. For brainstorming, return to its delivery router after approval. Standalone design-only work ends with the approved packet; an authorized implementation request continues through the appropriate implementation workflow without a mandatory route-selection ceremony.
- At task start and after a meaningful verified UI change, follow [bounded Paper library upkeep](references/paper-library.md). Maintain affected entries within the agreed allowance, retain last verified identities when pending, and report application delivery separately from upkeep and workflow adoption.

===== END SOURCE: skills/frontend-direction/SKILL.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/design-source-priority.md =====
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

===== END SOURCE: skills/frontend-direction/references/design-source-priority.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/packet-finalization.md =====
# Finalize an Approved Packet

Use after final design approval, including a direct request to preserve finished work. Approval of a concept leaves required runtime checks pending until they pass or the human explicitly accepts their unavailable evidence. This workflow finalizes version 2 only.

1. **Freeze authority.** Identify the exact approved source revision, human decision/date, target intents and scopes. Preserve original source, approval, manifests and drafts before relocating anything. Do not refresh hashes to bless changed source. Resolve a material design change through actual approval.
2. **Retain the selected source.** Follow the [folder contract](frontend-packet-folder-template.md). Write `design_source` and its local `design/` manifest. For Paper, retain provenance, extracted structure, computed styles, frozen resolved tokens, assets, exact copy/state mapping and component/source mappings. For runtime designs, retain the actual recoverable source. References-only work records its actual scoped omission decision. Put current captures in `references/`. Keep drafts and supersession explicit; existing historical packets stay at their original paths with unchanged bytes and reference-only authority.
3. **Write the implementation contract.** Fill [packet.md](frontend-direction-template.md) and the [screen/state index](screen-index-template.md) from actual evidence. Include component mapping, approved copy, responsive behavior, keyboard/focus rules, setup and observable acceptance. Record `runtime_evidence.required_checks`, results and local records with the seven-field runtime handoff, dependency setup and recoverable code. Distinguish final checks, inherited earlier checks, source inspection and missing proof. If no runtime checks were required, explain the scoped reason. Name production integration work left by a synthetic slice.
4. **Resolve stale or missing evidence.** Recapture desktop/narrow and important states from the unchanged approved source where available. A fresh capture of the same approved source needs no repeated design gate. Required failed checks block. Retain unavailable required check IDs and records; each needs its exact listed and explicitly accepted degraded limitation. Keep unresolved work pending. Do not label an earlier capture as the final revision or replace missing source exports with claims of source recovery.
5. **Write and check the descriptor.** Use [schema version 2](packet-schema.md). Inventory every local binding path, including all manifest extractions, assets, provenance, copy, mappings, runtime records, source, dirty changes and recovery evidence. After current payload files are final, run the bundled helper, resolving its absolute path from this skill installation:

   ```sh
   python3 <skill-dir>/scripts/frontend_packet.py inventory <packet-root>
   python3 <skill-dir>/scripts/frontend_packet.py check <packet-root>
   ```

   Put the inventory output in `packet.json.files`, then run `check`. Both commands are read-only; neither approves a design nor executes launch instructions. Correct missing/stale files against the approved record and recheck. Never refresh hashes to bless changed content. The descriptor is excluded from its own inventory; the checker returns its SHA-256 for the handoff. Keep that expected identity outside the packet in the invoking task or final response.
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

## Recovery and historical inputs

Every implementation handoff requires the version-2 descriptor and entry marker. Validate using the producer's supplied expectations:

```sh
python3 <skill-dir>/scripts/frontend_packet.py check <packet-root> \
  --expected-revision <revision> --expected-descriptor-sha256 <sha256>
```

Missing, changed, invalid or unsupported descriptors block dependent implementation. Recover the expected artifact or resolve the discrepancy. Version 1 fails with the exact unsupported-version message in the schema; unmarked or missing-version inputs also fail closed. Historical approvals remain part of the record and do not authorize new delivery. Leave those packets byte-identical at their original paths. New work informed by them must establish its own v2 evidence and human approval; changing a version field or copying an old approval is insufficient.

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

Version-2 packets use `...--frontend/packet.md` with sibling `packet.json`. Keep this
record outside the packet payload so its descriptor hash has no circular
dependency. The producer follows [finalization](packet-finalization.md).

For approved version-2 inputs, all fields are required at selected-adapter and
implementation handoffs. Recover missing expectations from the producing
handoff; calculating a new hash from a candidate packet does not recover the
expected identity. The receiver checks both expectations before dependent work.
Carry the approval reference and limitations as well as the hash. Identity
does not establish approval, actual execution or visual quality. Keep the
same design_source manifest and runtime_evidence records bound to that identity;
do not reconstruct them from a mutable Paper locator or an ephemeral checkout.

```sh
python3 <skill-dir>/scripts/frontend_packet.py check <packet-root> \
  --expected-revision <revision> --expected-descriptor-sha256 <sha256>
```

Missing expectations or invalid/unsupported packets block dependent work.
Version 1 returns the exact unsupported-version message in the
[schema](packet-schema.md); missing versions never select a fallback.

Before direction is complete, record `required-pending` and the follow-on
prompt; do not invent paths, revisions, hashes or approval. `not-required` uses
an explicit not-applicable record. Historical packets keep their original
paths, bytes and historical approvals as reference material only. They cannot
authorize a new delivery. Establish current v2 evidence and approval without
migration, automatic conversion or a legacy handoff branch.

===== END SOURCE: skills/frontend-direction/references/packet-handoff.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/packet-schema.md =====
# Frontend packet schema, version 2

`packet.json` is the machine-readable companion to `packet.md`. This reference
owns the field contract; [frontend_packet.py](../scripts/frontend_packet.py)
checks record consistency, containment and file identity. The helper never
writes a packet, runs launch commands, grants approval or certifies that a
recorded check actually ran, passed visually or worked for a person.

## Descriptor fields

| Field | Contract |
| --- | --- |
| `schema_version` | Integer `2`, with no missing-version fallback. |
| `status` | Final checks accept `approved` or `approved-with-degraded-evidence`. Unresolved work stays `required-pending` and fails finalization. |
| `revision` | Nonempty exact approved design revision. |
| `entrypoint` | `packet.md`, starting with `<!-- frontend-packet: 2 -->` on its own first line. |
| `context` | `brownfield` or `greenfield`. |
| `approval` | Matching `revision`, actual human `decision`, ISO `date` in `YYYY-MM-DD` form. Degraded status also requires `accepted_limitations`, naming every listed limitation. Recorded approval is not automatically verified authority. |
| `documents` | `screen_index: "screen-index.md"`; `inspection: "brownfield-ui-extraction.md"` for brownfield, `null` for greenfield. |
| `design_source` | `medium`: `paper`, `runtime` or `references-only`; matching `revision`; `manifest`: local JSON file under `design/`. See below. |
| `runtime_evidence` | Required `required_checks`, `checks` and `not_required_reason`. See below. |
| `targets` | Nonempty list of current scoped capture/reference objects. |
| `states` | Nonempty list of important states, setup and verification. |
| `limitations` | Specific remaining evidence/integration limits, or `[]`. |
| `files` | Every current payload path mapped to its lowercase SHA-256. Excludes root `packet.json`, root `history/`, and `.git`, `node_modules`, `__pycache__`, `.DS_Store` anywhere. All other current files, including notes and source dependencies retained as payload, are included. |

Version 1 fails with exactly:

```text
Unsupported packet schema version 1. This workflow requires version 2; historical packets are reference material only.
```

Missing and other unsupported versions also fail closed with `schema-version`.
The former source/omission fields are rejected, with no compatibility branch,
automatic conversion or migration. Leave historical packets and their original
paths byte-identical as reference material. New delivery requires independently
established v2 evidence and approval.

## Design manifest

Every manifest is a JSON object with matching `revision` and a `provenance`
file path. The provenance file records source locators, captured revision,
extraction method and relevant application source. For Paper, identify the
file, page and selected nodes. A live locator and a Paper token hash do not
identify the whole approved design. Hash the actual local payload.

For `medium: "paper"`, all these fields are required:

```json
{
  "revision": "v3",
  "provenance": "design/provenance.json",
  "structure": "design/structure.json",
  "computed_styles": "design/computed-styles.json",
  "resolved_tokens": "design/resolved-tokens.json",
  "assets": ["design/assets/logo.svg"],
  "copy": "design/copy.json",
  "component_mappings": "design/component-mappings.json"
}
```

The extraction files can use the format actually exported by the tool. Their
content must preserve extracted structure, relevant computed styles, frozen
resolved token values, required assets, exact approved visible copy with state
mapping, and application component/source mappings. `assets: []` explicitly
records that no assets are needed. Missing extraction files block finalization;
do not substitute a screenshot while claiming source recovery. Native editable
Paper file restoration is not promised by this contract.

For `medium: "runtime"`, the manifest requires `source`, using the recoverable
code shape below. Captures and runtime checks remain separate descriptor
records. A launch path alone is insufficient source recovery.

For `medium: "references-only"`, the manifest requires
`omission: {"reason": "<specific scope>", "decision": "<actual human scope choice>"}`.
This is an affirmative scope choice. It does not waive required runtime checks.
A tool failure belongs in the unavailable-evidence record and accepted degraded
scope, not an invented references-only choice.

Optional `supporting_files` lists additional local binding files, or `[]`.
Any declared extraction, asset, source or supporting path remains binding even
when included with a different medium. Additional provenance metadata belongs
in the provenance file; register every additional binding file in the defined
path fields or `supporting_files`.

## Runtime checks and records

```json
{
  "required_checks": ["actual-component-focus"],
  "checks": [{
    "id": "actual-component-focus",
    "state_ids": ["success"],
    "result": "passed",
    "record": "runtime/actual-component-focus.json"
  }],
  "not_required_reason": null
}
```

Each check has a unique nonempty `id`, nonempty unique `state_ids` naming
existing states, `result` of `passed`, `failed` or `unavailable`, and an
inventoried local JSON `record`. Every required ID resolves exactly once.
An empty required list needs a substantive `not_required_reason`, explaining
why no pre-approval runtime checks were needed for the actual scope. Keep the
field present and use `null` when checks were required.

A failed required check always blocks. An unavailable required check needs
`status: "approved-with-degraded-evidence"` and `limitation` on the check naming
the exact limitation present in both `limitations` and
`approval.accepted_limitations`. Retain its check ID, record and missing gate.
Do not remove or relabel a required failure to pass finalization. Changed
requirements or approval need actual resolution and a new handoff identity.

Each record carries these fields:

```json
{
  "check_id": "actual-component-focus",
  "state_ids": ["success"],
  "result": "passed",
  "source_revision": "<exact application source revision>",
  "handoff": {
    "checkout_build": "<absolute checkout/build; commit and dirty snapshot identity or immutable build ID>",
    "start_command_and_working_directory": "<actual command; absolute cwd>",
    "base_url_and_target_route": "<reachable implementation route or device target>",
    "readiness_check": "<confirm the intended source/build is serving and ready>",
    "authentication_and_fixture_state_setup": "<fresh-context steps; credential reference, no secrets>",
    "required_viewports_platforms": "<sizes/platforms and relevant states>",
    "server_owner_lifetime": "<owner/session/process and availability through review>"
  },
  "source": {
    "kind": "local",
    "revision": "<same application source revision>",
    "paths": ["runtime/source/relevant-component.ts"],
    "dependencies": "runtime/dependencies.txt",
    "dirty_changes": ["runtime/dirty-source.patch"]
  },
  "supporting_files": ["runtime/focus-observations.md"]
}
```

`check_id`, `state_ids` in the same order and `result` must agree with the
descriptor check. `source_revision` must agree with `source.revision`; it need
not equal the design revision when a focused actual-app slice supplies proof.
Use all seven fields from the [runtime handoff](../../implementing-frontend-design/references/runtime-handoff.md).
The source/build, dependency setup and state preparation must let an independent
reviewer establish the intended runtime. A matching URL or screenshot alone
does not prove served-source identity.

For `unavailable`, add specific `unavailable_reason` and retain all seven
handoff fields, marking unknown values pending with reasons. `source: null`
is accepted only when that unavailable check names its explicitly accepted
degraded limitation. Otherwise retain recoverable source. Optional checks
remain recorded honestly; an omission reason never suppresses required checks.

## Recoverable code

Both runtime-authored manifests and runtime records use the same `source`
object. Local source requires `kind: "local"`, nonempty `revision`, nonempty
`paths` of retained source files or archives, a `dependencies` file naming
versions and reproducible setup, and `dirty_changes` listing retained patches
or snapshots. Use `dirty_changes: []` only when there are no uncommitted edits
outside the retained source snapshot. Include enough relevant code and assets
to recover the checked slice; a pathname to a temporary checkout is not code.

Alternatively:

```json
{
  "kind": "immutable-reference",
  "revision": "<immutable commit/archive/build identity>",
  "locator": "<immutable source reference>",
  "recovery_evidence": "runtime/source-recovery.json",
  "dependencies": "runtime/dependencies.txt",
  "dirty_changes": ["runtime/dirty-source.patch"]
}
```

The local recovery JSON records the same `locator` and `revision`,
`result: "passed"` and a nonempty `method` describing the retrieval and
verification actually performed. Retain uncommitted changes locally. Optional
local `paths` remain binding with this kind too. The helper checks the recovery
record's consistency; it does not contact a remote service or verify the truth
of its claim. The producer and independent reviewer establish recoverability.

## Targets, states and file containment

Each target has unique `id`, `path` within `references/`, `intent` of
`visual-truth`, `semantic-guidance` or `reference-only`, specific `scope`, exact
`source_version`, a `state` ID, and `viewport` with positive integer `width`
and `height`. A surviving earlier reference may have a different source
version with explicit limited authority and supersession in `packet.md`.

Each state has unique `id`, concrete `setup`, `references` listing current
target IDs, and `verification` of `exercised`, `source-inspected` or
`not-exercised`. References can be `[]` for a state described by recoverable
source and setup. Every target's declared state must exist and list that
target; cross-wired state references fail. A shared capture uses a separate
target ID for each state, with explicit scope. The screen index records actual
checks and exact evidence revision; a label alone is not execution evidence.

Every local binding path, including manifests, provenance, extraction, assets,
copy, mappings, code, dependency and dirty-change files, recovery records,
check records, supporting files and targets, must exist inside the verified
inventory. Use contained relative paths without symlinks, `..`, empty path
segments or absolute paths. Excluded directories and `history/` cannot hold
binding files. External locators never exempt associated local files from
these checks. Unreferenced generated dependencies remain excluded.

## Check result and exact handoff identity

`check` exits zero only when valid and returns `valid`, `errors` with actionable
`code`/`message`, `revision` and `descriptor_sha256`. Invalid JSON, missing files,
stale hashes, added or removed current files, stale approval, inconsistent
records and unsupported versions exit nonzero. I/O failures are structured
errors. `inventory` returns the current file map, or structured errors.

The descriptor is excluded from its own inventory. Carry the producer's exact
entry, revision, descriptor hash, human approval reference, status and accepted
limits outside the packet. On consumption use `--expected-revision` and
`--expected-descriptor-sha256`, unchanged from the existing CLI. Recover the
expected bytes or resolve the mismatch; rehashing a changed descriptor does
not recover approval. Structural validity establishes consistency only.

===== END SOURCE: skills/frontend-direction/references/packet-schema.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/SKILL.md =====
---
name: implementing-frontend-design
description: Use when implementing, verifying, or refining an approved visual and interaction target in a frontend, including version-2 packets and their scoped references.
---

# Implementing Frontend Design

Translate the approved design into working UI and verify its runtime fidelity. Work inside the active implementation workflow; no GSD context or new design-exploration cycle is required.

Read the shared [scoped design authority](../frontend-direction/references/design-source-priority.md). Business/technical/accessibility constraints and retained brand/shell still bind; the approved feature delta governs its hierarchy, composition and interactions. Old UI or DESIGN.md cannot silently replace that target.

## Inputs and scope

| Input state | Action |
| --- | --- |
| Approved version-2 packet | Validate the exact supplied identity and inspect binding design source, runtime records and references; implement without regenerating artifacts. |
| Required packet status `required` or `required-pending`, absent/unapproved target | Resolve the required direction before dependent implementation. |
| Historical packet/image pack or unsupported version | Reference material only; establish a new v2 handoff before dependent implementation. No migration or legacy fallback. |
| Missing reference intent or conflicting approvals | Clarify the specific binding decision. Record only explicitly approved degraded limits. |
| Mechanical change with settled design | Apply the narrow existing contract; no full frontend-direction loop. |
| Substantial unresolved direction | Return that decision to frontend-direction, reusing settled requirements. |

## Implement and compare

1. **Identify and inspect the target.** Current implementation handoffs require integer `schema_version: 2` and first-line marker `<!-- frontend-packet: 2 -->`. Follow the [finalization and recovery contract](../frontend-direction/references/packet-finalization.md): run its read-only `check` with the producing handoff's `--expected-revision` and `--expected-descriptor-sha256`. Missing, changed, malformed or unsupported descriptors block dependent implementation; recover the expected bytes, never refresh hashes to bless a replacement. Version 1 returns exactly: `Unsupported packet schema version 1. This workflow requires version 2; historical packets are reference material only.` Missing/other unsupported versions fail closed, including inputs without canonical signals. Historical files remain untouched context. Read the packet/brief, design manifest and its medium-specific payload, including structure/styles/frozen tokens/assets/copy/component mappings for Paper, exact binding captures, runtime evidence and recoverable source, state setup and supersession. Inspect current routes, components/tokens and project instructions for feasibility. Approved local snapshots work offline; live Paper access is not a consumption gate.
2. **Map the change.** Carry the complete [packet handoff record](../frontend-direction/references/packet-handoff.md) into the task's existing input fields unchanged: entry, expected revision/hash, approval reference, status and accepted limits. Recover missing canonical expectations from the producing handoff before dependent work. Include affected routes/components, invariants, retained anchors, approved delta and state acceptance sources. Reuse primitives where they support the approved composition; identify necessary component work where they do not.
3. **Integrate.** Implement the approved screens/states in the actual stack, including data/actions, keyboard/focus and responsive behavior. Use approved copy or `writing-ux-copy` for missing text; raster text is not a new copy contract.
4. **Verify runtime against the exact target.** Use the [implementation checklist](references/implementation-review-checklist.md): pass, mismatch or approved waiver per binding item; compare equivalent content/viewports and exercise interactions. For explicitly requested image references retained in v2, see [image consumption](references/chatgpt-image-source-consumption.md).
5. **Correct supported issues.** Optional [Impeccable quality work](../frontend-direction/references/impeccable-brownfield-quality-layer.md) provides focused audit/refinement. Apply in-scope corrections, then recheck changed rendering. Preserve the approved target when normalization suggests restoring old layouts; a true direction change returns to the design decision.
6. **Complete the active review.** For non-trivial UI, fulfill the fresh visual review below inside the existing review sequence. Reuse an equivalent independent pass rather than adding another orchestration family or duplicate review.

## Evidence boundaries

Web proof includes route/state checks, screenshots, relevant console/network observations and interactions. Native proof uses appropriate simulator/device captures, platform tests and accessibility evidence; load relevant mobile guidance only for that surface.

Synthetic fixtures and isolated prototypes prove the exercised visual/state/interaction behavior, not backend integration, auth, persistence or service wiring. Retain immutable approved design payloads and separate runtime records with recoverable code and final captures. Paper exports do not replace actual served-build identity or runtime checks. Logs/traces and transient screenshots are local by default. Record actual inspection and remaining limits; a screenshot file alone or a passing build is not reference fidelity.

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

After verification, reconcile affected maintained entries within the agreed allowance using [Paper library upkeep](../frontend-direction/references/paper-library.md). Preserve manual/concurrent edits and the original approval snapshot. Deferred upkeep retains `last_verified` revision/source/evidence and records the change, reason and intended verified application revision. It does not block an otherwise verified app delivery or waive defects, required proof or approval. Report application, library and workflow-adoption outcomes separately.

Report exact targets and versions used, implemented delta, runtime comparisons, interaction/state checks, fixture versus integration proof, review result, and unresolved mismatches or approved waivers. Missing runtime recapture cannot become approval through old screenshots or a plugin score.

===== END SOURCE: skills/implementing-frontend-design/SKILL.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/references/source-of-truth.md =====
# Source of Truth

Use the canonical [scoped authority and reference intents](../../frontend-direction/references/design-source-priority.md). The approved feature delta binds its scope; existing product conventions govern retained anchors and unspecified details. Only the exact approved v2 packet supplies the current design handoff. Historical packets remain untouched reference material; missing or unsupported versions fail closed without migration or legacy fallback.

Before coding, inspect exact selected target/version, design manifest and extracted payload, separate runtime records/recoverable source and state setup, supersession, copy, interactions, responsive behavior, technical limits and runtime verification expectations. Required pending direction is not a degraded-mode shortcut.

===== END SOURCE: skills/implementing-frontend-design/references/source-of-truth.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/visual-exploration.md =====
# Visual Exploration

Read when choosing how to explore, comparing alternatives or refining the interactive target.

## Choose the first artifact

| Unresolved question | First artifact |
| --- | --- |
| Substantial hierarchy, density, typography or screen composition | Rough sketches or [Paper](paper-workflow.md) structures comparing the unresolved composition choices, using actual content and established anchors. |
| Interaction, focus, disclosure, scrolling or uncertain component behavior | Small focused slice in the actual app, isolated from live writes. |
| Imagery or deliberate brand exploration | Assets or scoped visual references when requested or authorized. |
| Known local defect with settled direction | Direct correction and relevant runtime verification. |
| Current approved v2 target | Consume its exact packet in implementing-frontend-design. |

There is no required sequence through all media. When substantial composition is unresolved, compare a small useful set of inexpensive structures before polishing one. Alternatives change task flow, hierarchy or interaction, not merely color or card styling. Select by ease of use, clarity, visual quality and product fit, stating the benefit and cost. Settled patterns and mechanical changes use the direct path; no fixed image or artboard count. Narrow feedback reopens only the affected decision, not the whole exploration. Hold task, fixtures, shell, content and widths constant. Compare grouping, action placement and disclosure by task benefit and cost. Keep supported facts and business semantics separate from design hypotheses. Apply [task-to-layout](task-to-layout.md) and the relevant [design knowledge](design-knowledge-selection.md) before composing. Refine typography, spacing, alignment, contrast and emphasis with the task relationships in view.

Routine generated UI screenshots, Companion screen composition and a full standalone recreation are not stages in this workflow. If the user explicitly requests image-based UI concepts or Companion mockups, honor that scoped medium and count. The override does not waive final approval, exact copy or actual-component evidence.

## Comparable image concepts

For an explicit image-based UI concept request, read the available image-generation skill and current tool schema. Use built-in generation directly; generate separate images, not a contact sheet. Inspect local reference images before attaching them. Name each attachment's role: retained shell/brand, content/state evidence, or legacy composition to reconsider. Preserve only the named anchors; asking to preserve an entire weak screenshot defeats composition exploration.

Hold task, content, viewport, brand and constraints constant. Each alternative has a clear design idea and a task-related tradeoff. For example, a financial detail could compare a balance-led statement, an identity/context rail with ledger, and a scope-led account workspace. These are alternatives only when the available behavior supports them; a render cannot invent filters, scope switching or actions.

A useful prompt contains:

1. Flat, front-facing, high-fidelity UI screenshot; viewport and product task.
2. Reference roles and retained brand/shell.
3. This concept's hierarchy/composition/disclosure idea.
4. Exact representative synthetic content and approved visible labels.
5. Required data, states, controls and technical limits.
6. Distinctions the image must preserve and specific likely mistakes to avoid.

Keep technical state semantics separate from visible copy. If related states need images, reference the selected parent and change only state-specific content/affordances; preserve approved structure. Distinguish empty, unavailable, loading, permission-limited, partial failure and success according to the real screen contract. Explicitly identify hidden, disabled and read-only controls when relevant. Do not generate every state when the actual-app slice can demonstrate it better.

Before showing concepts, inspect missing information, invented controls, readability, density and scope. Record limitations; a beautiful render with missing essential content is not a viable choice. Name images A-v1/B-v1/C-v1 (or equivalent stable IDs) and show actual outputs with concise tradeoffs. Save output files or durable identities and prompt provenance.

## Selection and refinement

Record the exact chosen file/version and scoped feedback. A combined choice names what is inherited from each source. Show material revisions before final approval. A concept choice authorizes building that direction; the concrete final design and required interaction evidence still need review.

## Actual-component and browser evidence

For interaction-dependent or component-sensitive visual decisions, build the smallest risk-resolving actual-component slice with working controls and representative data. A known unchanged component used within verified constraints does not need another experiment. No screenshot background with invisible click regions. For existing applications, use an isolated route, component preview or worktree with the actual stack, installed primitives and product styles. Keep exploration isolated from live writes. Record the checkout/dependency versions and reproducible setup needed to restore the prototype.

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

Retain the v2 design manifest and extracted payload separately from runtime evidence. Runtime records retain recoverable code, all seven runtime handoff fields, source version, state setup and relevant captures. Record final browser targets that replace earlier images and their approved intent. Keep final approval distinct from concept selection. Capture alone is not verification: say what was inspected, changed and remains uncertain.

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
not required for Paper composition or actual-app checks. Never invent a screenshot or quietly turn
an explicit image-concept request into prose.

===== END SOURCE: skills/frontend-direction/references/visual-exploration.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/task-to-layout.md =====
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

Review the actual design and packet together. In the existing review evidence, record **ready for human review** or **requires changes**, tied to the exact rendered revision and experience brief. A valid packet, complete exports or functioning controls can still receive **requires changes**. For each consequential finding give the visible region/state, problem → task consequence → correction, plus unresolved limits. Correct those findings in the existing loop before seeking final approval; this verdict neither replaces human approval nor adds a reviewer or gate. No numeric quality score or unobserved usability claim.

- Does the primary task improve through hierarchy, grouping, density or interaction, with brand/shell and business constraints retained?
- Did the exploration medium answer the unresolved question? Did Paper composition use supported content and established anchors, and did actual-component checks resolve interaction/feasibility risks? Were task, content and widths consistent, with rough structural comparisons before polish when substantial composition remained unresolved, and the selected approach justified by ease, clarity, visual quality and product fit? Record the precise choice/refinement and any explicit scope or fallback.
- Do final captures match the retained design source and runtime evidence versions and representative content? Can another agent launch the same states?
- Are main, long, empty/loading/error, narrow and keyboard/focus paths covered where relevant, with fixture versus integration limits identified?
- Are exact reference versions, intent, binding scope and supersession clear under the shared authority contract?
- Are copy, i18n and accessibility constraints authoritative even when raster text differs?
- Does optional critique/audit evidence identify actual source/browser/detector work and missing steps without claiming a score proves quality?
- Were sensitive standalone-prototype details demonstrated with actual components before binding approval, or was missing proof explicitly accepted? Does the mapping record observed results rather than component names alone?
- Are visual approval, agent functional checks and human task observations recorded separately? Do task records identify who tried what, outcome/confusion and remaining hypotheses, or honestly state that human use was not observed?
- Does the rendered experience show clear hierarchy and next action, manageable interaction/load, useful feedback rather than duplicated field values, concise user-facing copy, deliberate type/spacing/alignment/grouping, readable contrast and accessibility? Check responsive task ordering rather than indiscriminate stacking, and empty/edit/error/completion states. Functional or overflow checks alone do not prove usefulness; a scaled screenshot does not prove reflow. Were consequential defects corrected before approval?
- Is affected library coverage honest, with pending upkeep retaining last verified identities under the agreed allowance?
- Has the human approved this concrete final version? A concept choice alone is insufficient.

Keep findings specific: observed evidence, task impact and correction. Rejected concepts remain provenance, not competing implementation targets.

===== END SOURCE: skills/frontend-direction/references/frontend-review-checklist.md =====

===== COMPLETE SOURCE: skills/implementing-frontend-design/references/runtime-handoff.md =====
# Implementation runtime for independent review

Put this block in the existing task or reviewer input. It describes the
implementation being reviewed; Paper extraction and design-source launch notes do not replace it. Version-2 runtime records retain these seven fields plus recoverable source, dependency setup and dirty changes under the shared packet schema.
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

- Did the v2 handoff pass [packet validation](../../frontend-direction/references/packet-finalization.md) with supplied expected revision/descriptor SHA-256? Did missing, unsupported or invalid metadata block dependent work? Historical references never supply a legacy implementation path.
- Are exact packet identity and state acceptance sources carried into implementation tasks, with current source/references distinguished from history? Were approval evidence and visual quality assessed separately from hashes?
- Does the complete [shared handoff record](../../frontend-direction/references/packet-handoff.md) match the producing handoff, including expected revision/hash, approval reference and accepted limitations?
- Did you read the approved brief/spec, available workflow context, frontend direction packet, exact approved design manifest/payload and separate runtime records/source versions and state setup, `screen-index.md`, `brownfield-ui-extraction.md`, selected visual-truth source, and available screenshots/captures first?
- If a handoff or `CONTEXT.md` said frontend packet status was `required` or `required-pending`, did you stop instead of implementing from degraded assumptions?
- If explicitly selected image references are retained in the v2 packet, did you read the exact approved generated image files and their approved reference intent?
- If brownfield, did you inspect existing tokens, components, shell patterns, interaction patterns, and current rendered UI?
- If no packet is required for a mechanical change, is that scope explicit? If a packet is required, did missing evidence remain pending rather than becoming an implicit degraded approval?

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
- Are hierarchy, grouping, useful density, typography, spacing, alignment, readable contrast, action clarity and feedback/recovery faithful and usable in the rendered app?
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
- Did that existing review consume the packet’s experience brief and rendered quality findings, and judge the actual app for useful feedback, task ordering, interaction load and state clarity as well as fidelity? A faithful implementation of a consequential design defect requires changes in the affected scope; valid hashes and functioning controls do not resolve it.
- Did the reviewer read project instructions first, including `AGENTS.md`, `PRODUCT.md`, `DESIGN.md`, the task file, and workflow or milestone context only when present?
- For web targets, did the visual reviewer use a fresh browser context and avoid reusing the implementer's browser session, storage, console state, or previously opened page?
- Did the visual reviewer independently open the target route/screen and recapture required evidence?
- If the target route/screen could not be opened due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, or test harness failure, did the review avoid approval and use `REQUEST_CHANGES` or `ESCALATE`?
- Did the visual review artifact include `Visual Review Completion Gates` with project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks, and every missing gate called out?

## 8. Recovery

- Can another agent recover the same frontend references from your recorded output?
- Were affected library entries reconciled within allowance, or left explicitly pending with unchanged last verified revision/source/evidence? Was app delivery reported separately without waiving defects?
- Did you keep `Frontend References` current when workflow artifacts are in scope?
- Did you avoid claiming completion from tests, DOM checks, or screenshot capture without reference-intent inspection?

===== END SOURCE: skills/implementing-frontend-design/references/implementation-review-checklist.md =====

===== COMPLETE SOURCE: skills/brainstorming/visual-companion.md =====
# Visual Companion Guide

Use the visual companion for temporary explanations, flows and product comparisons when seeing the structure, sequence or relationship materially improves the current brainstorming step. Screen composition belongs in Paper through frontend-direction even after Companion consent. An explicit Companion mockup request overrides that default for its scoped task; the runtime and product-mockup recipes remain supported.
If a choice survives, carry it into the frontend-direction follow-on prompt. The later frontend-direction session must capture it in the approved v2 design source and scoped evidence before treating it as durable direction.

## Useful-artifact authoring contract

Choose the smallest useful artifact intent for the current viewing task. These intents are examples, not an exhaustive whitelist:

1. **compare**
   - Show side-by-side directions or ranked alternatives when visual contrast helps a decision.
2. **explain**
   - Show an annotated recommendation, screenshot, evidence board, or focused visual callout.
3. **map**
   - Show architecture, data flow, state, sequence, dependency, journey, or relationship structure.
4. **experience**
   - For an explicit mockup request, show a mockup, wireframe, prototype fragment, layout, or interaction-state preview.
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

When frontend direction is required, the Companion may clarify a product flow, explain existing evidence or summarize a product decision. It does not routinely recreate the Paper screen composition. Explicit mockup requests keep the supported experience register and honest simulated fidelity.

The companion is still for **decision-making**, not for pretending the chosen reference or screenshot is already final implemented UI. The follow-on packet captures retained decisions in approved v2 design evidence, not raw temporary Companion files.

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

If this is a qualifying explanation, flow or product comparison, or an explicit Companion mockup request, the first such turn starts the companion path instead of remaining terminal-only. Complete the first-use context workflow, then fill the startup record below with the actual project directory before starting the server. Capture `url`, `screen_dir` and `state_dir`, share the complete keyed URL, and retain the server lifetime across turns. Each qualifying visual turn stays artifact-first: author or refresh the visual artifact first, make it viewable, tell the user what they are viewing and what decision it supports, then ask the decision or confirmation in terminal with the platform question tool when available.

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

The first-use startup action includes this record. Fill the project directory from the task's actual repository or project root; retain that input alongside the returned session fields.

```text
Project directory: <actual absolute project root>
Start command: bash <skill-dir>/scripts/start-server.sh --project-dir <same project root> --open
Server lifetime: <platform session/process kept alive across turns>
Returned session: url=<complete keyed URL>; screen_dir=<path>; state_dir=<path>
```

Start after consent, using the platform lifecycle below. `--open` opens the first pushed screen. Record returned values only after startup succeeds; a proposed action names its project directory and leaves unreturned fields pending.

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

===== COMPLETE SOURCE: skills/frontend-direction/references/paper-workflow.md =====
# Paper composition and recoverable handoff

Load this reference when Paper is the chosen authoring medium. Frontend-direction owns the design loop; Paper supplies editable composition. Use [visual exploration](visual-exploration.md) to choose the medium and [library upkeep](paper-library.md) to bound maintained coverage.

## Establish the baseline

Read the brief, current app and relevant source/tokens, affected library entries and applicable v2 approvals. Use [task-to-layout](task-to-layout.md) and the relevant substantive [design knowledge](design-knowledge-selection.md) before composing. Name the next user decision, supported facts and their meaning/source/scope, proposed grouping or action placement, benefit and cost. A plausible fixture cannot invent business semantics.

Load the installed Paper guide and tool schemas. Inspect `get_basic_info`, selection, affected tree/nodes, tokens and fonts before editing. Use explicit file/page identifiers where supported and verify returned file identity. Read current token values with `get_tokens`; a changed token content hash means reread tokens. That hash identifies token state, not the complete artwork. Check the installed font information before first typographic edits.

Follow the guide's canvas and tool restrictions while preserving product requirements, anchors, copy, accessibility and the installed component system. Aesthetic suggestions are not authority to choose arbitrary palettes, asymmetric data rows, unreadable labels or new component APIs. Paper canvas restrictions do not prohibit semantic tables or the application's grid system in production.

If Paper is unavailable before requested design, report the missing capability and obtain an explicit available-medium decision. Continue independent app/source inspection meanwhile. An already approved local snapshot remains consumable offline without reconnecting to Paper.

## Compose and critique

Use the shared experience brief and the [exploration rule](visual-exploration.md): unresolved substantial composition gets inexpensive structural comparisons before polish; settled patterns proceed directly. Choose using actual content and retained shell, with a task-related benefit and cost. Keep task, fixtures, widths and content equal. Use the smallest useful foundation and affected components; do not backfill a product catalog.

Preserve a checkpoint before changing maintained artwork. Read current affected nodes and source again when edits may have changed. Apply small targeted mutations; preserve manual organization and unaffected regions. Clone only to retain an approved baseline or useful comparison. Chat is the primary feedback channel. Direct canvas edits also count as evidence; compare concurrent code/canvas changes to their shared baseline before reconciling. Narrow annotations reopen only their affected choice.

Use screenshots after meaningful changes for critique, not as substitutes for source extraction. Apply the [frontend review checklist](frontend-review-checklist.md): hierarchy, grouping, useful density, typography, spacing, alignment, contrast, action clarity, feedback/recovery, copy and accessibility. Test long content and actual relevant container widths. A scaled screenshot cannot establish reflow. Record the rendered quality verdict in existing review evidence: observed defect, task impact, correction and remaining limits. A successful export or geometry check cannot turn a weak design into a passing verdict; fix consequential defects before approval. Complete the tool's node-working lifecycle when done.

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

===== END SOURCE: skills/frontend-direction/references/paper-workflow.md =====

===== COMPLETE SOURCE: skills/frontend-direction/references/paper-library.md =====
# Bounded Paper library upkeep

The library helps relevant feature work reuse verified design. It is a navigation and freshness record, not another approval authority or synchronization service. Keep maintained entries, feature drafts and immutable approved snapshots distinct, even when they share a Paper file.

## Scope at task start

Record initial coverage and the maintenance allowance in the existing task brief. Use `docs/design/paper/library.json` unless a suitable project record already owns this information. Ordinary scoped upkeep needs no extra project-wide approval ceremony.

| Context | Useful initial coverage |
| --- | --- |
| Greenfield | Approved brief, chosen stack, minimal foundation and components needed by the first flow. Establish a real app baseline through an early working slice. |
| Small brownfield | Relevant tokens, common components and representative screens justified by expected reuse. |
| Large brownfield | Touched screens and relevant shared components; expand through real feature work. |

Never invent a full catalog, palette or unsupported API to populate the library. A proposed greenfield component is not implemented until it exists and is verified. Mechanical local fixes stay in code; update an entry only if its represented UI changed. No per-chat-turn, per-commit or backend-only sync, full-product backfill, watcher or continuous two-way synchronization.

Read the current app/source, tokens, affected entries and current v2 approval evidence. Compare their recorded source/design revisions with current versions. Inspect relevant shared dependencies; unrelated code changes do not invalidate every entry. If a shared token/component changes, check affected uses relevant to the task and mark other dependent entries `needs-review` when validity is unknown. Updating one consumer never marks all consumers checked.

Refresh the relevant baseline within the allowance. If refresh must wait, work from directly inspected app/source evidence and keep the entry pending. Missing mappings or no traceable baseline means `unknown`. Preserve manual organization, draft proposals and unaffected edits. Before mutation retain a checkpoint; if code and Paper both changed, compare each with the last recorded baseline, preserve non-conflicting changes and reopen only an unresolved affected decision. Last-writer-wins is not reconciliation.

## Record shape and identity

Use an `entries` list. Each entry has a stable `id`, `kind`, scoped Paper locators, source/dependency mappings, exact approved packet identity, design and implemented revisions, `freshness`, `last_verified` and `pending`. Include last checked source/date, verification evidence, accepted differences and coverage limits in the existing record. The approved packet link carries its exact entry/revision/descriptor hash and approval reference; the library does not create a parallel approval history.

This abbreviated before/after example shows a deferred update after verified application revision `app-42`. Existing source mappings, locators and packet identity stay in the full entry:

```json
{
  "before": {
    "id": "branding.preview",
    "design_revision": "paper-7",
    "implemented_revision": "app-40",
    "freshness": "checked",
    "last_verified": {
      "revision": "paper-7",
      "source": "app-40",
      "evidence": "evidence/preview-app-40.md"
    },
    "pending": null
  },
  "after": {
    "id": "branding.preview",
    "design_revision": "paper-7",
    "implemented_revision": "app-40",
    "freshness": "needs-review",
    "last_verified": {
      "revision": "paper-7",
      "source": "app-40",
      "evidence": "evidence/preview-app-40.md"
    },
    "pending": {
      "change": "Reflect verified app-42 preview wrapping",
      "reason": "Maintenance allowance reached",
      "intended_verified_application_revision": "app-42"
    }
  }
}
```

`last_verified` retains revision, source and evidence unchanged until reconciliation is actually verified. Do not stamp new application identities onto stale or partially edited artwork. Partial/draft canvas edits remain unverified with the checkpoint retained. New entries have explicit `last_verified: null`, `freshness: "unknown"` and a pending reason stating that no verified baseline exists. Draft, approved and implemented states are separate; importing artwork or adding an index row proves none of them.

## Reconcile and stop

After meaningful UI verification, reconcile only affected maintained entries from the verified implementation. Record actual source identity, evidence and accepted adaptations; retain the original immutable approval snapshot. Small fidelity corrections stay in the app when they satisfy the contract. Changed hierarchy, interaction, token meaning, component API or material treatment reopens only the affected design decision and needs a new approved revision where required. Never normalize unapproved drift into the library.

Stop housekeeping when the agreed allowance is reached or further work would exceed it. If overrun is discovered mid-update, stop on discovery. Record each remaining change, reason, intended verified application revision and unchanged last verified revision/source/evidence. Do this minimum pending/freshness recording even when Paper is unavailable. Broader catch-up is a separate task or later use of the entry.

Pending housekeeping does not block an otherwise verified application delivery. Report app verification and library upkeep separately. The stopping rule cannot waive application tests, design fidelity, exact approval identity, required evidence or unresolved design/behavior defects.

## Evaluation and adoption

Keep candidate workflow status until regression and fresh-session behavior checks pass and a real pilot demonstrates the full v2 path, actual scoped library reconciliation, acceptable implementation fidelity and useful maintenance within the agreed effort. Measure setup, Paper iteration, export/handoff, implementation corrections and upkeep separately. Time spent alone is not useful coverage; name the reconciled entries and evidence. Report export friction, repeated screen authoring, manual repairs and pending work honestly.

An incomplete pilot, unproved reconciliation, failed required checks or impractical upkeep retains candidate status. Correct or narrow the workflow and rerun affected checks. Additional pending housekeeping may coexist with adoption once bounded reconciliation and the other criteria are met. Verified app delivery may precede workflow adoption. One screen does not establish long-term savings or general usability improvement; record unmeasured claims. Default activation is a separate evidence-based decision, never an automatic consequence of passing scripts.

===== END SOURCE: skills/frontend-direction/references/paper-library.md =====

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
