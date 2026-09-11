# Frontend packet finalization plan

Use `superpowers:executing-plans` as the explicit controller execution override for this self-hosting skill correction. Fresh actors test behavior and one fresh reviewer reviews the final change. The user already authorized tightening and normalization; preserve existing design approval.

Goal: produce a canonical, verified final packet that reliably carries approved UI into implementation.
First delivery boundary: new-packet finalization contract/tool, focused consumer/caller updates, normalized DashPark documentation bundle. No production changes, package installation, push or PR.
Spec: docs/superpowers/specs/2026-09-11--frontend-packet-finalization.md
Spec revision: authorized continuation 2026-09-11
Implementation base: 8fdf6ef90fd4842b0cb13a247ec49353d04e7c91
Workspace: existing task branch feat/frontend-direction-visual-exploration; clean at start.
Risk class: review-required
Risk triggers: public packet format and producer/consumer contract; explicit tested-skill request.
Verification lanes: controller RED/GREEN and focused tests, matched fresh behavioral probes and real normalization; final independent review; finishing alone runs complete available regression suite.

## Readiness Record

Author mapping: all spec requirements assigned below. Independent readiness review round1 found R1 missing-descriptor routing and R2 task contract detail. Both corrected below; scoped independent re-review returned spec PASS, plan PASS, verdict READY. Readiness: READY. Schema choices are reversible implementation details within the authorized finalization outcome; no design decision is reopened.

## Task 1: Canonical production and validation

