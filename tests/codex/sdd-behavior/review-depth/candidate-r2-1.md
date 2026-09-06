# Review output

Reviewed the complete supplied BASE and HEAD snippets independently for Cases A and B. Locations below use snippet-local line numbers. No repository implementation or test execution was needed; reported test results remain implementer claims.

## Instruction selection

Read and applied:

- `/Users/gamarsoft/.codex/superpowers/skills/subagent-driven-development/SKILL.md`: controller review selection and one review gate per unit.
- `/Users/gamarsoft/.codex/superpowers/skills/subagent-driven-development/task-reviewer-prompt.md`: specification and quality review, evidence requirements, dispositions, and output.
- `/Users/gamarsoft/.codex/superpowers/skills/requesting-code-review/references/review-method.md`: mandatory baseline coverage and inspection of actual test assertions, fixtures, and mocks.
- `/Users/gamarsoft/.codex/superpowers/skills/requesting-code-review/references/profile-selection.md`: recompute selection from each actual patch despite no planned profiles.

Case A additionally selects and reads `/Users/gamarsoft/.codex/superpowers/skills/requesting-code-review/references/security-checklist.md` because `receipts.py` introduces shared state that changes tenant authorization/data exposure, and `/Users/gamarsoft/.codex/superpowers/skills/requesting-code-review/references/code-quality-checklist.md` because the patch introduces caching. Case B selects and reads the same code-quality checklist because `lookup.py` changes the implementation of collection traversal and string equality boundaries. Neither case changes public signatures, dependency direction, or module responsibilities sufficiently to select structural design. Neither involves JVM, deployment configuration, or a persistence implementation change; an opaque store call does not require the Java profile. Case B does not change a security boundary.

## Case A

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | `receipts.py:4-6` uses receipt ID alone. After alpha caches r1, beta's r1 reads alpha's result without calling the tenant-enforcing store. | A1 |
| Failure paths | CHECKED | At `receipts.py:5`, a store exception propagates before assignment, so no new cache entry is published on that failed lookup. A successful missing lookup caches None; another tenant then incorrectly inherits that absence. | A1 |
| Boundary conditions | CHECKED | Same ID across tenants collides, including present/missing combinations. Membership testing correctly distinguishes cached None from an absent key within a single tenant. | A1 |
| Compatibility and integration | CHECKED | Signature and returned object shape remain unchanged. The supplied dependency contract says `store.get(tenant, receipt_id)` enforces isolation; HEAD bypasses it on cache hits without preserving its tenant identity. | A1 |
| Test adequacy | NOT CHECKED | Read `test_receipts.py:1-4`: both assertions exercise alpha/r1 only, so they miss the proved cross-tenant collision and would also pass BASE. The `store` fixture source is absent, preventing verification of real fixture behavior and mocks. No TDD requirement applies, so absent RED is not a defect. | A1 |
| Maintainability | CHECKED | Module-global `_cache` at line 1 hides request-to-request coupling; the key omits an input that determines the result. This has the concrete isolation consequence in A1. | A1 |
| Security — AuthN/AuthZ | CHECKED | Cache-hit path at lines 4-6 returns data without the store's tenant check and without an equivalent tenant-scoped key. | A1 |
| Security — Secrets and PII | CHECKED | No secrets or logging are introduced; cached receipts can be exposed to another tenant, irrespective of their exact fields. | A1 |
| Security — Runtime Risks | CHECKED | Cache can grow with distinct IDs. No workload, capacity, or lifetime requirement is supplied, so no resource-exhaustion or TTL defect is established. | none |
| Security — Race Conditions | CHECKED | Shared dictionary and check-then-act are visible at lines 1, 4-6. Interleaving distinct tenants with the same ID can overwrite/read each other's cached result; the sequential trace already proves the defect. No additional concurrency or exactly-once guarantee is assumed. | A1 |
| Security — Data Integrity | CHECKED | Successful cache writes associate values with an incomplete identity, corrupting tenant lookup semantics. No persistent writes or transactions occur in the patch. | A1 |
| Security — Input/Output Safety, JWT & Token Security, Supply Chain & Dependencies, CORS & Headers, Cryptography | N/A | No rendering, query construction, paths, token handling, dependencies, headers, or cryptographic operations are changed in this bounded patch. | none |
| Code quality — Error Handling | CHECKED | Store exceptions propagate unchanged on misses; no catch or false fallback is introduced. | none |
| Code quality — Performance & Caching | CHECKED | Repeated IDs skip store reads, but cache key uniqueness fails across tenants. TTL, eviction, and invalidation requirements are unspecified and do not justify additional findings. | A1 |
| Code quality — Boundary Conditions | CHECKED | Same-ID tenant collisions and cached None were traced directly; key membership avoids truthiness errors. | A1 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| A1 | BLOCKING | HEAD `receipts.py:4-6` | Given distinct receipts for alpha/r1 and beta/r1 and an empty cache, alpha's call stores its receipt under r1; beta's call hits r1 and returns alpha's receipt. If alpha/r1 is missing, beta inherits None even when beta/r1 exists. | BASE always passes both identity components to the isolation-enforcing store; the new cache discards tenant identity. | Cross-tenant receipt disclosure and incorrect missing results violate the approved contract. | Ensure cached results are isolated by tenant and receipt identity, preserving missing-result behavior; add behavioral coverage with two tenants sharing an ID, including present/missing cases. |

