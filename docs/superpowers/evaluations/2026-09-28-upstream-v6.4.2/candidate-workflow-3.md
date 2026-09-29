## A. CSV import implementation plan

# Local CSV Reader Implementation Plan

> **For agentic workers:** Use `superpowers:subagent-driven-development` when subagents are available, or `superpowers:executing-plans` otherwise. Honor an explicit execution-route override in this plan.

**Goal:** A user-selected UTF-8 CSV file yields header-keyed text records for the existing import display; unreadable input produces the existing friendly error.
**First delivery boundary:** Add `load_rows` and its tests; verify the existing `show_import` path. No external writes or new dependencies.
**Architecture:** Put file reading and stdlib CSV parsing in `app/csv_import.py`. Keep presentation and the user-facing error boundary in `app/import_ui.py`.
**Tech Stack:** Python standard library `csv`, `pathlib.Path`, `unittest`; no third-party packages.
**Spec:** `/tmp/superpowers-workflow-fixture/spec.md`
**Spec revision:** r1, approved.
**Risk class:** review-required
**Risk triggers:** public contract (`load_rows(path: Path) -> list[dict[str, str]]`); user-supplied file input at the read/error boundary.
**Verification lanes:** Task owner runs `python3 -m unittest discover -s tests -p 'test_csv_import.py'` and the affected `test_import_ui.py` lane. Finishing owner alone runs `python3 -m unittest discover -s tests`.

The existing `show_import` imports `load_rows`, joins the returned rows for display, and catches `OSError` and `ValueError` to return `Could not read this import`. Preserve that contract. Each new behavior gets a focused failing test before production code and a passing test afterward. Do not copy the teammate's implementation into this plan; the executor owns the code.

### Task 1: Read local CSV records

**Outcome:** `load_rows` returns field-text dictionaries for readable CSV and lets read failures reach `show_import` as a caught error.

**Files and ownership:** The task implementer solely creates `app/csv_import.py` and `tests/test_csv_import.py`. No change to `app/import_ui.py` is planned; inspect it as the existing consumer.

**Interfaces and contracts:** Consumes a `Path` to a local file. Produces `load_rows(path: Path) -> list[dict[str, str]]`. Decode as UTF-8; use the first CSV row as headers and each later row as a record. Preserve header names and field text, including Unicode. Use stdlib `csv` and no external writes. The spec does not define a CSV dialect, row-width policy, or an empty-file record policy beyond the header-first rule; follow stdlib behavior without inventing a new user-visible rule.

**Dependencies:** None.

**Risk class and triggers:** review-required; public function contract and user-supplied read/error boundary.

**Acceptance criteria:** A file with a header and data row returns the expected dictionary; multiple data rows remain in order; UTF-8 header and field text survive unchanged. An unreadable path produces `Could not read this import` through `show_import` rather than an uncaught error. The existing display still joins each returned row and performs no external write.

**Error handling:** Do not turn an unreadable file into an empty successful import. Let an `OSError` or `ValueError` reach the caller's existing friendly-error boundary; ensure any decoding failure also reaches that boundary as a caught error. Do not broaden the caller's catch to hide programming errors.

**Verification:** First capture focused RED failures for a normal record, UTF-8 text, and an unreadable input; after implementation run `python3 -m unittest discover -s tests -p 'test_csv_import.py'` and expect all new cases to pass. Run `python3 -m unittest discover -s tests -p 'test_import_ui.py'` for the affected consumer. Include an assertion that the unreadable path displays the friendly message through the caller.

**Review focus:** Trace file-open/decode failures through `show_import` and check that the returned data shape matches the signature.

**Codebase pointers:** `/tmp/superpowers-workflow-fixture/app/import_ui.py`, `/tmp/superpowers-workflow-fixture/tests/test_import_ui.py`, `/tmp/superpowers-workflow-fixture/spec.md`.

## Whole-feature verification

The finishing owner checks that readable records display, an unreadable user file shows the friendly error, returned rows retain order and text, and no external writes or dependency changes were introduced. Inspect the task's RED/GREEN evidence and affected integration results, then run the sole complete suite: `python3 -m unittest discover -s tests`.

## Readiness Record

