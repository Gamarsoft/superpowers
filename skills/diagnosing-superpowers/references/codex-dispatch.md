# Codex diagnostic dispatch

Use fresh generic agents: omit `agent_type`, set `fork_turns: "none"`, and
supply the complete diagnostic prompt. SDD implementation, review, and topic
roles carry different responsibilities; do not substitute their role prompts.

| Work | Model | Reasoning effort |
| --- | --- | --- |
| Transcript analyst or similar-session comparison | `gpt-6-sol` | `medium` |
| Authorized bundle scrub | `gpt-6-sol` | `medium` |
| Independent scrub audit | `gpt-6-astra` | `medium` |

Pass explicit model and effort only when the runtime supports them. Report an
unavailable setting; do not claim it was applied. Never raise effort solely
because a pass retried.

For each analyst, supply absolute CASE/session paths, the full common and
selected dimension prompts, and any assigned RANGE. For scrubbing and audit,
supply the full respective prompt, redaction policy and exact bundle inputs.
Every prompt forbids subagents. Analysts and auditors are read-only; the scrubber
may edit only the authorized bundle copies, never source sessions.

Schedule at most the currently free worker slots. Run all seven dimensions in
batches when capacity is limited; do not drop dimensions or change their depth.
When full, wait for existing workers rather than submitting failing calls.
Keep the scrub audit in a fresh agent separate from the scrubber. Scheduling
and model selection do not waive intake, citation, export, or approval gates.
