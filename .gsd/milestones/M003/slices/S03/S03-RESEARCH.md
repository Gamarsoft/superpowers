# S03: Review loop hardening around the named regression family — Research

**Date:** 2026-03-30

## Summary

S03 owns **R039** directly. Its job is to harden `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` so the review loop explicitly audits the named visual-companion protocol regression family instead of relying on generic prose quality checks. The current review assets are still broad and useful, but they do **not** mention `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`, and they do not tell a reviewer to fail missing first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback wording.

The key constraint is that these review assets are **global** brainstorming review surfaces, not M003-only documents. `skills/brainstorming/SKILL.md` uses them for the normal spec + handoff review loop across many feature types. That means S03 should not turn the checklist into a visual-companion-only gate for every spec. Instead, it should add an explicit **when-relevant** blocking review path for specs or handoffs that change, describe, or depend on the visual-companion workflow. The checklist already uses this style elsewhere through relevance-sensitive bullets, so the slice can stay additive rather than inventing a parallel review system.

A second important finding is that the repo does **not** appear to have an automated parser-style test for these review assets. The nearest proof surface is `tests/claude-code/test-document-review-system.sh`, but that integration test only checks broad reviewer behavior such as catching TODOs and deferred content. It does not prove that the M003 protocol family is enforced. That means S03 should likely close on authored file review and explicit readback against the named pressure scenarios, unless the slice intentionally expands scope to add a dedicated regression harness.

## Recommendation

Take S03 in this order:

1. **Use the named pressure-scenario artifact as the single vocabulary source.**
   - Reuse the exact four scenario names from `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.
   - Reuse the exact S02-proved outcomes already encoded in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`.
   - Avoid paraphrasing them into looser review language.

2. **Harden the checklist first.**
   - Add an explicit blocking review category, or a clearly marked subsection under an existing blocking category, for **visual-companion protocol regression checks (when the spec or handoff touches this workflow)**.
   - That section should tell reviewers to fail artifacts that do not make the following outcomes explicit and consistent across the spec and handoff:
     - the first later genuinely visual question starts the companion path after consent
     - each qualifying visual turn is artifact-first and the artifact is viewable before the terminal prompt
     - later qualifying visual turns keep the terminal question-tool prompt when available
     - question-tool unavailability is described as explicit degraded fallback rather than silent freeform drift
   - The checklist should reference `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` directly so the review bar points to named scenarios, not reviewer memory.

3. **Then harden the reviewer prompt.**
   - Keep the existing exact output format and concise blocking/advisory split.
   - Add a direct instruction that when the reviewed spec or handoff changes or depends on the visual-companion workflow, the reviewer must audit the named pressure scenarios and fail missing outcomes.
   - Add the M003 regression family to the `Look especially hard for:` section so the reviewer is prompted to catch the same gaps humans already observed in live use.
   - Point the reviewer to the checklist rather than duplicating all detailed logic in the prompt.

4. **Verify by authored readback, not by assumption.**
   - Read back the updated checklist and reviewer prompt and compare them against the four named pressure scenarios.
   - Confirm the prompt still preserves the current dispatch contract: same purpose, same input shape, same output format, same concise blocking-issues posture.
   - Optionally smoke-check `tests/claude-code/test-document-review-system.sh` if a regression check on prompt usability is desired, but treat it as a generic review-loop safeguard, not proof that R039 is satisfied.

5. **Do not drift into S04.**
   - Wireframe appendix guidance belongs to `skills/brainstorming/references/spec-template.md` and is a later slice.
   - S03 should focus on making review fail the named protocol family in spec + handoff artifacts.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Naming the regression family consistently | `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` | S01 already created the authoritative scenario names and required outcomes, so S03 should reference that artifact directly instead of inventing fresh reviewer wording. |
| Knowing the exact protocol outcomes review must enforce | `skills/brainstorming/SKILL.md` `## Visual companion` and `skills/brainstorming/visual-companion.md` `## Per-question decision rule` | S02 already proved these exact rules via the contract test. The review assets should mirror those validated terms, not reinterpret them. |
| Spec/handoff review workflow | `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` | These are the existing review surfaces used by the brainstorming workflow. S03 should sharpen them rather than creating a parallel review path. |
| Review-loop contract and prompt format | `docs/superpowers/specs/2026-01-22-document-review-system-design.md` and `tests/claude-code/test-document-review-system.sh` | They define the current reviewer purpose, loop shape, and output expectations. S03 should preserve that contract while adding M003-specific pressure checks. |

## Existing Code and Patterns

- `skills/brainstorming/references/spec-review-checklist.md` — current blocking quality bar for both the design spec and the GSD handoff. It already uses concise reviewer-facing categories and relevance-sensitive questions, but it does not yet name the M003 pressure scenarios or their required outcomes.
- `skills/brainstorming/spec-document-reviewer-prompt.md` — current reviewer dispatch template. It already has a stable input contract, an exact output format, and a `Look especially hard for:` section that is the natural insertion point for named M003 checks.
- `skills/brainstorming/SKILL.md` — shows that these two review assets are the live review loop, not dead documentation. The workflow explicitly says to read the checklist, dispatch the reviewer with the prompt, review both spec and handoff, fix blocking issues, and re-dispatch.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — authoritative named non-regression artifact for this slice. It defines the four scenario names and the required outcomes the review loop now needs to enforce.
- `skills/brainstorming/SKILL.md` `## Visual companion` — already contains the exact S02-proved wording for first-turn startup, artifact-first sequencing, terminal prompt continuity, and explicit degraded fallback.
- `skills/brainstorming/visual-companion.md` `## Per-question decision rule` — already contains the exact S02-proved artifact-first sequence and later-turn continuity wording. S03 should use this as the source of truth for checklist/prompt phrasing.
- `skills/brainstorming/references/test-scenarios.md` — existing pressure-scenario idiom. Scenario 7 (`visuals would help`) and Scenario 8 (`platform question tool`) show the repo’s existing habit of turning workflow drift into named failure conditions.
- `docs/superpowers/specs/2026-01-22-document-review-system-design.md` — confirms the reviewer is supposed to be concise, blocking-first, and reusable across specs. That reinforces the need for a conditional M003 overlay rather than a spec-review rewrite.
- `tests/claude-code/test-document-review-system.sh` — useful reminder that the current review loop is integration-tested for generic document quality problems. Surprise: it does not prove any M003-specific review behavior.

