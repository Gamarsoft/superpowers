# S03: Review loop hardening around the named regression family — UAT

**Milestone:** M003
**Written:** 2026-03-30

## UAT Type

- UAT mode: artifact-driven
- Why this mode is sufficient: S03 hardens authored review assets, not runtime behavior. The proof comes from checklist/prompt readback plus the shared document-review smoke loop.

## Preconditions

- `skills/brainstorming/references/spec-review-checklist.md` includes the S03 review gate.
- `skills/brainstorming/spec-document-reviewer-prompt.md` includes the matching routing language.
- For the smoke script, either:
  - the environment already provides `timeout` and `claude`, or
  - the tester is prepared to use the same transient PATH-only shims used during slice verification.

## Smoke Test

Open `skills/brainstorming/references/spec-review-checklist.md` and confirm there is a section titled `## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)` that tells reviewers to skip it silently when the visual-companion workflow is out of scope.

## Test Cases

### 1. Checklist blocks the named protocol regression family only when relevant

1. Open `skills/brainstorming/references/spec-review-checklist.md`.
2. Read section `## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)`.
3. Confirm it explicitly says the subsection applies only when the reviewed design spec or GSD handoff changes, describes, or depends on the visual-companion workflow.
4. Confirm it points to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
5. Confirm it requires reviewers to compare both the design spec and the GSD handoff.
6. Confirm it names all four blocking outcomes: first-turn startup, artifact-first sequencing, terminal question-tool continuity, and explicit degraded fallback.
7. **Expected:** The checklist gives a reviewer enough detail to fail a relevant spec or handoff on any missing named outcome, while staying silent for unrelated review work.

### 2. Reviewer prompt preserves the stable review contract while routing relevant reviews through the new gate

1. Open `skills/brainstorming/spec-document-reviewer-prompt.md`.
2. Read the main prompt template block.
3. Confirm it still instructs the reviewer to output exactly:
   - `## Spec Review`
   - `**Status:** ✅ Approved | ❌ Issues Found`
   - `### Blocking Issues`
   - `### Advisory Suggestions`
4. Confirm it explicitly tells reviewers that when a reviewed spec or GSD handoff changes, describes, or depends on the visual-companion workflow, they must apply the checklist’s visual-companion regression subsection before approving.
5. Confirm `Look especially hard for:` now includes the named M003 regression family via the checklist gate instead of restating the full checklist.
6. **Expected:** The prompt still matches the existing reusable review contract, but relevant visual-companion reviews are now routed through the hardened checklist gate.

### 3. Shared review-loop smoke test still catches blocking issues

1. Run `bash tests/claude-code/test-document-review-system.sh` directly.
2. If it fails because `timeout` or `claude` is unavailable, create transient PATH-only shims equivalent to the slice verification setup and rerun the same command.
3. Confirm the script creates the intentionally bad spec, runs the reviewer, and prints `STATUS: PASSED` at the end.
4. Inspect the smoke output and confirm the reviewer:
   - catches the TODO in Requirements,
   - catches the deferred “specified later” content,
   - emits an Issues/Blocking section, and
   - does not approve the bad spec.
5. **Expected:** The shared review loop still works after the prompt/checklist hardening, and the reviewer contract remains intact.

## Edge Cases

### Unrelated specs are not falsely blocked by the visual-companion gate

1. Use the same smoke script output from Test Case 3.
2. Note that the intentionally bad test spec does not touch the visual-companion workflow.
3. Confirm the smoke test still passes based on the ordinary review criteria alone, without any requirement that the output mention first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback.
4. **Expected:** The new gate behaves as conditional logic, not as a global blocker for unrelated specs.

## Failure Signals

- Section `## 10. Visual-companion protocol regression checks (conditional, blocking when relevant)` is missing or no longer relevance-gated.
- The checklist stops pointing to `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
- Any of the four named protocol outcomes is missing from the checklist gate.
- The reviewer prompt no longer preserves `Status / Blocking Issues / Advisory Suggestions`.
- The reviewer prompt duplicates detailed checklist logic instead of routing to the checklist.
- The smoke test approves the intentionally flawed spec or stops reporting TODO / deferred-content failures.

## Requirements Proved By This UAT

- R039 — Proves the review assets explicitly enforce the named protocol regression family while preserving the shared review-loop contract.

## Not Proven By This UAT

- R041 — This UAT does not prove the selective wireframe appendix guidance; that belongs to S04.
- Any runtime, helper, or frame-template behavior — S03 is an authored review-surface slice only.

## Notes for Tester

If the smoke script fails immediately with `timeout: command not found` or `claude: command not found`, that is an environment issue already observed during slice execution, not necessarily a regression in the authored assets. Re-run with transient PATH-only shims rather than editing repository test files.
