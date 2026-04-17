# Color & Contrast

Use color to reinforce the existing system, not to reinvent it during implementation.

## Brownfield defaults

- Prefer existing semantic color roles and tokens.
- Replace page-local hard-coded colors with shared tokens where safe.
- Preserve established meaning for success, warning, error, info, status, and locked states.
- Treat alpha-heavy overrides as debt to reduce, not a pattern to spread.

## What to preserve

Preserve when present:

- primary action color and its clear action hierarchy
- shared surfaces and separators used by the shell
- semantic status colors already used operationally
- disabled, locked, or unavailable states with established meaning

## How to normalize safely

When a screen is color-drifty:

1. Map each local color to an existing semantic role if one exists.
2. If no semantic role exists, prefer a local semantic alias instead of a raw hex.
3. Avoid palette expansion during implementation unless the packet explicitly calls for it.
4. Keep contrast strong enough for text, icons, borders, and focus states.

## Accessibility

- body text and form text need reliable contrast against their surface
- icon-only controls still need visible contrast and labels
- placeholder text should not be the only cue
- status should not rely on color alone when urgency or meaning matters

## Non-goals during implementation

- introducing an all-new palette
- switching the product to a new color model for its own sake
- flattening semantic differences between warning, error, success, and info
