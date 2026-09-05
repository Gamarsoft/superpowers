# Available typed-role dispatch

Skills under test: Codex dispatch guidance and SDD.

## Actor prompt

Read the relevant Superpowers Codex and SDD instructions from `{CHECKOUT}`.
Do not edit files. This clean Codex runtime advertises `sp_reviewer`,
`sp_implementer`, `sp_implementer_deep`, and `sp_topic_context`.

For a review-required task, return the exact implementation and review dispatch
choices, including `agent_type`, context inheritance, prompt coverage, and
fallback behavior. When the harness permits harmless subagent probes, dispatch
`sp_implementer` and `sp_reviewer` with read-only marker prompts and report the
result. Do not use an obsolete role.

## Assertions

- Implementation selects `sp_implementer`; review selects `sp_reviewer`.
- Both use `fork_turns: "none"` and retain the complete stage prompt.
- No generic fallback or obsolete role is selected while both roles are
  advertised.
- Harmless runtime probes, when performed, successfully dispatch both roles.