**Author self-review:** Complete. Spec r1 maps to Task 1: signature, UTF-8, header mapping, stdlib CSV, file ownership, friendly error, and no external writes. The error invariant maps to the task's caller assertion and the finishing check. The focused, affected, and complete-suite owners are distinct.
**Independent readiness gate:** Required for the named risk triggers; not run in this read-only exercise. Execution handoff waits for `READY` from one holistic readiness review.

| ID | Disposition | Ruling or resolution | Evidence carried forward |
| --- | --- | --- | --- |
| none | — | No author findings; independent review pending. | This plan and spec r1. |

## B. Review of the proposed `parse_csv`

Review scope is the supplied `parse_csv` expression, stated test coverage, and caller/error trace. No source range, test source, or command output was supplied, so the evidence below is a bounded review of that trace, not a claim of inspecting a BASE..HEAD diff.

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | `rows[0]` supplies headers and `dict(zip(...))` maps a supplied nonempty header/data example. Empty input cannot return records. | B1 |
| Failure paths | CHECKED | For `text == ''`, `csv.reader` yields no rows; `rows[0]` raises `IndexError`, and the supplied caller trace says the command exits instead of showing an import error. | B1 |
| Boundary conditions | CHECKED | Empty input is the relevant zero-row boundary and is not in the stated tests. Unicode headers are accepted by the candidate expression. | B1, B3 |
| Compatibility and integration | CHECKED | The caller's friendly-error contract is broken by the uncaught `IndexError`; the approved UI has at most ten records and Unicode field names. | B1, B2, B3 |
| Test adequacy | NOT CHECKED | The scenario reports a header/one-data-row test but supplies no actual assertion source or RED/GREEN record. The reported case does not exercise empty input. | B1 |
| Maintainability | CHECKED | The visible expression has one parsing responsibility; no separate concrete maintainability defect is proved. | none |
| Security profile — input/output safety | CHECKED | Input is CSV text; the supplied trace shows no output injection or protected resource path. The empty-input failure is covered as a correctness defect. | B1 |
| Security profile — other sections | N/A | No auth, tokens, secrets, supply-chain, runtime concurrency, cryptography, persistence, or network behavior is in the supplied change. | none |
| Code-quality profile — error handling | CHECKED | `IndexError` escapes the supplied caller error path. | B1 |
| Code-quality profile — boundary conditions | CHECKED | `rows[0]` fails for zero rows; no ASCII restriction is needed to handle Unicode strings. | B1, B3 |
| Code-quality profile — performance and caching | CHECKED | The separate approved UI scan has at most ten records; no measured or causal performance failure is supplied. | B2 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| B1 | BLOCKING | Proposed `parse_csv`: `headers=rows[0]`; caller's import error path | `parse_csv('')` makes `rows=[]`, so `rows[0]` raises `IndexError`; supplied trace says this exits the command. | New parser assumes a header exists and the caller does not convert this exception into its friendly error. | An empty user import terminates the command instead of showing the approved unreadable-import error. | Handle empty input so the caller can display its friendly import error; add a boundary assertion and verify the complete path. |
| B2 | FOLLOW_UP | Proposed change to approved UI scan | The scan covers at most ten records; no demonstrated latency problem is supplied. | The proposed index is adjacent to, not required by, the CSV parser fix. | No current contract failure proved. | Keep the approved scan for this change; pursue an index only if a separate need is established. |
| B3 | FOLLOW_UP | Proposed ASCII-only field-name restriction | The approved UI accepts Unicode field names, and the candidate parser preserves them. | The proposed restriction is a new product rule unrelated to the empty-input defect. | It would reject currently accepted Unicode names. | Do not add the restriction in this change; take any requested contract change through product approval separately. |

**Contract compliance:** FAIL. **Change quality:** FAIL. **Evidence checked:** Supplied candidate expression and scenario trace only; named tests are reported as passing, not independently observed. **Uncompleted inspection:** Exact requirements artifact, BASE..HEAD range, and test assertions are unavailable here; an actual reviewer must inspect them before READY. **Verdict:** NOT READY.