## Constraints

- **R039 is the only active requirement this slice owns.** S03 should stay focused on review-loop enforcement for the named protocol family.
- **The review assets are repo-wide, not milestone-local.** Any new M003 checks must be conditional on relevance, or unrelated specs will get false blocking failures.
- **Preserve the current prompt contract.** The reviewer prompt’s exact output format, concise blocking-issues emphasis, and minimal-input dispatch style should remain stable.
- **Preserve the current review loop shape.** `skills/brainstorming/SKILL.md` already dispatches the reviewer and caps iterations at five before surfacing to the human.
- **Do not reopen runtime, helper, frame-template, or metadata scope.** This slice remains above runtime behavior.
- **Do not weaken the S02-proved vocabulary.** Review assets should mirror the already-validated protocol terms closely enough that reviewers are checking the same thing the contract test already locked down.
- **Avoid adding a parallel review flow.** The repo already has a checklist + reviewer-prompt system; S03 should extend it rather than creating another path to maintain.

## Common Pitfalls

- **Making the M003 checks unconditional for every spec** — these review assets are global. The right move is: fail on the named protocol family **when the spec or handoff touches visual-companion workflow**, not for unrelated backend or non-visual work.
- **Paraphrasing the protocol too loosely** — if the checklist says only “visual flow seems clear,” the live regression family can re-enter under softer wording.
- **Checking only the spec and forgetting the handoff** — R039 covers both review surfaces and expects consistency between them.
- **Adding advisory language instead of blocking language** — the roadmap says review should explicitly fail missing startup, artifact-first sequencing, confirmation continuity, or degraded fallback outcomes.
- **Assuming the generic document-review integration test is enough proof** — it helps protect prompt usability, but it does not verify that reviewers are now auditing the M003 regression family.
- **Breaking the reviewer output format while adding new checks** — the existing workflow expects a compact `Status / Blocking Issues / Advisory Suggestions` response.

## Open Risks

- The main risk is still **review-only drift**: without a dedicated automated regression for the checklist/prompt, future edits could soften the M003 checks again while the runtime and authored contract stay green.
- Applicability may be underspecified if the checklist says “when relevant” without telling reviewers how to recognize a visual-companion-dependent spec or handoff.
- If the prompt duplicates too much protocol detail instead of pointing to the checklist and scenario artifact, the two review surfaces could drift out of sync.
- If S03 over-corrects and turns visual-companion checks into a global requirement, unrelated specs could accumulate false blocking issues and reviewers may start ignoring the category.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| Spec/reviewer prose quality | `writing-clearly-and-concisely` | installed / available |
| Skill-doc validation workflow | `writing-skills` | installed / available |
| Node.js-based repo/test work | `wshobson/agents@nodejs-backend-patterns` | none installed; promising via `npx skills add wshobson/agents@nodejs-backend-patterns` |
| Documentation review workflow | `lerianstudio/ring@ring:documentation-review` | none installed; promising via `npx skills add lerianstudio/ring@ring:documentation-review` |

## Sources

- `skills/brainstorming/references/spec-review-checklist.md` — current checklist is broad and reusable, but does not yet name the M003 pressure scenarios or fail their missing outcomes directly.
- `skills/brainstorming/spec-document-reviewer-prompt.md` — current reviewer prompt preserves a stable format and strict blocking-first posture, but does not yet instruct reviewers to audit the named protocol regression family.
- `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` — authoritative named scenario artifact for first-turn startup, artifact-first sequencing, question-tool continuity, and explicit degraded fallback.
- `skills/brainstorming/SKILL.md` `## Visual companion` — exact S02-proved wording for startup, artifact-first sequencing, prompt continuity, and degraded fallback that S03 should mirror.
- `skills/brainstorming/visual-companion.md` `## Per-question decision rule` — exact S02-proved per-turn protocol sequence that review assets should audit.
- `skills/brainstorming/references/test-scenarios.md` — existing pressure-scenario idiom, especially Scenario 7 (`visuals would help`) and Scenario 8 (`platform question tool`).
- `docs/superpowers/specs/2026-01-22-document-review-system-design.md` — existing review-loop architecture, output shape, and reuse expectations for the spec reviewer.
- `tests/claude-code/test-document-review-system.sh` — integration test that proves generic spec reviewer usefulness, but not M003-specific enforcement.
- Local code search: `rg -n "spec-review-checklist|spec-document-reviewer-prompt|visual-companion-protocol-pressure-scenarios|question tool|artifact-first|first later genuinely visual|degraded fallback" -S skills docs tests .gsd`
- Local skill discovery: `npx skills find "nodejs"` and `npx skills find "documentation review"`.
