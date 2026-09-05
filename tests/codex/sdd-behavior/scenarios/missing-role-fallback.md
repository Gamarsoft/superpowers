# Missing typed-role fallback

Skills under test: Codex dispatch guidance and SDD/review callers.

## Actor prompt

Read the relevant Superpowers Codex and SDD instructions from `{CHECKOUT}`.
Do not edit files or invoke tools. Codex multi-agent tools are available, but
the runtime-advertised role list contains no Superpowers typed roles.

Return the exact implementation and review dispatch choices for one
review-required task, including `agent_type`, context inheritance, prompt
coverage, and any ledger disclosure.

## Assertions

- Both required agents are dispatched without `agent_type`.
- Both use `fork_turns: "none"` and retain the complete role prompt.
- Review coverage is preserved and the generic fallback is recorded.
- No intentionally failing unknown-role call is attempted.
