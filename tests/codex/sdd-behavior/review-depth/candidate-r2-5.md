# Review output

The reviewed ranges are the complete BASE and HEAD snippets for Case A and Case B in `scenario.md`. Line numbers below count from the first line of each supplied code snippet. No repository revisions are supplied or inferred. No tests were rerun; the exact commands and results below are implementer reports, not independently observed executions.

## Instruction selection

Common instructions read and applied, under `/Users/gamarsoft/.codex/superpowers/`:

- `skills/subagent-driven-development/SKILL.md`: controller selection and one work-unit review gate.
- `skills/subagent-driven-development/task-reviewer-prompt.md`: specification and quality review, dispositions, output requirements.
- `skills/requesting-code-review/references/review-method.md`: all six baseline areas and evidence requirements.
- `skills/requesting-code-review/references/profile-selection.md`: recompute profiles from actual changes despite the plan selecting none.

Case A adds and applies `skills/requesting-code-review/references/security-checklist.md` for tenant authorization, data exposure, and shared state, and `skills/requesting-code-review/references/code-quality-checklist.md` for caching and key boundaries. These cover `receipts.py` and its supplied test. Structural design is not selected: no changed public boundary, dependency direction, or named architectural risk. The Java/persistence/deployment profile is not selected: this is a non-JVM cache change; the store API contract is supplied, with no persistence implementation change.

Case B adds and applies `skills/requesting-code-review/references/code-quality-checklist.md` because `lookup.py` changes collection traversal and identifier comparison control flow. Security, structural design, and Java/persistence/deployment predicates are absent. Selection does not impose normalization, memoization, or extra scale requirements.

## Case A

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | `receipts.py:4-6` keys all tenants by receipt ID; a cache hit bypasses the supplied tenant-isolating `store.get(tenant, receipt_id)` contract. The return shape is preserved but ownership is not. | A1 |
| Failure paths | CHECKED | On a miss, `receipts.py:5` propagates store exceptions; failed RHS evaluation does not install a value. A cached None from another tenant can falsely represent a missing receipt. | A1 |
| Boundary conditions | CHECKED | Cold cache, repeat reads, missing receipt, and same ID across tenants traced. Alpha's `r1` value wins over beta's distinct `r1`; alpha's cached None can also hide beta's existing row. | A1 |
| Compatibility and integration | CHECKED | Signature and direct store-value return remain unchanged. The established store isolation boundary is bypassed by process-global hits at line 6. No external consumer implementation is present or needed to prove this failure. | A1 |
| Test adequacy | NOT CHECKED | Supplied `test_receipts.py:2-4` compares two same-tenant reads with the store value. These assertions do not exercise two tenants or prove a cache hit. The `store` fixture definition and cache setup/cleanup are not supplied, so fixture realism and initial cache state cannot be verified. TDD is explicitly not required; absent RED evidence is not a defect. | A1 |
| Maintainability | CHECKED | The module-global cache at line 1 introduces shared state whose key omits an input determining the result. This creates concrete cross-tenant coupling. No abstraction or stylistic change is required. | A1 |
| Security / AuthN/AuthZ | CHECKED | Alpha populates `r1`, then beta receives alpha's receipt at line 6 without invoking the isolating store. Authentication alone cannot prevent this. | A1 |
| Security / Secrets and PII | CHECKED | The exposed value is another tenant's receipt; no assumptions about specific PII fields are needed. No new logs or literal secrets appear. | A1 |
| Security / Runtime Risks | CHECKED | The dictionary retains entries with no eviction. No lifetime, capacity, or deployment scale contract is supplied, so this alone establishes no additional contract defect. | — |
| Security / Race Conditions: Shared State Access and Check-Then-Act | CHECKED | Lines 4-6 share a dictionary and use a non-atomic check/fill sequence. The tenant collision already occurs sequentially; interleaved misses can also overwrite the same key. No independent concurrency guarantee or additional failure is asserted. | A1 |
| Security / Data Integrity | CHECKED | Cached None and receipt values can be substituted across tenants; no persistent writes or transaction changes occur. | A1 |
| Security / Input/Output Safety, JWT, Supply Chain, CORS, Cryptography, database/distributed concurrency | N/A | The complete patch contains no rendering, query construction, paths, tokens, dependencies, headers, cryptography, transactions, or distributed operations. Store internals are outside this range. | — |
| Quality / Error Handling | CHECKED | Store errors propagate from line 5, as at BASE. No catch converts failure into success; cached wrong-tenant data is covered by A1. | A1 |
| Quality / Performance & Caching | CHECKED | One lookup on cold key, cached reuse thereafter. The key excludes tenant identity, causing a proven collision. Missing TTL/capacity is not itself a requirement violation. | A1 |
| Quality / Boundary Conditions | CHECKED | Membership tests correctly retain None but distinguish only IDs, not tenant-local identities. Same-ID tenant collision and negative-cache collision are traced above. | A1 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| A1 | BLOCKING | `receipts.py:4-6`; `test_receipts.py:2-4` | Start empty; `store.get(alpha, r1)` is receipt A and `store.get(beta, r1)` is receipt B. Calling alpha first stores A under r1; calling beta then returns A without calling its store lookup. If alpha returns None, beta incorrectly gets None instead of B. | HEAD introduces a global ID-only cache where BASE always passes tenant and ID to the isolation-enforcing store. | Cross-tenant receipt disclosure and incorrect missing-receipt results violate the explicit ownership contract. The added single-tenant test does not cover the failing path. | Preserve tenant isolation on every cached read, including cached missing results, and supply behavioral regression coverage for different tenants sharing an ID. |

