# S04: Selective wireframe appendix guidance and integrated closure — Research

**Date:** 2026-03-30

## Summary

S04 owns **R041** directly. The shared spec path already supports appendices in general, but `skills/brainstorming/references/spec-template.md` still does **not** say when a low-fidelity wireframe appendix is appropriate, what shape it should take, or how the handoff may point back to it. The current `skills/brainstorming/references/gsd-handoff-template.md` is intentionally separate and should stay unchanged in this slice, so the missing guidance has to land in the spec path rather than through a handoff-template rewrite.

The most useful surprise is that the repo already contains a concrete pattern to reuse: `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` has an `Appendix D. Wireframe Appendix Pattern` section with the right scope, form, and guardrails. That means S04 does not need to invent the content model from scratch. It needs to generalize that pattern into the shared template carefully enough that durable wireframes stay **selective**, **low-fidelity**, and **decision-tied** rather than becoming a routine appendix or a fifth companion archetype.

The verification picture is mixed in an important way. The two main M003 proof surfaces are green right now: `node tests/brainstorm-server/visual-companion-contract.test.js` passes, and `node tests/brainstorm-server/live-companion-acceptance.test.js` passes. But neither test reads `spec-template.md`, so rerunning them alone will not prove R041. Meanwhile, the generic review smoke test still fails directly in this shell with `timeout: command not found`, and it remains a review-loop safeguard rather than direct proof of appendix guidance. S04 therefore needs direct authored readback of the shared template in addition to the integrated reruns.

## Recommendation

Take S04 in this order:

1. **Update only the shared spec path.**
   - Put the new guidance in `skills/brainstorming/references/spec-template.md`.
   - Keep `skills/brainstorming/references/gsd-handoff-template.md` unchanged.
   - Treat the handoff allowance as a rule that the spec path seeds, not as a template rewrite.

2. **Reuse the one-off wireframe appendix pattern instead of inventing a new one.**
   - Distill the existing pattern into shared guidance with these core rules:
     - create a wireframe appendix only when spatial structure matters to later implementation or review
     - keep it low-fidelity and structure-first
     - tie it to a specific decision and its key visual rationale
     - do not create one for every visual turn
   - Keep the wording explicit enough that reviewers and future authors can tell when **not** to add one.

3. **Prefer low-churn template edits over a new fixed appendix regime.**
   - The current shared template ends with `## Appendix E. GSD Handoff Seed`, and multiple existing specs follow that exact shape.
   - The safest move is likely to keep the template’s existing handoff appendix stable while adding:
     - an explicit optional low-fidelity wireframe-appendix rule in the authoring guidance, and
     - a note in the handoff-seed area that the handoff may link to an existing appendix when it materially shapes implementation.
   - That achieves the allowance without implying that every spec now needs a dedicated wireframe appendix block.

4. **Close R041 by direct template proof plus integrated reruns.**
   - Read back `skills/brainstorming/references/spec-template.md` and confirm it now says all of the following:
     - wireframe appendices are optional, not routine
     - they are for durable spatial decisions
     - they stay low-fidelity
     - the handoff may link to an existing appendix when relevant
   - Then rerun:
     - `node tests/brainstorm-server/visual-companion-contract.test.js`
     - `node tests/brainstorm-server/live-companion-acceptance.test.js`
   - Treat `bash tests/claude-code/test-document-review-system.sh` as optional follow-up only if the slice touches review assets again; it is not the proof surface for R041.

5. **Do not widen scope at milestone close.**
   - Do not add a new archetype.
   - Do not edit runtime, helper, or frame-template files.
   - Do not change the shared handoff template.
   - Do not claim integrated closure from green runtime/doc tests alone if the template itself was not read back directly.

## Don't Hand-Roll

