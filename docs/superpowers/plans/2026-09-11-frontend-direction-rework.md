# Frontend Direction Rework Implementation Plan

> **For agentic workers:** Use `superpowers:executing-plans` for this explicit self-hosting execution override. The controller edits and tests each skill sequentially, coordinates fresh behavioral actors and the interactive image/browser pilot, and obtains one final independent review. Do not invoke a second execution controller.

**Goal:** Frontend direction produces a human-selected, browser-tested design that survives implementation in a legacy app.
**First delivery boundary:** Rework design and implementation skills and their actual callers; preserve historical artifacts; validate decisions and a DashPark design-only pilot. No production DashPark edits, framework upgrades, publication, pushes, or PR.
**Architecture:** One design workflow with follow-on and standalone entries; a focused implementation consumer; one shared authority contract and conditional Impeccable reference. Built-in image generation replaces upload-pack authoring.
**Tech Stack:** Markdown skills, existing YAML discovery metadata, shell/Python structural tests, existing browser companion tests. Runtime tools are discovered from this session rather than encoded APIs. No new dependency.
**Spec:** `docs/superpowers/specs/2026-09-10--frontend-direction-visual-exploration.md`
**Spec revision:** User-approved 2026-09-11, including optional Impeccable, clean skill-name migration, and the confirmed Superpowers route; only delivery/evidence status may change during execution.
**Risk class:** review-required
**Risk triggers:** public contract, cross-system contract, explicit user request for tested skills and reviews
**Verification lanes:** Controller owns RED/GREEN decision probes and focused structural checks, caller/link integration, and actual image/browser pilot. Fresh actors supply independent behavioral evidence and a fresh reviewer checks the full change. Finishing owns the complete available deterministic suite and records unavailable harness tests separately.

## Context and invariants

Branch `feat/frontend-direction-visual-exploration` is the existing task-only checkout; implementation base `4355ee8428146481235ddcac1bc604815102975a`. Keep it. The installed Superpowers path symlinks to this checkout, so freeze evaluation snapshots and give actors only assigned versions. Existing untracked spec/handoff are task-owned. No external installation edits.

Use `skill-creator` and `writing-skills`; behavior needs observed RED before instructions change, five matched fresh samples per wording variant including controls, manual reading, and independent forward tests. Do not claim keyword checks prove visual outcomes. Validate a skill before moving to the next; caller migrations are part of their owning skill's delivery. No automatic pushes despite generic deployment guidance.

Existing approval is sufficient for planning/implementation. Actual concept selection and approval of the final pilot remain human decisions and are not inferred from this plan. A pause for those concrete choices leaves the pilot pending, not the rework complete.

Authority is scoped: business/accessibility/technical constraints, retained brand/shell, and an approved feature design delta can all bind without promoting legacy composition above the selected target. Existing packets retain their recorded authority; a renamed skill does not retroactively grant redesign permission. `visual-truth`, `semantic-guidance`, `reference-only`, and `required-pending`/approved/degraded statuses remain compatible, including old `required` status at consumption.

No new API integration is coded. Image/browser skills and live tool documentation supply runtime syntax. Optional Impeccable is read from the target project; absent or partial tools do not block core work or justify fabricated reports.

## Readiness Record

**Author self-review:** complete. Each spec area maps below; separated decision probes from real visual pilot, retained caller migration and historical authority, and made the interactive checkpoint explicit.
**Independent readiness gate:** READY after round 1; `plan_readiness`, 2026-09-11, holistic and selected-adapter review found no supported failure.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | READY; no findings | Full plan/spec mapping accepted by `plan_readiness` |

## Requirement and verification mapping

| Spec area / invariant | Owner | Verification |
| --- | --- | --- |
| Standalone and follow-on; three concepts/refine/prototype; scope-aware fallback | Task 1 | Matched controls/current/candidate plus boundary actors; Task 3 actual pilot |
| Shared authority, exact selected version, copy/states, durable packet | Task 1 | Artifact contract checks and selection-feedback actor; Task 3 captures |
| Upload authoring retirement, old images readable | Task 1 authoring; Task 2 consumer | Discovery and link checks, historical-packet forward case |
| Focused implementation rename, useful runtime/fresh review gates | Task 2 | Implementation authority RED/GREEN, forward runtime fixture, legacy visual-review tests |
| Minimal brainstorming/planning/bootstrap/GSD callers | Task 2 | Caller inventory, handoff tests, visual-companion regression |
| Optional installed/absent/degraded Impeccable; no legacy normalization | Task 1 shared reference; Task 2 consumption | Matched standalone and implementation conflict cases; Task 3 installed pilot pass |
| Truthful evidence; production boundary; human choice | Task 3 | Actual saved images, prototype, state captures, user decisions; final review |

### Task 1: Produce an explorable frontend direction

