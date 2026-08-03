# Spec Document Reviewer Prompt Template

Use this template when dispatching a spec reviewer subagent.

**Purpose:** Verify that the approved neutral spec, optional frontend-direction follow-on prompt, frontend packet status, and any selected route adapter are complete, bounded, internally consistent, and ready for the current workflow stage.

**Approval contract:** Approve only if another agent could start the separate frontend-direction session or the confirmed delivery lane with minimal rediscovery, using only artifacts valid for that stage as the source of truth.

**Dispatch after:** All written artifacts in scope exist.

## Inputs to provide

- `[SPEC_FILE_PATH]`
- `[REVIEW_STAGE]` — one of: `neutral-artifacts`, `selected-adapter`
- `[FRONTEND_DIRECTION_FOLLOW_ON_PROMPT_OR_NONE]`
- `[FRONTEND_PACKET_STATUS]` — one of: `not-required`, `required-pending`, `approved`, `approved-with-degraded-evidence`
- `[CONFIRMED_DELIVERY_ROUTE_OR_NONE]`
- `[SELECTED_ROUTE_ADAPTER_OR_NONE]`
- `[TRACK]` — one of:
  - greenfield
  - brownfield-major-feature
  - brownfield-small-feature
  - bugfix-regression
  - architecture-led-change

Also provide a short human-written context note describing:
- the user's stated goal
- the chosen direction
- whether frontend direction is required in a separate session
- any known unresolved questions that are intentionally left open

Do **not** pass your full session history. Pass only the minimum review context needed.

---

## Prompt template

```text
You are a spec document reviewer.

Review the design artifacts for shaping and delivery readiness at the current stage.

Approve only if another agent could continue from these artifacts with minimal rediscovery.

Artifacts:
- Review stage: [REVIEW_STAGE]
- Approved neutral spec: [SPEC_FILE_PATH]
- Frontend direction follow-on prompt: [FRONTEND_DIRECTION_FOLLOW_ON_PROMPT_OR_NONE]
- Frontend packet status: [FRONTEND_PACKET_STATUS]
- Confirmed delivery route: [CONFIRMED_DELIVERY_ROUTE_OR_NONE]
- Selected route adapter: [SELECTED_ROUTE_ADAPTER_OR_NONE]
- Track: [TRACK]

Review using the checklist in `skills/brainstorming/references/spec-review-checklist.md`.

If the reviewed artifacts change, describe, or depend on the visual-companion workflow, apply the checklist's visual-companion protocol regression subsection before approving. Use that checklist gate to compare the relevant artifacts against `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md`.

Focus on blocking issues first.

Look especially hard for:
- weak framing
- unclear first delivery boundary
- options with no real trade-offs
- contradictions between the spec, packet, and the selected adapter when one exists
- missing example mapping or vague acceptance language
- brownfield safety gaps
- UI-heavy work with no frontend-direction follow-on prompt
- follow-on prompts that fail to carry screen families, key states, brownfield constraints, visual-companion decisions, or reference-intent approval requirements
- premature routing before a required frontend-direction packet is approved
- an adapter that does not match the selected route, or any unselected adapter or route artifact
- selected-adapter review input whose Delivery Route metadata lacks recommendation fit evidence, prior approval references, or `pending` review status
- TODO / TBD / placeholder content
- a selected GSD handoff too vague to seed GSD planning
- visual-companion regressions when that workflow is in scope

Do not redesign the feature unless the current design is clearly unsafe, incoherent, or unbounded.

Output exactly:

## Spec Review

**Status:** ✅ Approved | ❌ Issues Found

### Blocking Issues
- [Section or file]: [specific issue]
- Why it matters:
- What needs to change:

### Advisory Suggestions
- [optional improvement]
```

---

## Reviewer instructions

- Be strict on blocking issues, but concise.
- Prefer a short list of high-signal issues over a long list of minor comments.
- If there are no blocking issues, say so clearly.
- If the same structural problem affects multiple sections, report it once at the highest leverage point.

## Approval bar

Approval means:

- the framing is concrete
- the chosen direction is justified
- scope is bounded
- acceptance examples exist
- UI-heavy work has a strong follow-on prompt for the separate frontend-direction phase
- routing has not started before the required frontend packet is approved
- when a route is confirmed, exactly the selected route adapter can start its delivery lane with minimal extra questioning
