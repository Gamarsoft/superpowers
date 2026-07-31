# Origin Main Integration Specification

## Objective

Integrate `origin/main` at `44c9b2d6e889982ac18c27d05a19fefe335194e1`
into the Gamarsoft customization line at
`dacda7bda73f3b7b287e9af80d760e720665b4c6`, preserving the valuable behavior
from both histories and leaving the original branch untouched.

## Source facts

- Both histories descend from the `v5.0.6` commit `eafe962`.
- The custom line contains 35 commits after the common ancestor.
- Upstream contains 273 commits after the common ancestor: v6.2.0 plus one
  README-only commit.
- A synthetic merge produced 26 textual conflicts across 32 overlapping paths.
- The original branch is published at
  `gamarsoft/feature/brainstorming-frontend-direction`.
- Work occurs on `codex/integrate-origin-main` in an isolated worktree.

## Required outcomes

### Visual companion runtime

- Use upstream authentication, path containment, security headers, WebSocket
  origin checks, payload bounds, restart persistence, safe shutdown, and
  lifecycle behavior as the runtime foundation.
- Preserve the custom comparison-first UI, authored selection semantics,
  polling fallback, carry-forward contract, fragment/full-document behavior,
  and GSD handoff material.
- Run both upstream security/lifecycle tests and every custom companion test.

### Subagent-driven development

- Use upstream plan-scoped workspaces, task briefs, review packages, durable
  ledger, resumable fix loop, scoped re-review, circuit breaker, and broad final
  review.
- Preserve typed Codex roles, Context7 findings handoff, codebase-vs-plan
  escalation, concern statuses, and applicable Java/Spring/GKE review depth.
- Prefer the upstream combined per-task reviewer architecture; do not restore
  the legacy two-independent-reviewer lifecycle.

### Planning, review, and bootstrap policy

- Preserve workflow-family isolation and the custom product/frontend/mobile
  skill family.
- Preserve acceptance-criteria/interfaces-based planning, cross-task
  invariants, boundary cases, and whole-feature verification.
- Import upstream task right-sizing and concise, harness-neutral guidance
  without restoring implementation bodies in plans.
- Repair the reviewer placeholder contract while retaining specialized review
  checklists and typed Codex dispatch.

### Platform, worktree, and packaging behavior

- Adopt upstream Codex marketplace manifests, deterministic packaging, native
  no-hook behavior, worktree detection, provenance cleanup, and explicit-only
  discard flow.
- Preserve `.codex/agents/*.toml`, multi-agent configuration, GSD ignore rules,
  and the submodule-oriented feature-branch skill.
- Remove orphaned Codex hook wiring, generated `.superpowers/brainstorm`
  artifacts, and stale standalone Codex installation instructions.

### Additive custom content

- Retain all custom frontend, mobile, UX copy, Context7, audit, webapp testing,
  prompt-pack, plan-refinement, topic-context, and GSD materials unless a test
  demonstrates an incompatibility.

## Invariants

- No generated runtime state or authentication secret is tracked.
- An unauthenticated client cannot read screens or submit choice events.
- Custom UI guidance remains free of the removed Pencil workflow.
- Superpowers and GSD remain separate workflow families unless explicitly
  combined by the user.
- Reviewers remain read-only and make evidence-backed findings.
- Existing published history is not rebased or force-pushed.
- The integration branch is not considered ready while any required test or
  Critical/Important review finding remains open.

## Known baseline condition

Before integration, the main companion suite passed 26/26 and all runtime,
WebSocket, carry-forward, contract, and lifecycle suites passed. One unwired
static assertion in `helper-selection-clarity.test.js` failed because the exact
default-selection sentence is split across an HTML newline even though the
rendered text and helper constant agree. The integrated test runner must include
this test and remove that representation-sensitive failure.

## Non-goals

- Rewriting the custom additive skills for upstream style alone.
- Importing every upstream harness into active use when it does not affect the
  shared package.
- Reintroducing Pencil artifacts.
- Rewriting the existing custom commit history.

## Acceptance

The result is acceptable when the merge records current `origin/main` as an
ancestor, the original branch remains unchanged, no conflict markers or stale
references remain, combined deterministic tests pass, the Codex package tests
pass, security behavior is exercised at runtime, and the final diff preserves
the custom skill inventory and policies named above.
