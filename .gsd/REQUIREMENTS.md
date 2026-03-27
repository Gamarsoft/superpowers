# Requirements

This file is the explicit capability and coverage contract for the project.

Use it to track what is actively in scope, what has been validated by completed work, what is intentionally deferred, and what is explicitly out of scope.

Guidelines:
- Keep requirements capability-oriented, not a giant feature wishlist.
- Requirements should be atomic, testable, and stated in plain language.
- Every **Active** requirement should be mapped to a slice, deferred, blocked with reason, or moved out of scope.
- Each requirement should have one accountable primary owner and may have supporting slices.
- Research may suggest requirements, but research does not silently make them binding.
- Validation means the requirement was actually proven by completed work and verification, not just discussed.

## Active

## Validated

### R034 — First qualifying visual turn starts the companion path after consent
- Class: operability
- Status: validated
- Description: Update `skills/brainstorming/SKILL.md` so an accepted visual-companion session requires the first later genuinely visual question to start the companion path instead of remaining terminal-only.
- Why it matters: Acceptance is not enough if the first qualifying visual turn can still drift past the companion.
- Source: user
- Primary owning slice: M003/S02
- Supporting slices: none
- Validation: validated
- Notes: Validated by the hardened `skills/brainstorming/SKILL.md` wording plus the passing rerun of `node tests/brainstorm-server/visual-companion-contract.test.js` recorded in M003/S02.

### R035 — Qualifying visual turns are artifact-first
- Class: operability
- Status: validated
- Description: Update `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` so every qualifying visual turn is artifact-first: the visual artifact must be created and viewable before the terminal question is asked.
- Why it matters: Asking the question before the artifact is visible breaks the companion’s core value.
- Source: user
- Primary owning slice: M003/S02
- Supporting slices: none
- Validation: validated
- Notes: Validated by the mirrored artifact-first wording in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` plus the passing rerun of `node tests/brainstorm-server/visual-companion-contract.test.js`.

### R036 — Terminal question-tool continuity survives earlier browser use
- Class: operability
- Status: validated
- Description: Preserve the dedicated terminal question-tool prompt for qualifying visual turns even after the companion has already been opened earlier in the session.
- Why it matters: Browser turns should not silently downgrade guided terminal confirmation discipline.
- Source: user
- Primary owning slice: M003/S02
- Supporting slices: none
- Validation: validated
- Notes: Validated by the explicit continuity wording in `skills/brainstorming/SKILL.md` plus the passing rerun of `node tests/brainstorm-server/visual-companion-contract.test.js`.

### R037 — Question-tool unavailability has explicit degraded wording
- Class: failure-visibility
- Status: validated
- Description: Add explicit degraded-mode wording for environments where the platform question tool is unavailable, instead of allowing silent drift to freeform-only handling.
- Why it matters: If the dedicated tool is unavailable, the fallback still needs to stay visible and disciplined.
- Source: user
- Primary owning slice: M003/S02
- Supporting slices: none
- Validation: validated
- Notes: Validated by the explicit degraded fallback wording in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md` plus the passing rerun of `node tests/brainstorm-server/visual-companion-contract.test.js`.

### R040 — Skill-doc validation follows writing-skills plus TDD
- Class: process
- Status: validated
- Description: Use `skills/writing-skills/SKILL.md`, with its `skills/test-driven-development/SKILL.md` prerequisite, to drive the validation loop: baseline scenario run before edits, verified failure, post-edit rerun, and recorded evidence.
- Why it matters: The skill edit needs a real red/green proof loop instead of an ad hoc documentation pass.
- Source: user
- Primary owning slice: M003/S02
- Supporting slices: M003/S01
- Validation: validated
- Notes: Validated by the S01 RED baseline, the S02 GREEN rerun of `node tests/brainstorm-server/visual-companion-contract.test.js`, and the recorded proof in the M003/S02 task and slice summaries.

