# Gamarsoft and upstream v6.4.2 comparison

Date: 2026-09-28. Status: analysis and recommended integration decisions. This document does not authorize execution or claim that a merged candidate has passed verification.

## Recommendation

Merge the pinned upstream release into a branch based on Gamarsoft. Use upstream for platform support and helper fixes, retain the fork's delivery and frontend contracts, and reconcile the overlapping workflow policies explicitly.

The fork already incorporated several ideas released in v6.3.0. Its September delivery redesign names specification traceability, batching, recorded rulings, event-driven waits, and safe cleanup as adopted upstream ideas. Replacing those files with upstream would discard subsequent fork work without necessarily buying new behavior.

The most useful new workflow additions are the overlooked-input review scan, concise plan self-review, an explicitly selectable inline executor, and session diagnosis. The strongest reasons to preserve fork behavior are risk-scaled review, bounded correction loops, exact-revision finishing evidence, pinned agent roles, and approved frontend packet identity.

## Verified comparison boundary

| Item | Revision or result |
| --- | --- |
| Gamarsoft branch and remote branch | `410d0fc3516e6c67931fd9de5642f7f6363fc7a4` |
| Upstream v6.4.2 and remote main | `8ca22dba9a94f28898bbce59f2537ff4d87c747d` |
| v6.2.0 release commit | `3dcbd5c4b48e02263fbf4a3c01e3fe4f81d584d9` |
| Actual common ancestor | `44c9b2d6e889982ac18c27d05a19fefe335194e1` |
| Difference between v6.2.0 and common ancestor | One README-only commit removing the hiring section |
| Upstream release delta | 100 paths, 8,535 insertions, 539 deletions |
| Fork delta from common ancestor | 1,096 paths, including extensive design and evaluation artifacts |
| Paths changed by both histories | 25 |
| Paths with textual merge conflicts | 19 |
| Paths changed upstream only | 75 |
| Active skill entrypoints | Fork 26; upstream 15; combined proposed inventory 27 |

Both remote tips were checked with `git ls-remote`. Annotated tag object IDs differ from their release commits; all comparisons use peeled commits. Upstream has three release commits after the common ancestor: v6.3.0, v6.4.1, and v6.4.2. There was no shipped v6.4.0.

The merge preview used `git merge-tree --write-tree --name-only` with a temporary object directory and the repository's objects as read-only alternates. It did not change the current branch, index, working files, or repository refs. [Inventory](/Users/gamarsoft/.codex/superpowers/docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/inventory.json) and [raw merge preview](/Users/gamarsoft/.codex/superpowers/docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/merge-preview.txt) preserve the results. The [file decision table](/Users/gamarsoft/.codex/superpowers/docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/file-decisions.md) assigns all 100 upstream paths to the proposed merge plan.

## What upstream released

| Release | Main changes | Relevance to this fork |
| --- | --- | --- |
| v6.3.0, August 12 | Spike/bounded/architectural brainstorming; SDD batching and autonomous rulings; Codex dispatch/wait corrections; safer worktree cleanup; Devin and Hermes support | Many execution-efficiency changes already have fork equivalents. Brainstorming's artifact shortcuts remain a real policy difference. |
| v6.4.1, September 18 | Session diagnosis; substantial inline executor; review of unnamed inputs; complete-suite TDD guidance; workspace collision and review-range guards; OpenCode V2, Muse, Qwen install guidance; interpreter-based script calls | Contains the largest set of useful new changes and several direct conflicts with fork execution ownership. |
| v6.4.2, September 25 | Plans focus on signatures, exact values and assertions; proportion self-check; removal of unused plan reviewer; canonical AGENTS.md without CLAUDE.md | The fork already writes contract-oriented plans and removed the unused reviewer. Adopt the additional concision check and contributor-file migration. |