- Spec compliance: FAIL.
- Task quality: FAIL, based on A1; fixture inspection also remains incomplete.
- Evidence checked: complete supplied BASE/HEAD, supplied test assertions, approved store contract, and reported `python -m pytest test_receipts.py` → 1 passed. No tests rerun. Missing artifact: the `store` fixture and any relevant mock setup.
- Verdict: NOT READY. Correct A1 and supply the fixture evidence to complete this review.

## Case B

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | `lookup.py:2-5` traverses in input order, returns immediately on exact equality, and returns None after exhaustion, matching BASE. | none |
| Failure paths | CHECKED | No I/O or writes exist. Rows always have id by contract, so no missing-field fallback is required. Equality and iteration failures are not newly caught or converted to success. | none |
| Boundary conditions | CHECKED | Empty rows skip to None; missing identifiers exhaust the loop; empty strings and Unicode use unchanged equality with no coercion or normalization; duplicate IDs return the first matching row. At most ten rows are examined. | none |
| Compatibility and integration | CHECKED | Same signature, row identity, return shape, ordering, and default None. No external dependencies or persistent state are introduced. | none |
| Test adequacy | NOT CHECKED | The scenario supplies a prose description and a five-pass report, but no `test_lookup.py` assertion, fixture, or mock source. Equivalence by inspection does not establish actual test quality. Request that source within this existing review. TDD is expressly not required. | none |
| Maintainability | CHECKED | Lines 2-5 express the same single-purpose lookup directly, without hidden state or duplicated policy. No concrete maintainability defect is identified. | none |
| Code quality — Error Handling | CHECKED | There is no fallible I/O or exception handling to change; iteration and comparison semantics remain the same under the approved inputs. | none |
| Code quality — Performance & Caching | CHECKED | Both versions stop at the first match, scan at most ten rows, and use constant auxiliary space. No performance or caching requirement is missing. | none |
| Code quality — Boundary Conditions | CHECKED | Direct equality preserves case, Unicode and empty identifiers; the early return preserves first-duplicate behavior, and exhaustion preserves None. | none |

Findings table: none.

- Spec compliance: PASS on the complete supplied implementation.
- Task quality: FAIL to establish the required evidence gate because test source is unavailable; this is not a proved implementation defect.
- Evidence checked: complete supplied BASE/HEAD, approved contract, and reported `python -m pytest test_lookup.py` → 5 passed. The claimed coverage is not independently established. No tests rerun.
- Verdict: NOT READY pending actual `test_lookup.py` assertions and relevant fixtures/mocks. Finish that inspection in this same review; no code correction or second reviewer is justified by current evidence.

No ASCII restriction, bounded-scan optimization, cache lifetime policy, or retrospective TDD requirement is imposed. There are no supported FOLLOW_UP or INVALID findings to populate artificially.