### R041 — Selective durable wireframe appendix guidance exists in the spec path
- Class: operability
- Status: validated
- Description: Add selective durable wireframe appendix guidance to `skills/brainstorming/references/spec-template.md`, and allow the GSD handoff to link to an existing appendix when relevant, while keeping handoff-template changes deferred.
- Why it matters: Spatial decisions sometimes need durable carry-forward, but that should stay selective and low-fidelity.
- Source: user
- Primary owning slice: M003/S04
- Supporting slices: none
- Validation: validated
- Notes: Validated by direct readback of `skills/brainstorming/references/spec-template.md` for optional/selective use, durable spatial triggers, low-fidelity form, and handoff-link allowance; the passing reruns of `node tests/brainstorm-server/visual-companion-contract.test.js` and `node tests/brainstorm-server/live-companion-acceptance.test.js`; and a clean `git diff --name-only -- skills/brainstorming/references/gsd-handoff-template.md skills/brainstorming/scripts/server.cjs skills/brainstorming/scripts/helper.js skills/brainstorming/scripts/frame-template.html` scope-boundary check.

### R001 — Comparison-first archetype kit
- Class: core-capability
- Status: validated
- Description: The visual companion provides a comparison-first authoring kit with exactly four v1 archetypes: side-by-side comparison, ranked alternatives, annotated recommendation / current winner, and carry-forward summary.
- Why it matters: This is the core product change. Without named archetypes, comparison quality stays ad hoc.
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: M001/S02, M001/S03
- Validation: validated
- Notes: Validated by the S01 guide rewrite, authored fragment example kit, and `tests/brainstorm-server/visual-companion-contract.test.js`.

### R002 — Recommendation and alternatives are legible by default
- Class: quality-attribute
- Status: validated
- Description: Comparison screens make the current recommendation and the visible alternatives easy to parse at a glance.
- Why it matters: The upgrade is only valuable if the browser reduces ambiguity instead of adding styling noise.
- Source: user
- Primary owning slice: M001/S02
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated by the shared fragment comparison defaults in `skills/brainstorming/scripts/frame-template.html` plus regression coverage in `tests/brainstorm-server/fragment-comparison-defaults.test.js`.

### R003 — Ranked screens show a visible current winner without hiding lower-ranked options
- Class: primary-user-loop
- Status: validated
- Description: Ranked alternatives clearly show the current best option and still keep lower-ranked options readable enough for honest comparison.
- Why it matters: Ranking that hides alternatives stops being comparison support and becomes a disguised forced choice.
- Source: user
- Primary owning slice: M001/S02
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated by selector-level regression checks for ranked/current-winner emphasis and the non-selected opacity guard in `tests/brainstorm-server/fragment-comparison-defaults.test.js`.

### R004 — Chosen or still-open direction carries forward clearly into later screens
- Class: continuity
- Status: validated
- Description: Later screens explicitly state the carried-forward direction, or clearly state that the comparison is still open.
- Why it matters: Users should not have to infer what the next screen is building on.
- Source: user
- Primary owning slice: M001/S03
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated by authored `Chosen direction` / `Still open` carry-forward copy in the guide and examples, `tests/brainstorm-server/carry-forward-behavior.test.js`, and the live runtime check that stayed explicit after `state/events` was cleared on a fresh later screen.

### R005 — Terminal remains the primary reasoning channel
- Class: constraint
- Status: validated
- Description: The non-blocking browser-plus-terminal model remains intact, and the terminal stays the primary channel for reasoning, recommendation, and final discussion.
- Why it matters: Replacing the terminal would change the product, not upgrade the companion.
- Source: user
- Primary owning slice: M001/S03
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated by the helper workflow-boundary guard, container-scoped selection regression coverage, and live proof that the browser stayed an additive decision aid while authored carry-forward meaning remained in the screen and terminal flow.

### R006 — Current HTML/runtime contract stays intact
- Class: integration
- Status: validated
- Description: The upgrade preserves the current HTML authoring and runtime contract, including fragment/full-document compatibility and `screen_dir` / `state_dir/events` behavior.
- Why it matters: The codebase already has a stable runtime surface. M001 should build above it, not reopen it.
- Source: user
- Primary owning slice: M001/S04
- Supporting slices: M001/S02, M001/S03
- Validation: validated
- Notes: Validated by the passing S04 matrix (`visual-companion-contract`, `fragment-comparison-defaults`, `carry-forward-behavior`, `server.test.js`, `ws-protocol.test.js`, `windows-lifecycle.test.sh`, and `live-companion-acceptance.test.js`) plus the live browser acceptance pass tied back to `state/server-info`, `state/server.log`, `state/events`, and the absence of fragment-shell leakage in the full-document runtime check.

