---
estimated_steps: 6
estimated_files: 5
---

# S03: Review loop hardening around the named regression family

**Goal:** Harden the brainstorming review loop so specs and handoffs that change or depend on the visual-companion workflow are explicitly failed when they miss the named M003 protocol outcomes: first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback wording.
**Demo:** A future agent can open `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md`, see the named pressure scenarios enforced as a conditional blocking gate for visual-companion-dependent review work, and run the existing document-review smoke test without breaking the reviewer contract.

## Description

This slice directly owns **R039**. I’m grouping the work into two tasks because the main risk is drift between the two live review surfaces, not missing prose volume. First, harden the checklist into the detailed, conditional gate that reviewers can apply to both the design spec and the GSD handoff without relying on memory. Second, tighten the reviewer prompt so it routes relevant reviews through that checklist, preserves the existing `Status / Blocking Issues / Advisory Suggestions` contract, and gets a light smoke-check to prove the shared review loop still behaves as expected. That order keeps the named pressure-scenario artifact as the single vocabulary source, avoids duplicating detailed protocol logic in two places, and prevents a global review asset from becoming an unconditional visual-companion requirement for unrelated specs.

## Must-Haves

- `skills/brainstorming/references/spec-review-checklist.md` contains a clearly conditional blocking review path for specs or handoffs that change, describe, or depend on the visual-companion workflow, and it points reviewers to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
- The checklist fails missing first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback outcomes across both the spec and the GSD handoff when the visual-companion workflow is in scope.
- `skills/brainstorming/spec-document-reviewer-prompt.md` preserves the current reviewer dispatch contract and output format while explicitly instructing reviewers to audit the named pressure scenarios and fail missing outcomes when relevant.
- The slice stays above runtime, helper, frame-template, and wireframe-appendix scope.

## Proof Level

- This slice proves: contract
- Real runtime required: no
- Human/UAT required: no

## Verification

- Read back `skills/brainstorming/references/spec-review-checklist.md` and confirm it has a blocking visual-companion protocol regression check that is relevance-gated, references the pressure-scenario artifact directly, and names the four required outcomes for both spec and handoff review.
- Read back `skills/brainstorming/spec-document-reviewer-prompt.md` and confirm it still uses the existing concise review contract (`Status`, `Blocking Issues`, `Advisory Suggestions`) while instructing reviewers to use the checklist and named pressure scenarios when a reviewed artifact touches the visual-companion workflow.
- `bash tests/claude-code/test-document-review-system.sh` — smoke guard that the prompt and checklist changes do not break the reusable document-review loop. This is a safeguard, not the sole proof of R039.

## Observability / Diagnostics

- Runtime signals: none; this slice closes on authored review-surface wording plus a generic smoke-test result.
- Inspection surfaces: `skills/brainstorming/references/spec-review-checklist.md`, `skills/brainstorming/spec-document-reviewer-prompt.md`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and `bash tests/claude-code/test-document-review-system.sh`.
- Failure visibility: checklist and prompt readback should show whether the remaining gap is missing relevance gating, missing pressure-scenario linkage, missing one of the four required outcomes, or reviewer-output-format drift.
- Redaction constraints: keep the review instructions generic and protocol-focused; do not embed user-specific artifacts, transcripts, or secrets.

## Integration Closure

- Upstream surfaces consumed: `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, `skills/brainstorming/references/spec-review-checklist.md`, `skills/brainstorming/spec-document-reviewer-prompt.md`, `docs/superpowers/specs/2026-01-22-document-review-system-design.md`, and `tests/claude-code/test-document-review-system.sh`.
- New wiring introduced in this slice: the checklist and reviewer prompt explicitly route relevant spec and handoff reviews through the named M003 pressure-scenario gate instead of relying on reviewer memory.
- What remains before the milestone is truly usable end-to-end: S04 must add the narrow wireframe-appendix guidance and rerun the final integrated acceptance stack.

## Tasks

- [x] **T01: Add conditional protocol-regression gates to the spec review checklist** `est:40m`
  - Why: R039 will stay soft if the detailed checklist still relies on generic “visual clarity” language or reviewer memory instead of naming the exact protocol outcomes that must block spec and handoff approval.
  - Files: `skills/brainstorming/references/spec-review-checklist.md`
  - Do: Add a clearly labeled blocking checklist subsection for visual-companion protocol regression checks that applies only when the reviewed spec or handoff changes, describes, or depends on the visual-companion workflow; point that subsection to the pressure-scenario artifact directly; mirror the exact S02 protocol vocabulary for first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback; require reviewers to compare both the design spec and the GSD handoff against the same outcomes; and keep the rest of the checklist’s global structure intact.
  - Verify: Read back the updated checklist and confirm the new subsection is relevance-gated, references the named pressure-scenario artifact, and treats each of the four protocol outcomes as blocking when missing from the spec or handoff.
  - Done when: the checklist can independently direct a reviewer to fail any relevant spec or handoff that omits one of the four named M003 outcomes, without creating a false blocking rule for unrelated work.
- [x] **T02: Tighten the reviewer prompt and smoke-check the shared review loop** `est:35m`
  - Why: The prompt is the live dispatch surface for the review loop; if it does not invoke the new checklist gate explicitly or if it breaks the existing reviewer contract, the checklist hardening will not reliably reach actual review runs.
  - Files: `skills/brainstorming/spec-document-reviewer-prompt.md`
  - Do: Update the reviewer prompt so it explicitly tells reviewers that when the reviewed spec or handoff changes or depends on the visual-companion workflow, they must use the checklist to audit the named pressure scenarios and fail missing first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback outcomes; add this regression family to the prompt’s `Look especially hard for:` guidance; preserve the exact response format and concise blocking/advisory split; avoid duplicating the full checklist logic in the prompt; then run the generic document-review smoke test and make only minimal wording adjustments if the prompt contract regresses.
  - Verify: `bash tests/claude-code/test-document-review-system.sh` and read back `skills/brainstorming/spec-document-reviewer-prompt.md` to confirm the prompt still preserves the reviewer output contract while pointing relevant reviews to the named pressure-scenario gate.
  - Done when: the prompt preserves the existing dispatch contract, explicitly routes relevant visual-companion reviews through the hardened checklist, and the generic document-review smoke test stays green.

## Files Likely Touched

- `skills/brainstorming/references/spec-review-checklist.md`
- `skills/brainstorming/spec-document-reviewer-prompt.md`
- `.gsd/milestones/M003/slices/S03/S03-SUMMARY.md`
