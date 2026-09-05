# Review Profile Selection

Choose the smallest set justified by changed files or named risk. Record the
predicate that selected each profile. The default reviewer is stack-neutral and
uses the base prompt without loading every checklist.

| Profile | Select only when | Instruction path |
| --- | --- | --- |
| Structural design | The diff changes public boundaries, dependency direction, module responsibilities, or a named architecture/maintainability risk | `solid-checklist.md` |
| Security | The diff changes authentication, authorization, secrets, cryptography, trust boundaries, input validation, data exposure, or carries a named security/privacy risk | `security-checklist.md` |
| Java 21 / Spring / persistence / GKE | Changed files or requirements involve Java/Kotlin, Maven/Gradle, Spring, JPA, SQL persistence access, containers, Kubernetes, Helm, GKE, or deployment/runtime behavior | `java-21-spring-gke-checklist.md` |
| Broad code quality | A major refactor or explicit quality review spans several changed responsibilities and the base rubric is insufficient | `code-quality-checklist.md` |

Do not select a profile solely because the repository contains that technology.
Do not load security or Java policy for an unrelated documentation change.
Selected profiles add relevant questions; they do not add product requirements,
scope, or another severity system.