### R007 — Runtime screen creation explicitly invokes `/frontend-design` or `$frontend-design`
- Class: core-capability
- Status: validated
- Description: When the agent creates companion screens, it explicitly invokes `/frontend-design` or `$frontend-design` as the screen-structuring step.
- Why it matters: The new quality bar depends on a named runtime step, not improvised HTML generation.
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated as an explicit authoring rule in `skills/brainstorming/visual-companion.md` and `skills/brainstorming/SKILL.md`, with regression coverage in `tests/brainstorm-server/visual-companion-contract.test.js`.

### R008 — First `frontend-design` use follows a bounded one-time session workflow
- Class: operability
- Status: validated
- Description: Before the first `/frontend-design` or `$frontend-design` invocation in a visual companion session, the workflow checks existing instruction context, then a repo design-context source if present, then gathers one-time minimal session context.
- Why it matters: The design-context gate must be satisfied consistently without turning the session into a questionnaire.
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: M001/S03
- Validation: validated
- Notes: Validated by the ordered workflow language in the guide and contract test assertions for instruction context, repo reuse, one-time session capture, and degraded mode fallback.

### R009 — Existing repo design context is reused when available
- Class: operability
- Status: validated
- Description: If a design-context source exists in the repo, the workflow reuses it before asking for one-time session context.
- Why it matters: Existing context should reduce friction instead of being ignored.
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the explicit repo-context reuse rule in the S01 workflow contract and its regression coverage.

### R010 — Missing design context falls back to explicit degraded mode
- Class: failure-visibility
- Status: validated
- Description: If design context is unavailable or the user declines to provide it, the agent may still produce a plain archetype-based screen, but only in explicit degraded mode.
- Why it matters: The workflow should fail visibly and honestly, not pretend `frontend-design` ran successfully.
- Source: research
- Primary owning slice: M001/S03
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated by explicit degraded-mode authoring rules in `skills/brainstorming/visual-companion.md`, the authored carry-forward example in `skills/brainstorming/examples/visual-companion/carry-forward-summary.html`, regression coverage in `tests/brainstorm-server/carry-forward-behavior.test.js`, and live runtime assertions for visible `Degraded mode` output.

### R011 — Existing screens and terminal-only flows keep working
- Class: launchability
- Status: validated
- Description: Existing valid screens continue to render, and terminal-only decisions still support clear carry-forward screens even without browser clicks.
- Why it matters: The upgrade has to improve the product without breaking current use.
- Source: research
- Primary owning slice: M001/S04
- Supporting slices: M001/S03
- Validation: validated
- Notes: Validated by the passing S04 lifecycle, server/WebSocket, and live-entrypoint suites plus the explicit browser acceptance flow that showed authored fragment continuity, terminal-only carry-forward copy, `state/events` clearing on a fresher screen, and clean full-document passthrough without fragment-shell contamination.

### R012 — Guidance and examples are strong enough to use consistently
- Class: operability
- Status: validated
- Description: The guidance in `visual-companion.md` includes concrete authoring rules and examples strong enough that authors can consistently produce the four archetypes.
- Why it matters: The value of the milestone depends on repeatable authored screens, not one-off good taste.
- Source: user
- Primary owning slice: M001/S01
- Supporting slices: M001/S04
- Validation: validated
- Notes: Validated by the four copyable fragment examples, guide cross-links, and contract checks that lock the example-kit presence and ordering.

### R013 — Companion routing stays genuinely visual
- Class: operability
- Status: validated
- Description: `skills/brainstorming/SKILL.md` routes the visual companion only to questions that are materially easier to judge by seeing them than by reading them, while conceptual, scope, and text-first decisions stay in terminal.
- Why it matters: The browser only adds value when it sharpens a visual decision instead of interrupting reasoning.
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the mirrored routing threshold in `skills/brainstorming/SKILL.md` and `skills/brainstorming/visual-companion.md`, plus `tests/brainstorm-server/visual-companion-contract.test.js`.

### R014 — Pre-display checklist is explicit and committed
- Class: operability
- Status: validated
- Description: `skills/brainstorming/visual-companion.md` defines a short pre-display checklist covering genuinely visual fit, concrete subject-specific visual content, visible differences that support the decision, and clear recommendation or comparison legibility.
- Why it matters: Authoring quality has to be checked before a screen is shown, not inferred after weak output reaches the browser.
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the named `Pre-display quality gate` section with ordered checklist labels and contract coverage in `tests/brainstorm-server/visual-companion-contract.test.js`.

