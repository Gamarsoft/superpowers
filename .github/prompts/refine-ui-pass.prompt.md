---
description: "Refine an already implemented UI against the strongest available contract: frontend packet when present, otherwise spec and handoff, otherwise current source code and rendered UI."
name: "Refine UI Pass"
agent: ui-refinery
argument-hint: "Goal, relevant route or component, packet or spec or handoff paths if they exist, what feels weak, and whether you want subtle polish or a stronger but still contract-safe push."
---
Refine the current UI/UX against the strongest available contract.

Before editing:
- reconstruct the active contract mode
- critique the current UI
- verify the rendered result in the browser when possible

After one bounded refinement round:
- summarize the contract mode used
- summarize what changed
- summarize what still feels weak
- ask me whether to continue refining or stop
