# Review Profile Selection

Choose the smallest set justified by changed files or named risk. Record the
predicate that selected each profile. The default reviewer is stack-neutral and
uses the shared `review-method.md` baseline without loading every specialist checklist.
Recompute selection from the actual diff at each initial and final review; a
plan with no profiles does not mean the diff has no applicable risks.

| Profile | Select only when | Instruction path |
| --- | --- | --- |
| Structural design | The diff changes public boundaries, dependency direction, module responsibilities, or a named architecture/maintainability risk | `solid-checklist.md` |
| Security | The diff changes authentication, authorization, secrets, cryptography, trust boundaries, input validation, data exposure, or carries a named security/privacy, concurrency, idempotency, or recovery risk | `security-checklist.md` |
| Java 21 / Spring / persistence / GKE | Changed files or requirements involve Java/Kotlin, Maven/Gradle, Spring, JPA, SQL persistence access, containers, Kubernetes, Helm, GKE, or deployment/runtime configuration | `java-21-spring-gke-checklist.md` |
| Broad code quality | The diff changes error handling, caching, resource use, numeric/string/collection boundaries, or spans several responsibilities in a major refactor or explicit quality review | `code-quality-checklist.md` |

Do not select a profile solely because the repository contains that technology.
Do not load security or Java policy for an unrelated documentation change.
Selected profiles add relevant questions; they do not add product requirements,
scope, or another severity system.

Generic application execution alone does not select the Java/deployment profile.
Use the security and code-quality profiles for non-JVM cache or isolation changes
without persistence or deployment changes.
