# Frontend workflow audit follow-up, 2026-10-22

The confirmed handoff, validator and instruction defects are repaired. The
revised exploration instructions changed the choices made in five fresh agent
exercises. These exercises evaluate workflow decisions, not the visual quality
or usability of a delivered application.

## Scope and changes

| Audit finding | Disposition and implemented change |
| --- | --- |
| Images selected before interaction comparison | Accepted workflow revision. Working layouts come first for hierarchy, density, comparison and disclosure; image concepts remain the route for visual style or an explicit request. |
| Standalone approximation becomes binding too early | Strengthened the existing feasibility requirement. Sensitive details require a demonstration with actual components, or explicit acceptance of missing proof. |
| Human use implied by visual approval | Separate visual approval, agent functional checks and observed human tasks in the existing review. Unavailable human observation is recorded and does not create a mandatory study or extra approval. |
| Companion prescribes an approval-screen composition | Product mockups derive structure and narrow order from the actual task. The guardrails/evidence sequence remains an approval/policy-review example. |
| Paths and packet identity lost through handoff | Added a shared record containing resolved entry, expected revision/hash, approval reference, status and accepted limits. Spec, selected-adapter review, delivery adapter, plan task and implementation prompt carry it. Historical paths remain valid for legacy packets. |
| Reviewer runtime insufficiently specified | Added seven required runtime fields covering source/build including dirty edits, launch/cwd, URL/route, readiness, fresh auth/state, viewports and server owner/lifetime. |
| Validator accepts unprotected binding files | Target paths and prototype entrypoint must belong to the verified inventory. Excluded directories cannot hold binding artifacts. |
| Validator accepts contradictory state references | Validate both directions of each state/reference relationship. Shared image bytes use separate target IDs with explicit state/scope. |
| Examples conflict with design guidance | Replaced small uppercase operational examples, unchecked light text, universal empty-state illustration/CTA advice and indiscriminate record variation. Checked explicit text/background pairs. |
| Entry, adapter and maintenance inconsistencies | Clarified direct frontend entry for settled behavior, inert adapter preparation followed by one invocation after review, and purposeful open discovery. Updated the default prompt, example flow and current reference guides. |

## Deterministic regression evidence

Baseline source: `9fe25c61535f7867cbc9555610adc070b70ec9f7`, initially clean.

The existing validator suite passed 18 tests. The new regression cases then
failed against that implementation with ten expected failures: eight excluded
binding-path combinations, cross-wired state references, and a target omitted
from its declared state's references. The excluded-path cases supplied the
original revision and descriptor hash after changing the referenced file.

After correction, all 23 tests pass. Positive cases preserve ignored unused
dependencies, shared image files with separate state targets, states without a
capture, and the existing historical-file and identity checks. The validator
still checks structure and identity; it does not claim to verify human approval
or actual interaction behavior.

Commands completed successfully:

```sh
python3 tests/claude-code/test-frontend-packet.py
python3 tests/claude-code/test-frontend-direction-contract.py
node tests/brainstorm-server/visual-companion-contract.test.js
bash tests/claude-code/test-brainstorming-artifact-quality.sh
bash tests/claude-code/test-frontend-visual-review-policy.sh
bash tests/claude-code/test-custom-policy-contracts.sh
bash tests/claude-code/test-lean-delivery-contracts.sh
git diff --check
```

The resource suite passes five checks. The existing shell/companion suites
check compatibility and document contracts; they are not behavioral evidence.
The explicit contrast pairs were calculated with sRGB relative luminance:
`#111827` on white is 17.74:1 and `#374151` on white is 10.31:1.

## Fresh-context application exercises

The reusable [scenario](scenario.md) combines a deadline, sunk effort in
standalone HTML and pressure from a colleague. It asks for concrete artifacts
and decisions across exploration, approval, a shipment mockup, handoff and
runtime review. No application or browser is supplied.

Five generic GPT-6.1 Sol agents at low effort read the existing skills before
the changes. Five fresh agents with the same settings read the revised skills
and applied the same checkpoints. Each used `fork_turns: none`, stayed read-only
and received no desired answers. Baseline sample 1 received the same checkpoints
inline; the other samples loaded the scenario file. This is an existing-version
control without the proposed guidance, not a skill-free control.

The controller read every response and scored these observable choices:

| Observable choice | Existing instructions | Revised instructions |
| --- | --- | --- |
| Working layout before selection for the ledger interaction problem | 0/5 | 5/5 |
| Shipment-specific narrow order without approval-screen sections | 0/5 | 5/5 |
| Does not claim a recording proves human task completion | 5/5 | 5/5 |
| Requests actual-component proof for the sensitive standalone slice | 5/5 | 5/5 |
| Defers writing-plans execution until independent adapter approval | 5/5 | 5/5 |
| Includes server owner/lifetime in review input | 0/5 | 5/5 |
| Includes an explicit readiness field alongside the other runtime fields | 0/5 | 4/5 |

The first candidate's runtime evidence was not uniformly complete: sample 5
described source/state preconditions in prose but omitted a labeled readiness
check. The runtime template was clarified to retain all seven labeled fields,
with unknowns explicitly pending. One additional fresh exercise under a
five-minute deadline then emitted all seven, including readiness, and refused
to invent commands, login state or source verification. This targeted correction
was checked once, not five times.

Representative verbatim excerpts:

- Baseline 1: "The current skill explicitly defaults to three image concepts for substantial unresolved direction; this request meets that condition."
- Baseline 3: "At narrow width, preserve context → title → proposed change → guardrails → evidence → actions in DOM and reading order."
- Candidate 1: "Second artifact: one working recommendation on the isolated Angular component route, using the actual table, form, and overlay components with synthetic ledger fixtures."
- Candidate 3: "Narrow DOM/reading order: scope → filters → results → selected details → relevant actions."
- Runtime recheck: "Resolve pending fields before runtime review."

Session-local sample names are `frontend_baseline_1` through
`frontend_baseline_5`, `frontend_candidate_1` through `frontend_candidate_5`,
and `frontend_runtime_recheck`. Their complete outputs remain in the authoring
chat; this file retains the scenario, results and selected excerpts, not a
standalone full-transcript archive.

## Boundary checks and limits

An additional fresh `frontend_boundary_probe` correctly handled six independent
cases: an explicit three-image request, a mechanical label change, final
approval with human usability unobserved, a historical image-only packet,
purposeful discovery after uncertainty, and compact operational table/empty-state
choices. It kept final status `approved` when required component/browser checks
and final approval existed but no person could attempt the task.

The installed `~/.codex/skills/superpowers` link resolves to this checkout's
`skills/` directory. The edits therefore update the linked local installation.

No representative product screen was redesigned or compared in this task.
Better task completion, visual quality and lower implementation rework remain
unmeasured. A real-screen comparison with equal requirements, fixtures and
components is the next product-level test, separate from these completed skill
and validator checks.
