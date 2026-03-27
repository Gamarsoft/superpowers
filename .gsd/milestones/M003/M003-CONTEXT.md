# M003: Visual Companion Protocol Hardening

**Gathered:** 2026-03-30
**Status:** Queued — pending auto-mode execution.

## Project Description

Harden the brainstorming visual-companion workflow so accepted visual sessions start at the right moment, every qualifying visual turn is artifact-first, terminal confirmation discipline stays intact, and the written review/spec surfaces can catch the same live-use regression family before it reaches users. This milestone also adds selective low-fidelity wireframe appendix guidance for spatial decisions that need to persist into the design spec or handoff.

## Why This Milestone

M002 tightened routing and authoring quality, but the first real brownfield trial still exposed protocol drift: the first later genuinely visual turn could remain terminal-only, the question could arrive before the artifact was viewable, and terminal question-tool confirmations could disappear once browser turns began. The smallest reversible response is to harden the workflow contract and review pressure now, not to reopen the runtime before the docs-and-review path has been pressure-tested.

## User-Visible Outcome

### When this milestone is complete, the user can:

- accept the visual companion and then see the next genuinely visual artifact before being asked to judge it in terminal
- carry a major spatial decision into the written spec or handoff through an optional low-fidelity wireframe appendix when that persistence is actually useful

### Entry point / environment