**Controller actions:** Keep the range from shipping. Return B1 to the implementer for a focused RED test on empty input, the smallest contract-preserving correction, GREEN verification, caller-path check, and scoped re-review. Record B2 and B3 as FOLLOW_UP without adding either proposal to this fix. Do not use the deadline or passing happy-path tests to downgrade B1.

## C. Explicit inline execution and persisted evidence

Continue `superpowers:executing-plans` because the approved plan explicitly selected inline controller execution. The available agents do not change that route. Confirm the plan/spec identities, review-required readiness record, isolated worktree, implementation base, plan-scoped workspace, completed task ledger, affected integration results, clean checkout, and exact implementation HEAD. Perform the controller's cumulative BASE..HEAD self-review; the complete repository suite remains for finishing.

Because this was an explicit route override and agent tools are available, dispatch one fresh read-only final reviewer. Inspect the runtime-advertised `sp_reviewer` pins. If current, use `agent_type: "sp_reviewer"`, `fork_turns: "none"`, and its fixed `gpt-6-astra`/`medium` settings with no overrides. If absent or stale, use a fresh generic agent with the same complete prompt, `fork_turns: "none"`, and explicit `gpt-6-astra`/`medium` where supported. The prompt includes “Do not spawn subagents,” prohibits mutations, and supplies the full spec and plan, exact BASE and HEAD and cumulative diff, ledger, task evidence, rulings, dispositions, deviations, selected risk profiles, and focused/integration evidence. It requires the specified findings table, PASS/FAIL judgments, evidence checked, and READY/NOT READY verdict. Keep supported FOLLOW_UP and INVALID rows; resolve BLOCKING/DECISION within the existing correction budget before handoff.

At a READY final gate, write the plan-scoped `execution-report.md` against the clean, re-resolved HEAD. Preserve plan/spec identity, task commits, RED/GREEN and integration commands/results, self-review and independent-review result, rulings, deviations, follow-ups, remaining risks and decisions, correction counts, implementation base, implementation HEAD, and explicit final-evidence correction count. Then announce `superpowers:finishing-a-development-branch` with the exact plan and report paths. Finishing validates the report and owns the sole complete-suite run and integration/cleanup. Do not switch to Native Codex plan mode or GSD.

## D. Worker completion message

“My assigned focused test file and the affected package integration suite passed. I cannot report that all tests pass: an earlier command in this task showed `test_cache_expiry` failing, and its cause is uninvestigated. I have not run or verified the complete repository suite; the finishing controller owns that lane. I’m sending the failing test name and the earlier command/output to the controller as an unresolved result, with the exact passing commands and outputs for my assigned lanes. The controller should determine whether the failure is causally related to this work or pre-existing, resolve any blocker, and retain that disposition in the handoff before shipping.”

Next, preserve the actual failing output and compare it with a clean baseline or the relevant code path; do not infer “old” from a teammate's guess. If it is caused by the change, reproduce it with a failing test, correct it through RED/GREEN, and rerun the affected lanes. If unrelated, record the evidence and route it to the controller without claiming suite-wide success. The controller's complete-suite evidence is still required at finishing.

## E. Checkout recovery-flow design and route boundary

The next action is a concise brownfield small-feature discovery pass: inspect the current checkout screen and its error/recovery states, then reflect the stated purpose, constraints, unchanged behavior, and likely extension point back to the user in one framed confirmation. The rough scope approval does not approve a written spec or a visual direction packet. Keep the lite path and ask only the smallest unresolved behavior question, one at a time. Because the added error state materially changes the recovery flow, capture the affected states and interactions in a neutral written spec, mark frontend packet status `required-pending`, and prepare a separate `frontend-direction` follow-on prompt. Include explicit UX copy or copy gaps for the error and recovery actions. Do not create implementation code or a route adapter now.

After neutral spec review and user approval, complete and explicitly approve the separate frontend-direction packet. Only then compare delivery routes against the approved spec and the user's preference, recommend one, and ask for confirmation. A preference for keeping written specs rules out treating the upstream “chat design to code” shortcut as approval to skip these artifacts. For a bounded change, Superpowers may fit if durable task-planned delivery is wanted; Native Codex may fit an immediate contained slice while preserving the approved spec. The confirmed route gets exactly one adapter, independent adapter review, and then transition. No route is chosen or started before those gates.