### R015 — Placeholder screens are forbidden and failed checks force fallback
- Class: failure-visibility
- Status: validated
- Description: The companion guidance explicitly forbids placeholder or low-information screens and states that if any checklist item fails, the agent must revise the artifact or stay in terminal instead of showing it.
- Why it matters: A weak browser turn reduces trust faster than a terminal-only answer.
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the explicit `No placeholder screens.` rule, the `revise the artifact or stay in terminal` fallback, and the contract regression that fails when either is missing.

### R016 — Active example refresh boundary stays explicit
- Class: scope-control
- Status: validated
- Description: The milestone refreshes only `side-by-side-comparison.html`, `ranked-alternatives.html`, and `annotated-recommendation.html`, while `carry-forward-summary.html` stays untouched unless planning or verification finds a direct contradiction.
- Why it matters: The first follow-on should stay narrow enough to prove whether rule and example quality are the real bottleneck.
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the explicit `Active example refresh boundary (M002)` block in `skills/brainstorming/visual-companion.md` and T03’s in-scope example-file-only refresh discipline.

### R017 — Active examples become decision-capable starting points
- Class: operability
- Status: validated
- Description: The refreshed side-by-side, ranked, and annotated-recommendation examples contain concrete, subject-specific visual content strong enough to support real layout, hierarchy, and recommendation decisions instead of generic labeled boxes.
- Why it matters: Authors copy examples. Weak examples quietly teach weak usage.
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the rewritten active example fragments plus passing `visual-companion-contract`, `fragment-comparison-defaults`, and `carry-forward-behavior` regression checks.

### R018 — Flow-style comparisons stay conditional unless genuinely visual
- Class: quality-attribute
- Status: validated
- Description: Flow-style companion use remains allowed only when the authored artifact is visually concrete enough to show sequence, structure, or trade-offs clearly; dressed-up prose lists should fail the quality gate and stay in terminal.
- Why it matters: Borderline flow questions are the easiest place for the companion to drift into low-value output.
- Source: user
- Primary owning slice: M002/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the guide’s conditional flow-style rule, the quality gate’s failure path, and the refreshed examples’ concrete trade-off framing rather than dressed-up prose lists.

### R019 — M002 preserves the current runtime and archetype contract
- Class: constraint
- Status: validated
- Description: This slice keeps the current runtime contract, `data-choice` interaction boundary, and four-archetype surface unchanged while improving only routing, authoring rules, and the three active example fragments.
- Why it matters: M001 already validated the runtime. Reopening it here would blur cause and effect.
- Source: user
- Primary owning slice: M002/S02
- Supporting slices: M002/S01
- Validation: validated
- Notes: Validated by the passing S02 runtime matrix (`node tests/brainstorm-server/live-companion-acceptance.test.js`, `bash tests/brainstorm-server/windows-lifecycle.test.sh`, `node tests/brainstorm-server/server.test.js`, and `node tests/brainstorm-server/ws-protocol.test.js`) plus live browser corroboration through `skills/brainstorming/scripts/start-server.sh`, where `state/server-info`, `state/server.log`, `state/events`, and `performance.getEntriesByType('resource')` confirmed the only recurring warning was the auxiliary `/favicon.ico` request rather than runtime drift.

### R038 — Named pressure-scenario artifact exists for the regression family
- Class: operability
- Status: validated
- Description: Create `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` with the concrete live-use regression family: baseline first-visual-turn startup failure, artifact-first sequencing, terminal confirmation continuity, and degraded fallback when the question tool is unavailable.
- Why it matters: The workflow drift needs a named non-regression artifact, not just rewritten prose.
- Source: user
- Primary owning slice: M003/S01
- Supporting slices: none
- Validation: validated
- Notes: Validated by the authored `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` artifact plus the intentional RED rerun of `node tests/brainstorm-server/visual-companion-contract.test.js`, which advanced from missing-file failure to the named missing-protocol-wording baseline in `skills/brainstorming/SKILL.md`.

