# Paper frontend workflow adopted

The reviewed Paper workflow is now the installed Superpowers default. The human
explicitly authorized initial adoption on 2026-10-26, accepted the documented
limitations and closed the DashPark Branding pilot. This decision supersedes the
earlier retain-candidate ruling in the 2026-10-23 assessment. Its evidence and
failed evaluations remain unchanged.

No additional pilot or broad evaluation campaign is required for this adoption.
The remaining gaps are follow-ups to revisit through real-project experience.
This acceptance does not waive exact design approval or required application
verification in future work.

## Installed revision

| Item | Value |
| --- | --- |
| Adopted source | `f60fa2c9bd0be1eff533b707a1668966090fda60` from `codex/paper-frontend-candidate` |
| Reviewed implementation | `f44961cb0dee13f5d660f58523488b32cd710705`; the later candidate commit preserves its execution report only |
| Active branch | `codex/adopt-paper-frontend-workflow` |
| Installed repository | `/Users/gamarsoft/.codex/superpowers` |
| Existing skill link | `/Users/gamarsoft/.codex/skills/superpowers` resolves to the repository's `skills/` directory |
| Previous defaults | `b97ddc0f5205c36185bce8dd555ea2db58c3bac3` on `codex/frontend-design-audit-fixes` |

All 169 tracked skill files match the reviewed candidate byte-for-byte. Adoption
adds this decision and its evidence; it makes no further skill, role, dependency,
configuration or workflow changes. No activation failure required a correction.

Four original untracked planning documents overlapped the candidate's tracked
copies. They were preserved before checkout under
`.superpowers/sdd/2026-10-26-paper-frontend-adoption/pre-adoption-originals/`.
Their bytes also match their committed copies at `cf2603aed51ad69631033e43a30e9da8b0f420ee`.
The candidate's reviewed, amended plan and specification now occupy the active paths.

## Preserved workflow

- Paper develops substantial screen composition. The current application grounds
  brownfield work and remains the authority for behavior and delivered components.
- Task-to-layout reasoning, design knowledge, rendered quality checks and exact
  final-design approval precede dependent implementation.
- Active handoffs generate, validate and consume version 2 only. Version 1 is
  rejected. File identity, path containment and state/reference agreement remain
  checked; historical packets remain reference material.
- Library work covers affected entries within the agreed effort. Stop at the
  allowance, retain the last verified revision when work is deferred, and keep
  pending housekeeping separate from verified application delivery.
- Visual Companion supports useful diagrams and comparisons. Image generation
  supports assets or explicit exploration. Actual-component prototypes resolve
  behavior and feasibility risks without a routine duplicate screen-design stage.

## Installation checks and focused regressions

The following checks ran against the activated installation at the adopted source
revision. Complete outputs and structured results are in
[`2026-10-26-paper-frontend-adoption/`](2026-10-26-paper-frontend-adoption/).

| Check | Result |
| --- | --- |
| `python3 tests/claude-code/test-frontend-packet.py` | 53 tests passed, including unsupported-version and integrity cases |
| `python3 tests/claude-code/test-frontend-direction-contract.py` | 6 tests passed |
| `node tests/brainstorm-server/visual-companion-contract.test.js` | Passed |
| `node tests/brainstorm-server/visual-companion-design-kit.test.js` | 15 checks passed |
| `bash tests/claude-code/test-frontend-visual-review-policy.sh` | Passed |
| `bash tests/claude-code/test-no-pencil-frontend-policy.sh` | Passed |
| `bash tests/claude-code/test-brainstorming-artifact-quality.sh` | Passed |
| `bash tests/claude-code/test-custom-policy-contracts.sh` | Passed |
| `bash tests/claude-code/test-lean-delivery-contracts.sh` | Passed |

One fresh, ephemeral Codex session used GPT-6 Astra with medium reasoning and a
read-only sandbox. It discovered both frontend skills through the native skills
catalog, read the advertised installed files, resolved their repository and
confirmed revision `f60fa2c9bd0be1eff533b707a1668966090fda60`. Its independently
reported file hashes match the controller's source check. It also inspected the
preserved contracts above. This was an installation smoke check, not another
behavior campaign or a claim of reliable implicit activation for every task.

The initial smoke-command heredoc encountered a read-only temporary-file limit;
ordinary read commands succeeded. No installed-source failure occurred. Prior
full-suite results remain evidence for their recorded revisions and were not
rerun merely for adoption.

## Pilot closed

Final recorded active pilot effort is **12,034.6 seconds**, or **3h20m34.6s**,
against the authorized 12,000 seconds. The **34.6-second overrun** remains recorded.
Estimated library upkeep is **255 seconds**, or **4m15s**, against its 20-minute
cap. Adoption adds zero pilot effort and does not erase the overrun.

No DashPark design, implementation, browser state, publication fixture, database
or service was reopened or changed during adoption. Task-owned evidence is retained
at its original path and copied into the private ignored archive
`.superpowers/sdd/2026-10-26-paper-frontend-adoption/retained-pilot-evidence/`.
Closure, accounting and restoration records were checked byte-for-byte.
[`pilot-closure.json`](2026-10-26-paper-frontend-adoption/pilot-closure.json) preserves
the final accounting and evidence identities in Git.

The affected `branding.color-control` entry remains stale with a pending recheck
after the requested shell-padding correction. Its last verified design is
`branding-color-library-20261026`, source
`8a220f90182f13b1cf6f69487e88ed1f7e2aac5e`; the intended updated application source
is `b03c920a6a3fd0cf4f815b9f562bc9131e2cf351`. Whole-screen coverage remains unknown.
The existing DashPark library record was read without alteration. Reconciliation
is deferred and is not a condition of this adoption.

## Accepted follow-ups

- The final experience samples remain **6/6 and 5/6**. One response left approval
  of the revised artifact implicit. Keep the exact-design approval rule and this
  failure visible; future refinements should address observed real-project gaps.
- The historical 75/75 design-handoff result belongs to `0da9cdd`; it is not a
  fresh campaign at the later source. Earlier failed campaigns remain preserved.
- Claude CLI and Quorum coverage remain unavailable. The focused checks above ran
  directly; unavailable harness lanes are not described as passing.
- Human task outcomes, broad cross-browser coverage, repeat-use savings and
  long-term maintenance efficiency remain unmeasured. This adoption makes no
  stronger effectiveness claim.
- The pilot's positive live Terminer persistence limit, existing wizard overlap,
  unrelated local mail errors and TypeScript-LSP runtime mismatch remain in its
  historical report. They are not reopened here.

These limits are accepted for initial use. They do not trigger another pilot or
broad campaign before activation, and they do not weaken application delivery
checks, approval authority or packet integrity.

## Revert the adoption

With a clean checkout, switch the installed repository back to the preserved
pre-adoption branch:

```sh
git -C /Users/gamarsoft/.codex/superpowers switch codex/frontend-design-audit-fixes
```

That branch remains at `b97ddc0f5205c36185bce8dd555ea2db58c3bac3`. The unchanged
skill link will then resolve to the prior defaults. Start a fresh Codex session
to load that version. Do not force the switch if new work makes it unsafe.

The adoption branch, candidate branch and pilot evidence remain recoverable.
Original untracked planning files can be restored from the backup above if their
pre-adoption layout is also wanted. To reactivate this release, switch back to
`codex/adopt-paper-frontend-workflow` and start a fresh session. No remote push,
merge or deletion is part of adoption or rollback.