Ownership: skills/frontend-direction/**, tests/claude-code/test-frontend-packet.py, its runner registration, plan-scoped local eval evidence.
Contract: canonical self-contained packet.md + packet.json + screen/state index; brownfield evidence when applicable; current prototype/references separated from history. One versioned contract owns field definitions; one standard-library Python helper inventories/checks files without executing launch commands or manufacturing approval. Existing-approved legacy path bypass remains.
Acceptance: coherent predictable output across candidate probes; validator detects stale, missing, escaped and unapproved current evidence; packet prose still owns quality and integration acceptance.
Dependencies: observed baseline before skill edits; failing helper tests before script code.
Errors: actionable nonzero validation with no mutations; unsupported versions never silently downgraded; no fabricated approval or missing runtime proof.
Verification: five controls/current/candidate decisions manually read; real unittest failure before helper exists, then passing mutation tests; quick_validate frontend-direction and local resource links.

## Task 2: Consume exact validated design

Ownership: skills/implementing-frontend-design/**; narrow frontend handoff references in writing-plans/subagent-driven-development/brainstorming and active frontend workflow docs, only where new packet identity must propagate.
Contract: descriptor presence, canonical entry marker or expected handoff identity selects canonical handling; missing/deleted/changed descriptor fails validation against supplied revision/hash before dependent implementation; historical approved image-only packets remain readable; implementation task carries revision/descriptor hash and acceptance sources; actual browser/design comparison remains necessary.
Acceptance: fresh consumers find exact current source/captures, reject tampered canonical files and a missing canonical descriptor, preserve required-pending gates, and do not require conversion of approved legacy evidence.
Dependencies: Task1 verified before editing consumer.
Errors: no invalid-descriptor-to-legacy downgrade, no hashes-as-human-approval shortcut.
Verification: fresh independent canonical/tampered/legacy forward scenarios; focused existing visual-review and caller/resource checks; quick_validate affected skills. Do not widen review policy or install optional tools.

## Task 3: Normalize DashPark and finish

Ownership: exact existing DashPark docs/superpowers/specs/2026-09-11--credipark-detail--frontend directory, staging under local ignored eval root; durable evaluation doc and execution report.
Contract: original39 manifest files and original manifest preserved byte-exact under history; current source unchanged; canonical entrypoints/references/state map/approval produced. Preserve current README and IMPLEMENTATION URLs. Packaging does not alter approved design or grant release authority.
Acceptance: validator passes actual normalized copy, original-history hashes pass, approved prototype bytes match, final desktop/narrow captures made from exact source where available, independent forward consumer can identify real integration requirements. Pilot remains synthetic.
Dependencies: Tasks1/2; existing user approval is reused.
Errors: stage and check before replacing current documentation; preserve recoverable original folder, avoid deleting history; report missing browser proof honestly. Filesystem escalation is ordinary authorization handling for the explicitly requested DashPark documents.
Verification: local actual bundle validation, source/history hashes, scoped browser recapture and source-backed state map, forward consumer. One final reviewer reads full spec/plan/exact cumulative diff and evidence, at most2 supported corrections. Write clean exactHEAD execution report, then finishing's suite.

## Complete-suite command

Run from repository root using exec_command sandbox_permissions=require_escalated so existing macOS safe server shutdown can inspect ps. Previous regression run proved that requirement. Claude CLI live-session tests remain unavailable; optional plugin packaging lacks prior official metadata. These are NOT RUN, not silently replaced.

```bash
bash <<'SH'
set -uo pipefail
failed=0
for test in test-worktree-path-policy.sh test-timeout-portability.sh test-lean-delivery-contracts.sh test-review-depth-contracts.sh test-sdd-workspace.sh test-sdd-custom-contracts.sh test-custom-policy-contracts.sh ../codex/sdd-behavior/test-score-results.sh test-frontend-visual-review-policy.sh test-gsd-review-policy-detail.sh test-no-pencil-frontend-policy.sh test-brainstorming-artifact-quality.sh test-frontend-direction-resources.sh; do
  bash "tests/claude-code/$test" || failed=1
done
python3 tests/claude-code/test-frontend-packet.py || failed=1
node --test tests/brainstorm-server/*.test.js || failed=1
exit "$failed"
SH
```

Keep all branch/evidence/design artifacts locally at completion. The finishing report is one report-only commit; no repeated integration-choice question or cleanup of the retained pilot.

## Readiness corrections and exact task contracts

R1 resolution: canonical entry marker is `<!-- frontend-packet: 1 -->`; canonical handoffs record revision and descriptor SHA-256. Descriptor presence OR marker OR expected identity selects canonical validation. Missing/deleted descriptor cannot silently become legacy. Only inputs with no canonical signal use the existing legacy path. `check` accepts expected revision/hash so task identity is actually compared. Add focused missing-descriptor and wrong-identity tests and forward case. This does not change product/design approval.

Task1 consumes the frozen current snapshots and matched scenario under `.superpowers/evals/frontend-packet-finalization-20260911/`. It produces the new schema/reference, marker-bearing packet template, `skills/frontend-direction/scripts/frontend_packet.py` inventory/check CLI and producer instructions. Risk class review-required; triggers public packet/schema contract and explicit test-first skills request. Exact codebase pointers: `skills/frontend-direction/SKILL.md`, `references/frontend-direction-template.md`, `references/frontend-packet-folder-template.md`, `references/frontend-packet-completeness-checklist.md`, `references/screen-index-template.md`, and `tests/claude-code/test-frontend-direction-contract.py`. Focused commands: `python3 tests/claude-code/test-frontend-packet.py`; `python3 tests/claude-code/test-frontend-direction-contract.py`; `PYTHONPATH=/private/tmp/frontend-direction-validator-deps python3 /Users/gamarsoft/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/frontend-direction`. Frozen five-per-variant responses are manually scored separately. The helper schema/CLI is the interface consumed by Task2.

Task2 consumes Task1's verified descriptor/marker/identity contract and produces consumer routing and exact expected identity in planning/implementation handoffs. Risk class review-required; triggers public producer/consumer contract and cross-workflow handoff. Exact pointers: `skills/implementing-frontend-design/SKILL.md`, `references/implementation-review-checklist.md`, `skills/writing-plans/SKILL.md`, `skills/subagent-driven-development/implementer-prompt.md`, `skills/brainstorming/references/frontend-direction-follow-on-prompt-template.md`, and `docs/superpowers/references/frontend-skill-stack-reference.md`. Focused commands: `python3 tests/claude-code/test-frontend-direction-contract.py`; `bash tests/claude-code/test-frontend-visual-review-policy.sh`; `bash tests/claude-code/test-no-pencil-frontend-policy.sh`; `bash tests/claude-code/test-brainstorming-artifact-quality.sh`; `node --test tests/brainstorm-server/visual-companion-contract.test.js`; quick_validate command above for each changed skill. Fresh forward cases cover valid canonical, changed/missing descriptor or source, and approved legacy without a descriptor. No unrelated review policy change.

Task3 consumes the verified producer/consumer and exact approved original bundle at `/Volumes/Workspace/Development/SolutionPark/DashPark/docs/superpowers/specs/2026-09-11--credipark-detail--frontend`. Original ARTIFACTS.json SHA-256 is `04d39e05467fbfc7b8ecc4c77c6221d0ef98980c349704428a7b7b545c436d33`, listing39 payload files. Local byte-exact backup is `.superpowers/evals/frontend-packet-finalization-20260911/original-bundle/`. It produces the normalized folder at that same external path and a durable evaluation in `docs/superpowers/evaluations/2026-09-11-frontend-packet-finalization.md`. Risk class review-required; triggers user-authorized external documentation normalization and design authority preservation. Pointers: original packet.md, IMPLEMENTATION.md, approval.json, prototype-v2-manifest.json, prototype-v2/**, baseline/final captures and audit/history notes. Exact helper command from repo root: `python3 skills/frontend-direction/scripts/frontend_packet.py check /Volumes/Workspace/Development/SolutionPark/DashPark/docs/superpowers/specs/2026-09-11--credipark-detail--frontend`. Verify all39 archived payload hashes against the original ARTIFACTS.json and all8 approved prototype source hashes against prototype-v2-manifest.json. Browser prework source server is `python3 -m http.server 8768 --bind 127.0.0.1 --directory .superpowers/evals/frontend-direction-20260911/pilot/prototype-v2`; final normalized launch uses the packet's command. Stage and verify before promotion; preserve original bytes and public README/IMPLEMENTATION entry links. No production repository base/branch mutation is permitted or needed.
