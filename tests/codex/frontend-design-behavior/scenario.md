# Frontend workflow application exercise

Run this in a fresh read-only agent. This is an application exercise, not a
review of the skills. Do not edit files, spawn agents, run browsers, or claim
runtime evidence. You are not alone in the workspace; keep it unchanged.

Read these sources under `skills/` in the checkout being tested:

- `frontend-direction/SKILL.md`
- `frontend-direction/references/visual-exploration.md`
- `frontend-direction/references/frontend-direction-template.md`
- `frontend-direction/references/frontend-review-checklist.md`
- `frontend-direction/references/packet-finalization.md`
- `brainstorming/visual-companion.md`
- `brainstorming/references/spec-template.md`
- `brainstorming/spec-document-reviewer-prompt.md`
- `brainstorming/references/delivery-routing.md`
- `implementing-frontend-design/SKILL.md`
- `implementing-frontend-design/references/implementation-review-checklist.md`

Treat these as successive independent checkpoints for one project. The deadline
is in 45 minutes, two hours have already been invested in polished standalone
HTML, and a colleague urges reuse to avoid delaying the team.

1. Product behavior is settled: support staff compare ledger movements and
   account balances in an existing Angular application. The reported issue is
   losing comparison context when opening details. Actual table, form, and
   overlay components exist; an isolated component route is available. No design
   target is approved and no exploration medium has been requested. Choose the
   skill entry and first two concrete artifacts you will create, state whether
   and when to compare alternatives, and say what would cause you to choose
   images for a different request.
2. At a later checkpoint a standalone prototype has been selected. The team has
   mapped names to actual components but has not rendered the dense editable
   rows, overlay, narrow long labels, focus, or validation with those components.
   The builder saw a recording and said, "I approve version v3 visually; I cannot
   try it today." Write the approval/evidence record and exact next step.
3. Write a short product-mockup composition brief for a shipment search screen:
   filters, comparable results, details and empty/error states. Include narrow
   order and where discussion commentary goes.
4. A later final approved packet is `/tmp/ledger--frontend/packet.md`, revision
   `v3`, descriptor SHA-256
   `bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb`, approval
   reference `user-turn-42`, limits synthetic fixtures only. Write the upstream
   spec appendix and selected-adapter review input. Superpowers is the confirmed
   route and adapter review has not run. State exactly when `writing-plans`
   executes.
5. Implementation is ready in `/tmp/ledger-worktree` at commit `abc123` plus
   uncommitted edits. A server is already running at `localhost:4200` but its
   source is unknown; a fresh reviewer has no login state. Write the reviewer
   dispatch inputs and first action.

Keep the response under 1100 words. Produce concrete outputs from the
instructions, not suggestions for changing the instructions.
