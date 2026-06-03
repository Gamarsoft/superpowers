---
description: "Refine an already implemented UI against the strongest available contract: frontend packet when present, otherwise spec and handoff, otherwise current source code and rendered UI. Prefer retained screenshots, browser captures, approved generated images, and rendered UI over temporary HTML comparison artifacts."
name: "Refine UI Pass"
agent: ui-refinery
argument-hint: "Goal, relevant route or component, packet or spec or handoff paths if they exist, which screenshots/captures are in scope, what feels weak, and whether you want subtle polish or a stronger but still contract-safe push."
---
Refine the current UI/UX against the strongest available contract.

Before editing:
- reconstruct the active contract mode
- locate retained screenshots, browser captures, approved generated-image references, and any temporary HTML companion artifacts if they still matter
- critique the current UI
- verify the rendered result in the browser when possible

After one bounded refinement round:
- summarize the contract mode used
- summarize which packet, screenshot, browser, generated-image, or temporary HTML sources were used
- summarize what changed
- summarize what still feels weak
- ask me whether to continue refining or stop
