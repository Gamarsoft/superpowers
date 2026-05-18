---
name: mobile-visual-design
description: Use when defining, improving, or critiquing native mobile visual direction, hierarchy, typography, spacing, density, color, motion, empty/loading/error visuals, premium feel, native polish, or non-generic app UI quality.
---

# Mobile Visual Design

## Overview

Create mobile screens with a clear visual thesis, strong hierarchy, and native polish. Visual design should clarify the task before it decorates the interface.

This skill is universal. Do not emit framework-specific code or assume web, Flutter, Pencil, React, Tailwind, or any one design tool.

## Core Pattern

1. Choose the product feel:
   - utilitarian, calm, premium, playful, editorial, dense, reassuring, luxury, technical, or service-oriented
2. Make the first screen impression match that feel.
3. Give each screen one dominant intent and one dominant visual action.
4. Use type, spacing, grouping, and color roles to express importance.
5. Design empty, loading, error, disabled, and success states as part of the visual system.
6. Remove generic AI-mobile decoration that does not help the user decide or act.

## Mobile Visual Contract

Use this in frontend packets, Pencil worksets, or design reviews:

```markdown
## Mobile Visual Direction

- Product feel:
- First-screen impression:
- Visual hierarchy:
- Primary visual anchor:
- Typography roles:
- Spacing/density rhythm:
- Surface and grouping rules:
- Color and status roles:
- Icon/media style:
- Motion/feedback style:
- State visuals:
- Anti-patterns to avoid:
```

## Quality Rules

| Area | Strong mobile design | Weak mobile design |
|---|---|---|
| Hierarchy | user sees the next action in 3 seconds | every card competes equally |
| Typography | readable scale, restrained weights, strong numerals where useful | oversized headings inside small panels |
| Spacing | relationships are visible through rhythm | random padding or card stacking |
| Color | semantic roles and one clear accent | decorative gradients and many saturated CTAs |
| Motion | clarifies cause, progress, or confirmation | motion used as decoration or delay |
| Surfaces | sections support scanning and touch | nested cards, heavy shadows, excessive blur |
| States | empty/loading/error states feel designed | framework defaults or generic filler |

## Anti-Patterns

- Gradient hero plus stacked promo cards on a task-first screen.
- Six-item bottom navigation.
- Huge decorative cards hiding the core task.
- Random purple/blue gradients, glassmorphism, bokeh, or blur without product purpose.
- “Dashboard” widgets copied into apps where the user needs a specific transaction, booking, search, or recovery path.
- Tiny gray metadata that carries legal, price, time, or safety meaning.
- Icons from mixed families or arbitrary line weights.
- Brand color used for every surface, chart, status, and CTA.
- Motion that blocks progress, causes disorientation, or ignores reduced-motion expectations.

## Reference Loading

- Read `references/mobile-visual-quality-checklist.md` when defining a visual thesis, evaluating a mockup, or improving mobile screen polish.

## Common Mistakes

| Mistake | Better approach |
|---|---|
| Starting with decoration | Start with hierarchy, then add only useful brand expression |
| Making every screen “premium” through low contrast | Premium still needs readable text, visible controls, and clear status |
| Copying inspiration apps directly | Extract conventions and hierarchy patterns; do not clone visuals |
| Treating empty/error/loading states as copy only | Give each state layout, action hierarchy, and visual tone |
| Overusing cards | Use cards for repeated items or contained decisions, not every section |
