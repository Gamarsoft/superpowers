# Java 21 / Spring Boot / GKE Review Checklist

Apply when the diff touches Java/JVM code, Spring Boot configuration, persistence, service boundaries, GraphQL/REST endpoints, build files, container settings, Kubernetes manifests, Helm charts, or deployment/runtime behavior.

## Java 21+ production baseline

- No preview, experimental, incubator, or Valhalla/JEP 401 value-class syntax unless the target runtime and build explicitly opt in.
- Prefer records for immutable DTOs, commands, events, query projections, and small value carriers; do not use records as JPA entities or lazy-loaded objects.
- Use sealed types only for genuinely closed hierarchies.
- Use pattern matching and switch expressions when they improve clarity; do not modernize syntax in behavior-changing ways.
- Use `var` only when the inferred type is obvious from the right-hand side.
- Use `Optional` only as a return type for absence; do not use it in fields, parameters, DTO payloads, or JPA entities.
- Use `java.time` for dates/times and `BigDecimal`/integer minor units for money; never create `BigDecimal` from `double`.
- Prefer clear loops over complex streams in branchy, exception-heavy, or hot-path code; avoid parallel streams in request paths.

## Spring Boot service design

- Controllers/resolvers are thin: validate input, enforce auth/tenant context, delegate to use-case services, map responses.
- Service methods own business orchestration and transaction boundaries; domain rules are not hidden in controllers, mappers, or repositories.
- Constructor injection only; no field injection or static application context access.
- Configuration uses typed `@ConfigurationProperties` with validation for non-trivial settings.
- External clients define timeouts, bounded retries, and failure behavior; no infinite retry loops or calls without deadlines.
- Logs are parameterized and useful for operations; do not log secrets, access tokens, refresh tokens, full PII payloads, or payment data.
- Actuator/metrics/tracing changes do not expose sensitive details.

## Security and multi-tenant correctness

- Every new read/write endpoint, mutation, scheduled job, and repository query enforces authentication, authorization, tenant/ownership scope, and role/feature checks where required.
- Never trust client-provided user IDs, tenant IDs, roles, flags, prices, loyalty balances, or booking ownership.
- Validate DTOs at boundaries; fail with safe, non-leaking error messages.
- Avoid injection: no string-concatenated JPQL/SQL/GraphQL queries, shell commands, file paths, or URLs from untrusted input.
- For JWT/OAuth2 integrations, validate issuer, audience, expiration, algorithm, and intended trust boundary.
- SSRF-sensitive URLs require allowlists or strict destination validation.
- CORS, CSRF, cookie, and security-header changes are least-privilege and environment-aware.
- Idempotency exists for retryable write flows, webhook ingestion, payment-like operations, external sync, and outbox/event publication.

## JPA/Hibernate and data integrity

- No N+1 queries: loops must not trigger one query per item; use fetch joins, entity graphs, batch fetching, DTO projections, or explicit batch queries.
- Pagination is required for unbounded reads; avoid loading entire tables or large associations into memory.
- Queries fetch only required data; prefer DTO/projection reads for list screens and APIs that do not mutate entities.
- Transactions are explicit and narrow; use read-only transactions for read paths when useful.
- Do not rely on Open Session in View or lazy-loading from serialization.
- Avoid cascade/orphan changes that can delete or update more data than intended.
- Concurrent updates use optimistic locking, pessimistic locking, unique constraints, or atomic database operations as appropriate.
- Database migrations are backward-compatible when rolling deployments are expected.
- Schema/index changes match query patterns and expected cardinality.

## Performance and resource discipline

- Do not claim performance improvement without evidence, obvious asymptotic improvement, or removal of obvious repeated work.
- Watch for repeated regex/date formatter construction, JSON parsing, object allocation, sorting, remote calls, or database calls in hot paths.
- Avoid nested `List.contains`/linear scans where a `Set` or `Map` expresses the intent.
- Caches are bounded and have explicit key design, TTL/eviction, invalidation, tenant isolation, and failure behavior.
- Thread pools, queues, schedulers, buffers, and batch sizes are bounded and configurable.
- Virtual threads are used only when the runtime/framework is configured for them and blocking boundaries are understood; never pool virtual threads.
- CPU-heavy work, blocking I/O, and long-running jobs do not starve request handling.
- Large files, exports, imports, and reports use streaming or batching rather than full in-memory loading.

## JVM container / GKE readiness

- JVM options are compatible with container memory limits; heap, metaspace, direct buffers, thread stacks, and native memory are considered.
- Kubernetes requests/limits are realistic for the changed workload; no accidental memory growth or unbounded concurrency.
- Readiness/liveness/startup probes reflect real app behavior and do not create restart loops.
- Graceful shutdown works for HTTP requests, schedulers, consumers, and in-flight jobs.
- Secrets are mounted or injected through approved runtime mechanisms, not committed or baked into images.
- Build/image changes preserve reproducibility, small attack surface, and non-root runtime where applicable.

## Review severity hints

Treat as Critical when the diff can cause unauthorized access, cross-tenant data exposure, token/secret leakage, data loss, payment/booking corruption, or broken authentication.

Treat as Important when the diff introduces N+1 queries, unbounded memory/concurrency, missing idempotency for retryable writes, unsafe transactions, missing tests for changed behavior, or runtime settings likely to break in Kubernetes.
