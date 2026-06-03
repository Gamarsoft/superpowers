# Retex Frontend Implementation Lessons

This reference captures a brownfield UI failure mode: implementing the functional skeleton while missing the approved visual intent.

## What Went Wrong

- Runtime verification focused on DOM presence and layout existence instead of visual parity.
- Existing framework defaults were preserved too aggressively even when the approved direction required calmer controls, clearer surfaces, and different visual hierarchy.
- The implementation treated brownfield preservation as "keep local styling" instead of "preserve shell, behavior, and product family while applying the approved scoped visual delta."

## Correct Rule

Approved frontend direction should be translated through the real framework and design system. If the packet explicitly changes hierarchy, surfaces, control emphasis, density, or responsive behavior, implement those deltas with shared tokens or scoped styling when no shared primitive exists.

## Required Acceptance Bullets

- Compare runtime screenshots against the approved visual references.
- List pass/fail items for surfaces, control emphasis, section background, spacing, typography, responsive flow, and button hierarchy.
- Treat screenshots, DOM checks, compilation, linting, and tests as supporting evidence, not visual acceptance by themselves.
- If a stack default conflicts with approved visual intent, neutralize it through theme variables, component wrappers, or narrowly scoped styles.

## Planning Wording To Reuse

For approved UI implementation, "preserve brownfield" means preserve shell, behavior, data contracts, and product family. It does not mean preserve flawed local styling that the approved packet explicitly changes.
