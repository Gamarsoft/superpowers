---
name: integrating-superpowers-upstream
description: Use when comparing a new obra/superpowers release with the Gamarsoft Superpowers fork, selectively integrating upstream changes, or revisiting deferred release decisions in this repository.
---

# Integrating Superpowers Upstream

Improve this fork through selective adoption. Git ancestry, release versions, and adopted behavior are separate facts. Keep a durable decision record so the next release starts from evidence.

This is a repository maintenance skill, scoped to the Gamarsoft fork. Confirm repository identity through remote URLs; discover remote names rather than assuming `origin` is the fork.

## Establish the request

| Request | Deliverable |
| --- | --- |
| Compare, assess, recommend | Pinned comparison, per-path decisions, and a concrete integration proposal awaiting approval |
| Integrate selected changes | Present the concrete proposal first; apply it only after explicit user approval |
| Merge, push, publish | Only the explicitly authorized destination and operation |

Proceed with assessment and proposal preparation. Preserve unrelated edits. Read referenced chats with `read_thread` when available, then verify their claims against repository artifacts.

## Assess

Read [release-workflow.md](references/release-workflow.md) for source locations, inventory mechanics, and integration checks.

1. Pin fork HEAD, verified upstream tag and peeled commit, last assessed release, last integration, and actual merge bases. Read previous comparison/decisions/report plus subsequent fork changes. Carry unresolved dispositions forward; an ancestry-only merge cannot close them.
2. Compare the complete release delta and current fork behavior. Cover renames, deletions, clean merges, and fork-only callers of moved files. Inspect source before judging release-note claims. Preserve current contracts, including newer frontend and role changes; old reports are context, not permanent policy.
3. Record each changed path's **adopt / adapt / already-present / defer / reject** decision, evidence, dependencies, and verification. Group related decisions for the human summary, keeping exhaustive coverage in the ledger. Identify genuine benefits and tradeoffs; do not rank by patch-version size or text-conflict count.
4. For every proposed behavior-shaping edit, include a **before/after evaluation plan**: frozen baseline and candidate sources, realistic cases, criteria, fresh runs, and limits. Use `skill-creator` and `superpowers:writing-skills` when authoring it. Five cases in one session are one run; upstream results and structural tests do not demonstrate fork improvement. If baseline already passes, record clarification or preservation rather than inventing a failure.

## Present the proposal and wait

Always present a concrete integration proposal based on the recommendations **before applying upstream changes**, then ask for and wait for the user's explicit approval of that proposal. Follow the [proposal contract](references/release-workflow.md#integration-proposal-and-approval). An initial “integrate the recommended changes” request does not approve a proposal the user has not seen.

Record the proposal revision and approving user message. Approval of that same unchanged proposal remains valid on resume. Material additions or changed release inputs require a revised proposal and explicit approval before the changed work; unaffected approved work may continue.

While approval is pending, inspection, isolated non-applying previews/probes, and assessment/proposal artifacts are permitted. Applying candidate edits, staging patches, or integrating on a draft branch/worktree must wait. Silence, elapsed time, sandbox permission and teammate advice are not proposal approval.

## Integrate the approved proposal

Freeze the selected scope and current workflow instructions before changing skills that govern this session. Reuse the authorized checkout/branch arrangement. Preserve upstream ancestry with a real merge when that is the agreed strategy, resolving every path by its decision and testing the combined fork behavior. Reference extraction requires checking readers, scripts and packaging together.

Finish with exact tested revisions, actual results and skips, remaining deferrals, and the integration/report identities. Preserve assessment versus adoption status distinctly. Publication is a separate operation governed by the request and repository contribution rules.

## Common mistakes

| Shortcut | Correction |
| --- | --- |
| “Clean merge / patch release means safe” | Inspect semantic differences and dependency closure. |
| “Version or merge-base proves adoption” | Reconcile content with the decision ledger. |
| “Checks passed, so wording improved” | Report measured behavior and limitations separately. |
| “The user already said integrate” | Present the concrete proposal and obtain its explicit approval first. |
