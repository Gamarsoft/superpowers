---
name: mobile-product-direction
description: Use when turning product requirements, specs, app ideas, onboarding, commerce, booking, account, search, map, or native mobile workflows into mobile-first screen direction before visual design or implementation.
---

# Mobile Product Direction

## Overview

Turn product intent into a native mobile flow contract. Use this before `frontend-direction` finalizes visual truth when mobile app structure, screen inventory, or state coverage is still being shaped.

This skill is universal. Do not assume Flutter, Pencil, React, Tailwind, iOS-only, Android-only, or a specific app.

## Core Rule

Design the mobile job before the mobile screen. Every screen needs a user goal, one primary action, clear entry/exit context, and the states needed to keep the user oriented.

## Workflow

1. Identify the mobile product mode:
   - native app, companion app, transactional app, marketplace, content/search app, utility, account/service app, or responsive web fallback
   - iOS, Android, cross-platform, tablet, or mixed device families
2. Name the high-frequency user jobs and the high-risk jobs.
3. Map each job to a short flow:
   - previous screen or trigger
   - current screen goal
   - primary action
   - secondary escape or recovery path
   - next screen or confirmation
4. Build the screen inventory with states, not just happy paths:
   - unauthenticated, first-run, loading, empty, partial, error, offline, permission denied, validation, disabled, success, destructive, and expired states where relevant
5. Decide what must be visible immediately on compact phones.
6. Decide what can be progressively disclosed through sheets, details, search, filters, or secondary screens.
7. Record native mobile constraints:
   - safe areas, keyboard, thumb reach, text scaling, platform navigation, permission timing, offline expectations, and sensitive-data handling
8. Hand off a mobile direction contract to visual design or implementation.

## Mobile Direction Contract

Use this shape in specs, frontend packets, or handoffs:

```markdown
## Mobile Product Direction

- Target platforms/device families:
- Product mode:
- Primary mobile jobs:
- High-risk jobs:
- Navigation model:
- Screen inventory:

| Screen | User goal | Primary action | Came from | Goes to | Critical states |
|---|---|---|---|---|---|
| ... | ... | ... | ... | ... | ... |

- First-screen priorities:
- Progressive disclosure:
- Permission moments:
- Offline/degraded behavior:
- Authentication/account boundaries:
- Transactional or safety-critical constraints:
- Native-vs-web risks:
```

## Reference Loading

- Read `references/mobile-product-direction-checklist.md` when creating a new mobile screen inventory, a frontend direction packet, or a mobile-first GSD handoff.

## Common Mistakes

| Mistake | Better approach |
|---|---|
| Starting from a pretty home screen | Start from the highest-frequency mobile job and its next action |
| Listing screens without states | Include loading, empty, error, permission, offline, and success states in the inventory |
| Copying desktop IA into bottom tabs | Reduce to top-level mobile destinations and move secondary tasks into stacks, sheets, or account |
| Treating permissions as setup chores | Ask at the moment of value and provide denied-state fallback |
| Making every screen multifunctional | Give each screen one dominant intent and one obvious primary action |
| Designing the happy path only | Include recovery and interruption paths before visual design starts |
