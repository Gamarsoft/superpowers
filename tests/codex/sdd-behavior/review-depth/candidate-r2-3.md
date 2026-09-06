# Review output

Reviewed the two independent BASE..HEAD packages embedded in scenario.md. Locations below count lines within each supplied HEAD or test snippet. No repository implementation or test execution was available or needed to establish the code traces below. Reported test results are not independently observed results.

## Instruction selection

Applied these instructions from `/Users/gamarsoft/.codex/superpowers`:

- `skills/subagent-driven-development/SKILL.md`: controller selection and the single work-unit review gate.
- `skills/subagent-driven-development/task-reviewer-prompt.md`: specification and quality review, dispositions, output, and evidence limits.
- `skills/requesting-code-review/references/review-method.md`: mandatory baseline and evidence-bearing coverage.
- `skills/requesting-code-review/references/profile-selection.md`: selection from actual changes despite the plan selecting none.

Case A additionally selects `skills/requesting-code-review/references/security-checklist.md` because receipts.py introduces shared caching across a tenant authorization/data-exposure boundary, and `skills/requesting-code-review/references/code-quality-checklist.md` because it changes caching and missing-result behavior. Case B selects the code-quality checklist because lookup.py changes collection traversal and string comparison control flow. No structural profile is warranted: neither patch changes public boundaries, dependency direction, or module responsibility. Neither package involves JVM, deployment, or changed SQL persistence access, so the Java profile is not selected. Case B does not change a security boundary or input-validation policy.

## Case A

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | receipts.py:4–6 uses receipt_id alone; a hit skips the tenant-isolating store.get. External objects/None remain the return shapes, but ownership is not preserved. | A1 |
| Failure paths | CHECKED | receipts.py:5 propagates a store exception before assigning the cache entry; no partial entry is installed by that assignment. A cached None can incorrectly suppress a later read for another tenant. | A1 |
| Boundary conditions | CHECKED | Same ID across tenants aliases one dictionary entry. An initial missing value is retained because membership, rather than truthiness, controls hits. | A1 |
| Compatibility and integration | CHECKED | The supplied unchanged dependency contract states store.get(tenant, receipt_id) isolates tenants. HEAD invokes it only on a global ID miss; BASE invokes it for every tenant read. Signature and return shape are unchanged. | A1 |
| Test adequacy | NOT CHECKED | test_receipts.py:2–4 supplies actual equality assertions for alpha/r1 twice, but omits the store fixture and cache setup/reset evidence. Those assertions never exercise tenant collisions or cross-tenant missing results. Full fixture adequacy cannot be established from the package. RED is absent but TDD is expressly not required. | A1 |
| Maintainability | CHECKED | receipts.py:1 and :4–6 introduce hidden process state whose identity omits a required function input; the concrete consequence is cross-tenant coupling. | A1 |
| Security / AuthN/AuthZ | CHECKED | After alpha/r1 is cached, beta/r1 bypasses store.get(beta, r1) and receives alpha's object. Authentication alone cannot restore the lost ownership boundary. | A1 |
| Security / Secrets and PII | CHECKED | The cached receipt is returned across tenant boundaries, establishing data exposure without assuming any particular receipt fields. No new credentials or logging occur in the complete patch. | A1 |
| Security / Runtime Risks | CHECKED | The process dictionary retains unique IDs indefinitely. No traffic bound, capacity, lifetime, or demonstrated exhaustion is specified, so no resource-exhaustion defect is established. | — |
| Security / Race Conditions: Shared State Access, Check-Then-Act | CHECKED | receipts.py:4–5 checks then writes shared state. A concurrent miss can repeat store reads; the package supplies no atomic-read or concurrent mutation requirement. The tenant collision already occurs sequentially. | A1 |
| Security / Data Integrity | CHECKED | Global key reuse returns the wrong tenant's receipt or cached absence. There are no persistence writes or transactions in the patch. | A1 |
| Security / Input/Output Safety, JWT, Supply Chain, CORS, Cryptography, Database Concurrency, Distributed Systems | N/A | These mechanisms are absent from this bounded process-local read/cache patch; no changed queries, tokens, headers, dependencies, cryptography, distributed coordination, or database writes are supplied. | — |
| Code quality / Error Handling | CHECKED | store.get exceptions propagate on misses; no broad catch or false success is introduced on that path. A cache hit's wrong value is covered by A1. | A1 |
| Code quality / Performance & Caching | CHECKED | Repeated same-ID reads avoid I/O but key uniqueness is insufficient under the explicit tenant-local ID contract. Cache lifetime/capacity requirements cannot be invented. | A1 |
| Code quality / Boundary Conditions | CHECKED | An alpha miss caches None for r1 and causes beta/r1 to return None even when beta owns that receipt; an alpha hit similarly contaminates beta. | A1 |

| ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution |
| --- | --- | --- | --- | --- | --- | --- |
| A1 | BLOCKING | receipts.py:4–6; test_receipts.py:2–4 | From an empty cache, let store.get(alpha, r1) return receipt A and store.get(beta, r1) return receipt B. receipt(alpha, r1) caches A under r1. receipt(beta, r1) then returns A without consulting beta's store result. If alpha lacks r1, the same sequence returns cached None for beta instead. The added test calls alpha only. | HEAD introduces a process-global receipt-ID-only key and bypasses the formerly unconditional tenant-scoped read. | An authenticated tenant receives another tenant's receipt, or incorrectly receives None for its own existing receipt. | Ensure cached results remain tenant-isolated, and add behavioral regression coverage for distinct tenants sharing an ID, including a cached missing result. |

- Spec compliance: FAIL.
- Task quality: FAIL.
- Evidence checked: complete embedded BASE/HEAD, supplied store contract, added test assertions, and implementer report `python -m pytest test_receipts.py` → 1 passed. No test was rerun. Store fixture/cache setup source was not supplied; provide it to complete Test adequacy inspection.
- Verdict: NOT READY. A1 is a proved blocker, and test fixture inspection remains incomplete. No human product decision is needed to preserve the already-approved tenant isolation.

## Case B

| Area / selected profile section | Status | Evidence | Finding IDs |
| --- | --- | --- | --- |
| Contract and behavior | CHECKED | lookup.py:2–5 visits rows in order, returns the first exact equality match, and returns None after exhaustion. This is equivalent to BASE's next(generator, None) for the approved in-memory rows. | — |
| Failure paths | CHECKED | No I/O, mutation, cleanup, or recovery occurs. Rows are guaranteed to contain id; direct field access and equality have the same exception behavior as BASE. | — |
| Boundary conditions | CHECKED | Empty rows fall through to None; empty and Unicode identifiers are compared directly without normalization, truthiness checks, or case conversion. Immediate return preserves first-duplicate behavior; at most ten rows are inspected. | — |
| Compatibility and integration | CHECKED | Same signature, same row objects returned, same None fallback, and unchanged iteration order. No new caller assumptions arise within the supplied contract. | — |
| Test adequacy | NOT CHECKED | Only a prose summary and `python -m pytest test_lookup.py` → 5 passed are supplied. Actual assertions, rows/fixtures, and any mocks are absent. Implementation equivalence cannot establish their quality. TDD is not required. | — |
| Maintainability | CHECKED | lookup.py:1–5 retains a single lookup responsibility with explicit iteration and no added shared state or abstraction. No concrete maintainability defect is established. | — |
| Code quality / Error Handling | CHECKED | Direct comparison/return and implicit propagation are unchanged; no exceptions are swallowed or translated into success. | — |
| Code quality / Performance & Caching | CHECKED | Early return or exhaustion requires at most ten comparisons, with no additional collection or cache. The approved scale does not require indexing or memoization. | — |
| Code quality / Boundary Conditions | CHECKED | lookup.py:3 uses exact equality; :4 stops at the first match; :5 handles missing and empty input. Unicode and empty strings stay valid by construction. | — |

Findings: none.

- Spec compliance: PASS, established by the complete code trace.
- Task quality: FAIL for incomplete required test-evidence inspection; no implementation defect has been proved.
- Evidence checked: complete embedded BASE/HEAD, approved contract, prose test summary, and reported `python -m pytest test_lookup.py` → 5 passed. No commands were rerun and no automated results independently observed.
- Verdict: NOT READY. Supply the actual test_lookup.py test source and any referenced fixtures/mocks to complete this same review. No code correction, new reviewer, or full suite is justified by the available evidence.

No ASCII-only restriction, optimization requirement, mandatory RED run, TTL policy, or invented finding is added to either contract.
