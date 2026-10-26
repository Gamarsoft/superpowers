# Paper Frontend Workflow Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** Improve substantial frontend design and preserve it through actual-component implementation, with bounded Paper library upkeep.
**First delivery boundary:** One isolated version-2 candidate, evaluated skills and packet contracts, one approved-and-verified DashPark Branding pilot, scoped reconciliation, and an evidence-based adoption decision. Default activation requires the adoption gate; a verified application delivery may precede it.
**Architecture:** Retain frontend-direction and implementing-frontend-design as coordinators. Add on-demand Paper operating guidance, immutable local design evidence and a small library index. No second orchestrator, synchronization service or packet compatibility layer.
**Tech Stack:** Markdown, Python standard library, existing Node tests; Paper MCP. Pilot: Angular 7.2, Nebular 3.5.0, Bootstrap 4.3.1, Node 12.22.12 and Jest 24; preserve Gateway's intentional TypeScript 3.9.10 resolution.
**Active candidate spec:** `/private/tmp/paper-frontend-candidate/docs/superpowers/specs/2026-10-23--paper-frontend-workflow.md`, including the 2026-10-26 user-authorized experience amendment; SHA-256 `79210adbc34c4e83ed0536a957937d04424237e20cf51d3c4ccbd0fd6522dfe8`. This identifies the consumed amendment, not a new readiness approval.
**Historical original spec:** `/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-10-23--paper-frontend-workflow.md`; installed copy remains unchanged.
**Spec revision:** User-approved neutral SHA-256 `7bfe8f51dd5b096282be002747953aee4a16658af868c8ab4cd467c1c813e2e8`; routed file SHA-256 `94505acc479e7d6d578b8570785fd57c76ce003c856e91016d9a2bd8f2a04846`. At the original handoff only status and Delivery Route metadata changed after neutral approval. The later experience amendment is identified separately below.
**Risk class:** review-required.
**Risk triggers:** public contract, authorization, security, cross-system contract, concurrency, retry/recovery, multi-owner invariant.
**Verification lanes:** Task owners run focused checks. The execution controller owns cross-task integration and the paired behavior campaign. `finishing-a-development-branch` alone owns complete-suite runs and the final evidence report.

## Execution boundaries and shared contracts

This is planning only. The [reviewed Superpowers handoff](../handoffs/2026-10-23--paper-frontend-workflow-superpowers.md) authorizes this plan, not execution. Once execution is requested, use SDD; no inline-execution override is selected. Use writing-skills during skill changes and retain its adversarial baseline/candidate process. TDD applies once across execution: new executable behavior needs a meaningful failing test before implementation and a passing result afterward; skill changes need observed baseline decisions before revision. Do not invent failures or usability gains.

Path conventions below are exact roots: **S** is the separate candidate checkout `/private/tmp/paper-frontend-candidate`; **B** is the frozen control `/private/tmp/paper-frontend-baseline`; **G** is `/Volumes/Workspace/Development/SolutionPark/DashPark/gateway`. Resolve existing collisions without replacing files and record any substituted root before work. Paths without G are relative to S. Do not modify installed skills in `/Users/gamarsoft/.codex/superpowers` before Task 6. Its installed skill link points into this checkout. DashPark prohibits worktrees; use its permitted feature-branch/submodule workflow. Keep changes local; no PR, push, deployment or dependency upgrade is included.

Workflow frontend handoff, copied unchanged from the selected adapter:

```text
Frontend packet entry: not applicable — workflow/skills change
Expected revision: not applicable
Expected descriptor SHA-256: not applicable
Approval reference: not applicable — no pilot screen design approved
Status and accepted limitations: not-required for workflow planning; no product-design authority granted
```

The pilot is **required-pending** until Task 4 supplies its own complete handoff. Never substitute this workflow record, the inspected screen or the plan approval for pilot-design approval. Agree pilot effort and library allowance, establish the resettable local publication fixture, and identify the served source before pilot execution. These are execution prerequisites, not unanswered planning decisions. Inspection of parking 104 does not authorize publication to it.

### Version-2 interface

Task 2 owns the schema used by all later tasks. Keep `packet.md`/`packet.json`, revision/approval, documents, targets, states, limitations and the inventory/hash expectations. Require integer `schema_version: 2` and first-line marker `<!-- frontend-packet: 2 -->`; remove `prototype` and `prototype_omission` from active v2 instructions.