| Problem | Existing Solution | Why Use It |
|---------|------------------|------------|
| Deciding what a durable wireframe appendix should contain | `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` `## Appendix D. Wireframe Appendix Pattern` | The repo already has the exact structure S04 needs: low-fidelity form, short structural bullets, and explicit guardrails against appendix sprawl. |
| Shared spec artifact structure | `skills/brainstorming/references/spec-template.md` | This is the live template the brainstorming workflow tells authors to use, so R041 should land here rather than in a one-off spec only. |
| Handoff boundary and no-template-change constraint | `skills/brainstorming/references/gsd-handoff-template.md` | It makes the boundary concrete: S04 can allow linkage to an existing appendix without reopening the handoff template itself. |
| Final integrated proof above runtime scope | `tests/brainstorm-server/visual-companion-contract.test.js` and `tests/brainstorm-server/live-companion-acceptance.test.js` | These are already the trusted authored-contract and unchanged-runtime tie-breaker surfaces. S04 should rerun them after the template change rather than inventing a new closure stack. |

## Existing Code and Patterns

- `skills/brainstorming/references/spec-template.md` — the shared design-spec template. It currently encourages appendices for nuanced work, but it does not yet define selective wireframe appendix triggers, low-fidelity guardrails, or handoff-link allowance.
- `skills/brainstorming/references/gsd-handoff-template.md` — the shared GSD handoff template. It is intentionally stable and already strong enough for this slice to leave untouched.
- `skills/brainstorming/SKILL.md` — the live workflow calls for using `references/spec-template.md`, then `references/gsd-handoff-template.md`, then reviewing both artifacts. That means S04’s template wording will affect real authoring behavior.
- `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` `## Appendix D. Wireframe Appendix Pattern` — best reusable source for the appendix content model. It already says the appendix is for preserved spatial reasoning, prefers low-fidelity diagrams or ASCII wireframes, recommends 3–6 structural bullets, and warns against creating one unless it materially improves handoff clarity.
- `docs/superpowers/specs/2026-03-27--visual-companion-comparison-first-upgrade.md` and `docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality.md` — recent specs follow the current shared pattern exactly and end with `## Appendix E. GSD Handoff Seed`. That suggests S04 should be cautious about unnecessary appendix renumbering or template churn.
- `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` — S03 already hardened these review surfaces around the named regression family. S04 should consume them as stable inputs rather than reopening them unless a contradiction appears.
- `tests/brainstorm-server/visual-companion-contract.test.js` — still the fastest authored-surface regression check, but it does **not** inspect `spec-template.md` today.
- `tests/brainstorm-server/live-companion-acceptance.test.js` — still the unchanged-runtime tie-breaker and passed cleanly in this environment.
- Local code search surprise: `rg -n "wireframe|appendix|durable" skills/brainstorming/visual-companion.md skills/brainstorming/SKILL.md` returned no matches. Shared operator guidance for durable wireframes does not exist outside the spec/handoff path yet.

## Constraints

- **R041 is the only active requirement this slice owns.** S04 should stay focused on the shared spec-path guidance plus final integrated closure.
- **No handoff-template rewrite.** The milestone context and handoff are explicit that `skills/brainstorming/references/gsd-handoff-template.md` stays unchanged in this slice.
- **No runtime, helper, frame-template, or metadata changes.** The live runtime remains the unchanged tie-breaker, not an implementation target.
- **Wireframes must stay selective.** Guidance must make clear that not every visual turn earns a durable appendix.
- **Wireframes must stay low-fidelity.** The slice should prefer structure-first representations such as ASCII or simple block diagrams rather than implying polished mockups.
- **The appendix must stay tied to a decision.** The purpose is durable spatial carry-forward, not visual decoration or a new archetype.
- **Current automated tests do not cover the spec template.** S04 needs explicit file readback as part of proof.
- **The generic document-review smoke remains environment-sensitive here.** A direct run still fails with `timeout: command not found`, so it should not be treated as a required gate for R041.

## Common Pitfalls

