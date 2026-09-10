# Resume the approved frontend-direction rework

Paused at the user's request on 2026-09-11 so work can continue in Codex Desktop with the in-app browser. Do not resume automatically until the user asks.

## Authorization and objective

The user approved [the complete design specification](../specs/2026-09-10--frontend-direction-visual-exploration.md) and explicitly selected the Superpowers delivery route. Do not ask for either approval again.

Implement the specification using `skill-creator` and `superpowers:writing-skills`, both explicitly required by the user. It is a behavioral skill rework, not prose cleanup. The agreed defaults are:

- Preserve the established brand and app shell while reconsidering feature layout, hierarchy, density, and interactions.
- Generate three actual image concepts, refine the selected direction, then build and iterate an interactive high-fidelity browser prototype.
- Support standalone screen improvement with a short brief inside frontend-direction, without requiring full brainstorming or a pre-existing spec.
- Retire ChatGPT image upload-pack authoring; preserve consumption of existing approved images and packets.
- Replace the broad `gsd-frontend-design` skill with focused `implementing-frontend-design`; migrate known callers, no duplicate alias. Old explicit invocations require migration.
- Use optional project-local Impeccable for appropriate critique/audit/refinement, retaining approved-target authority and the full core workflow when unavailable.
- Preserve approved visual evidence through implementation and runtime verification.

The spec passed independent review, including migration trade-offs and optional Impeccable integration. Reviewer `visual_spec_review` returned READY. Earlier finding SR-01 requested migration alternatives and was resolved. No supported findings remain.

## Workspace state

- Repository: `/Users/gamarsoft/.codex/superpowers`.
- Current branch: `feat/frontend-direction-visual-exploration`.
- Base HEAD: `4355ee8428146481235ddcac1bc604815102975a`.
- Branch was created from `gamarsoft`; it is a normal checkout, not a linked worktree.
- No skill instructions or application code have been edited. No commits have been made for this work.
- The specification and this handoff are untracked task-owned documents. Do not mistake them for unrelated changes.
- `/Users/gamarsoft/.codex/skills/superpowers` is a symlink to this repository's `skills/`; edits here affect the installed skills. Isolate behavior-test inputs so actors do not read partially changed instructions.
- Git metadata writes required escalation; creating the feature branch succeeded on the escalated retry. Follow normal sandbox handling for later Git writes.

## Evaluation state

Persistent local archive: `/Users/gamarsoft/.codex/superpowers/.superpowers/evals/frontend-direction-20260911/`.

It contains:

- `manifest.json`: original base HEAD, scenario SHA-256, actor model/effort, sample count, and limitations.
- `scenario.txt`: realistic standalone legacy customer-loyalty design request with reuse, schedule, and sunk-cost pressure.
- `baseline-skills/`: unchanged snapshots of frontend-direction, creating-chatgpt-image-upload-packs, and gsd-frontend-design, including their resources.
- `control-01.md` through `control-05.md`: five completed fresh-context no-guidance responses from `gpt-5.6-sol`, effort `low`.

Original source directory: `/private/tmp/frontend-direction-evals-20260911`. The manifest retains that original run location; use the persistent archive above on resume. All five control files were verified nonempty. The controller has NOT read or scored them yet. They do NOT yet establish a failing baseline.

These are response-only decision probes, explicitly forbidden from generating images, using a browser, or editing application files. They cannot demonstrate visual quality, tool execution, accessibility, or functioning interactions. Preserve that limitation in every report. Five matched current-skill samples and five candidate samples have not run. Additional pressure/boundary cases and actual forward tests remain necessary as specified.

The five evaluation agents `control_01` through `control_05` finished before the pause. No active agents or tool processes require waiting or interruption. Do not rerun completed samples merely because their agents are unavailable in the new session.

## Next work

