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

1. **Inspect the target.** Read the packet or approved brief, exact binding images, final prototype source/version, launch and state setup, copy source, responsive rules and interactions. Check supersession; earlier concepts remain history. Inspect current routes, components/tokens and project instructions for feasibility.
2. **Map the change.** Record affected route/components, invariants, retained anchors, approved delta, and target artifacts in the task's existing input and acceptance fields. Reuse primitives where they support the approved composition; identify necessary component work where they do not.
3. **Integrate.** Implement the approved screens/states in the actual stack, including data/actions, keyboard/focus and responsive behavior. Use approved copy or `writing-ux-copy` for missing text; raster text is not a new copy contract.
4. **Verify runtime against the exact target.** Use the [implementation checklist](references/implementation-review-checklist.md): pass, mismatch or approved waiver per binding item; compare equivalent content/viewports and exercise interactions. For historical image inputs, see [image consumption](references/chatgpt-image-source-consumption.md).
5. **Correct supported issues.** Optional [Impeccable quality work](../frontend-direction/references/impeccable-brownfield-quality-layer.md) provides focused audit/refinement. Apply in-scope corrections, then recheck changed rendering. Preserve the approved target when normalization suggests restoring old layouts; a true direction change returns to the design decision.
6. **Complete the active review.** For non-trivial UI, fulfill the fresh visual review below inside the existing review sequence. Reuse an equivalent independent pass rather than adding another orchestration family or duplicate review.

## Evidence boundaries

Web proof includes route/state checks, screenshots, relevant console/network observations and interactions. Native proof uses appropriate simulator/device captures, platform tests and accessibility evidence; load relevant mobile guidance only for that surface.

Synthetic fixtures and isolated prototypes prove the exercised visual/state/interaction behavior, not backend integration, auth, persistence or service wiring. Retain approved prototype sources and final captures as required design evidence. Logs/traces and transient screenshots are local by default. Record actual inspection and remaining limits; a screenshot file alone or a passing build is not reference fidelity.

## Fresh Visual Review

For non-trivial UI work, after implementation and runtime/reference verification:

- spawn a fresh reviewer in the active workflow
- reviewer reads project instructions first: `AGENTS.md`, `PRODUCT.md`, `DESIGN.md`, the task, approved packet/brief, references, and runtime evidence; include workflow or milestone context only when it exists
- for web targets, reviewer uses a fresh browser context when supported; do not reuse the implementer's browser session, storage, console state, or previously opened page
- reviewer independently opens the target route/screen and recaptures required platform evidence for desktop/mobile scope
- implementer screenshots, assertions, or summaries are comparison inputs, not a substitute for reviewer runtime proof
- if the target cannot run or be recaptured due to `ERR_CONNECTION_REFUSED`, connection refused, server unavailable, simulator/device unavailable, route failure, or test harness failure, reviewer must not approve and must use `REQUEST_CHANGES` or `ESCALATE`
- reviewer writes the visual review artifact with findings, verdict, review decision, and `Visual Review Completion Gates`: project instructions read, fresh runtime isolation or recorded fallback, independent runtime recapture, approved reference checklist completion, desktop/mobile platform scope, console/network or Flutter test/log checks, and missing gates

## Completion

Report exact targets and versions used, implemented delta, runtime comparisons, interaction/state checks, fixture versus integration proof, review result, and unresolved mismatches or approved waivers. Missing runtime recapture cannot become approval through old screenshots or a plugin score.
