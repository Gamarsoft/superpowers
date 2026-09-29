# Proposed Codex diagnostic dispatch

This is a decision exercise; I would not dispatch agents or open the real sessions here. The scoped complaint and verified paths satisfy intake and locate. At triage, I would first read the reported region myself under the context-safety rules, then run all seven analysts. The complaint determines which region I inspect first and which findings lead the report; it does not remove dimensions.

For each analyst, call `spawn_agent` with `agent_type` omitted, `model: "gpt-6-sol"`, `reasoning_effort: "medium"`, and `fork_turns: "none"`. The task message must contain the **full text**, not just filenames, of `/Volumes/Workspace/Development/Codex/worktrees/upstream-v6-4-2/superpowers/skills/diagnosing-superpowers/prompts/analyst-common.md` and that analyst's dimension prompt from the same directory. It must also name the verified absolute CASE path, every relevant absolute session and subagent-transcript path and session ID, and an explicit assigned RANGE if the dimension is split by turns. It must forbid further subagents and require `path:line` for every finding. I would use a fresh generic agent for every dimension; none of `sp_implementer`, `sp_implementer_deep`, `sp_reviewer`, or `sp_topic_context` fits the diagnostic role.

With only two free slots, dispatch in these batches, advancing as workers finish:

1. `skill-timeline.md` and `plan-adherence.md`
2. `repeated-work.md` and `stumbles.md`
3. `quality-evidence.md` and `request-conflicts.md`
4. `cost-and-time.md`

The order can prioritize the dimension matching the complaint, while retaining all seven. If fewer than two slots are free at any point, use only the free capacity; if none is free, wait for an existing worker instead of making a failing spawn call. Do not reduce the prompt or analysis depth to fit capacity. Discard returned findings lacking `path:line` and check what each citation proves.

For a later **authorized** bundle scrub, after the requested redaction level and exact bundle inputs are known, dispatch a fresh generic agent with `agent_type` omitted, `model: "gpt-6-sol"`, `reasoning_effort: "medium"`, `fork_turns: "none"`. Supply the full `prompts/scrub.md`, redaction policy, exact bundle-copy paths and source-session paths. Forbid subagents and editing source sessions; permit edits only to authorized bundle copies. After that pass finishes, dispatch a **different fresh generic** read-only auditor with the full `prompts/scrub-audit.md`, the same policy, and exact bundle inputs, using `gpt-6-astra`/`medium` and `fork_turns: "none"`. Repeat scrub and independent audit until CLEAN, subject to available slots. No archive or external issue/comment bypasses its separate approval gate.
