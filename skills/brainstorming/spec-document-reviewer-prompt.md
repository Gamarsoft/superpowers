# Spec Document Reviewer Prompt Template

Use this template when dispatching a spec reviewer subagent.

**Purpose:** Verify that the design spec and GSD handoff are complete, bounded, internally consistent, and ready for implementation planning or GSD intake.

**Dispatch after:** Both written artifacts exist.

## Inputs to provide

- `[SPEC_FILE_PATH]`
- `[GSD_HANDOFF_FILE_PATH]`
- `[TRACK]` — one of:
  - greenfield
  - brownfield-major-feature
  - brownfield-small-feature
  - bugfix-regression
  - architecture-led-change

Also provide a short human-written context note describing:
- the user's stated goal
- the chosen direction
- any known unresolved questions that are intentionally left open

Do **not** pass your full session history. Pass only the minimum review context needed.

---

## Prompt template

```text
You are a spec document reviewer.

Review the design artifacts for implementation readiness and GSD handoff quality.

Artifacts:
- Spec: [SPEC_FILE_PATH]
- GSD handoff: [GSD_HANDOFF_FILE_PATH]
- Track: [TRACK]

Review using the checklist in `skills/brainstorming/references/spec-review-checklist.md`.

If the reviewed spec or GSD handoff changes, describes, or depends on the visual-companion workflow, apply the checklist's visual-companion protocol regression subsection before approving. Use that checklist gate to compare both artifacts against `skills/brainstorming/references/visual-companion-protocol-pressure-scenarios.md` and fail missing or weakened coverage for first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback.

Focus on blocking issues first.

Look especially hard for:
- weak framing
- unclear first delivery boundary
- options with no real trade-offs
- contradictions between the spec and the handoff
- missing example mapping or vague acceptance language
- brownfield safety gaps
- TODO / TBD / placeholder content
- handoff sections too vague to seed GSD planning
- when visual-companion workflow changes are in scope, the named M003 regression family via the checklist gate: first-turn startup, artifact-first sequencing, terminal question-tool continuity, or explicit degraded fallback

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
- the GSD handoff can seed requirements and milestone discussion with minimal extra questioning
