# Control transition checks

Use for changed web controls within the existing implementation review. Inspect the relevant transition, not just each state's markup. Keep approved interactions; these checks do not authorize redesign.

## Composite controls

For tabs, distinguish entry into the tab list, movement between tabs, activation, and entry into panel content. A single roving tab stop is intentional. Manual activation can use native button Enter/Space behavior; do not duplicate it with generic key handlers. Inspect the panel as well as the tab: a text-only panel without focusable content needs a keyboard entry point, usually `tabindex="0"`. Hidden panels must not remain in the tab sequence.

## Controls that change after activation

Trace the initiating control through pending, success, error, and terminal states. Does it survive rendering? Can it still receive focus when Next becomes disabled on the last page, the last item disappears, or an action becomes unavailable? Preserve useful content on failure and choose a logical enabled target when a keyboard action removes or disables its own control.

Do not restore focus unconditionally. If the user has moved to another panel, closed the dialog, or started a newer action, preserve that newer context and ignore obsolete completions. Check the actual lifecycle rather than assuming unseen helpers are broken.

## Evidence

Record the source finding and exercise the corresponding keyboard transition in the browser, including the boundary state. A screenshot cannot establish where focus went. Read the active element and inspect visible focus; record missing runtime checks as unverified. Use this inside the existing review, not as a separate gate.

Reviewed basis: [WAI tabs](https://www.w3.org/WAI/ARIA/apg/patterns/tabs/), [WAI modal dialogs](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/) and the [source audit](../../frontend-direction/references/design-knowledge-sources.md). Pattern details apply to their named controls, not every interactive element.
