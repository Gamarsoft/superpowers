---
name: mobile-design-review
description: Use when reviewing native mobile screens, flows, Pencil boards, screenshots, prototypes, visual references, Flutter/iOS/Android implementations, app store quality, usability, accessibility, or generic AI mobile UI risks.
---

# Mobile Design Review

## Overview

Review mobile design artifacts for task clarity, native fit, usability, accessibility, visual quality, and state coverage. Lead with concrete findings and evidence.

Use this after there is something to inspect: a spec section, screen inventory, Pencil board, image reference, screenshot, prototype, or implementation.

## Review Inputs

Gather what exists:

- product goal and target users
- target platform/device families
- approved frontend direction packet or design brief
- screenshots, Pencil boards, visual references, or implementation captures
- screen inventory and state coverage
- existing design system, if any
- accessibility, localization, and runtime evidence when available

If the artifact is only a description, review the described risks and name missing evidence explicitly.

## Findings Format

Use code-review severity:

- `Blocking`: likely prevents task completion, accessibility, trust, payment, safety, or platform acceptance.
- `Important`: hurts usability, conversion, comprehension, native feel, or maintainability.
- `Minor`: polish issue worth fixing when nearby.

Each finding should state:

```markdown
- [Severity] [Issue]
  Evidence:
  Impact:
  Recommendation:
```

## Review Checklist

Check these before approving:

- Primary action is obvious within 3 seconds.
- First screen serves the user job, not only promotion or brand.
- Navigation matches mobile conventions and uses 3-5 top-level destinations.
- Critical actions are visible, not gesture-only.
- Forms minimize typing and preserve state.
- Search, filtering, and sorting support fast scanning.
- Permissions are requested at the moment of value and have fallback paths.
- Loading, empty, error, offline, disabled, success, and destructive states are designed.
- Text remains readable at increased text scale.
- Tap targets are large enough and not crowded.
- Color contrast and non-color status cues are sufficient.
- VoiceOver/TalkBack labels, order, and state changes are plausible or verified.
- Safe areas, keyboard, bottom bars, and compact screens do not hide controls.
- Visual hierarchy, typography, spacing, and color roles are coherent.
- Motion clarifies state or feedback and respects reduced motion.
- The design avoids generic AI-mobile aesthetics and web-shaped mobile flows.
- Transactional flows preserve trust, price clarity, confirmation, and recovery.

## Verdict

End with:

```markdown
Verdict: APPROVE | REQUEST_CHANGES | ESCALATE
Review Decision: no_action | remediate_and_rereview | escalate_replan
Evidence Reviewed:
Missing Evidence:
```

Approve only when blocking and important findings are resolved, disproved, or explicitly waived.

## Reference Loading

- Read `references/mobile-design-review-checklist.md` for detailed checks by product mode and artifact type.

## Common Mistakes

| Mistake | Better approach |
|---|---|
| Reviewing only visual taste | Review product task, native behavior, accessibility, and state coverage too |
| Accepting screenshots without state evidence | Ask for key states or mark missing evidence |
| Treating a pretty mockup as implementation-ready | Check permissions, failure modes, text scaling, compact devices, and recovery |
| Rewriting the design in the review | Report findings and recommendations; do not create a competing design unless asked |
| Approving with no platform context | Name iOS, Android, cross-platform, tablet, or unknown constraints |
