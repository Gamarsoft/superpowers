# Delivery Routing

Use this contract only after the design spec is reviewed and approved. The approved neutral spec is the shared input; routing chooses one downstream planning and execution lane without changing the product direction.

For UI-heavy work, routing also waits until the required frontend-direction packet is approved. A follow-on prompt is context for completing that gate, not permission to route early.

## Route selection

1. Build the available route set. Remove an unavailable route before recommending anything.
2. Classify the delivery shape from the approved spec and the user's stated working preference. Route availability is a constraint, not a recommendation signal.
3. Recommend the available route with the strongest fit:
   - **GSD:** the work spans multiple milestones or independently shippable slices, needs a durable roadmap or resumable project state, coordinates cross-workstream delivery, or explicitly needs GSD governance and lineage.
   - **Superpowers:** the work is a bounded feature or fix that benefits from a durable implementation plan, test-driven task execution, risk-scaled review, subagent execution, or atomic commits without broader milestone governance.
   - **Native Codex:** the work is one contained slice intended for the same task or immediate follow-through, has a single clear owner, and needs a lightweight inline plan rather than durable workflow state.
4. Treat an explicit available route preference as strong fit evidence. Warn once only when that preference conflicts with a concrete delivery need in the approved spec; name that need and the trade-off. Honor the user's preference if they confirm it.
5. Resolve genuinely mixed signals deterministically: prefer an explicit viable user preference; otherwise prefer GSD for milestone continuity or cross-workstream coordination, Superpowers for durable task-planned delivery, then Native Codex for immediate contained work. Never break a tie merely because a route is available.
6. Ask the user to confirm exactly one route. Do not create an adapter, start a workflow, or add routing metadata before confirmation.
7. After confirmation, append the compact `## Delivery Route` section from `spec-template.md`, including recommendation fit evidence, prior approval references, and delivery review status `pending`; then produce exactly one route adapter. Change that status to `approved` with an independent reviewer reference before transition.

Route availability means the required skills and platform capability are actually present. GSD requires the relevant GSD workflow. Superpowers requires `writing-plans`. Native Codex requires plan mode. Never present a route that cannot be completed in the current environment.

## Confirmed route adapters

### GSD

- Write the GSD handoff using `gsd-handoff-template.md`.
- Prepare the ready-to-paste GSD steering note with real artifact paths.
- The GSD handoff and steering note exist only for this route.

### Superpowers

- Invoke `writing-plans` with the approved spec as its source of truth.
- Do not also create a GSD handoff, GSD steering note, or Native Codex plan.

### Native Codex

- Native Codex emits an inline proposed plan for review.
- Native Codex plan mode is a read-only authoring mode, not an execution workflow. Do not execute implementation while in plan mode.
- Enter plan mode with the approved spec as the source of truth.
- After plan mode exits, persist only the spec; do not save a separate plan artifact or create either workflow family's adapter.

## Mismatches and rerouting

An explicit user preference wins after the one-time mismatch warning and confirmation. Record the confirmed preference; do not keep warning or silently fall back to the recommendation.

If the requested route is unavailable, remove it and ask the user to confirm one of the remaining routes. Do not pretend an unavailable adapter can run.

If the user asks to change routes after an adapter exists or downstream workflow state has started, stop for reconciliation. Identify the artifacts and workflow state already created, agree on what remains authoritative and what must be retired, then restart routing from a clean confirmed boundary. Never reroute automatically or run two orchestration lanes at once.