**Outcome:** Standalone or follow-on work reaches real alternatives and a durable approved prototype without preserving legacy composition by default.
**Files and ownership:** Controller solely owns `skills/frontend-direction/**`, retirement of `skills/creating-chatgpt-image-upload-packs/**`, `tests/claude-code/test-chatgpt-image-pack-detail.sh` replacement and its runner registration, new `tests/claude-code/test-frontend-direction-contract.py`, and evaluation artifacts under `.superpowers/evals/frontend-direction-20260911/`.
**Interfaces and contracts:** Consume approved spec and immutable baseline snapshots. Produce focused entrypoint, exploration reference, shared scoped authority and conditional Impeccable guidance, packet templates with exact reference versions/prototype source/launch/state/capture/supersession/approval fields. No standalone spec prerequisite or new orchestrator; established follow-on preserves invoking workflow.
**Dependencies:** none.
**Risk class and triggers:** review-required; public contract, explicit review request.
**Acceptance criteria:** Five candidate samples choose the authorized three-concept loop and standalone brief, preserve brand/business scope, keep optional tools optional, and retain prototype evidence. Boundary tests cover approved target/mechanical work, unavailable tools, unresolved business rule, and mixed visual feedback. Packaging cannot discover retired upload authoring. Existing approved image files remain valid inputs. Conditional optional capability instructions match the installed skill's actual requirements.
**Error handling:** Missing capabilities are reported truthfully with the authorized fallback only; unresolved dependent business decisions stop that design decision; no pretend images or approval. Recheck supported behavioral failures before expanding instructions.
**Verification:** Run five matched fresh current and candidate actors using `scenario.txt` and snapshot skills; manually score all with quotes in `results.md`. Run `python3 tests/claude-code/test-frontend-direction-contract.py` and skill creator `quick_validate.py skills/frontend-direction`. Update obsolete upload-pack tests to assess the new discoverability/artifact contract, preserving meaningful generation semantics. These checks contribute to final suite.
**Codebase pointers:** All current frontend-direction references and metadata; upload-pack prompt structure; `writing-skills/testing-skills-with-subagents.md`; saved controls and `manifest.json`.

### Task 2: Carry approved visual direction into implementation

**Outcome:** Fresh implementation consumes the approved design instead of restoring legacy composition, and all active local callers resolve.
**Files and ownership:** Controller owns replacement `skills/implementing-frontend-design/**` and removal of `skills/gsd-frontend-design/**`; narrow edits to `skills/brainstorming/**`, `skills/using-superpowers/SKILL.md`, `skills/writing-plans/**`, and execution prompt templates only where missing packet consumption is evidenced; `.github/agents/ui-refinery.agent.md`, `.github/agents/ui-packet-guardian.agent.md`, `.github/copilot-ui-refinery-guide.md`, `docs/gsd/AGENTS.md`, `docs/gsd/preferences.md`, `docs/superpowers/references/frontend-skill-stack-reference.md`; relevant existing frontend/brainstorming tests and runner migration. Task 1 shared files are consumed, not duplicated.
**Interfaces and contracts:** Consume Task 1 authority/reference intents and approved prototype packet; accept existing approved packets and explicit references without GSD files or regenerated artifacts. Produce component mapping, runtime comparison, scoped optional refinement, and independent visual review with actual recapture. Task inputs and acceptance fields carry exact binding artifacts.
**Dependencies:** Task 1 verified, since authority and packets are shared.
**Risk class and triggers:** review-required; public contract, cross-system contract, explicit review request.
**Acceptance criteria:** Matched baseline/control/candidate implementation probes demonstrate approved delta beating conflicting legacy docs while retaining shell/copy/invariants. A fresh actor uses an approved fixture target and reports runtime mismatches without confusing fixture and integration proof. Old packet consumption works; missing required packet remains a blocker, approved direct inputs do not trigger discovery. Retain fresh context, independent route opening/recapture, inaccessible-route nonapproval, and visual completion gates. Update active names/paths together; report external invocation migration without editing other projects. Preserve visual companion and separate brainstorming session contracts. No unrequested invocation-policy changes.
**Error handling:** Ambiguous binding scope is clarified, unapproved revisions remain pending, route or recapture failure never yields visual approval; optional audit limitations do not become full-workflow prerequisites.
**Verification:** Freeze and run five implementation control/current/candidate decision samples with identical evidence. Run changed skills through `quick_validate.py`; run `bash tests/claude-code/test-no-pencil-frontend-policy.sh`, migrated frontend visual-review test, `bash tests/claude-code/test-brainstorming-artifact-quality.sh`, and `node --test tests/brainstorm-server/visual-companion-contract.test.js`. Inspect active callers with raw `rg` and local link/discovery checks. Add only tests justified by changed interfaces.
**Codebase pointers:** Existing implementation skill and references; caller inventory in handoff; brainstorming follow-on/template; writing-plans task inputs; execution implementer prompt; existing tests named above.

### Task 3: Validate the complete workflow on the DashPark slice