- `design_source`: `medium` (`paper`, `runtime`, `references-only`), matching `revision`, and `manifest`, an inventoried path under `design/`. The manifest binds source/provenance and every extraction/asset path. Paper requires structure, computed styles, frozen resolved tokens, assets, approved copy and component mappings; runtime requires recoverable source; references-only requires the actual scoped omission decision. Captures retain target intent, state, viewport and source version.
- `runtime_evidence`: `required_checks`, `checks` and `not_required_reason`. Each check has unique `id`, existing `state_ids`, `result` (`passed`, `failed`, `unavailable`) and an inventoried `record`. Every required ID resolves once. Empty required checks need a substantive reason; unavailable required evidence needs the existing explicitly accepted degraded scope. Failed required checks cannot be relabeled as missing proof.
- Runtime records carry the seven-field runtime handoff and recoverable code: local source or a verified immutable source reference with local recovery evidence and retained dirty changes. External locators never exempt local binding files from inventory/containment checks. Structural validation does not certify actual execution, approval or visual quality.

Keep the producer's exact entry, revision, descriptor SHA-256, human approval reference, status and accepted limits unchanged downstream. Reject version 1 with the spec's exact unsupported-version message; missing/other unsupported versions fail closed. Historical packets remain untouched reference material, including their original paths. No migration, automatic conversion or legacy fallback.

Library records use `entries` with stable `id`, `kind`, Paper locators, source/dependency mappings, approved packet identity, design/implemented revisions, `freshness`, `last_verified` and `pending`. `last_verified` retains its revision/source/evidence until verified reconciliation. `pending` states the change, reason and intended verified application revision. No baseline means explicitly unknown. The index is not an approval authority. Use `docs/design/paper/library.json` unless a suitable existing project record already owns this information.

### Context7 findings and applicability