### R039 — Review assets enforce the protocol regression family
- Class: operability
- Status: validated
- Description: Update `skills/brainstorming/references/spec-review-checklist.md` and `skills/brainstorming/spec-document-reviewer-prompt.md` so review explicitly checks the named pressure scenarios and their expected protocol outcomes.
- Why it matters: Review should fail future drift on the same scenario family that exposed the gap.
- Source: user
- Primary owning slice: M003/S03
- Supporting slices: M003/S01
- Validation: validated
- Notes: Validated by the conditional protocol-regression gate in `skills/brainstorming/references/spec-review-checklist.md`, the matching checklist-routing language in `skills/brainstorming/spec-document-reviewer-prompt.md`, and the passing rerun of `bash tests/claude-code/test-document-review-system.sh` under transient local `timeout`/`claude` shims after reproducing the raw environment failure.

## Deferred

### R020 — Diagram-oriented companion patterns beyond the comparison-first set
- Class: differentiator
- Status: deferred
- Description: Add explicit diagram-oriented visual companion patterns beyond the four comparison-first archetypes.
- Why it matters: The runtime can already support diagram use cases, but this milestone is not trying to optimize them yet.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Deferred to keep M001 tightly comparison-first.

### R021 — Session-wide decision ledger with rationale history
- Class: continuity
- Status: deferred
- Description: Add a richer session memory layer that records decisions and rationale across screens.
- Why it matters: This could improve continuity later, but it would expand product and technical scope too early.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Rejected for M001 in favor of lightweight carry-forward.

### R022 — Branching or gated workflow orchestration
- Class: admin/support
- Status: deferred
- Description: Add explicit branching, gating, or approval workflow logic to the companion.
- Why it matters: It may be useful later, but it is not needed to prove comparison-first value.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Deferred to avoid turning the helper/runtime into a workflow engine.

### R023 — Optional full-document comparison helpers or parity work
- Class: integration
- Status: deferred
- Description: Add optional helpers or a later parity path for comparison-first behavior in full-document screens.
- Why it matters: Some future authors may want less manual work in full-document mode.
- Source: inferred
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Not part of v1. Full-document screens are compatibility-supported only.

### R042 — Runtime or helper enforcement hooks if the hardened workflow still fails the same live scenario
- Class: differentiator
- Status: deferred
- Description: Runtime or helper enforcement hooks if the hardened workflow still fails the same live scenario.
- Why it matters: A runtime follow-up may become necessary later, but only if the docs-and-review hardening proves insufficient.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Deferred directly from the 2026-03-30 protocol-hardening handoff.

### R043 — New archetype or browser-native confirmation flow
- Class: differentiator
- Status: deferred
- Description: Any new archetype or browser-native confirmation flow.
- Why it matters: The current slice should harden the existing workflow before expanding the product surface.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Deferred directly from the 2026-03-30 protocol-hardening handoff.

### R044 — Broader wireframe template or catalog work beyond simple appendix linkage
- Class: operability
- Status: deferred
- Description: Broader template/catalog work for wireframes, including any GSD handoff template change beyond simple linkage to an existing appendix.
- Why it matters: Wireframe persistence needs a narrow first slice rather than template/catalog sprawl.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: unmapped
- Notes: Deferred directly from the 2026-03-30 protocol-hardening handoff.

## Out of Scope

### R030 — Deep server architecture rewrite
- Class: anti-feature
- Status: out-of-scope
- Description: Redesign the server/session architecture as part of this milestone.
- Why it matters: This prevents scope creep into runtime work that does not directly improve comparison quality.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: Allowed server changes are limited to small compatibility fixes if truly required.

### R031 — Mandatory new authoring DSL or schema
- Class: anti-feature
- Status: out-of-scope
- Description: Introduce a new required DSL, schema, or metadata system for companion screens.
- Why it matters: The milestone must preserve the current HTML authoring contract.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: Existing `data-choice` remains the only required choice metadata in M001.

### R032 — Browser replaces the terminal as the primary reasoning channel
- Class: anti-feature
- Status: out-of-scope
- Description: Shift reasoning, recommendation, or primary discussion out of the terminal and into browser-native workflow logic.
- Why it matters: This would change the product boundary the user explicitly wants preserved.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: The browser remains optional and question-by-question.

### R033 — Automatic comparison-kit defaults for full-document screens in v1
- Class: constraint
- Status: out-of-scope
- Description: Make full-document screens automatically inherit the comparison-kit defaults used by fragment screens.
- Why it matters: This prevents an accidental parity promise the current design does not support.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: Full documents remain valid, but authors must structure comparison screens explicitly.