- **Turning the wireframe appendix into a routine deliverable** — the requirement is selective carry-forward for durable spatial decisions, not a new default appendix every time the browser was useful.
- **Smuggling the rule into the handoff template** — that would violate the slice boundary. The allowance should be seeded from the spec path.
- **Using vague “optional diagrams” language** — the template needs explicit trigger rules, or future authors will either overuse wireframes or ignore the guidance entirely.
- **Over-proving the wrong thing** — green reruns of the contract and live acceptance tests are necessary for integrated closure, but they do not prove that `spec-template.md` now carries the right appendix guidance.
- **Renumbering appendices without a reason** — the current shared pattern uses `Appendix E. GSD Handoff Seed`, and recent specs follow it. If S04 can achieve clarity without changing that shared shape, that is the lower-risk path.
- **Letting appendix wording redefine the protocol** — S02 and S03 already locked the per-turn protocol. S04 should support durable carry-forward without contradicting or restating that logic loosely.

## Open Risks

- If the template guidance is too soft, future authors may still skip durable spatial carry-forward because the rule reads like optional decoration rather than a targeted tool.
- If the template guidance is too strong, teams may start treating wireframe appendices as routine paperwork for ordinary visual turns.
- If S04 closes only on integrated reruns and not on direct template readback, R041 could remain unproven while the milestone looks green.
- If the slice touches review assets again without need, it could reopen already-stable S03 behavior and reintroduce the environment-sensitive smoke-test friction.

## Skills Discovered

| Technology | Skill | Status |
|------------|-------|--------|
| Spec and handoff prose quality | `writing-clearly-and-concisely` | installed / available |
| Skill-doc validation workflow | `writing-skills` | installed / available |
| RED→GREEN discipline for doc changes | `test-driven-development` | installed / available |
| Node.js-based repo/test work | `wshobson/agents@nodejs-backend-patterns` | none installed; promising via `npx skills add wshobson/agents@nodejs-backend-patterns` |
| Browser/live acceptance verification | `currents-dev/playwright-best-practices-skill@playwright-best-practices` | none installed; promising via `npx skills add currents-dev/playwright-best-practices-skill@playwright-best-practices` |

## Sources

- `skills/brainstorming/references/spec-template.md` — current shared spec template; appendices are supported generally, but selective low-fidelity wireframe guidance is still missing.
- `skills/brainstorming/references/gsd-handoff-template.md` — current shared handoff template; confirms the boundary that S04 should avoid changing.
- `skills/brainstorming/SKILL.md` — shows the live authoring order: use the spec template, write the handoff, then run the review loop on both artifacts.
- `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` `## Appendix D. Wireframe Appendix Pattern` — concrete reusable pattern for purpose, recommended form, placement, and guardrails.
- `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening--gsd-handoff.md` — acceptance and validation language confirming that durable wireframe appendices are selective, low-fidelity, and linkable from the handoff when relevant.
- `docs/superpowers/specs/2026-03-27--visual-companion-comparison-first-upgrade.md` and `docs/superpowers/specs/2026-03-29--visual-companion-routing-and-authoring-quality.md` — evidence that the current shared pattern ends with `Appendix E. GSD Handoff Seed` and is already in live use.
- `tests/brainstorm-server/visual-companion-contract.test.js` — current authored-contract proof surface; rerun locally and passed: `PASS: visual companion contract + archetype kit assertions passed`.
- `tests/brainstorm-server/live-companion-acceptance.test.js` — current unchanged-runtime tie-breaker; rerun locally and passed all 6 checks.
- `tests/claude-code/test-document-review-system.sh` — generic review-loop smoke guard; rerun locally and failed directly in this shell with `timeout: command not found`, confirming the known environment-sensitivity and its unsuitability as direct R041 proof.
- Local code search: `rg -n "wireframe|appendix|durable" skills/brainstorming/visual-companion.md skills/brainstorming/SKILL.md` — no matches, confirming the shared wireframe guidance gap outside the spec path.
- Local skill discovery: `npx skills find "Node.js"` and `npx skills find "Playwright"`.
