# Gamarsoft and upstream v7.0.0 comparison

Date: 2026-10-13. Status: analysis and recommendations only. No workflow changes or integration have been performed.

## Recommendation

Integrate the release selectively. Adopt the concrete helper and platform fixes. Adapt the improvements to intent discovery, decision ownership, and builder readiness within the fork's existing workflow. Retain conditional research, written specs, separate frontend approval, one confirmed delivery route, and bounded independent review.

V7 addresses a real weakness worth examining in this fork: the process can become more visible than the person's goal. The fork's brainstorming entrypoint is 3,449 whitespace-delimited words and 21 numbered steps, before references. Upstream v6.4.2 was 2,613 words; v7 is 1,724. These counts suggest an opportunity to simplify, but they do not measure session cost or quality. The fork carries responsibilities that upstream does not, so matching upstream's length is not the goal.

The strongest combined direction is open discovery when intent is unknown, evidence-backed choices once the decision is clear, and the fork's durable handoff after approval.

## Verified boundary

| Item | Revision or result |
| --- | --- |
| Current Gamarsoft HEAD | `7d5c52b7e42936c6f186deac892e1c781c1341b6` |
| Upstream v7.0.0 release commit | `bb92a77741419a4ab5f06e711a283343f1ada0c3` |
| Common ancestor, v6.4.2 | `8ca22dba9a94f28898bbce59f2537ff4d87c747d` |
| Release date | October 9, 2026 |
| Upstream delta | 51 paths, 2,219 insertions, 399 deletions |
| Paths changed in both histories | 15 |
| Textual conflicts in merge preview | 8 |

The annotated v7 tag was checked against `git ls-remote origin`; comparisons use its peeled commit. The fork includes the v6.4.2 integration, the subsequent decision-research change, and the role-TOML change. This is a three-way comparison against the actual common ancestor, not a comparison of two stock releases.

The referenced chat, **✅ Compare upstream and fork changes**, was read, including the original written-spec choice and the later research implementation. The earlier choice retained written specs for that integration and deferred the shortcut for separate evaluation. It is a baseline to preserve here, not a permanent prohibition on revisiting the policy.

The merge preview used `git merge-tree --write-tree --name-only` with a temporary object directory and read-only repository object alternates. It did not change refs, the index, or working files. See [inventory](inventory.json), [merge preview](merge-preview.txt), and [all file decisions](file-decisions.md).

## What v7 changes in brainstorming

Upstream changes the sequence to: establish intent through conversation, play it back, size the work, then use either direct action, an in-chat description, or a written design. It offers research after initial grounding, replaces the spec reviewer with a builder's questions, and explicitly asks which making choices the person wants to own. The exact release skill is the authority for these behaviors. [Pinned upstream skill](https://github.com/obra/superpowers/blob/bb92a77741419a4ab5f06e711a283343f1ada0c3/skills/brainstorming/SKILL.md)

| Change | Value and fit for the fork | Recommendation |
| --- | --- | --- |
| Open questions about real moments before menus | High value for fuzzy intent. The fork prefers options and requires the next turn after an open answer to reframe it. Premature options can anchor the user to an incomplete understanding. | Adapt. Ask open questions while intent is genuinely missing; use 2–3 recommended options for concrete trade-offs. Do not require a menu immediately after an answer that still leaves the goal unclear. |
| Prior art, deeper purpose, anti-goals | High value. The fork covers goals, constraints and non-goals, but does not explicitly distinguish an outcome that would feel wrong despite technical success. | Add a compact prompt to discover relevant prior art and unacceptable outcomes. Do not create another mandatory questionnaire. |
| Explicit ownership of platform, language, tools and medium | High value. A default stack can be implementation detail or can change the product itself. Existing-stack preservation alone does not establish the user's platform intent. | Adopt. Record user decisions, agent defaults and delegated choices separately. State consequential defaults before committing the design to them. Reuse choices already supplied. |
| Repeated playback, with guesses attributed | Useful, partly present. The fork already synthesizes every 2–3 turns and presents design sections. | Consolidate. Preserve the why and clearly label inference in those existing checkpoints; do not add a second playback loop or a fixed 200–300-word quota. |
| Size after understanding intent | Useful distinction, but upstream sizes are not equivalent to the fork's five tracks. Brownfield, regression and architecture tracks guide which evidence to inspect. | Keep provisional internal track selection; avoid making the user approve process labels. Finalize scope and artifact depth after intent is sufficiently clear. |
| Generate alternatives privately; show only useful comparisons | Medium value. The fork's mandatory option cards can manufacture alternatives when the choice is already settled. | Adapt with behavioral evaluation. Keep real trade-offs, but avoid inventing a second option simply to fill a template. |
| Builder asks what is still needed to plan | High value as a review lens. The current reviewer already asks whether another agent can proceed with minimal rediscovery, but focuses on contract compliance. | Fold this lens into the existing neutral-artifact review. Resolve answers already in the project, make and label minor delegated decisions, and return product-changing choices to the user. Keep existing dispositions, stage coverage and two-round correction limit. |
| Research offered only with permission | Poor fit. The fork just added conditional research before consequential options, including applicability and source retention. | Retain the fork. Routine relevant inspection stays automatic; optional broad exploration can still be offered. Do not introduce an extra approval before checking evidence needed to answer the request. |
| Small change agreed only in chat | Potential efficiency gain, but directly reopens the earlier deferred choice. | Defer to a separate experiment. Retain the short written spec for shaped changes in this integration. |
| First-message invitation to skip brainstorming, with the gate removed on opt-out | Too broad as a default for the fork. “Skip questions” does not reliably specify which downstream approvals or artifacts the person wants to waive. | Do not import the blanket bypass. Honor explicit instructions and avoid redundant discovery, while keeping the confirmed artifact and delivery contract. |
| Throwaway spikes bypass planning, implementation and review workflows | Useful missing capability, with a retention boundary in v7. The earlier comparison already identified it as a separate policy question. | Defer a narrow spike lane for explicit evaluation: learning question, disposable location, stop condition, no promotion into production without returning to normal approval. Answer-only investigation already needs no implementation handoff. |
| Broader just-in-time visual-companion offer | Mostly already present, with stronger fork protocols and durable frontend packets. | Retain the fork's artifact-first visual turns and separate frontend direction. Borrow concise offer wording only if useful; do not confuse a throwaway mockup with approved implementation evidence. |
| Brainstorming for talks, renovations and other non-software work | Upstream scope expansion is not needed to solve this fork's software workflow. | Keep the fork's focused trigger in this integration. |

