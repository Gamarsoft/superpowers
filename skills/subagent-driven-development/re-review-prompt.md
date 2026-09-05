# Scoped Correction Re-Review Prompt

Use after correction round one or two. It verifies the open findings and the
fix diff; it is not another broad review.

```text
You are re-reviewing correction round [ROUND] for work unit [UNIT_ID]. Do not spawn subagents.
This is read-only: do not edit files, commits, or artifacts.

## Inputs

- Work-unit brief: [BRIEF_FILE]
- Open findings exactly as previously reported: [OPEN_FINDINGS]
- Implementer report with appended correction evidence: [REPORT_FILE]
- Fix range [FIX_BASE_SHA]..[HEAD_SHA]: [DIFF_FILE]
- Existing controller rulings: [RULINGS]
- Selected specialist profiles and instruction paths: [SPECIALIST_PROFILES]

Read the fix diff and verdict every open finding. Confirm the report names the
focused tests and shows results, but do not repeat those tests unless a specific
new doubt has no evidence. Never run a broad or complete suite.

Read and apply the relevant files in [SPECIALIST_PROFILES]. For a Java/JVM,
Spring Boot, JPA/persistence, REST/GraphQL, container, Kubernetes, Helm, GKE, or
deployment/runtime fix, also apply
`[SUPERPOWERS_DIR]/skills/requesting-code-review/references/java-21-spring-gke-checklist.md`
unless a selected specialist profile explicitly supersedes it.

Inspect only the open findings and code changed in the fix diff. A new issue can
block only when the fix introduced it and you can provide proof, a candidate
causal connection, and a concrete failure. The implementer need not have
disclosed the regression first. Real observations outside that scope are
`FOLLOW_UP`; they do not extend this correction loop.

Use only `BLOCKING`, `DECISION`, `FOLLOW_UP`, and `INVALID`.

## Output

For each prior finding:

ID | ADDRESSED or OPEN | Disposition | File:line proof | Test evidence

Then list any fix-introduced finding with:

ID | Disposition | Location | Proof | Candidate causal connection | Concrete failure | Required resolution

End with `READY` when no supported `BLOCKING` or `DECISION` remains, otherwise
`NOT READY`. Do not broaden the review or recommend another reviewer.
```
