# Mobile Interaction and Usability Checklist

Use this reference for mobile navigation, forms, gestures, permissions, state behavior, and accessibility.

## Navigation

- Use bottom navigation only for stable top-level destinations.
- Keep task flows inside stacks, steps, sheets, or modals rather than adding bottom-tab destinations.
- Preserve back behavior and user-entered state across review/correction loops.
- Make active location visible.
- Keep destructive or account-sensitive paths away from accidental taps.

## Forms and Inputs

- Prefer saved values, pickers, steppers, scan, autocomplete, and selection over typing.
- Match keyboard type to input.
- Validate after interaction or submit, not before the user has acted.
- Keep errors near the field and summarize when the form is long.
- Keep submit/review actions visible without covering fields.
- Handle keyboard, safe area, and scroll-to-error behavior.

## Gestures

- Treat gestures as accelerators.
- Provide visible alternatives for swipe, drag, long-press, shake, and motion actuation.
- Confirm destructive gesture actions or offer undo.
- Avoid gesture conflicts with platform navigation.

## Permissions

- Ask only when the feature needs the permission.
- Explain value before the system prompt when context is not obvious.
- Provide denied-state fallback where possible.
- Do not block the whole app for optional permissions.
- Record when to re-ask or route users to settings.

## Accessibility and Mobile WCAG

- Use platform-safe targets; WCAG 2.2 AA target-size guidance is a minimum baseline, and larger platform targets are preferable for common controls.
- Support increased text scale without clipping or hiding critical actions.
- Keep contrast sufficient and add non-color cues for status.
- Preserve logical reading and focus order.
- Label controls with purpose, value, state, and result where relevant.
- Announce async state changes and validation errors.
- Avoid orientation lock unless essential.
- Support reduced motion and alternatives to motion-triggered actions.

## State Behavior

- Use skeletons or localized progress for predictable loading.
- Empty states should state why the area is empty and provide a next action.
- Error states should distinguish retryable, permission, validation, offline, and unavailable cases.
- Disabled controls need an explanation when the reason is not obvious.
- Offline states should preserve visible useful data when possible.
