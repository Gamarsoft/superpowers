# Review-depth evaluation

Date: 2026-09-06. Harness: Codex desktop native agents, fresh context with
`fork_turns: "none"`, inherited model/settings. No external Drill campaign or
scorer certification was run. Responses were manually inspected by the root
controller. The independent instruction audit is recorded separately.

## Motivation and scope

The user observed that SDD owns review while its quality checks seemed much
lighter than the standalone checklists. Inspection found conditional plan-only
profile selection, a broad Java/runtime fallback, and PASS outputs without
coverage evidence. The requested change strengthens SDD and standalone review
without adding gates or changing correction budgets.

## Before/after probes

`scenario.md` supplies two complete small code patches. A introduces a receipt
cache; the reviewer must discover its tenant collision without being told the
bug. B is a clean bounded Unicode lookup refactor, with test coverage initially
supplied only as prose. Both include time pressure, passing-test claims, and an
empty plan profile selection.

Five fresh agents ran each variant. Baseline instructions were copied before
edits from the commit recorded in `instruction-hashes.json`. R1 and R2 used the
working instructions. The recorded shared-method/profile fingerprints identify
the tested wording. These are manual micro-tests, not immutable full-controller
runs. Baseline and R1 response files were preserved by their original agents
from their completed responses; they are response text, not raw tool traces.

| Observed behavior | Baseline | Candidate R1 | Candidate R2 |
| --- | --- | --- | --- |
| Finds A's tenant isolation defect with concrete trace | 5/5 | 5/5 | 5/5 |
| Selects security and code-quality profiles for A | 0/5 | 5/5 | 5/5 |
| Avoids Java profile for the non-JVM cache change | 0/5 | 5/5 | 5/5 |
| Provides baseline and selected-section coverage evidence | 0/5 | 5/5 | 5/5 |
| Marks B's unavailable test source NOT CHECKED and withholds READY | 0/5 | 0/5 | 5/5 |
| Avoids a code blocker for B's approved Unicode/ten-row behavior | 5/5 | 5/5 | 5/5 |

The defect itself was already detected by the baseline. These probes establish
more consistent selection, coverage, and evidence handling, not a measured
increase in general defect-detection rate.

R1 still accepted a test summary. For example, candidate-r1-1 marked Test
adequacy CHECKED while stating: "Actual test source is not included;
source-level equivalence independently supports preserved behavior."
R2 requires actual assertions and relevant fixtures/mocks when test coverage is
claimed, with NOT CHECKED for unavailable source. All five then withheld READY
without inventing a product defect. They also identified the missing store
fixture in A while retaining its directly proved blocker.

Each R2 reviewer then received `clean-test-evidence.md` in the same review.
All five inspected the supplied assertions and returned READY for B, without
code corrections or test reruns. Their original reports remain unchanged;
`candidate-r2-clean-*.md` records the evidence completions. This checks that
incomplete review does not create an unnecessary correction loop.

## Integration and correction probes

`create-integration-fixture.py` creates a disposable Git repository with real
BASE/HEAD commits, a specification, plan, actual unit tests, and cumulative
diff. Run it with Python 3; it prints the review inputs. Its two unit tests
pass after a producer switches to cents while its consumer still formats
dollars. Unit reports claim READY. Pass its paths and commits to the checked-in
final or standalone reviewer template in a fresh agent.

- `integration-review.md`: the final prompt verified the range, selected
  structural and code-quality profiles, inspected the unchanged consumer, and
  observed `$1200.00` where `$12.00` is required. NOT READY despite unit approvals.
- `standalone-review.md`: the standalone prompt found the same integration
  blocker with coverage evidence. It also recorded an adjacent negative-input
  follow-up. That observation is not counted as a successful defect detection;
  rejection semantics were not specified for invalid inputs.

The final probe reused reported test results and ran a focused composition
check. The standalone probe independently reran the two fixture tests; it did
not run the Superpowers repository suite. These are one sample per entry point,
not before/after detection-rate measurements.

The correction fixture clones the faulty HEAD, changes the consumer to format
`invoice['amount'] / 100`, updates its literal input to 1200, and adds a real
`display(invoice()) == '$12.00'` assertion. Three fixture tests pass. Its scoped
review uses the existing integration finding and prior coverage, plus the exact
fix diff. `correction-review.md` returned READY, marked F1 addressed, retained
unaffected prior coverage, and found no fix-introduced defects. It reran no tests.

## Instruction audit and regression checks

`instruction-audit.md` records an independent read-only audit. It found that a
new shared report requirement accidentally affected executing-plans, whose
optional reviewer was unchanged. The correction limits that additional report
field to SDD. The scoped recheck returned READY. Inline execution review was
not expanded by this request.

Passed:

- `bash tests/claude-code/test-review-depth-contracts.sh`
- `bash tests/claude-code/test-lean-delivery-contracts.sh`
- `bash tests/claude-code/test-sdd-custom-contracts.sh`
- `bash tests/claude-code/test-custom-policy-contracts.sh`
- `bash tests/claude-code/test-sdd-workspace.sh`
- `bash tests/codex/test-package-codex-plugin.sh`

The new wiring test first failed with "missing shared review method" before
implementation. Existing Java-depth assertions now follow the shared selection
reference instead of requiring a duplicated Java fallback in each prompt.

Limitations: small Python examples, one session/model configuration, manual
scoring, no broad language coverage or adversarial security benchmark. The
coverage table is an audit aid; it cannot prove reviewers found every defect.
