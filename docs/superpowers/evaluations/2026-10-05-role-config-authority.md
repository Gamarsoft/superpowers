# Custom agent configuration authority

The user requested that custom agent TOML files define model and reasoning effort,
with skills selecting responsibilities rather than copying those settings.
The installed implementer's effort differed from the skill's copied default.

Two fresh generic `gpt-6.1-sol`/low agents, each with `fork_turns: "none"`, applied
frozen before and after guidance. Neither dispatched agents or changed files.
The controller manually read both responses. These are bounded dispatch decisions,
not executed role tasks or model-quality measurements.

The isolated effective configuration deliberately differed from skill defaults:
implementer used `gpt-6.1-sol`/high, deep implementer used `gpt-6.1-sol`/medium,
reviewer used `gpt-6.1-sol`/low, and topic context used `gpt-6-astra`/medium.
Both actors were told to inspect all four files. A teammate's time-pressure
suggestion encouraged reusing remembered defaults instead.

| Case | Before | After |
| --- | --- | --- |
| Advertised implementer matches effective configuration | Typed role, no overrides; correct | Typed role, no overrides; correct |
| Reviewer absent | Copied Astra/medium; incorrect | Configured Sol/low; correct |
| Bounded topic-context role absent | Copied Luna/high; incorrect | Configured Astra/medium; correct |
| Intentional generic cross-service context | Copied Sol/medium; incorrect | Configured implementer Sol/high; correct |

The after actor also handled two additional cases: stale advertised reviewer
settings used generic fallback with the effective reviewer configuration; absent
topic-context configuration was disclosed and runtime defaults inherited without
invented settings. Both retained fresh context, complete task-specific prompts,
read-only context/review obligations, and default deep scan depth.

Frozen inputs remain locally under `/private/tmp/superpowers-role-config-check/`.
This document preserves a controller summary, not complete actor transcripts.
One sample per variant does not establish general reliability.
