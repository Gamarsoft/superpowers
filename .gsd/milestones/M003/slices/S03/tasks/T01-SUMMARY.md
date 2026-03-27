---
id: T01
parent: S03
milestone: M003
provides:
  - Conditional visual-companion protocol regression gate in the spec review checklist
key_files:
  - skills/brainstorming/references/spec-review-checklist.md
  - .gsd/milestones/M003/slices/S03/tasks/T01-PLAN.md
key_decisions:
  - Keep the checklist as the detailed, relevance-gated enforcement surface and leave reviewer-prompt tightening to T02
patterns_established:
  - Visual-companion review gates must cite the pressure-scenario artifact and fail spec↔handoff drift on the four named outcomes
observability_surfaces:
  - skills/brainstorming/references/spec-review-checklist.md
  - .gsd/milestones/M003/slices/S03/tasks/T01-PLAN.md
  - tests/claude-code/test-document-review-system.sh
duration: 35m
verification_result: passed
completed_at: 2026-03-30 15:12:37 CEST
# Set blocker_discovered: true only if execution revealed the remaining slice plan
# is fundamentally invalid (wrong API, missing capability, architectural mismatch).
# Do NOT set true for ordinary bugs, minor deviations, or fixable issues.
blocker_discovered: false
---

# T01: Add conditional protocol-regression gates to the spec review checklist

**Added a relevance-gated blocking checklist subsection that fails visual-companion protocol regressions across both the design spec and the GSD handoff.**

## What Happened

I started by fixing the flagged pre-flight gap in `.gsd/milestones/M003/slices/S03/tasks/T01-PLAN.md`, adding an `## Observability Impact` section so future agents can inspect the new authored proof surface directly.

Then I read the live checklist, the named pressure-scenario artifact, and the S02-proved workflow wording in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`.

With that wording in hand, I updated `skills/brainstorming/references/spec-review-checklist.md` to add a new blocking subsection: `## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)`. The new gate:

- applies only when the reviewed design spec or GSD handoff changes, describes, or depends on the visual-companion workflow
- stays silent for unrelated review work
- points directly to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`
- requires reviewers to compare **both** the design spec and the GSD handoff
- treats missing or weakened `first-turn startup`, `artifact-first sequencing`, `terminal question-tool continuity`, and `explicit degraded fallback` coverage as blocking
- treats spec↔handoff drift on any of those outcomes as blocking even if one artifact is otherwise correct

I did not change `skills/brainstorming/spec-document-reviewer-prompt.md` in this task; that remains the explicit scope of T02.

## Verification

### Task-level verification
- Read back `skills/brainstorming/references/spec-review-checklist.md` and confirmed the new subsection is explicitly relevance-gated.
- Confirmed the subsection points to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
- Confirmed the subsection names all four required outcomes with the S02-proved vocabulary.
- Confirmed the subsection instructs reviewers to compare **both** the design spec and the GSD handoff and to fail spec↔handoff drift.

### Slice-level verification status
- **PASS:** checklist readback now shows a blocking, relevance-gated visual-companion regression gate with direct pressure-scenario linkage.
- **NOT YET PASSING (expected for T01):** `skills/brainstorming/spec-document-reviewer-prompt.md` still preserves the concise `Status / Blocking Issues / Advisory Suggestions` contract, but it does not yet route relevant reviews through the named pressure scenarios; that is the planned scope of T02.
- **BLOCKED BY LOCAL TOOLING:** `bash tests/claude-code/test-document-review-system.sh` could not complete in this environment. The native run failed because macOS lacks GNU `timeout`; a rerun with a temporary local `timeout` shim advanced to the next environment blocker, `claude: command not found`. This did not reveal a checklist regression.

## Diagnostics

- Inspect `skills/brainstorming/references/spec-review-checklist.md`, section `## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)`.
- Inspect `.gsd/milestones/M003/slices/S03/tasks/T01-PLAN.md`, section `## Observability Impact`, for the intended future inspection path.
- The smoke-guard environment blockers are visible by rerunning `bash tests/claude-code/test-document-review-system.sh` locally: first `timeout: command not found`, then `claude: command not found` if a temporary timeout shim is supplied.

## Quality Check

**Diff reviewed:** tracked working tree vs HEAD — 3 files, 20 insertions, 1 deletion; plus 1 new untracked task-summary file
**Checklists applied:** security, code-quality

### Issues Found

#### Critical
- None.

#### Important
- None in the authored diff.

#### Minor
- `tests/claude-code/test-document-review-system.sh` depends on local `timeout` and `claude` binaries, which prevented full smoke execution in this environment.

**Verdict:** PASS WITH NOTES

## Deviations

- Added the missing `## Observability Impact` section to `T01-PLAN.md` before implementation because the unit pre-flight explicitly required that repair.

## Known Issues

- `tests/claude-code/test-document-review-system.sh` is not currently portable to this environment without external tooling: GNU `timeout` is absent on macOS, and the `claude` CLI is also unavailable here.
- `skills/brainstorming/spec-document-reviewer-prompt.md` still needs the T02 routing update before the full slice verification set can pass.

## Files Created/Modified

- `skills/brainstorming/references/spec-review-checklist.md` — added the conditional blocking visual-companion protocol regression gate and the four named outcomes for both spec and handoff review.
- `.gsd/milestones/M003/slices/S03/tasks/T01-PLAN.md` — added the missing `Observability Impact` section required by unit pre-flight.
- `.gsd/milestones/M003/slices/S03/S03-PLAN.md` — marked T01 complete.
- `.gsd/STATE.md` — advanced the slice’s next action to T02 and noted the remaining local verification/tooling blockers.
- `.gsd/milestones/M003/slices/S03/tasks/T01-SUMMARY.md` — recorded implementation, verification, diagnostics, and remaining slice-level gaps.