Relevant current sources: [guided choices](../../../../skills/brainstorming/references/guided-choice-protocol.md), [research protocol](../../../../skills/brainstorming/references/decision-research.md), [spec reviewer](../../../../skills/brainstorming/spec-document-reviewer-prompt.md), and [delivery routing](../../../../skills/brainstorming/references/delivery-routing.md).

## Preserve the fork's deliberate contracts

The October research design explicitly retained reflection before discovery, one-question cadence, written specs, independent review, bounded corrections, frontend separation and one delivery route. Its wording and exact reference placement are implementation choices. [Approved research design](../../specs/2026-10-01--brainstorming-decision-research.md)

Keep those outcomes while allowing the conversation and internal organization to improve. The five track names and the command to create 21 workflow tasks are not individually established user preferences. V7's motivation supports evaluating a simpler entrypoint, but wholesale restructuring deserves its own before/after evidence.

Do not replace the existing spec reviewer with the upstream 23-line builder prompt. That would remove checks for research provenance, brownfield invariants, frontend packet status, adapter consistency and confirmed routing. Likewise, v7's automatic software handoff to `writing-plans` cannot replace this fork's GSD, Superpowers and Native Codex selection.

The builder lens should run inside the existing reviewer responsibility. It should not add another reviewer, replace independent review with self-review, or silently replace the fork's one-question cadence with a batch of product decisions. An implementation agent may settle HOW within delegated bounds; changing observable WHAT still returns to the human.

Keep the fork's review ownership, exact-revision finishing evidence, role settings, and frontend packet identity. V7 does not introduce a new execution architecture that makes these obsolete. Preserve `task-done`'s distinction between **verification passed** and **task complete**.

## Other changes worth bringing in

| Area | Value | Integration treatment |
| --- | --- | --- |
| Visual-companion literal content insertion | High, directly relevant. Dollar replacement tokens can corrupt a screen and duplicate its frame. | Apply the callback-based replacement and regression test to the fork server; retain all custom companion behavior. |
| Existing SDD `.gitignore` preservation | High. Current helper overwrites repository-owned ignore rules. | Import create-only behavior and the test. |
| Physical path normalization on Git Bash | Useful portability fix. | Import into the helper and tests; retain fork checks that refuse foreign markerless ledgers. |
| Broken-PATH hook bootstrap | High for Claude/Cursor and other hook users; indirect for this Codex setup. | Adopt hook changes and regression tests. |
| Windows hook discovery and exit status | Useful platform correctness and hardening. | Adopt per-user Git discovery, WSL filtering, current-directory exclusion and exit propagation. Require Windows acceptance before claiming Windows validation. |
| Debugging example exposes checked environment values | High, small change. | Import the presence-only commands into the fork's existing skill. |
| Hermes skill descriptions | Useful where Hermes is used; low policy risk. | Adopt description registration and test it against the fork's larger skill inventory. |
| Antigravity native manifest | Useful platform support, low immediate value for Codex-only use. | Import as a complete group with logo, manifest tests, version registration and corrected bootstrap docs. Preserve the fork's Codex packaging exclusions and other manifests. |
| Version-audit false positives and test portability | Small maintenance gain. | Adopt numeric-boundary matching, actual Node binary resolution, non-login test shells and cleanup fixes. |
| Silent successful command in `task-done` | Already solved. | Keep fork implementation and its existing test. Import only relevant portability changes in the upstream test. |
| Code-review example's `$1` substitution bug | Not applicable. The fork removed that example and requires recorded BASE/HEAD. | Keep fork skill; do not restore an inferred review range to gain this upstream fix. |