- Entry point: the existing brainstorming workflow driven by `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, and the written spec/handoff review loop
- Environment: local terminal plus browser brainstorming sessions, with spec and handoff authoring in the repo
- Live dependencies involved: the platform question tool when available, the existing visual companion runtime, and the current spec-review workflow

## Completion Class

- Contract complete means: the workflow docs, pressure-scenario artifact, review assets, and spec-template guidance all state the hardened protocol explicitly enough to verify by file review and regression-style scenario checks
- Integration complete means: `skills/brainstorming/SKILL.md`, `skills/brainstorming/visual-companion.md`, `skills/writing-skills/SKILL.md`, `skills/test-driven-development/SKILL.md`, `skills/brainstorming/references/spec-review-checklist.md`, `skills/brainstorming/spec-document-reviewer-prompt.md`, and `skills/brainstorming/references/spec-template.md` reinforce the same protocol without implying runtime or archetype changes
- Operational complete means: the same brownfield regression family can be rerun as named pressure scenarios, show a baseline failure before edits, and then pass after the docs-and-review hardening without requiring server, helper, or frame-template edits

## Final Integrated Acceptance

To call this milestone complete, we must prove:

- given the user accepted the companion and the next later decision is genuinely visual, the workflow starts or confirms the companion, makes the artifact viewable, and only then asks the terminal decision prompt
- given the companion is already open, a later qualifying visual turn still uses the dedicated terminal question-tool prompt when available, or names degraded fallback explicitly when it is unavailable
- given a major layout or spatial decision needs durable carry-forward, the spec can include a selective low-fidelity wireframe appendix and the GSD handoff can link to an existing appendix without turning appendices into a required archetype or changing runtime behavior

## Risks and Unknowns

- Workflow wording may still be interpreted too loosely even after the hardening pass — if the named pressure scenarios are weak, drift will survive the docs update
- Question-tool availability boundaries may be underspecified — degraded fallback needs to stay explicit so freeform handling does not become silent policy
- The same live scenario may still fail after the docs-and-review slice lands — if that happens, the follow-on should become a runtime/diagnostics milestone backed by concrete evidence instead of guesswork

## Existing Codebase / Prior Art

- `skills/brainstorming/SKILL.md` — owns per-turn routing, consent flow, and terminal question-tool discipline in brainstorming sessions
- `skills/brainstorming/visual-companion.md` — owns artifact-first behavior, pre-display gating, and the companion-side protocol language
- `skills/writing-skills/SKILL.md` — defines the required red/green validation loop for skill-document edits
- `skills/test-driven-development/SKILL.md` — provides the prerequisite red/green discipline that the writing-skills loop depends on
- `skills/brainstorming/references/spec-review-checklist.md` — review bar that needs explicit pressure-scenario checks
- `skills/brainstorming/spec-document-reviewer-prompt.md` — reviewer dispatch template that needs to enforce the same protocol family
- `skills/brainstorming/references/spec-template.md` — spec guidance surface that should allow selective durable wireframe appendices for spatial decisions
- `tests/brainstorm-server/visual-companion-contract.test.js` — current contract regression surface for authored workflow language
- `tests/brainstorm-server/live-companion-acceptance.test.js` — live proof surface that already exercises the real entrypoint and should stay the runtime tie-breaker
- `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening.md` — detailed design source for the milestone
- `docs/superpowers/specs/2026-03-30--brainstorming-visual-companion-protocol-hardening--gsd-handoff.md` — authoritative queue brief and requirement seed
- `.gsd/milestones/M002/M002-SUMMARY.md` — proof that M002 tightened routing/quality above the runtime and left the thin-runtime baseline intact

> See `.gsd/DECISIONS.md` for all architectural and pattern decisions — it is an append-only register; read it during planning, append to it during execution.

## Relevant Requirements

- R034 — require the first later genuinely visual question after consent to start the companion path instead of remaining terminal-only
- R035 — require every qualifying visual turn to be artifact-first so the visual artifact is viewable before the terminal question is asked
- R036 — preserve the dedicated terminal question-tool prompt for qualifying visual turns even after the companion has already been opened earlier in the session
- R037 — make degraded-mode wording explicit when the platform question tool is unavailable
- R038 — create the named pressure-scenario artifact for the observed live-use regression family
- R039 — update review assets so they check the named pressure scenarios and expected protocol outcomes directly
- R040 — require `writing-skills`, with its `test-driven-development` prerequisite, to drive the validation loop through a baseline failing scenario and a post-edit rerun
- R041 — add selective durable wireframe appendix guidance to the spec path and allow the handoff to link to an existing appendix when relevant

## Scope

### In Scope

- first-visual-turn startup behavior after visual-companion consent
- artifact-first sequencing for every genuinely visual question
- terminal question-tool continuity plus explicit degraded fallback wording
- the named `visual-companion-protocol-pressure-scenarios.md` regression family artifact
- review-asset updates in the spec checklist and reviewer prompt
- selective low-fidelity wireframe appendix guidance in the spec template and handoff-link allowance when an appendix already exists

### Out of Scope / Non-Goals

- runtime changes in `skills/brainstorming/scripts/server.cjs`, `helper.js`, or `frame-template.html`
- new required metadata beyond `data-choice`
- browser-first reasoning or browser-native confirmation flows
- mandatory wireframe appendices for every visual turn
- handoff-template changes beyond allowing linkage to an already-existing appendix

## Technical Constraints

- Keep the browser optional and per-question rather than treating consent as a switch into browser mode.
- Keep conceptual, scope, and text-first turns in terminal.
- Preserve the current runtime, metadata, and four-archetype contract.
- Treat durable wireframes as appendix artifacts for spatial decisions, not as a new visual-companion archetype.
- Use `writing-skills` together with its `test-driven-development` prerequisite instead of an ad hoc docs-edit flow.

## Integration Points

- brainstorming workflow routing — the per-turn decision about terminal-only versus companion-assisted handling
- visual companion authoring flow — the artifact-first sequence and pre-display gate before a visual decision prompt
- platform question tool boundary — whether qualifying visual turns use the dedicated tool or explicit degraded fallback wording
- spec-review loop — named pressure scenarios must become part of the review bar, not just advisory prose
- design spec and GSD handoff artifact structure — optional durable wireframe appendices need narrow, reusable written guidance

## Open Questions

- Whether a later runtime slice should emit stronger diagnostics for skipped first-visual-turn startup — current thinking: keep that deferred unless the hardened workflow still fails the same scenario after this milestone lands
