# Copilot UI Refinery guide

## What this pack is for

Use this pack when:

- the spec is approved
- the GSD handoff exists
- the frontend direction packet exists
- a first raw implementation pass already exists
- you want a stronger design-oriented refinement pass in VS Code Copilot outside GSD

This pack gives you:

- one main custom agent: `ui-refinery`
- six hidden specialist subagents
- one optional prompt file: `Refine UI Pass`

## Install

Copy these files into your repo:

- `.github/agents/*.agent.md`
- optional: `.github/prompts/refine-ui-pass.prompt.md`

The agent customization docs say workspace custom agents live in `.github/agents`, and skills can be discovered from project skill folders such as `.github/skills` or `.agents/skills`. Your existing skills like `gsd-frontend-design`, `frontend-direction`, and the Impeccable-derived design skills should stay in those skill folders so Copilot can discover them.

## Recommended prerequisites

### 1. Keep these skills installed and discoverable

At minimum:

- `gsd-frontend-design`
- `frontend-direction`
- `brainstorming`

For stronger refinement, also keep the Impeccable-derived skills available.

### 2. Enable browser tools

Browser tools are experimental and need to be enabled. Turn on the integrated browser chat tools and enable the Browser tool group in the chat tools picker. The official guide lists tools such as `openBrowserPage`, `navigatePage`, `readPage`, `screenshotPage`, `clickElement`, and `runPlaywrightCode`.

### 3. Enable askQuestions

The `askQuestions` tool moved into VS Code core and is intended for interactive question carousels. This pack uses it so the main agent always asks whether to stop or continue after each refinement round.

### 4. Ensure subagents are available

The main agent uses subagents heavily. The VS Code subagents docs say subagents are ideal for isolated research or parallel analysis, and that consistent behavior should be defined in the custom agent instructions. They also note that the main agent needs the subagent tool enabled.

## How the flow works

### Phase 1 — recover the design contract

The main agent:

1. reads the approved spec, GSD handoff, frontend packet, and current implementation
2. loads `gsd-frontend-design` if available
3. asks clarifying questions if paths or intent are unclear

### Phase 2 — parallel critique

The main agent then dispatches subagents:

- `ui-packet-guardian` — packet fidelity
- `ui-ux-critic` — hierarchy, IA, cognitive load
- `ui-visual-refiner` — spacing, typography, color, simplification
- `ui-robustness-refiner` — copy, edge cases, onboarding, responsive behavior
- `ui-system-guardian` — design-system consistency, a11y, performance, extraction
- `ui-motion-delight` — tasteful motion and delight, only after the basics are solid
- `ui-browser-verifier` — rendered verification in the integrated browser

### Phase 3 — one bounded edit batch

The main agent consolidates findings into a small, high-impact edit plan, applies one round of changes, and verifies again.

### Phase 4 — human checkpoint

The main agent must not stop by itself. It uses `askQuestions` to ask whether to:

- continue refining
- stop here
- try a stronger alternate direction within the packet
- refresh the packet first

## Recommended usage patterns

### Pattern A — subtle polish

Use when the product is directionally right but still feels rough.

Example start prompt:

> Use ui-refinery for the billing settings flow. Read the approved spec, GSD handoff, and frontend direction packet first. The current UI works but feels flat and slightly cluttered. Aim for a subtle, higher-quality polish. After one round, ask me whether to continue.

### Pattern B — strong but packet-safe redesign

Use when the first pass is technically correct but visually weak.

Example start prompt:

> Use ui-refinery for the dashboard overview route. The current pass honors the packet but still feels generic. Push for a stronger visual hierarchy and a more confident composition without breaking the approved direction. After one round, ask me whether to continue.

### Pattern C — browser-led refinement

Use when the best feedback comes from the rendered app.

Example start prompt:

> Use ui-refinery for the onboarding flow. Start the app if needed, verify the current implementation in the integrated browser, use the browser verifier subagent heavily, and then refine the implementation. After one round, ask whether to continue.

### Pattern D — packet mismatch

Use when the current implementation and packet no longer align cleanly.

Example start prompt:

> Use ui-refinery for the analytics detail page. First tell me whether the current UI can be polished within the existing packet or whether the packet itself needs a refresh. If the packet is too weak, stop and ask me whether to switch to frontend-direction.

## Model choice

I left the custom agent model unset on purpose.

The custom-agents docs allow setting a single model or a fallback array, but model names vary across Copilot plans and enabled providers. Leaving it unset lets you pick your strongest currently available design-oriented model in VS Code, such as Claude Opus or Gemini, without breaking the agent profile if exact model strings differ.

## Important behavioral boundaries

- This pack is for **refinement after implementation**, not initial product discovery.
- The main agent should honor the frontend direction packet.
- If the packet is too weak, the agent should ask to refresh it instead of freelancing.
- Browser tools are powerful but experimental.
- The integrated browser can also add specific elements to chat manually if you want to steer the agent with exact UI context.