On 2026-10-23, Context7 resolved Paper to `/websites/paper_design`, indexing [official MCP documentation](https://paper.design/docs/mcp). Its unversioned tool reference supports node/tree inspection, `get_jsx`, `get_computed_styles`, screenshots, image extraction and exports. These support a locally hashed handoff; they do not establish native editable-file recovery or real-app behavior. Inspect the installed MCP schemas/guide at execution, including available token extraction, and record capability limits. Missing exports keep the affected evidence pending. No mandatory community pack or new runtime dependency is needed.

Gateway's installed-version evidence and API lookup procedure live in `G/AGENTS.md` and `/Volumes/Workspace/Development/SolutionPark/DashPark/docs/agents/NEBULAR.md`. No new component API is chosen in this plan. Check the relevant local Nebular article and installed implementation before any later API/token change; modern documentation is not proof for 3.5.0.

### Coverage and ownership

| Requirement/invariant | Mutation owner | Later proof |
| --- | --- | --- |
| Isolated candidate and honest before/after evidence | Task 1 evaluation owner; controller retains this ownership through campaign completion | Task 3 campaign; Task 6 source/isolation audit |
| v2-only authority, immutable payload, identity/containment/state agreement | Task 2 packet owner | Task 3 consumer integration; Tasks 4–6 real handoff |
| Media roles, task-to-layout reasoning, quality gates and explicit overrides | Task 3 workflow owner | Paired pressure campaign; pilot critique and runtime review |
| Bounded library scope, pending freshness, concurrent edits | Task 3 record/policy owner; Task 5 actual library owner | Campaign fixtures; verified reconciliation and adoption report |
| Pilot effort/fixture prerequisites and human design approval | Task 4 design owner | Task 5 fail-closed handoff consumption |
| Branding invariants, fidelity, required runtime checks | Task 5 application owner | Independent runtime review and finishing evidence |
| No premature defaults or housekeeping delivery blocker | Task 6 release controller | Adoption decision with separate app/library/workflow outcomes |

## Readiness Record

**Author self-review:** complete; separated policy evaluation from tool execution, made file ownership explicit, preserved the pending pilot-design gate and degraded-evidence rules, and removed a circular adoption/finishing dependency.
**Independent readiness gate:** READY after round 0 (initial holistic review; no correction rounds), `paper_plan_readiness`, `sp_reviewer` / gpt-6-astra / medium, 2026-10-23. Reviewed full plan SHA-256 `37b9eab3315dde2df25cfbc60b824333b03bea205c1d236191fc828f6c97ce83`; at that review handoff only this readiness record changed afterward. The dated experience amendment below was authorized later and was not part of this review.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| R1 | INVALID | Pending effort, fixture and runtime identity are explicit execution prerequisites; design approval precedes implementation. No planning omission is supported. Preserve these gates. | Tasks 4–5 prerequisite and exact-handoff records |
| R2 | INVALID | Finishing supplies verification before the adoption ruling; promotion follows with identity/path checks. No circular dependency or premature activation is supported. | Task 6 and Whole-feature verification |

## User-authorized experience amendment — 2026-10-26

The user rejected Branding r1 and requested the bounded correction described in the [amended spec](../specs/2026-10-23--paper-frontend-workflow.md#experience-amendment--2026-10-26) and [diagnosis](../reviews/2026-10-26-paper-experience-correction.md). The readiness record above applies to its original reviewed bytes; it is not approval of the new wording. Completed U1–3 and historical evaluations remain complete and immutable. No current pilot design is approved.

U3A adds the shared experience brief for both entry routes, conditional rough structural exploration before polish, and a consequential rendered quality verdict within the existing cadence. Ownership is limited to frontend-direction entry, task-to-layout, visual-exploration, frontend-review-checklist, paper-workflow and packet prose template; one implementation-review consumption sentence; these affected spec/plan sections; and the diagnosis. The v2 schema and validator are unchanged. Root owns fresh pressure/transfer evidence and affected design-handoff regression, preserving prior runs. Run the focused frontend resource test, visual review policy and artifact-quality integration. These checks establish policy reachability/regression, not better product design; new rendered evidence and human approval are still necessary. Use the existing single SDD review after evaluation, without resetting historical correction counts.

Task 4 resumes with focused experience discussion, not polishing r1. Branding is once per parking with rare rebranding; supplied logos and agreed color are ready. Compare useful rough structures for unresolved task flow, hierarchy and interaction, then select on ease, clarity, visual quality and product fit. Reconsider preview usefulness, current/draft duplication, visual asset selection, copy, first publication/edit emphasis and mobile/picker interaction. Keep the rejected packet unchanged as baseline. Preserve publication/save behavior, the existing remaining pilot allowance, fixture prerequisites and exact final design approval before Task 5. Workflow-correction effort is separate; pilot critique/design effort is charged once. Task 6 still requires actual design improvement evidence, implementation, reconciliation and the existing adoption gates.

## Tasks

### Task 1: Establish the isolated control and candidate evidence

**Outcome:** Candidate development cannot change installed defaults; a reproducible baseline exists before skill edits.
**Files and ownership:** Evaluation owner creates `tests/codex/paper-frontend-behavior/` containing `scenarios/design-handoff.md`, `scenarios/maintenance-boundaries.md`, `evaluation.md` and immutable `results/runs/` records. Own these files throughout later campaign runs; no new general eval harness.
**Interfaces and contracts:** Consumes approved spec/adapter; produces recorded B/S roots and source hashes, frozen scenarios/assertions, baseline responses and environment inventory. Copy approved untracked planning artifacts explicitly; cloning HEAD alone omits them.
**Dependencies:** none.
**Risk class and triggers:** checkpoint-review; none.
**Acceptance criteria:** Create separate local Git copies; retain the existing installation unchanged. Use the actor procedure from `tests/codex/sdd-behavior/README.md`: supply complete immutable skills plus neutral scenarios to fresh `fork_turns: none` agents, with no actor tools or inherited session. This tests policy application, not implicit skill discovery. Record all supplied source hashes and complete outputs. Hold model/effort and harness conditions constant; start with five samples per scenario and follow the existing matched-count rule when one baseline failure requires expansion. Capture real baseline failures/rationalizations; passing baseline cases remain regression controls.
**Error handling:** Missing source identity, incomplete samples or mixed candidate/baseline instructions invalidate the run. Preserve it and make a new run ID; never overwrite evidence. Inventory missing Claude/Quorum capabilities rather than claim those lanes ran.
**Verification:** Run `python3 tests/codex/sdd-behavior/score-results.py tests/codex/paper-frontend-behavior/results/runs/baseline-r1`. Expected: valid manifest, complete sample set and honest scored outcomes, including failures. Also compare installed skill-tree hashes before/after setup.
**Review focus:** none beyond the recorded isolation and evidence contract.
**Codebase pointers:** `tests/codex/frontend-design-behavior/scenario.md`, `tests/codex/sdd-behavior/README.md`, `skills/writing-skills/testing-skills-with-subagents.md`.

### Task 2: Replace the packet contract with version 2

**Outcome:** The read-only helper and canonical authoring references validate v2 design/runtime evidence and reject old handoffs.
**Files and ownership:** Packet owner alone changes `skills/frontend-direction/scripts/frontend_packet.py` and `tests/claude-code/test-frontend-packet.py`. Under `skills/frontend-direction/references/`, own `packet-schema.md`, `packet-finalization.md`, `packet-handoff.md`, `frontend-packet-folder-template.md`, `frontend-direction-template.md`, `screen-index-template.md` and `frontend-packet-completeness-checklist.md`.
**Interfaces and contracts:** Consumes the Version-2 interface above; produces the schema, v2 fixtures and existing `inventory`/`check` CLI with unchanged expected-revision/hash flags. Agents write/export packets; the helper never approves, writes files or runs launch commands. Task 3 consumes this schema without changing it.
**Dependencies:** Task 1, so old behavior is recorded and mutations occur only in S.
**Risk class and triggers:** review-required; public contract, authorization, security, cross-system contract.
**Acceptance criteria:** Port positive cases to v2, including Paper, runtime, scoped references-only and explicitly degraded evidence. Reject v1, absent/unknown versions, missing source payload, required failed/missing proof, stale approval and mismatched expected identity. Retain tamper/add/remove detection, symlink/path containment, excluded binding-path rejection, target/state agreement and legitimate uncaptured states. Frozen token values and extraction files remain bound even if live Paper tokens change. Preserve old packets byte-for-byte.
**Error handling:** Structured actionable errors and nonzero exit; no fallback, migration, descriptor rehash to bless changed content or invented human approval.
**Verification:** Run `python3 tests/claude-code/test-frontend-packet.py`; require failing-then-passing evidence for new cases and all retained integrity cases passing. Keep `check` validation with externally supplied expected identity in consumer fixtures.
**Review focus:** Required proof cannot disappear through an omission branch; every binding path is inventoried and version rejection is unavoidable.
**Codebase pointers:** Existing helper's `check`/`current_files`, schema and finalization recipe; `skills/implementing-frontend-design/references/runtime-handoff.md`.

### Task 3: Integrate Paper authoring, bounded library upkeep and consumers

**Outcome:** One coherent candidate uses Paper for composition, actual components for behavior, and v2 throughout active handoffs.
**Files and ownership:** Workflow owner has these files; filenames grouped under a directory are relative to that directory:

- `skills/frontend-direction/`: `SKILL.md`, `agents/openai.yaml`, `references/visual-exploration.md`, `references/frontend-direction-phase.md`, `references/frontend-review-checklist.md`, `references/design-source-priority.md`; create `references/paper-workflow.md` and `references/paper-library.md`.
- `skills/implementing-frontend-design/`: `SKILL.md`, `agents/openai.yaml`, `references/implementation-review-checklist.md`, `references/runtime-handoff.md`, `references/source-of-truth.md`, `references/chatgpt-image-source-consumption.md`.
- `skills/brainstorming/`: `SKILL.md`, `visual-companion.md`, `references/frontend-direction-follow-on-prompt-template.md`, `references/spec-template.md`, `references/gsd-handoff-template.md`, `references/delivery-routing.md`, `references/visual-companion-protocol-pressure-scenarios.md`.
- `skills/using-superpowers/SKILL.md`, `skills/writing-plans/SKILL.md`, `skills/subagent-driven-development/implementer-prompt.md`, `.github/agents/ui-packet-guardian.agent.md`, `.github/agents/ui-refinery.agent.md`, `docs/gsd/AGENTS.md`, `docs/gsd/preferences.md`, `docs/superpowers/references/frontend-skill-stack-reference.md`, `docs/superpowers/references/brownfield-frontend-contract-workflow.md`.

Task 2 retains its schema/templates. Workflow owner updates the focused policy/resource/Companion tests named below; evaluation owner retains campaign files/results. Edit only instructions contradicted by the approved workflow; historical research and delivered packets stay untouched.
**Interfaces and contracts:** Consumes Task 2 schema and unchanged handoff fields; produces on-demand Paper guidance, library record examples and consistent producers/consumers. Active historical-image consumption instructions are retired; historical records are preserved.
**Dependencies:** Tasks 1–2.
**Risk class and triggers:** review-required; public contract, authorization, concurrency, retry/recovery, cross-system contract.
**Acceptance criteria:** Preserve task-to-layout reasoning, substantive design references, exact copy/i18n/accessibility, quality critique and independent runtime review. No routine Companion screen composition, generated UI screenshots or full standalone recreation. Preserve diagrams, explicit medium overrides and Companion startup/artifact-first/question-tool/degraded-fallback guarantees. Cover greenfield minimal foundations and affected-only brownfield growth. Stop upkeep at allowance; retain pending entries' last verified identities and preserve manual/concurrent edits. Pending housekeeping cannot block verified app delivery or waive defects. No watcher, auto-sync, parallel approval history or full-product backfill.
**Error handling:** Missing Paper before requested design requires an explicit available-medium decision; missing required export/proof stays pending. Approved local snapshots remain consumable offline. Conflicting edits reopen only their affected decision.
**Verification:** Focused: `python3 tests/claude-code/test-frontend-direction-contract.py`, `node tests/brainstorm-server/visual-companion-contract.test.js`, `node tests/brainstorm-server/visual-companion-design-kit.test.js`. Controller integration also runs the five policy scripts listed in Whole-feature verification. Evaluation owner runs matched fresh candidate actors and scores `python3 tests/codex/sdd-behavior/score-results.py tests/codex/paper-frontend-behavior/results/runs/candidate-r1 --baseline tests/codex/paper-frontend-behavior/results/runs/baseline-r1`.
**Review focus:** Pressure checkpoints must exercise stacked media, polished-but-task-inappropriate design, skipped component proof, narrow feedback, global aesthetics, manual edits, stale/partial coverage, over-budget upkeep, delivery blocking, token-hash confusion, historical input, mechanical changes and explicit overrides. Include concrete library before/after records testing stale dependencies, pending identity preservation and approved-versus-implemented state. Grade observable decisions and record every failure; word matching is not behavior proof.
**Codebase pointers:** Existing design-source-priority, task-to-layout, design-knowledge-selection, visual-exploration, runtime-handoff and retained Companion pressure scenarios. Update active guidance only where outcomes or evaluation require it.

### Task 4: Produce and approve the Branding pilot design

**Outcome:** A recoverable v2 design resolves the pilot's visual decisions and is approved before application implementation.
**Files and ownership:** Design owner creates `G/docs/design/paper/branding-pilot.md` for prerequisites/evaluation and `G/docs/superpowers/specs/2026-10-23--parking-branding--frontend/` for the packet. Operate scoped Paper drafts; do not mutate Gateway application source in this task. Disposable actual-component probes may establish feasibility without delivering the screen or publishing data.
**Interfaces and contracts:** Consumes evaluated candidate and spec pilot scope. Produces final packet, source/viewport/state evidence, and the complete actual handoff record copied into `branding-pilot.md` and the implementation dispatch. Until approval, record required-pending without invented revision/hash/approval.
**Dependencies:** Task 3; agreed pilot effort/library allowance, resettable publication fixture, available Paper/browser tools and seven-field runtime handoff are mandatory entry prerequisites.
**Risk class and triggers:** review-required; authorization, cross-system contract.
**Acceptance criteria:** Start from parking 104's observed Branding baseline and current source. Correct overlap; justify first-publication, edit/preview and publication-readiness relationships. Preserve displayName versus parking name, light/dark logos, favicon, hex/file validation, selected-light-logo gating, publish versus Terminer, shell/stepper and French-first density. Critique at 1440×900, 1024×768, 390×844 and the reproduced overlap width, using actual content widths. Apply relevant design knowledge and actual-component checks before dependent approval. Export coherent structure/styles/tokens/assets/captures and scoped reference intents. Obtain final human design approval once for the exact design; record usability as unobserved unless a person performs the task.
**Error handling:** Missing prerequisites stop dependent pilot work. Required proof stays provisional unless the existing explicit degraded-acceptance mechanism is satisfied; this cannot waive the pilot's adoption evidence. Do not treat elapsed time, workflow approval or a screenshot as permission. Any requested change to publication rules returns to scope approval.
**Verification:** From S run `python3 skills/frontend-direction/scripts/frontend_packet.py check /Volumes/Workspace/Development/SolutionPark/DashPark/gateway/docs/superpowers/specs/2026-10-23--parking-branding--frontend`. Expected: valid v2 descriptor plus separately recorded quality, evidence and human approval. Check available MCP export/token behavior with the real tool, not mocks.
**Review focus:** Design quality and recoverability, exact approved identity, justified component feasibility and no unauthorized publication.
**Codebase pointers:** Spec's Selected use case and state table; G component HTML/TS/SCSS, shared color picker, branding validation/service, PRODUCT.md, DESIGN.md and AGENTS.md.

### Task 5: Implement the approved pilot and reconcile affected entries

**Outcome:** Verified Branding implementation and at least one reconciled maintained entry demonstrate the complete workflow.
**Files and ownership:** Application owner changes `G/src/main/webapp/app/admin/parking/admin-parking-update.component.html`, `.scss`, and `.ts` only as needed; its component/branding utility specs, `G/src/main/webapp/app/core/services/tenant-branding-admin.service.spec.ts`, and affected `G/src/main/webapp/i18n/*/parking.json`. Shared color-picker files change only if required by the approved design and after impact inspection. Same owner updates `G/docs/design/paper/library.json` (or the existing suitable record) and the verification/reconciliation sections of `branding-pilot.md`; never rewrite the approved packet.
**Interfaces and contracts:** Consumes Task 4's complete unchanged handoff, exact capture/source versions, launch/state setup, acceptance and supersession. Check both expected revision and descriptor hash before work; missing expectations return to the producing record. Produces application revision/evidence, accepted deviations, reconciled Branding screen/pattern entry and explicitly pending additional upkeep.
**Dependencies:** Approved Task 4 handoff; no application implementation before that approval.
**Risk class and triggers:** review-required; authorization, cross-system contract, concurrency, retry/recovery.
**Acceptance criteria:** Use actual Angular/Nebular components, not generated JSX. Verify every spec pilot state: initial/unchanged/draft, invalid inputs and asset variants, publish in progress/error/success on the resettable fixture, responsive/keyboard access, copy and contrast. Preserve backend/publication contracts and unrelated steps. Fresh independent runtime review uses all seven handoff fields and recaptures matching states. Reconcile the Branding entry from verified code; update shared entries only if affected. Stop at allowance, retain last verified identities and minimum pending records. Uncompleted extra housekeeping does not block a verified app; material fidelity changes require scoped approval, never silent library normalization.
**Error handling:** Reject stale handoff or unknown served source. Keep app defects distinct from library backlog. If no entry can be reconciled, verified app delivery may proceed but workflow adoption remains pending.
**Verification:** In G under Node 12.22.12 run `npm run test:jest -- --runInBand --testPathPattern='admin-parking-update.component.spec.ts|branding-file-validation.util.spec.ts|branding-url.util.spec.ts|tenant-branding-admin.service.spec.ts'`. Add focused selectors for changed shared consumers. Follow G's formatting-before-lint, fresh LSP and Sass/build fallback procedures; tests/lint do not replace diagnostics. Collect live publication evidence for persistence claims and independent visual/interaction findings. Record setup, Paper iteration, export, corrections and reconciliation effort separately.
**Review focus:** Faithful and useful implementation, preserved publication semantics, genuine reconciliation, and no false freshness or human-usability claim.
**Codebase pointers:** G's four existing spec files above, `jest.config.js`, `/Volumes/Workspace/Development/SolutionPark/DashPark/docs/agents/TESTING.md` and `LIVE_RUNTIME_DB.md`.

### Task 6: Decide adoption from integrated evidence

**Outcome:** One documented adoption decision; defaults advance only with sufficient evidence.
**Files and ownership:** Release controller owns `docs/superpowers/evaluations/2026-10-23-paper-frontend-adoption.md` and promotion of the exact tested S commits into the installed Superpowers checkout. No additional skill edits during promotion; route fixes back to their owner and recheck affected evidence.
**Interfaces and contracts:** Consumes exact candidate identity, regression/campaign evidence, approved pilot handoff, verified app and scoped reconciliation report. Produces adopt/retain-candidate decision, remaining limits and reversible Git promotion record.
**Dependencies:** Tasks 1–5 and pre-adoption verification supplied by finishing below.
**Risk class and triggers:** review-required; cross-system contract, multi-owner invariant.
**Acceptance criteria:** Require passing relevant regression and fresh-session checks, actual export-to-component delivery, acceptable fidelity and useful bounded reconciliation. Assess design quality and maintenance effort, not only script success. Separate first-use setup from upkeep; report unmeasured repeat-use savings and one-screen limits. Pending extra housekeeping may coexist with adoption once minimum reconciliation and other gates pass. On success, promote once, retain history untouched and verify a fresh session resolves the adopted skill path; no dual-format switch or old-format runtime fallback.
**Error handling:** Missing evidence, impractical maintenance or failed required checks retain candidate status. Narrow/fix and rerun affected checks only. Preserve unrelated changes and keep promotion reversible through Git.
**Verification:** Controller checks the coverage table against exact source identities and invokes finishing. After promotion, compare installed source identity with tested candidate and perform the fresh-session path/entry smoke check. A mismatch prevents an adoption claim.
**Review focus:** Evidence permits adoption; neither pending housekeeping nor incomplete workflow adoption is misreported as an application defect.
**Codebase pointers:** Spec Adoption criteria, `skills/finishing-a-development-branch/SKILL.md`, campaign report and `G/docs/design/paper/branding-pilot.md`.

## Whole-feature verification and finishing

The controller stitches one candidate revision and records its source/fixture identities. Cross-skill integration runs `bash tests/claude-code/test-frontend-visual-review-policy.sh`, `bash tests/claude-code/test-no-pencil-frontend-policy.sh`, `bash tests/claude-code/test-brainstorming-artifact-quality.sh`, `bash tests/claude-code/test-custom-policy-contracts.sh` and `bash tests/claude-code/test-lean-delivery-contracts.sh`. Reuse valid Task 2–3 results for unchanged sources; do not repeat for ceremony. Trace one real pilot packet from extraction through validator, approval, implementation dispatch and library record. Confirm current/draft/invalid/publishing/error/success states, responsive composition and retained constraints survived stitching.

Required pre-adoption evidence is the paired campaign report with full outputs, exact pilot handoff, independent runtime review, state/viewport captures, scoped library before/after identities and separated effort measurements. Explicitly check token drift, replaced descriptors, excluded paths, unavailable required proof, concurrent edits, exhausted allowance and Paper unavailability after app verification. These cannot be waived by a visually polished result.

Complete suites belong only to `finishing-a-development-branch`: from S, `npm --prefix tests/brainstorm-server test` and `bash tests/claude-code/run-skill-tests.sh --timeout 900`; from G under Node 12.22.12, `npm run test:jest -- --runInBand`; then `git diff --check` in changed repositories. The Claude runner currently lacks its CLI here; the external `evals/`/Quorum checkout is also absent. Record unavailable harness lanes explicitly. Required deterministic checks run directly and the fresh Codex campaign plus real pilot remain mandatory; do not claim Claude/Quorum coverage or install them silently. If an unavailable lane leaves an approved requirement unproved, retain candidate status. No universal repository-wide suite is claimed.

Finishing supplies these verification results before Task 6 decides adoption. Task 6 then adds the ruling and any promotion identity; finishing closes the report. Unchanged promotion needs identity/path checks, not a second suite run.

## Execution handoff

After the readiness record is READY, compact before execution. Use this continuation only when execution is requested:

> Use `$superpowers:subagent-driven-development` to execute `/Users/gamarsoft/.codex/superpowers/docs/superpowers/plans/2026-10-23-paper-frontend-workflow.md`. Start with isolated candidate/control setup and baseline evaluations. Preserve the approved spec and review records, keep installed defaults unchanged until evidence supports adoption, resolve pilot effort and resettable fixture prerequisites before pilot work, and obtain approval of the exact pilot design before application implementation. Carry all readiness findings and exact packet identities forward.
