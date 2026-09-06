# Standalone review

Range: `de21d307d38af9a3ffc5de1d7b30d23862205a31..0cb13871764d4eeca86791c2f5a18890247f5afe` in `/var/folders/z4/7jbhpsv92bz10qnjcvht08dh0000gn/T/sdd-review-integration-fkt41_u7`. Both endpoints resolve to commits and BASE is an ancestor of HEAD. Requirements: `spec.md`; additional context: `plan.md`. Paths below are relative to this fixture unless identified as profile paths.

The supplied selection was empty. Added `/Users/gamarsoft/.codex/superpowers/skills/requesting-code-review/references/solid-checklist.md` because the producer's returned amount changes its public unit contract, covering producer/consumer responsibility and coupling. Added `/Users/gamarsoft/.codex/superpowers/skills/requesting-code-review/references/code-quality-checklist.md` because the diff changes numeric units, covering amount boundaries and formatting. Security and Java profiles are inapplicable: the diff changes neither validation/trust boundaries nor JVM/deployment behavior.

| Area / selected profile section | CHECKED / N/A / NOT CHECKED | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | `spec.md` requires cents internally and dollars externally; `producer.py:2` returns 1200 while `consumer.py:2` formats that directly as dollars. Observed composed output `$1200.00`, expected `$12.00`. | B1 |
| Failure paths | CHECKED | `consumer.py:2` propagates KeyError for missing amount, TypeError for None and ValueError for a string. No I/O, writes, cleanup or recovery paths exist. These unchanged exceptions have no newly specified alternative behavior. | none |
| Boundary conditions | CHECKED | Observed zero yields `$0.00`, one cent yields `$1.00`, and negative input yields `$-1.00`. Producer has no input and only returns a positive constant. Negative acceptance predates the range. | B1, F1 |
| Compatibility and integration | CHECKED | Traced `invoice()` into `display(invoice())`; dictionary shape stays the same but units change, multiplying visible dollars by 100. Unit READY reports do not establish this combined path. | B1 |
| Test adequacy | CHECKED | `test_invoice.py:7` catches a producer reversion to 12. Line 9 uses a handwritten dollar fixture and never invokes the producer, so both tests pass despite the integration defect. No negative or zero assertion exists. `spec.md` explicitly requires no TDD evidence. | B1, F1 |
| Maintainability | CHECKED | Each two-line function has one responsibility; the concrete problem is an implicit shared unit contract, not file size or missing abstractions. | B1 |
| Structural / SRP and common smells | CHECKED | `producer.py:1-2` produces an amount and `consumer.py:1-2` formats it. Hidden numeric-unit coupling creates the demonstrated display error. | B1 |
| Structural / refactor heuristics | CHECKED | Inspected the complete two-file diff; producer's local assertion is updated while external behavior is not preserved. No broad refactoring is required. | B1 |
| Structural / OCP, LSP, ISP, DIP | N/A | No extension framework, subclasses, interface hierarchy, infrastructure dependency or dependency-direction change exists in these two functions. | none |
| Quality / Error Handling | CHECKED | Missing and malformed inputs propagate exceptions from `consumer.py:2`; no swallowed exceptions, asynchronous operation or recoverable I/O exists. | none |
| Quality / Performance & Caching | N/A | A fixed dictionary and one format operation introduce no loops, cache, I/O or growing collections. | none |
| Quality / Boundary Conditions | CHECKED | Checked actual zero, one-cent, negative, absent and malformed values against `consumer.py:2`, as well as the positive producer result. Unit mismatch affects positive values; negative acceptance is unchanged. | B1, F1 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | `producer.py:2`, `consumer.py:2`, `test_invoice.py:7-9` | `display(invoice())` returns `$1200.00`; approved output is `$12.00`. Both existing tests independently pass because display receives the stale dollar fixture. | Changed producer returns cents through the same amount key; consumer still interprets the value as dollars. | Invoice totals shown to callers are 100 times the required dollar total. | Preserve dollar output for producer amounts represented in cents, and cover the composed producer-to-display path in a regression assertion. |
| F1 | FOLLOW_UP | `consumer.py:2` | `display({"amount": -1})` yields `$-1.00`; BASE's consumer blob is identical. The specification states negative amounts are invalid. | None: unchanged consumer already accepts negatives, and this producer introduces no negative value or new input path. | Direct consumer calls can display an amount outside the valid domain. | Address negative-input rejection separately; it does not block this recorded range on causal grounds. |

- Contract compliance: FAIL
- Change quality: FAIL
- Evidence checked: observed full diff and source, actual passing tests, and failing composed behavior. `evidence.md` reports two unit READY verdicts and a passing test run; its claim that no consumer change is needed is contradicted by observed integration output.
- Uncompleted inspection: none.
- Verdict: NOT READY.

Exact commands run in the fixture:

```sh
cat spec.md evidence.md
git rev-parse --verify de21d307d38af9a3ffc5de1d7b30d23862205a31^{commit}
git rev-parse --verify 0cb13871764d4eeca86791c2f5a18890247f5afe^{commit}
git merge-base --is-ancestor de21d307d38af9a3ffc5de1d7b30d23862205a31 0cb13871764d4eeca86791c2f5a18890247f5afe
git diff de21d307d38af9a3ffc5de1d7b30d23862205a31..0cb13871764d4eeca86791c2f5a18890247f5afe
rg --files
nl -ba producer.py
nl -ba consumer.py
nl -ba test_invoice.py
cat plan.md
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest -v
PYTHONDONTWRITEBYTECODE=1 python3 -c 'from producer import invoice; from consumer import display; print("integrated:", display(invoice())); print("zero:", display({"amount": 0})); print("negative:", display({"amount": -1}))'
git show de21d307d38af9a3ffc5de1d7b30d23862205a31:consumer.py
PYTHONDONTWRITEBYTECODE=1 python3 -c 'from consumer import display
for value in ({}, None, {"amount": "x"}, {"amount": 1}):
 try: print(repr(value), display(value))
 except Exception as error: print(repr(value), type(error).__name__)'
git diff --quiet 0cb13871764d4eeca86791c2f5a18890247f5afe -- producer.py consumer.py test_invoice.py
git -c core.fsmonitor=false diff --quiet 0cb13871764d4eeca86791c2f5a18890247f5afe -- producer.py consumer.py test_invoice.py
```

The initial quiet diff emitted an IPC error; the command-local fsmonitor-disabled retry exited 0, verifying inspected working files match HEAD without changing repository configuration. Tests exited 0 with two passing assertions. Probe scripts exited 0 and printed the values/errors described above; the integrated value itself violates the specification.

Also read `skills/requesting-code-review/code-reviewer.md`, `references/review-method.md`, `references/profile-selection.md`, `references/solid-checklist.md`, and `references/code-quality-checklist.md` under the Superpowers requesting-code-review skill directory. No fixture files, commits, index, branch state or repository configuration were changed.
