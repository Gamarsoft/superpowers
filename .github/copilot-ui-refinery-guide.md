# Copilot UI Refinery guide

## What this pack is for

Use this pack when:
- a first raw implementation pass already exists
- you want a stronger design-oriented refinement pass in VS Code Copilot outside GSD
- the best available contract may be:
  - a frontend direction packet,
  - only an approved spec plus GSD handoff,
  - or only the existing source code and rendered UI

This pack gives you:
- one main custom agent: `ui-refinery`
- specialist subagents
- one optional prompt file: `Refine UI Pass`

## Install

Copy these files into your repo:

- `.github/agents/*.agent.md`
- optional: `.github/prompts/refine-ui-pass.prompt.md`

Keep your existing skills like `gsd-frontend-design`, `frontend-direction`, and any Impeccable-derived skills in project skill folders such as `.github/skills` or `.agents/skills` so Copilot can discover them.

## Contract modes

The main agent now works in three modes.

### 1. Packet-backed mode
Use when a frontend direction packet exists.

Best for the highest-fidelity refinement.

### 2. Spec-and-handoff-backed mode
Use when there is no packet, but you still have an approved spec and GSD handoff.

The main agent derives a conservative working UI contract from:
- the spec and handoff
- retained screenshots, browser captures, or approved generated-image references when present
- the existing product UI and shared design system

This is good for improving a raw implementation without inventing a new direction.

### 3. Source-code-backed mode
Use when there is no packet and no strong planning artifact, but the existing source code and rendered UI exist.

The agent then treats the current product language as the primary design contract and focuses on:
- clarity
- consistency
- hierarchy
- responsiveness
- copy and state quality
- system fit

This mode is intentionally conservative.

## Recommended prerequisites

### 1. Keep these skills installed and discoverable

At minimum:
- `gsd-frontend-design`
- `frontend-direction`
- `brainstorming`

For stronger refinement, also keep the Impeccable-derived skills available.

### 2. Enable browser tools

Browser tools are most useful when the app can run locally and the agent can inspect the rendered UI.

### 3. Enable askQuestions

The main agent never stops by itself. After each round it should ask whether to continue or stop.

### 4. Ensure subagents are available

The main agent uses subagents heavily for critique, packet guarding, browser verification, and polish.

## How the flow works

### Phase 1 — recover the active contract

The main agent:
1. reads the best available inputs
2. launches `ui-packet-guardian`
3. identifies one contract mode
4. asks clarifying questions if confidence is too low

### Phase 2 — parallel critique

The main agent then dispatches subagents:
- `ui-packet-guardian` — contract reconstruction and drift checks
- `ui-ux-critic` — hierarchy, IA, cognitive load
- `ui-visual-refiner` — spacing, typography, color, simplification
- `ui-robustness-refiner` — copy, edge cases, onboarding, responsive behavior
- `ui-system-guardian` — design-system consistency, a11y, performance, extraction
- `ui-motion-delight` — tasteful motion and delight, only after the basics are solid
- `ui-browser-verifier` — rendered verification in the integrated browser

### Phase 3 — one bounded edit batch

The main agent consolidates findings into a small, high-impact edit plan, applies one round of changes, and verifies again.

### Phase 4 — human checkpoint

The main agent must not stop by itself. It asks whether to:
- continue refining
- stop here
- try a stronger alternate direction
- create or refresh a frontend direction packet first

## Recommended usage patterns

### Pattern A — packet-backed polish

Example start prompt:

> Use ui-refinery for the billing settings flow. Read the spec, GSD handoff, and frontend packet first. The current UI works but feels flat and slightly cluttered. Aim for a subtle, higher-quality polish. After one round, ask me whether to continue.

### Pattern B — spec and handoff only

Example start prompt:

> Use ui-refinery for the analytics detail page. There is no frontend packet yet, but the approved spec and GSD handoff exist. Derive a conservative working direction from those plus the current product UI, then refine the implementation without inventing a new visual language. After one round, ask whether to continue.

### Pattern C — source code only rescue pass

Example start prompt:

> Use ui-refinery for the onboarding flow. There is no frontend packet and no strong planning artifact. Use the current source code, shared components, and rendered UI as the working contract. Focus on clarity, consistency, responsiveness, and states. After one round, ask whether to continue.

### Pattern D — browser-led refinement

Example start prompt:

> Use ui-refinery for the dashboard overview route. Start the app if needed, verify the current implementation in the integrated browser, derive the strongest available working contract, then refine the implementation. After one round, ask whether to continue.

### Pattern E — packet refresh needed

Example start prompt:

> Use ui-refinery for the analytics detail page. First tell me whether the current UI can be polished within the available contract or whether it now needs a frontend-direction refresh. If the contract is too weak, stop and ask me whether to switch to frontend-direction.

## Important behavioral boundaries

- This pack is for **refinement after implementation**, not initial product discovery.
- The main agent should honor the strongest available contract.
- When no packet exists, the main agent should stay conservative and preserve the existing brownfield design language.
- If a better result requires new visual direction rather than refinement, the main agent should say so explicitly and ask whether to switch to `frontend-direction`.