1. Read the approved spec and this handoff; check current branch/status without restarting discovery.
2. Complete `writing-plans`: write the durable implementation plan, map requirements/ownership/verification, run required readiness and selected-adapter review, and record those results. No plan or selected-adapter review exists yet; delivery review remains pending in the spec.
3. Read and assess all control responses. Complete matched current-skill baselines BEFORE changing any skill instructions. Use fresh actors without the proposed solution, keep model/effort and scenario fixed, and retain exact outputs. Follow writing-skills' no-guidance control and 5+ samples per wording variant requirements. Use genuine behavioral failures to guide changes.
4. Implement the coupled skill/caller changes through the chosen Superpowers lane with bounded ownership and reviews. Use existing skills' complete role prompts, fresh contexts, and the project's model policy. Do not introduce GSD orchestration.
5. Run the skill creator validator, appropriate focused/regression checks, repeated candidate and independent forward tests. Update obsolete contract tests without substituting keyword compliance for behavior.
6. Run a real DashPark-based visual pilot in Codex Desktop. Inspect current source/runtime before choosing the precise pilot boundary. The customer-loyalty detail experience is the spec's candidate. Generate actual concepts, collect the user's selection, build the selected prototype, and iterate with the browser. The user has NOT selected a concept or approved a pilot prototype yet.
7. Finish only with accurate evidence separating structural checks, behavioral results, actual image/browser proof, and human visual review. No production DashPark redesign, framework upgrade, external publish, push, or upstream PR is implied by the pilot.

## Relevant local findings

The earlier context investigation is complete. Avoid repeating broad searches:

- `skills/frontend-direction/SKILL.md` and `references/design-source-priority.md` prioritize old UI and manual external generation. Templates reinforce preservation and currently require a spec/follow-on.
- `skills/gsd-frontend-design/` has useful reference-intent and runtime/fresh-review gates but an overly broad trigger and legacy-first priority. Preserve the useful checks in the replacement.
- `skills/frontend-direction/references/impeccable-brownfield-quality-layer.md` exists but is not linked from the main skill; its conservative prerequisites conflict with standalone assessment and feature redesign. Rework it as shared conditional integration guidance.
- `skills/writing-plans` and SDD carry generic inputs/outputs but do not explicitly require visual artifact propagation. Make only demonstrated necessary changes.
- Active old implementation-skill callers: `skills/using-superpowers/SKILL.md`, `skills/brainstorming/references/gsd-handoff-template.md`, `.github/agents/ui-refinery.agent.md`, `.github/agents/ui-packet-guardian.agent.md`, `docs/gsd/AGENTS.md`, `docs/gsd/preferences.md`, and current frontend-stack documentation. Also inspect `.github/copilot-ui-refinery-guide.md`.
- Upload-pack authoring has one executable cross-skill caller, in frontend-direction. Current frontend-stack docs and dedicated tests also reference it.
- Packaging discovers top-level skill directories and requires `agents/openai.yaml` for each; update metadata and callers together.
- Relevant tests: `tests/claude-code/test-no-pencil-frontend-policy.sh`, `test-chatgpt-image-pack-detail.sh`, `test-gsd-frontend-visual-review-policy.sh`, `test-brainstorming-artifact-quality.sh`, and their runner. Existing tests include exact-path/text assertions that need principled migration. Keep routing, copy, reference-intent, and independent runtime review protections.
- `tests/codex/sdd-behavior/README.md` offers an existing pattern for immutable behavioral runs and matching model/scenario revisions. Do not confuse its suite with the new frontend evaluation campaign.

## DashPark and Impeccable

Project: `/Volumes/Workspace/Development/SolutionPark/DashPark`. Read its `AGENTS.md` and relevant subproject instructions before project work. It forbids worktrees and has strict Gateway toolchain/LSP verification requirements. The current task does not authorize writing production application changes there.

Impeccable is project-local, not absent:

- `/Volumes/Workspace/Development/SolutionPark/DashPark/.agents/skills/impeccable/SKILL.md`, version 4.3.1.
- Relevant installed playbooks read: `reference/routing.md`, `reference/critique.md`, `reference/audit.md`, `reference/polish.md`.
- Workflow questions do not execute commands. No Impeccable context, critique, audit, or polish command was run in this conversation.
- Critique reviews design/UX and has an independent-assessment protocol; audit reports technical findings; polish edits within scope. Read the installed command contract when actually invoking it.
- Pass the approved target and scoped brand/shell constraints. Do not let normalization restore the legacy layout or let broad redesign rewrite global design context incidentally.

Historical pilot inputs exist under `docs/superpowers/specs/2026-06-26--customer-loyalty-detail-dialog--frontend/` in DashPark, including a screenshot, extraction, and screen index. They were inspected as documentation, not verified against today's live app. No images have been generated and no browser session has started for this task.

## Execution reminders

Use RTK for noisy Git/structure commands, raw `rg`/`cat` for search and contents. Spawn typed custom roles with `fork_turns: "none"`. Follow the configured Astra/Sol mix; generic evaluation actors used Sol/low and must stay matched across the compared variants. Do not infer approval from silence, repeat existing approvals, or claim a source-only inspection as runtime proof.
