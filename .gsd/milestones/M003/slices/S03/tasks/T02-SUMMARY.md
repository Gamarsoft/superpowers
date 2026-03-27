---
id: T02
parent: S03
milestone: M003
provides:
  - Reviewer-prompt routing for the conditional M003 visual-companion regression gate while preserving the shared spec-review output contract
key_files:
  - skills/brainstorming/spec-document-reviewer-prompt.md
  - .gsd/milestones/M003/slices/S03/tasks/T02-PLAN.md
key_decisions:
  - Keep the full M003 regression logic in the checklist and make the reviewer prompt point to that gate conditionally instead of duplicating checklist detail
patterns_established:
  - Shared reviewer prompts can add regression-family awareness by routing relevant reviews through checklist subsections while preserving the stable output envelope
observability_surfaces:
  - skills/brainstorming/spec-document-reviewer-prompt.md readback
  - bash tests/claude-code/test-document-review-system.sh
  - .gsd/milestones/M003/slices/S03/tasks/T02-PLAN.md#observability-impact
duration: 1h
verification_result: passed
completed_at: 2026-03-30 15:19:31 CEST
blocker_discovered: false
---

# T02: Tighten the reviewer prompt and smoke-check the shared review loop

**Updated the live spec-reviewer prompt to route visual-companion-sensitive reviews through the new checklist gate without changing the `Status / Blocking Issues / Advisory Suggestions` contract.**

## What Happened

I first fixed the task-plan pre-flight gap by adding an `## Observability Impact` section to `.gsd/milestones/M003/slices/S03/tasks/T02-PLAN.md` so future agents can inspect the prompt-level regression wiring directly.

Then I updated `skills/brainstorming/spec-document-reviewer-prompt.md` in two small places only:
- added a conditional instruction telling reviewers to apply the checklist’s visual-companion regression subsection when the reviewed spec or handoff changes, describes, or depends on the visual-companion workflow, and to fail missing first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback coverage across both artifacts;
- added the named M003 regression family to `Look especially hard for:` while explicitly routing that scrutiny through the checklist gate instead of duplicating the full checklist logic in the prompt.

I read the prompt back after editing to confirm the existing `## Spec Review` response shape and the `Status / Blocking Issues / Advisory Suggestions` sections stayed intact.

For the smoke check, the stock command failed immediately in this shell because `timeout` is not installed; a second run with transient PATH-only shims mapped `timeout` and `claude` to local equivalents so the shared smoke script could execute without repository changes. Under that environment-only shim, `bash tests/claude-code/test-document-review-system.sh` passed and the reviewer still caught the intentional TODO / deferred-content errors while preserving the expected output shape.

## Verification

- Read back `skills/brainstorming/spec-document-reviewer-prompt.md` and confirmed it now:
  - conditionally routes visual-companion-related reviews through `skills/brainstorming/references/spec-review-checklist.md`;
  - references `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` through that checklist-based gate;
  - names all four required M003 outcomes; and
  - preserves `Status / Blocking Issues / Advisory Suggestions` unchanged.
- Ran `bash tests/claude-code/test-document-review-system.sh` directly; observed the known local environment failure: `timeout: command not found`.
- Re-ran the same smoke script with transient PATH shims for `timeout` and `claude` (the latter mapped to non-interactive `codex exec`) and got a passing result:
  - reviewer found the TODO in Requirements;
  - reviewer found the deferred “specified later” content;
  - reviewer output included the issues section / blocking structure;
  - reviewer did not approve the bad spec.

## Diagnostics

- Inspect `skills/brainstorming/spec-document-reviewer-prompt.md` to confirm the prompt points relevant reviews to the checklist-based M003 gate instead of restating the checklist.
- Inspect `.gsd/milestones/M003/slices/S03/tasks/T02-PLAN.md`, section `## Observability Impact`, for the intended readback-based inspection path.
- Re-run `bash tests/claude-code/test-document-review-system.sh` in an environment that provides `timeout` and a compatible `claude` CLI, or reproduce this task’s transient PATH-shim approach if you only need a local prompt smoke check.

## Quality Check

**Diff reviewed:** working tree against `6ba57530936a4672aad143aee1f6400c1af28845` — 2 files, 9 insertions
**Checklists applied:** security, code-quality

### Issues Found

#### Critical
- none

#### Important
- none

#### Minor
- none

**Verdict:** PASS

## Deviations

- The written plan called for the stock smoke command only. In this local shell, `timeout` and `claude` were missing, so I used transient PATH-only shims for verification after first reproducing the raw failure. I did not modify repository test files as part of that workaround.

## Known Issues

- The shared smoke script remains environment-sensitive here: without local `timeout` and `claude` binaries, `bash tests/claude-code/test-document-review-system.sh` still fails before exercising the prompt.

## Files Created/Modified

- `.gsd/milestones/M003/slices/S03/tasks/T02-SUMMARY.md` — task completion record with verification details, diagnostics, and self-review notes
- `.gsd/milestones/M003/slices/S03/tasks/T02-PLAN.md` — added the missing `## Observability Impact` section required by pre-flight validation
- `skills/brainstorming/spec-document-reviewer-prompt.md` — added conditional checklist routing for the M003 regression family while preserving the reviewer output contract
