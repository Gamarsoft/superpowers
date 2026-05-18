---
name: mobile-interaction-and-usability
description: Use when designing native mobile navigation, tabs, sheets, forms, search, filtering, gestures, permissions, loading, empty, error, offline, accessibility, text scaling, tap targets, semantics, or recoverable mobile states.
---

# Mobile Interaction and Usability

## Overview

Design mobile interactions that are discoverable, recoverable, reachable, and accessible. Accessibility is part of interaction design here, not a late audit.

This skill is universal. Compose it with Flutter, Pencil, React, or native implementation skills only after the interaction contract is clear.

## Core Rules

1. Prefer familiar platform patterns unless the product has a strong reason to diverge.
2. Make primary actions visible; gestures may accelerate but must not be the only path.
3. Minimize typing through selection, defaults, scanning, saved data, and progressive disclosure.
4. Treat text scaling, semantics, contrast, tap targets, and motion sensitivity as design inputs.
5. Keep users oriented through clear back paths, state preservation, loading feedback, and recovery actions.

## Interaction Contract

Before visual design or implementation, define:

```markdown
## Mobile Interaction Contract

- Navigation model:
- Top-level destinations:
- Stack/modal/sheet boundaries:
- Primary action placement:
- Form/input strategy:
- Search/filter/sort strategy:
- Gesture shortcuts and visible alternatives:
- Permission timing and denied-state fallback:
- Loading/empty/error/offline behavior:
- Accessibility constraints:
- Text scaling and compact-screen risks:
```

## Decision Rules

| Area | Use | Avoid |
|---|---|---|
| Bottom navigation | 3-5 stable top-level destinations | task steps, settings clutter, six-plus items |
| Sheets | focused choices, filters, contextual actions | deep workflows that need full navigation |
| Forms | short steps, native inputs, saved defaults | long unbroken forms, premature validation |
| Gestures | swipe-back, pull refresh, optional row shortcuts | hidden primary or destructive actions |
| Permissions | ask at the moment of user benefit | first-run permission walls |
| States | local skeletons, retry, fallback, recovery copy | frozen screens and generic failure banners |
| Accessibility | large targets, labels, focus order, non-color cues | tiny text, color-only status, gesture-only controls |

## Minimum Mobile Usability Checks

- Primary action is reachable and visible on compact phones.
- Tap targets are at least platform-safe size and not crowded.
- Dynamic Type/text scaling does not clip labels, buttons, or critical data.
- VoiceOver/TalkBack labels expose control purpose, value, state, and result.
- Swipe, drag, long-press, shake, or motion actions have visible alternatives.
- Errors explain what happened and how to recover.
- Loading states preserve layout and indicate which region is pending.
- Denied permissions keep the core task usable when possible.
- Destructive actions require confirmation or undo.
- Keyboard, safe areas, notches, home indicators, and bottom bars do not cover controls.

## Reference Loading

- Read `references/mobile-interaction-and-usability-checklist.md` when designing navigation, forms, gestures, permission flows, or mobile accessibility acceptance.

## Common Mistakes

| Mistake | Better approach |
|---|---|
| Treating accessibility as post-design QA | Design labels, target size, focus order, and text scaling with the interaction |
| Hiding core actions behind swipe | Provide visible buttons or menus; keep swipe as a shortcut |
| Asking every permission during onboarding | Ask just in time with a value explanation and fallback |
| Blocking the full screen for local loading | Use localized skeletons or progress where the delay happens |
| Letting filters become a second app | Use defaults, chips, recent choices, and clear reset actions |
| Preserving no form state on back | Keep state when users review, correct, or return from interruptions |
