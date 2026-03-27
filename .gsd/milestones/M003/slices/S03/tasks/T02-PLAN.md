---
estimated_steps: 5
estimated_files: 5
---

# T02: Tighten the reviewer prompt and smoke-check the shared review loop

**Slice:** S03 — Review loop hardening around the named regression family
**Milestone:** M003

## Description

Update the live reviewer dispatch prompt so it explicitly invokes the new M003 checklist gate for relevant visual-companion reviews while preserving the existing concise output contract and review-loop usability.

## Steps

1. Read `skills/brainstorming/spec-document-reviewer-prompt.md` alongside the updated `skills/brainstorming/references/spec-review-checklist.md`, `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and `docs/superpowers/specs/2026-01-22-document-review-system-design.md`.
2. Update the prompt so that when the reviewed spec or handoff changes or depends on the visual-companion workflow, the reviewer must use the checklist to audit the named pressure scenarios and fail missing first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback outcomes.
3. Add the M003 regression family to `Look especially hard for:` while preserving the exact `Status / Blocking Issues / Advisory Suggestions` response format and concise blocking-first posture.
4. Run `bash tests/claude-code/test-document-review-system.sh` as a generic smoke check; if it reveals prompt-contract drift, make the smallest wording adjustment needed and rerun.
5. Read back the updated prompt and confirm it points relevant reviews to the checklist-based M003 gate instead of duplicating the full checklist logic.

## Must-Haves

- [ ] `skills/brainstorming/spec-document-reviewer-prompt.md` explicitly tells reviewers to audit the named pressure scenarios when a reviewed spec or handoff touches the visual-companion workflow.
- [ ] The prompt keeps the existing concise reviewer output contract and the generic smoke test stays green after the wording change.

## Verification

- `bash tests/claude-code/test-document-review-system.sh`
- Read back `skills/brainstorming/spec-document-reviewer-prompt.md` and confirm it preserves `Status / Blocking Issues / Advisory Suggestions` while routing relevant visual-companion reviews through the hardened checklist.

## Observability Impact

- Signals changed: `skills/brainstorming/spec-document-reviewer-prompt.md` will explicitly route relevant visual-companion reviews through the checklist-based M003 regression gate while keeping the shared reviewer response contract stable.
- How to inspect later: read the prompt and confirm it conditionally points reviewers to `skills/brainstorming/references/spec-review-checklist.md` for visual-companion workflow changes, names the four required pressure-scenario outcomes, and still requires the exact `Status / Blocking Issues / Advisory Suggestions` structure.
- Failure visibility: prompt drift should be visible by readback alone as either missing relevance gating, missing linkage to the pressure-scenario family, missing one of the four required outcomes, or reviewer-output-format drift.

## Inputs

- `skills/brainstorming/spec-document-reviewer-prompt.md` — the live reviewer dispatch prompt that must stay contract-compatible
- `skills/brainstorming/references/spec-review-checklist.md` — the detailed M003 review gate the prompt should invoke
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — the named regression family the prompt should reference through the checklist
- `docs/superpowers/specs/2026-01-22-document-review-system-design.md` — the reviewer-system design contract and output-shape reminder
- `tests/claude-code/test-document-review-system.sh` — the generic smoke test for prompt usability

## Expected Output

- `skills/brainstorming/spec-document-reviewer-prompt.md` — updated with explicit conditional instructions for the named M003 regression family while preserving the existing reviewer contract
