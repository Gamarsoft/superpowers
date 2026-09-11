# Canonical frontend packet finalization — evaluation

The previous rework preserved design authority but left final packaging variable. This extension adds a canonical producer/consumer interface, a read-only validator and an actual normalized DashPark packet. It does not claim that packet validation establishes good visual design or production integration.

Scope and approved continuation: [spec](../specs/2026-09-11--frontend-packet-finalization.md), [plan](../plans/2026-09-11-frontend-packet-finalization.md). Implementation base: `8fdf6ef90fd4842b0cb13a247ec49353d04e7c91`. Producer implementation: `edeac65`; consumer/callers: `b30773a`. Final independent review and complete-suite results belong to the execution report for the final implementation HEAD.

## Matched behavioral samples

Five fresh no-guidance, five frozen-current, and five frozen-candidate Sol/low actors received the same standalone brownfield preservation scenario. The scenario included two runnable prototype versions, explicit v2.1 approval, a stale narrow capture, earlier concepts/prompts/draft/manifests, real state contracts and design-only scope. These were response-only samples, not simulated claims of executing tools. Every complete response was manually read.

Local raw scenario, snapshots, responses and scoring: `.superpowers/evals/frontend-packet-finalization-20260911/`. Original responses remain unchanged; candidate archive nesting is allowed to vary while current interfaces are fixed.

| Criterion | No guidance (5) | Previous skill (5) | Candidate (5) |
| --- | --- | --- | --- |
| Preserve explicit v2.1 approval, identify stale narrow evidence, avoid current production implementation | 5/5 | 5/5 | 5/5 |
| Predictable entry point | At least four different filenames | 5/5 old outer direction document | 5/5 canonical packet.md |
| Current source separated from earlier versions | Varied layouts | 1/5 separate archive; 4/5 versions mixed under prototype | 5/5 current prototype with separate history |
| Shared descriptor schema and runnable validation command | Absent | Absent | 5/5 packet.json schema1 plus inventory/check |
| Exact revision and descriptor digest in implementation handoff | No shared contract | No shared contract | 5/5 |

Observed baseline details: controls chose `DESIGN-PACKET.md`, `HANDOFF.md`, `implementation-brief.md` or `IMPLEMENTATION-HANDOFF.md`. Previous-skill metadata varied between `v2.1-hashes.json`, `hashes.json`, `records/hashes.json` and `manifest.json`. Current sample3 made stale-image retention conditional on “if project policy requires it” and omitted original draft/prior hashes from its shown tree. The failure was deliverable shape and missing machinery, not wholesale loss of approval or deliberate rule-breaking. The correction is a positive finalization recipe/schema/helper, without a new design approval ceremony.

All five candidate responses retained approval, separated current artifacts/history, named actual setup/state acceptance, proposed faithful stale-capture replacement and distinguished synthetic proof from integration. Candidate2's later implementation prompt follows an explicit design-only stopping point; it is not a request to implement now. Candidate4 keeps packaging pending until recapture, without reopening design selection. These results are evidence for this scenario, not a statistical guarantee across all projects.

## Real helper tests

Test-first sequence: the initial16 tests failed17 assertions because the helper did not exist. After readiness corrections added references-only and missing-descriptor/expected-identity cases,18 tests failed19 helper-absent assertions. Implemented the standard-library helper, then all18 tests passed.

Command: `python3 tests/claude-code/test-frontend-packet.py`.

The tests create real temporary files and invoke the CLI. They cover a valid packet, changed source, missing capture, added current source, nonbinding history, history used as a current target, pending status, approval/prototype revision mismatch, missing human decision, bad state setup/reference, unsupported schema, unsafe paths/symlinks, canonical documents, accepted degraded scope, explicit references-only scope, read-only inventory, missing/changed descriptor identity and malformed input. Hash checks do not fabricate approval or execute launch commands.

Focused producer/consumer verification also passed four resource checks; frontend visual-review, no-Pencil and brainstorming artifact-quality scripts; the visual-companion contract Node test; and skill-creator quick_validate for frontend-direction, implementing-frontend-design, writing-plans, subagent-driven-development and brainstorming. PyYAML was supplied through the pre-existing isolated temporary validator dependency directory, not installed globally.

## Fresh actual-artifact consumption

Three fresh consumer actors read the new implementation skill and operated on real input files. They did not share producer context, repair artifacts or implement production code. Reports: `forward-valid.md`, `forward-damage.md`, `forward-legacy.md` under the local evaluation root.