Sources: upstream [v6.3.0 release](https://github.com/obra/superpowers/releases/tag/v6.3.0), [v6.4.1 release](https://github.com/obra/superpowers/releases/tag/v6.4.1), [v6.4.2 release](https://github.com/obra/superpowers/releases/tag/v6.4.2), and exact file diffs from the pinned commits. Upstream's reported cost and quality measurements describe its evaluation setups; they are not measurements of the proposed fork integration.

## Workflow decisions

| Area | Upstream v6.4.2 | Current Gamarsoft | Recommended combined behavior |
| --- | --- | --- | --- |
| Understanding intent | Reflect purpose, constraints and success; avoid repeating already answered questions | Context gathering, reflection, five problem tracks, guided discovery | Retain fork tracks; adopt upstream's explicit reuse of supplied intent. Avoid adding another confirmation for information already established. |
| Small changes | Bounded path uses an approved in-chat design, no saved spec or plan | Lite track retains a short reviewed spec and one delivery adapter | Retain the written-spec path for this merge, as selected by the user on 2026-09-28. Evaluate the in-chat shortcut separately. |
| Feasibility spikes | Approved question/probe; throwaway output; no design file | No equivalent explicit exception in brainstorming's general artifact gates | Recognize answer-only investigations explicitly. Any future throwaway-code exception must name its stop boundary; retaining prototype code re-enters normal delivery. Do not bundle a broad bypass into this merge. |
| Delivery routing | Primarily Superpowers, with subagent or inline execution | One confirmed GSD, Superpowers, or Native Codex route | Retain fork routing. Execution inside Superpowers is a separate decision from choosing a workflow family. |
| Plan content | Compact signatures, assertions and exact spec values; proportion check | Outcome-oriented contracts, approved spec revision, dependencies, risk, ownership, verification lanes | Keep the fork template. Add a proportion check and remove duplicated mechanics, preserving concrete contracts. Do not restore code/test bodies or repeated five-step scripts. |
| Missed inputs | Review Focus records likely overlooked input classes and assigns tests | Boundary cases and invariants are required, but no single equivalent named scan | Add one compact Review Focus section, up to five meaningful cases. Map each to an owning task and test. Empty means examined and none found. Avoid duplicating existing cases. |
| Plan readiness | Author self-review and human review of saved plan | Author self-review; one independent readiness review for named risks | Retain risk-based readiness. Expose the saved plan before execution, while respecting any execution authorization already supplied. |
| SDD cadence | Combined task reviews, batching for small similar tasks, five-round circuit breaker | Risk-required units reviewed individually; ordinary units share checkpoints; two corrections per gate | Retain fork cadence and correction limit. Port only improvements absent from the fork. |
| Inline execution | First-class alternative, current session implements; one final independent review when possible | No-agent fallback or explicit plan override already supports controller execution and optional final reviewer | Make the existing override visible as an explicit inline choice. Keep fork plan, risk, report and correction contracts. SDD stays the default for risk-bearing or coupled work. |
| Reviewer authority | Reasonable user expectation is itself a requirement when the spec is silent | Proven contract/safety defects block; product decisions go to user; adjacent improvements are follow-ups | Adopt the search for unnamed failures, not unrestricted requirement creation. A concrete crash or safety failure gets evidence-based disposition; ambiguous new behavior remains DECISION. |
| Review coverage | A Declined to judge list makes omissions visible | Shared review method, coverage evidence, specialist profiles, structured dispositions | Record considered-but-excluded behavior through the existing disposition/coverage table. Avoid a second competing verdict format. |
| Test ownership | Project suite defines green even when a task names one file | Focused tests and integration during execution; sole complete-suite owner is finishing | Keep one full-suite owner for planned delivery; explicitly report every observed failure. Standalone changes still need the applicable project suite before completion. Focused green cannot be called full-suite green. |
| Completion | Upstream executor removes workspace before finishing | Exact Implementation HEAD, producer-return recovery, durable report-only commit, cleanup after successful integration | Retain fork completion. Deleting the ledger earlier would break its recovery and evidence contract. |
| Models and lifecycle | Generic model tiers, explicit spawn settings, event-driven waits; optional nested Claude controller | Four pinned roles, generic fallback with complete prompts, fresh context, event waits | Retain source and installed role pins. Use the active API over upstream examples. Do not import nested orchestration by default. |
| Frontend and mobile | General brainstorming companion | Dedicated frontend phase, bounded exploration, canonical packet/hashes, runtime comparison, mobile and UX guidance | Preserve fork behavior. Upstream has no replacement for these contracts. Apply shell-launch portability fixes without replacing the visual workflow. |
| Session diagnosis | New read-only, transcript-evidenced skill with seven analysis dimensions and gated export | No Superpowers equivalent | Adopt as an explicitly invoked diagnostic. Preserve evidence and export rules, wire local model policy and Codex metadata, and schedule analysts within available slots. Do not invoke it routinely on successful work. |

Key fork sources: [delivery routing](/Users/gamarsoft/.codex/superpowers/skills/brainstorming/references/delivery-routing.md), [planning](/Users/gamarsoft/.codex/superpowers/skills/writing-plans/SKILL.md), [execution](/Users/gamarsoft/.codex/superpowers/skills/subagent-driven-development/SKILL.md), [inline override](/Users/gamarsoft/.codex/superpowers/skills/executing-plans/SKILL.md), [finishing](/Users/gamarsoft/.codex/superpowers/skills/finishing-a-development-branch/SKILL.md), and [frontend packet finalization](/Users/gamarsoft/.codex/superpowers/skills/frontend-direction/references/packet-finalization.md).

### Why retain the fork's execution structure

This recommendation has a concrete basis. The [September delivery specification](/Users/gamarsoft/.codex/superpowers/docs/superpowers/specs/2026-09-04--lean-risk-scaled-superpowers-delivery.md) describes the real session that motivated the redesign: overlapping review ownership, repeated waits, late cross-task conflicts and expensive correction loops. The fork deliberately assigned one owner to each stage and bounded correction rounds.

The [paired finishing evaluation](/Users/gamarsoft/.codex/superpowers/tests/codex/sdd-behavior/results/lean-risk-scaled/runs/candidate-final-r4-paired/summary.md) records 5/5 candidate versus 0/5 baseline on return identity and correction-count preservation. The [review-depth evaluation](/Users/gamarsoft/.codex/superpowers/tests/codex/sdd-behavior/review-depth/RESULTS.md) supports improved coverage and evidence handling while explicitly avoiding a general defect-detection claim. These are narrow recorded results, not proof that every fork choice is better.

The cost of retention is continuing to maintain a forked workflow architecture. Upstream's shorter path genuinely removes work for small changes. That deserves its own comparison with the current lite track, using task completion, missed requirements, user interruptions and cost as outcomes. It should not be inferred from line count alone.

### Keep the two meanings of Native separate

The fork's Native Codex route produces an inline plan using Codex plan mode and avoids Superpowers execution state. Upstream's Native execution runs a saved Superpowers plan with a ledger through `executing-plans`. They are different routes.

Use the name **Superpowers inline execution** for the latter. It can be selected explicitly without removing SDD or manufacturing a fourth delivery family. If tools expose no independent reviewer, report that limitation honestly. Existing explicit execution choices survive the merge.

## Helper experiments

Unmodified scripts from both pinned revisions were copied into disposable Git fixtures. These were behavioral probes, not source-text assertions. The stripped-mode probes changed the copied files to mode 0644 and invoked entrypoints through `bash`.

| Probe | Fork | Upstream | Integration decision |
| --- | --- | --- | --- |
| `docs/alpha/plan.md` and `docs/beta/plan.md` | Both resolve to `plan` | Distinct `plan` and `plan-beta` workspaces | Adopt ownership markers and collision handling. |
| Review package for `HEAD..HEAD` | Accepted, exit 0 | Rejected, exit 3 | Add non-empty range guard while preserving fork's clean-tree/current-HEAD checks. |
| Task brief with stripped helper executable bits | Permission denied, exit 126 | Works | Apply upstream interpreter calls throughout fork helpers and instructions. |
| New inline `task-start` and `task-done` with stripped helper bits | Absent | Both fail, exit 126 | Correct their internal direct calls before adoption; cover both with behavioral tests. |

Evidence: [helper probe results](/Users/gamarsoft/.codex/superpowers/docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/helper-probes.json). Each fixture used real commits, committed plan files, a clean worktree and local fsmonitor disabled. Temporary fixtures were removed afterward.

Additional compatibility details:

- Keep the fork's multi-task `task-brief` argument contract, ordered extraction and duplicate-task checks. Upstream's version accepts one task and would regress batching.
- Keep the fork's commit-type resolution, requested HEAD identity and clean-tree checks in `review-package`. Adopt upstream's empty-range rejection. Standardize empty/non-descendant ranges on exit 3 and retain exit 2 for invalid input and state; update both sets of tests deliberately.
- Preserve the new workspace marker on ordinary resumes. A legacy markerless workspace may be adopted only after checking the existing ledger's plan identity. Upstream explicitly acknowledges that first use can otherwise claim an old colliding workspace.
- Native helpers can supply briefs and test logs, but a generic `Task N: complete` line cannot replace the fork's risk, disposition, correction, review and finishing records.

## Platform, packaging and additive content

Adopt OpenCode V1/V2 support together with root `index.js`, registration/session tests and install documentation. Adopt Devin, Hermes and Muse manifests/bootstrap support, the Hermes version-bump wiring, Qwen/Grok install guidance, Windows graph-rendering fix, and interpreter invocations. Test maintained platform entrypoints before claiming support in the fork.

Make `AGENTS.md` the real contributor file and remove `CLAUDE.md`, as upstream does. Preserve the supplied Gamarsoft model/RTK instructions in their owning configuration; do not mistake the injected user-level instructions for text that exists in the repository symlink. Retain fork-specific ignore rules and add upstream Python ignores.

Preserve deterministic Codex ZIP timestamp handling, native `hooks: {}`, the role-free package fallback, and custom skill metadata. The new diagnosing skill has no checked-in `agents/openai.yaml` upstream. Packaging therefore needs source-owned metadata or a verified updated metadata seed; an old seed will lack the new skill. Existing tests synthesize metadata for every directory and alone cannot prove a real seed is complete.

The sync script adds exclusions for Devin and root `index.js`; audit new Hermes/Muse directories against its destination layout too. The portal packaging script uses an explicit allowlist and has a different contract. Do not confuse their test coverage or invoke a publishing sync during local verification.

The 12 fork-only skill entrypoints to preserve are `auditing-ai-generated-code`, `context7-research`, `frontend-direction`, `gathering-topic-context`, `implementing-frontend-design`, four `mobile-*` skills, `using-feature-branches-with-submodules`, `webapp-testing`, and `writing-ux-copy`. Retain their references, scripts, tests and metadata, plus GSD documentation and workflow-family isolation. Upstream adds only `diagnosing-superpowers` to the active skill inventory. The unshipped movie skill is outside this merge.

All four checked-in Codex role files currently match their installed counterparts byte-for-byte. Retain Sol/medium, Sol/xhigh, Astra/medium and Luna/high. The [routing evaluation](/Users/gamarsoft/.codex/superpowers/tests/codex/model-routing/README.md) distinguishes earlier Astra deep-role samples from the later Sol/xhigh preference; do not reuse the former as proof of the latter's quality.

## Text conflicts and semantic checks

| Conflicted paths | Resolution basis |
| --- | --- |
| `README.md`, `RELEASE-NOTES.md` | Combine upstream releases/platforms with an explicit fork workflow description. Preserve historical records. |
| `skills/brainstorming/SKILL.md`, `visual-companion.md` | Fork design/delivery authority, upstream intent and launcher improvements; bounded shortcut follows the decision above. |
| `skills/executing-plans/SKILL.md` | Fork executor contract with explicit inline selection and compatible upstream helper use. |
| `skills/finishing-a-development-branch/SKILL.md` | Fork exact-revision evidence/recovery; preserve safe cleanup already present. Use host-managed archival where available. |
| `skills/requesting-code-review/SKILL.md`, `code-reviewer.md` | Fork dispositions/coverage; add unnamed-input reasoning and omissions; use recorded base or correct merge-base. |
| `skills/subagent-driven-development/SKILL.md`, `implementer-prompt.md`, `re-review-prompt.md`, `task-reviewer-prompt.md` | Fork risk cadence, model roles and two-round corrections; fold in missing upstream mechanics without a second review system. |
| SDD `scripts/review-package`, `scripts/task-brief` | Fork API/checks plus upstream empty-range and interpreter fixes. |
| `skills/using-superpowers/SKILL.md`, `references/codex-tools.md` | Fork isolation and role policy plus compatible harness references; current API is authoritative. |
| `skills/writing-plans/SKILL.md` | Fork contract format plus Review Focus and concision self-review. |
| `tests/claude-code/run-skill-tests.sh`, `test-sdd-workspace.sh` | Union maintained tests and assert the chosen contracts, including new helper cases. |

Six paths changed on both sides without textual conflicts: `.gitignore`, `docs/README.opencode.md`, `docs/testing.md`, TDD's `SKILL.md`, writing-skills' `SKILL.md`, and the deleted `plan-document-reviewer-prompt.md`. Inspect all six. In particular, the TDD addition contradicts fork full-suite ownership; Git's success does not resolve that policy.

Other automatic additions also need integration review: diagnosis metadata, inline helper portability, workspace legacy adoption, harness bootstrap mappings and version metadata. Preserve the deletion of the old plan reviewer, which both histories removed; the fork's active readiness reviewer is a different file.

## Strategy and confirmed choice

| Strategy | Trade-off | Judgment |
| --- | --- | --- |
| Real merge with subsystem resolutions | Records upstream ancestry, keeps history, requires explicit reconciliation | Recommended. The 19 conflict paths are identifiable and concentrated. |
| Cherry-pick selected release commits/patches | Easy to omit useful tests or duplicate earlier backports; does not fully record upstream integration | Useful only for isolated urgent fixes, not this update. |
| Reset to upstream and reapply customizations | Starts clean but reconstructs a large, evaluated fork and risks losing behavior | Too much avoidable migration risk. |

The user confirmed on 2026-09-28 that this integration retains the written-spec path. Evaluate an in-chat-only bounded-change shortcut separately. Inline execution is already possible through an explicit plan override, so exposing it does not require abandoning fork guarantees.

See the [proposed merge plan](/Users/gamarsoft/.codex/superpowers/docs/superpowers/analysis/2026-09-28-upstream-v6.4.2/merge-plan.md) for file ownership, order and verification. No implementation, merge commit, full test campaign, publishing or installed-skill update has been performed by this analysis.