### R045 — No runtime, helper, or frame-template changes in this slice
- Class: anti-feature
- Status: out-of-scope
- Description: Changes to `skills/brainstorming/scripts/server.cjs`, `helper.js`, or the frame template in this slice.
- Why it matters: This keeps the first response focused on protocol hardening above the runtime.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: Out of scope directly from the 2026-03-30 protocol-hardening handoff.

### R046 — No new required metadata beyond `data-choice`
- Class: anti-feature
- Status: out-of-scope
- Description: New required metadata beyond `data-choice`.
- Why it matters: The hardened workflow should preserve the existing authoring boundary.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: Out of scope directly from the 2026-03-30 protocol-hardening handoff.

### R047 — Browser does not become the primary reasoning or confirmation channel
- Class: anti-feature
- Status: out-of-scope
- Description: Making browser interaction the primary reasoning or confirmation channel.
- Why it matters: The product boundary stays terminal-first even when the companion is accepted.
- Source: user
- Primary owning slice: none
- Supporting slices: none
- Validation: n/a
- Notes: Out of scope directly from the 2026-03-30 protocol-hardening handoff.

## Traceability

| ID | Class | Status | Primary owner | Supporting | Proof |
|---|---|---|---|---|---|
| R001 | core-capability | validated | M001/S01 | M001/S02, M001/S03 | validated |
| R002 | quality-attribute | validated | M001/S02 | M001/S04 | validated |
| R003 | primary-user-loop | validated | M001/S02 | M001/S04 | validated |
| R004 | continuity | validated | M001/S03 | M001/S04 | validated |
| R005 | constraint | validated | M001/S03 | M001/S04 | validated |
| R006 | integration | validated | M001/S04 | M001/S02, M001/S03 | validated |
| R007 | core-capability | validated | M001/S01 | M001/S04 | validated |
| R008 | operability | validated | M001/S01 | M001/S03 | validated |
| R009 | operability | validated | M001/S01 | none | validated |
| R010 | failure-visibility | validated | M001/S03 | M001/S04 | validated |
| R011 | launchability | validated | M001/S04 | M001/S03 | validated |
| R012 | operability | validated | M001/S01 | M001/S04 | validated |
| R013 | operability | validated | M002/S01 | none | validated |
| R014 | operability | validated | M002/S01 | none | validated |
| R015 | failure-visibility | validated | M002/S01 | none | validated |
| R016 | scope-control | validated | M002/S01 | none | validated |
| R017 | operability | validated | M002/S01 | none | validated |
| R018 | quality-attribute | validated | M002/S01 | none | validated |
| R019 | constraint | validated | M002/S02 | M002/S01 | validated |
| R020 | differentiator | deferred | none | none | unmapped |
| R021 | continuity | deferred | none | none | unmapped |
| R022 | admin/support | deferred | none | none | unmapped |
| R023 | integration | deferred | none | none | unmapped |
| R030 | anti-feature | out-of-scope | none | none | n/a |
| R031 | anti-feature | out-of-scope | none | none | n/a |
| R032 | anti-feature | out-of-scope | none | none | n/a |
| R033 | constraint | out-of-scope | none | none | n/a |
| R034 | operability | validated | M003/S02 | none | validated |
| R035 | operability | validated | M003/S02 | none | validated |
| R036 | operability | validated | M003/S02 | none | validated |
| R037 | failure-visibility | validated | M003/S02 | none | validated |
| R038 | operability | validated | M003/S01 | none | validated |
| R039 | operability | validated | M003/S03 | M003/S01 | validated |
| R040 | process | validated | M003/S02 | M003/S01 | validated |
| R041 | operability | validated | M003/S04 | none | validated |
| R042 | differentiator | deferred | none | none | unmapped |
| R043 | differentiator | deferred | none | none | unmapped |
| R044 | operability | deferred | none | none | unmapped |
| R045 | anti-feature | out-of-scope | none | none | n/a |
| R046 | anti-feature | out-of-scope | none | none | n/a |
| R047 | anti-feature | out-of-scope | none | none | n/a |

## Coverage Summary

- Active requirements: 0
- Mapped to slices: 0
- Validated: 27
- Unmapped active requirements: 0
