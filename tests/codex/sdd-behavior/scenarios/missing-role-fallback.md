# Missing typed-role fallback

Skills under test: Codex dispatch guidance and SDD/review callers.

## Actor prompt

Read the relevant Superpowers Codex and SDD instructions from `{CHECKOUT}`.
Do not edit files. Codex multi-agent tools are available, but the
runtime-advertised role list contains neither `sp_implementer` nor
`sp_reviewer`.

Operationally prove the fallback with exactly two harmless dispatches:

1. Dispatch one fresh generic implementation probe with `agent_type` omitted
   and `fork_turns: "none"`. Its self-contained prompt must identify the
   implementation stage, exact candidate revision, task scope, no-nested-agent
   constraint, no-edit probe constraint, and exact marker
   `GENERIC_IMPLEMENTER_FALLBACK_OK`. Require the child to return that marker
   followed by `stage=implementation`, the exact revision, `scope=bounded-probe`,
   `no-edit=true`, and `no-subagents=true` so the retained child output proves
   what its fresh prompt contained.
2. Dispatch one fresh generic review probe with `agent_type` omitted and
   `fork_turns: "none"`. Its self-contained prompt must identify the review
   stage, exact candidate revision, specification/acceptance and exact-range
   evidence placeholders, the shared four dispositions and causality rule,
   read-only/no-nested-agent constraints, and exact marker
   `GENERIC_REVIEWER_FALLBACK_OK`. Require the child to return that marker
   followed by `stage=review`, the exact revision, `spec=SPEC`,
   `acceptance=ACCEPTANCE`, `range=BASE..HEAD`,
   `dispositions=BLOCKING,DECISION,FOLLOW_UP,INVALID`, `causality=required`,
   `proof=required`, `read-only=true`, and `no-subagents=true` so the retained
   child output proves the complete review coverage.

Wait for both results. Do not intentionally call an unavailable typed role.
Return the exact dispatch choices, observed markers, complete prompt coverage,
and the generic-fallback ledger disclosure. Counts include only dispatches
actually performed in this actor session.

## Assertions

- Both required agents are dispatched without `agent_type`.
- Both use `fork_turns: "none"` and retain the complete role prompt.
- Review coverage is preserved and the generic fallback is recorded.
- No intentionally failing unknown-role call is attempted.
- Retained operational parent/child traces prove both generic dispatches and
  both exact markers.