Release background: [v7.0.0 notes](https://github.com/obra/superpowers/releases/tag/v7.0.0). Decisions above also use exact three-way source diffs, rather than relying only on the notes.

## Evidence and its limits

Focused probes ran in disposable directories using files from the two pinned trees:

| Probe | Current fork | Upstream v7 |
| --- | --- | --- |
| Actual `wrapInFrame` function with literal dollar sequences | Content altered; two headers; placeholder restored | Content preserved; one header; no placeholder |
| Actual hook wrapper with `PATH=/nonexistent` | Exit 127; bootstrap missing | Exit 0; valid bootstrap JSON |
| Actual workspace helper with an existing custom `.gitignore` | Replaced contents with `*` | Preserved contents |

The fragment probe exercised the source function with a controlled frame, not a running browser. The PATH probe exercised the Unix branch. These demonstrate the specific changes, not a complete integrated candidate. [Probe data](probes.json)

The existing fork command `/bin/bash tests/claude-code/test-executing-plans-scripts.sh` passed all 13 assertions, including successful silent verification and stripped executable-bit behavior. [Raw output](fork-executing-plans-tests.txt)

Upstream's initial rebuild reports 115 opening samples, 58 simulated conversations and six blind comparison pairs, with better discovery and all six testers preferring the new flow. Those initial results were on Claude Code, and mid-conversation spike offers were listed as untested. They motivate an experiment here; they do not establish that replacing this fork performs better. [Rebuild and evaluation](https://github.com/obra/superpowers/pull/2463)

The subsequent platform-choice change reports Claude improvements but calls its Codex results inconclusive: many simulated sessions stalled on approvals, and some implemented too early. The opt-out follow-up reports no multi-turn evaluation of its own. [Platform-choice evidence](https://github.com/obra/superpowers/pull/2482), [opt-out follow-up](https://github.com/obra/superpowers/pull/2483)

The separate evaluation-writeup PR was still open when checked on October 13 and is not among the 51 release paths. It describes later cross-harness work and test-driver limitations. Treat this as supplementary evidence, not a shipped test suite. [Evaluation writeup PR](https://github.com/obra/superpowers/pull/2464)

The fork's research evaluations established better retention of source locators, not general live-search quality. They used synthetic sources and older model settings, and one unsupported feasibility inference remained. Preserving the research contract is justified; calling its research quality proven would not be. [Fork evaluation](../2026-10-01-brainstorming-research/evaluation-results.md)

No new behavioral A/B evaluation, complete integration suite, live Hermes/Antigravity session, or Windows runtime test was run for this comparison.

## Suggested integration order

1. Prepare an integration branch from the pinned fork in the base checkout, consistent with the earlier working preference. Preserve v7 ancestry with a real merge once implementation is authorized. The release is one release commit on this ancestry; wholesale cherry-picking would include the conflicting workflow rewrite too.
2. Resolve infrastructure and portability changes first, retaining fork helper semantics and unioning the meaningful tests. Resolve docs to describe the hybrid accurately. Version metadata must be consistent; preserve the custom Muse inventory and fork install instructions.
3. Adapt intent discovery, decision ownership and the builder lens together. Update the entrypoint, guided-choice protocol, question/framing guidance, spec template and existing reviewer consistently. Do not leave contradictory menu-first and open-first rules, or an unused competing reviewer prompt.
4. Evaluate current fork versus the proposed hybrid on current configured Codex roles. Cover hidden intent, fully supplied intent, native-versus-web preferences, existing stack, uncertain or stale research, a short spec retaining citations, UI packet approval, brownfield invariants, delegated HOW, and delivery-route ownership. Measure missed decisions and misleading attribution as well as turns, unnecessary confirmations, time and tokens.
5. Retain written-spec and spike policies for this release. Evaluate any shorter path as a separate policy change with explicit entry and retention boundaries.
6. Run the required complete integration suite against the final candidate and preserve its exact-revision evidence. Run live acceptance for any external harness whose working support is claimed.

The preferred scope is the concrete fixes plus a focused discovery improvement. Importing all of v7's brainstorming policy would discard deliberate fork behavior; preserving every existing discovery sentence would miss the release's most useful lesson.
