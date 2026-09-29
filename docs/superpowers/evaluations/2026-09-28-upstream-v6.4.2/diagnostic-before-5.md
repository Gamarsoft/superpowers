# Proposed dispatch

The controller first reads the reported region itself, using the case file's verified record meanings and `references/context-safety.md`. The complaint is already scoped, so intake and discovery are complete. Do not open raw transcript lines without measuring them. These are proposed calls only; no agent is spawned in this exercise.

Use seven **generic** `spawn_agent` calls, one per dimension, with `agent_type: "default"`, `model: "gpt-6-sol"`, `reasoning_effort: "medium"`, and `fork_turns: "none"`. None of the four typed Superpowers roles is an analyst; do not mislabel one. The analysis reconciles session records across turns, so Sol/medium fits the repository's broad exploration default. Give each call a distinct task name: `skill_timeline`, `plan_adherence`, `repeated_work`, `stumbles`, `quality_evidence`, `request_conflicts`, `cost_and_time`.

Each message must contain the *complete* analyst prompt, assembled from the full text of `/tmp/superpowers-diagnosis-baseline/diagnosing-superpowers/prompts/analyst-common.md` followed by the full text of its corresponding dimension file below, not just an instruction to read those files. Include `CASE: <verified absolute case.md path>` from discovery; the case supplies exact transcript paths, session IDs, source meanings, install root, and extraction commands. Include `RANGE: whole scoped session/turn range from the case` (or omit RANGE if the case has no range). State that every session-file read follows `/tmp/superpowers-diagnosis-baseline/diagnosing-superpowers/references/context-safety.md`, findings require `path:line`, and the analyst must not fix or diagnose Superpowers. Do not substitute the agent's own session for CASE.

Dimension files, in call order:

1. `prompts/skill-timeline.md`
2. `prompts/plan-adherence.md`
3. `prompts/repeated-work.md`
4. `prompts/stumbles.md`
5. `prompts/quality-evidence.md`
6. `prompts/request-conflicts.md`
7. `prompts/cost-and-time.md`

With two free slots, launch calls 1–2 concurrently; when one finishes, launch 3, then 4, and continue in order through 7. If a slot is unavailable, retain the pending dimension and wait for a real slot; do not combine dimensions, omit one, or invent a role/tool. If the transcript is long, split a dimension by evidenced turn ranges and queue those additional calls under the same two-slot limit. Collect all seven outputs and discard any finding without `path:line` before reporting.

For an **authorized** export only, dispatch a generic scrubber with `model: "gpt-6-astra"`, `reasoning_effort: "medium"`, `fork_turns: "none"`, and the full `prompts/scrub.md` text plus absolute `BUNDLE`, user-supplied `PUBLIC_REPOS`, and `PROPRIETARY` lists (empty if none). After it finishes, dispatch a separate generic Astra/medium auditor, also `fork_turns: "none"`, with full `prompts/scrub-audit.md` and the same three inputs. Both must apply `references/redaction-policy.md`. Run them sequentially, repeating both until the independent audit returns CLEAN; queue if no slot is free.