**Outcome:** Real images and an exercised prototype demonstrate the workflow and provide a target for fresh implementation verification.
**Files and ownership:** Controller owns pilot files beneath `.superpowers/evals/frontend-direction-20260911/pilot/`, durable evaluation report in `docs/superpowers/evaluations/2026-09-11-frontend-direction.md`, plan/handoff status, and plan-scoped execution ledger/report. Read-only DashPark source and project instructions.
**Interfaces and contracts:** Consume verified skills and current source-confirmed loyalty detail boundary. Produce three separate same-content/viewport concepts, exact human-selected/refined target, synthetic local prototype source and launch notes, desktop/narrow and interaction/state evidence, honest capability/run records, and human review. Pilot files remain durable while evidence is needed and are not cleaned by finishing.
**Dependencies:** Tasks 1 and 2; human selection precedes selected prototype, human final approval precedes approved packet/completion.
**Risk class and triggers:** review-required; explicit review request, cross-system contract.
**Acceptance criteria:** Confirm source behavior before using historical screenshot. Use built-in imagegen with inspected references; show actual alternatives and allow choice. Prototype uses real elements and representative interactions, not click regions over images; inspect normal/long/empty/error/narrow and keyboard/focus. Use installed project-local Impeccable for an appropriate bounded assessment with its real evidence requirements; preserve approved delta and report any degraded execution. Human can judge actual designs; fresh implementation actor consumes exact selected target in an isolated fixture and checks runtime without claiming production integration. Record improvement observations and remaining faults, not fabricated scores.
**Error handling:** Tool/runtime failures produce accurate partial evidence and an explicit fallback question only where necessary. Selection/approval pending is a normal durable checkpoint, not evidence of success. No live writes, credentials exposure, or production routing.
**Verification:** Browser capture and interactions through actual session tools; independent forward-use report; manual comparison at equivalent content/viewports; recorded human decisions. Final reviewer checks full spec/plan/cumulative diff plus all evidence. Finishing runs available deterministic tests from `tests/claude-code/run-skill-tests.sh` and `node --test tests/brainstorm-server/*.test.js`, packaging validation if supported; mark unavailable live harness tests NOT RUN with reason rather than substituting keyword tests.
**Codebase pointers:** DashPark root/gateway AGENTS, testing/design docs, `customer-loyalty-detail-dialog.component.{ts,html,scss}`, historical frontend packet, `.agents/skills/impeccable/SKILL.md`, installed imagegen skill and session browser docs.

## Whole-feature verification and handoff

Controller verifies exact target identity survives standalone/follow-on → packet → task input → implementation → independent runtime comparison. Cover old approved packet, stale concept superseded by browser, pending evidence, missing tools, and optional normalization conflict. Persist raw actor responses, manual scoring, checks, and real pilot evidence separately. One final independent review checks the exact cumulative change after all tasks; controller resolves supported findings with at most two corrections. Finishing owns full suite. Keep branch local and report the renamed invocation and remaining limitations accurately.

## Execution clarifications — 2026-09-11

The user selected B, requested a dedicated parking tab with stationary pagination and the Type column heading, then explicitly approved prototype-v2 revision v2.1. The subsequent request to keep and promote the artifacts authorizes a documentation-only copy into DashPark at `docs/superpowers/specs/2026-09-11--credipark-detail--frontend/`. This extends Task 3 artifact ownership to that exact folder; production application edits remain outside this delivery. The copied manifest verifies all 39 payload files.

Finishing's exact available deterministic suite, from the repository root:

```bash
bash <<'SH'
set -uo pipefail
failed=0
for test in \
  test-worktree-path-policy.sh \
  test-timeout-portability.sh \
  test-lean-delivery-contracts.sh \
  test-review-depth-contracts.sh \
  test-sdd-workspace.sh \
  test-sdd-custom-contracts.sh \
  test-custom-policy-contracts.sh \
  ../codex/sdd-behavior/test-score-results.sh \
  test-frontend-visual-review-policy.sh \
  test-gsd-review-policy-detail.sh \
  test-no-pencil-frontend-policy.sh \
  test-brainstorming-artifact-quality.sh \
  test-frontend-direction-resources.sh
do
  if bash "tests/claude-code/$test"; then
    printf 'PASS %s\n' "$test"
  else
    printf 'FAIL %s\n' "$test"
    failed=1
  fi
done
if node --test tests/brainstorm-server/*.test.js; then
  printf 'PASS brainstorm-server suite\n'
else
  failed=1
fi
exit "$failed"
SH
```

These are all 13 deterministic entries from `run-skill-tests.sh`, followed by the complete browser-companion Node suite. The top-level runner unconditionally requires the unavailable `claude` executable; its live `test-subagent-driven-development.sh` and opt-in integration session are NOT RUN. Direct deterministic execution does not claim those live checks. Plugin packaging is NOT RUN because no prior official metadata package was found and 13 unchanged skills intentionally lack tracked `agents/openai.yaml`; do not manufacture external metadata to claim packaging success. Changed skill metadata and resource discoverability retain their focused validation evidence.