| Input | Observed behavior |
| --- | --- |
| Canonical staged Credipark v2.1 | Ran validator with expected revision/hash; passed; inspected current images/source; identified component/state acceptance, history scope and absent production authority. |
| Changed prototype source | Failed `hash-mismatch`; implementation blocked without refreshing hashes. |
| Missing descriptor | Failed `missing-descriptor`; marker and supplied identity kept canonical routing. |
| Changed descriptor | Failed `expected-identity`; unchanged revision text did not override the mismatch. |
| Pending descriptor | Failed status and expected identity; prose approval did not bypass the check. |
| Synthetic approved legacy image-only fixture | Inspected exact image/intent; used legacy route without descriptor/prototype conversion or reapproval; retained later runtime/review requirements. |

The valid consumer ran from the Superpowers checkout, where Gateway paths are absent. Its absence finding is a context limitation, not a claim that DashPark lacks those components. Production integration was outside this test's scope. The legacy fixture's approval is an evaluation premise, not a new approval of the real UI.

## Durable DashPark result

Canonical entry:
`/Volumes/Workspace/Development/SolutionPark/DashPark/docs/superpowers/specs/2026-09-11--credipark-detail--frontend/packet.md`

Approved revision: `v2.1`.
Descriptor SHA-256: `1f90bbd555cae044a8e3a40079860e929c6a8438859cb1efd9368ec30359cfbc`.

The canonical directory now contains packet.md, packet.json, screen-index.md, brownfield inspection, current prototype/references and updated README/IMPLEMENTATION links. The entire original bundle is preserved under `history/pilot-v2.1/`, including all39 payload files and its byte-exact ARTIFACTS.json. The original manifest SHA-256 is `04d39e05467fbfc7b8ecc4c77c6221d0ef98980c349704428a7b7b545c436d33`. All eight approved prototype source files match their original manifest. Promotion checked the original destination for intervening changes before moving originals into history and copying the validated staged current files.

Actual promotion check:

```sh
python3 skills/frontend-direction/scripts/frontend_packet.py check \
  /Volumes/Workspace/Development/SolutionPark/DashPark/docs/superpowers/specs/2026-09-11--credipark-detail--frontend \
  --expected-revision v2.1 \
  --expected-descriptor-sha256 1f90bbd555cae044a8e3a40079860e929c6a8438859cb1efd9368ec30359cfbc
```

Result: exit0, valid true, exact expected revision/hash. Original-history and approved-source byte comparisons passed separately. Local backup, staging, normalization/promotion scripts and check outputs remain in the ignored evaluation directory.

Current desktop/narrow captures were made from unchanged approved v2.1 at actual DOM viewports1154×1324 and390×844, both at movements page2. Desktop shows the Type header; narrow reflow retains its accessible header and stationary pager. The current narrow paging/focus check passed. A staged normalized launch at8769 loaded the same source in a new browser tab with Type, parking tab and pager visible; warn/error console output was empty. Server requests loaded HTML, CSS, JS and both fonts; an absent favicon returned404. The preview server was then restarted against the durable DashPark prototype at the same port.

The screen index explicitly distinguishes current captures/paging from inherited v1/v2 observations and source-only states. No full state re-audit, axe/screen-reader assessment, physical-device testing, current Angular build or backend integration is claimed. No production Gateway file changed. This packet preserves the human's existing design approval for later implementation.

## Review and verification boundaries

Independent readiness review initially found two supported blockers: missing-descriptor legacy downgrade and incomplete task-local contracts. Both were corrected before implementation; scoped re-review returned READY. No new product/design decision was introduced.

The producer's focused evidence precedes the consumer changes. One final independent review checks the cumulative change and actual bundle. Finishing owns the sole full available regression run at the exact clean implementation HEAD and its report-only commit. Claude CLI live-session tests remain unavailable in this environment; optional packaging lacks prior official metadata. Neither is counted as passed. Keep local artifacts and branch; no push or PR is part of this task.

Final review round1 passed spec compliance and found one test-registration blocker: the new wrapper's mode100644 caused the standard runner to chmod it and dirty the tracked tree. A targeted RED run reproduced that mode change; the correction commits mode100755. The runner's unrelated Claude availability/version probe uses an isolated version-only shell fixture for this focused Python-test registration check; any actual Claude call fails. This is not a Claude live-session test. The scoped re-review and final clean-tree regression result are recorded in the execution report.
