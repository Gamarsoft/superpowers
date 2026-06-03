# Frontend Direction Packet Template

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend-direction.md`

Keep this packet compact. It is an implementation contract, not a design diary.

```markdown
# [Feature / Project Name] — Frontend Direction

## 1. Summary

- Linked spec:
- Linked GSD handoff:
- Packet status: approved | pending | degraded
- Brownfield call: preserve | focused refresh | redesign approved
- Default visual source: current UI screenshots/browser captures | approved ChatGPT Images 2 | degraded current UI
- UX copy source: spec | copy deck | existing i18n | pending

## 2. Source Evidence

- Current UI evidence:
- Design-system or component evidence:
- Approved generated images, if any:
- Temporary comparison artifacts retained only as context:
- Missing evidence / degraded constraints:

## 3. Screens And States

Link: `./{slug}--frontend/screen-index.md`

- In scope:
- Key states:
- Deferred:

## 4. Visual References

Use one row per implementation-facing reference.

| Screen/state | Reference | Intent | Approval | Binding notes |
| --- | --- | --- | --- | --- |
| [screen] | [screenshot/image/path] | visual-truth / semantic-guidance / reference-only | approved / pending | [what binds] |

Reference intent meanings:

- `visual-truth`: visual treatment is binding and needs runtime comparison.
- `semantic-guidance`: workflow, hierarchy, content priority, or state behavior is binding; visual treatment may adapt to the product system.
- `reference-only`: useful context, not an acceptance target.

## 5. Implementation Contract

### Must preserve
- ...

### May adapt
- ...

### Explicit no-gos
- ...

### Copy and accessibility
- Approved labels, CTAs, helper text, warnings, errors, empty states, confirmations:
- Terminology / i18n variables:
- Accessibility constraints:

### Responsive and interaction notes
- Viewports/device families:
- Reflow rules:
- Interaction/state feedback:

## 6. Verification

- Runtime screenshots/captures required:
- Reference-intent checklist:
- Interaction checks:
- Accessibility/copy checks:
- Known visual risks or waived mismatches:

## 7. Open Questions

- [question] — blocks [decision]
```

## Quality Bar

- Concrete evidence beats long prose.
- Every implementation-facing reference has an approved intent or a recorded blocker.
- The packet names what to preserve, what may change, and what is forbidden.
- The packet is short enough to scan before coding.
