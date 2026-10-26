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