- Spec compliance: FAIL.
- Task quality: FAIL.
- Evidence checked: complete supplied BASE/HEAD, test function assertions, approved store contract, and reported `python -m pytest test_receipts.py` → `1 passed`. The store fixture and cache setup source are unavailable.
- Verdict: NOT READY. A1 requires correction. Complete test-adequacy inspection also requires the fixture and relevant setup source; missing evidence is not a separate product defect or DECISION.

## Case B

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | `lookup.py:2-5` traverses in order, uses unchanged exact equality, returns the original first matching row, and falls through to None. This preserves BASE's generator/next behavior for the approved in-memory rows. | — |
| Failure paths | CHECKED | No I/O or exception suppression is added. Rows always have `id`; no-match and empty input both reach line 5. No unsupported malformed-row policy is imposed. | — |
| Boundary conditions | CHECKED | Zero rows returns None; ten rows are fully traversable; first duplicate returns immediately; empty and Unicode identifiers use the same exact equality with no truthiness or normalization. Case is preserved. | — |
| Compatibility and integration | CHECKED | Function signature, input assumptions, output object identity, and missing return value are unchanged. There is no global state, mutation, configuration, or changed external dependency. | — |
| Test adequacy | NOT CHECKED | Only a prose summary and passing command are supplied. Actual `test_lookup.py` source, assertions, fixtures, and any mocks are unavailable. Cannot verify the claimed missing, empty-list, empty-identifier, Unicode, and first-duplicate tests or their ability to detect regressions. TDD is not required. | — |
| Maintainability | CHECKED | `lookup.py:1-5` remains a single small lookup responsibility. Straight-line loop control adds no hidden coupling or duplicated policy. | — |
| Quality / Error Handling | CHECKED | The loop performs the same row access/comparison as BASE, with no new catch or fallback. None still means no match. | — |
| Quality / Performance & Caching | CHECKED | At most ten comparisons, early exit on match, constant auxiliary space. No costly I/O or computation exists to justify required caching or indexing. | — |
| Quality / Boundary Conditions | CHECKED | Direct equality preserves empty identifiers, case, and Unicode. Loop ordering preserves first duplicate behavior; empty rows safely fall through. No numeric or nullable-value handling is required by the supplied contract. | — |

Findings: none.

- Spec compliance: PASS by inspection of the complete implementation range.
- Task quality: FAIL for incomplete required test-evidence inspection; no implementation defect is established.
- Evidence checked: supplied BASE/HEAD, approved contract, prose coverage summary, and reported `python -m pytest test_lookup.py` → `5 passed`. Reported tests were not rerun and their assertions were not available to inspect.
- Verdict: NOT READY. Supply `test_lookup.py` and any referenced fixtures/mocks to complete this same review. Implementation equivalence and the reported passing result cannot establish test adequacy. No code correction, extra reviewer, broad suite, optimization, or ASCII restriction is warranted by the inspected range.
