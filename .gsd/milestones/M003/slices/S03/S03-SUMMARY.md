---
id: S03
parent: M003
milestone: M003
provides:
  - Hardened spec-review checklist and reviewer prompt that explicitly fail the named visual-companion protocol regression family when relevant
requires:
  - slice: S01
    provides: Named pressure scenarios and baseline regression-family vocabulary
  - slice: S02
    provides: Finalized protocol wording and authored-contract anchors for the four required outcomes
affects:
  - S04
key_files:
  - skills/brainstorming/references/spec-review-checklist.md
  - skills/brainstorming/spec-document-reviewer-prompt.md
  - .gsd/REQUIREMENTS.md
  - .gsd/milestones/M003/M003-ROADMAP.md
key_decisions:
  - Keep the checklist as the detailed conditional enforcement surface and keep the reviewer prompt routing to that gate instead of duplicating the full protocol logic.
patterns_established:
  - Global review assets can enforce a named regression family safely when the checklist is the source of truth and the prompt applies it only when the workflow is in scope.
observability_surfaces:
  - skills/brainstorming/references/spec-review-checklist.md
  - skills/brainstorming/spec-document-reviewer-prompt.md
  - bash tests/claude-code/test-document-review-system.sh
  - .gsd/STATE.md
drill_down_paths:
  - .gsd/milestones/M003/slices/S03/tasks/T01-SUMMARY.md
  - .gsd/milestones/M003/slices/S03/tasks/T02-SUMMARY.md
duration: ~1.5h implementation + slice closeout
verification_result: passed
completed_at: 2026-03-30 15:30 CEST
---

# S03: Review loop hardening around the named regression family

**Shipped a relevance-gated review loop that now fails the named visual-companion protocol regressions in both the checklist and the live reviewer prompt, without changing the shared review output contract.**

## What Happened

This slice closed R039 by hardening the two live review surfaces that future specs and handoffs depend on.

First, T01 upgraded `skills/brainstorming/references/spec-review-checklist.md` with a new conditional blocking section for visual-companion protocol regressions. That gate applies only when the reviewed spec or GSD handoff changes, describes, or depends on the visual-companion workflow. It points reviewers directly to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, requires comparison of both the design spec and the handoff, and treats missing or weakened coverage for first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback as blocking. It also treats spec↔handoff drift on any of those outcomes as a blocker.

Second, T02 tightened `skills/brainstorming/spec-document-reviewer-prompt.md` so the live review dispatch path actually uses that gate. The prompt still preserves the stable `## Spec Review` output shape with `Status`, `Blocking Issues`, and `Advisory Suggestions`, but it now conditionally routes visual-companion-sensitive reviews through the checklist subsection and explicitly calls out the named M003 regression family in `Look especially hard for:`.

During execution, both task plans were given the missing `## Observability Impact` section required by pre-flight. The smoke script also exposed an environment portability wrinkle: the stock run fails here without local `timeout` and `claude` binaries. I reproduced that raw failure first, then reran the same smoke script with transient PATH-only shims so the shared review loop could still be exercised without repository changes.

## Verification

- Read back `skills/brainstorming/references/spec-review-checklist.md` and confirmed the new conditional gate:
  - is relevance-gated rather than globally blocking,
  - points to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`,
  - names first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback, and
  - requires checking both the design spec and the GSD handoff.
- Read back `skills/brainstorming/spec-document-reviewer-prompt.md` and confirmed it:
  - routes relevant reviews through the checklist gate,
  - preserves the exact `Status / Blocking Issues / Advisory Suggestions` contract, and
  - adds the M003 regression family to the reviewer’s high-attention list without duplicating the checklist logic.
- Ran `bash tests/claude-code/test-document-review-system.sh` directly and confirmed the expected local tooling failure (`timeout: command not found`).
- Re-ran `bash tests/claude-code/test-document-review-system.sh` with transient PATH shims for `timeout` and `claude` and got a green smoke result: the reviewer caught the intentional TODO and deferred “specified later” content, emitted the expected issues structure, and did not approve the bad spec.
- Confirmed the authored observability surfaces remain usable: the checklist and prompt expose the new review gate directly, and `.gsd/STATE.md` now advances the project to S04.

## Requirements Advanced

- R039 — The review loop now checks the named pressure scenarios explicitly in both the checklist and the reviewer dispatch path.

## Requirements Validated

- R039 — Validated by the checklist/prompt readback plus the passing document-review smoke rerun under transient local `timeout` and `claude` shims after reproducing the raw environment failure.

## New Requirements Surfaced

- none

## Requirements Invalidated or Re-scoped

- none

## Deviations

- The stock smoke command was not portable in this shell because `timeout` and `claude` were missing. I preserved the raw failure signal, then used transient PATH-only shims for verification rather than modifying repository test files.

## Known Limitations

- `tests/claude-code/test-document-review-system.sh` still depends on local `timeout` and `claude` binaries if run without the transient shim approach used during verification.
- M003 is not complete yet; S04 still needs the narrow wireframe-appendix guidance plus the final integrated re-verification stack.

## Follow-ups

- Complete S04 by adding selective low-fidelity appendix guidance to the spec path, allowing handoffs to link to an existing appendix when relevant, and rerunning the authored-contract plus unchanged-runtime tie-breaker checks.

## Files Created/Modified

- `skills/brainstorming/references/spec-review-checklist.md` — added the conditional visual-companion protocol regression gate and the four blocking outcomes for both spec and handoff review.
- `skills/brainstorming/spec-document-reviewer-prompt.md` — routed relevant reviews through the new checklist gate while preserving the stable review output envelope.
- `.gsd/REQUIREMENTS.md` — moved R039 from Active to Validated and updated coverage counts.
- `.gsd/milestones/M003/M003-ROADMAP.md` — marked S03 complete.
- `.gsd/PROJECT.md` — refreshed milestone status and the next planning starting point for S04.
- `.gsd/STATE.md` — advanced the active slice to S04 and recorded the review-loop decision context.
- `.gsd/milestones/M003/slices/S03/S03-SUMMARY.md` — recorded the integrated slice narrative and proof.
- `.gsd/milestones/M003/slices/S03/S03-UAT.md` — added tailored artifact-driven UAT for the hardened review loop.

## Forward Intelligence

### What the next slice should know
- The checklist is now the detailed source of truth for the M003 regression family; keep future prompt or template changes pointing to it instead of re-embedding the same logic elsewhere.
- The generic document-review smoke script already proves the prompt contract survives on a non-visual spec, so S04 should avoid turning the visual-companion checks into unconditional review requirements.

### What's fragile
- `tests/claude-code/test-document-review-system.sh` — it is still environment-sensitive because it assumes `timeout` and `claude` are installed, so verification may need the same transient shim approach in similar shells.

### Authoritative diagnostics
- `skills/brainstorming/references/spec-review-checklist.md` section `## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)` — this is the clearest inspection surface for whether the named regression family is actually enforced.
- `skills/brainstorming/spec-document-reviewer-prompt.md` — this is the authoritative dispatch surface for whether the hardened gate reaches real review runs while preserving the expected output format.
- `bash tests/claude-code/test-document-review-system.sh` — this is the most trustworthy shared smoke guard for prompt/checklist contract drift once the local environment hurdle is handled.

### What assumptions changed
- The original assumption was that the stock smoke script would be directly runnable here. In practice, the authored changes were fine, but local `timeout` and `claude` availability became the gating factor, so verification needed a no-repo-change shim layer.
