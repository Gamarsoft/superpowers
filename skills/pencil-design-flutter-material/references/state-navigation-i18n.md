# State, Navigation, And i18n

Use this when a Pencil board implies app flow, UI state, forms, routing, or visible copy.

## State

Do not implement only the happy-path static board.
Extract required states from the packet, screen index, board annotations, and current feature behavior.

Common states:

- initial
- loading
- refreshing
- empty
- error
- validation error
- disabled
- selected
- permission denied
- success/confirmation

Use Bloc/Cubit or the repo-approved state layer. Keep business logic out of widgets.
Use page/view separation if that is the repo pattern: the page wires providers and routes; the view renders state.

## State Rendering

- Each state needs intentional layout and copy.
- Keep loading and skeleton states close to final geometry when visual parity matters.
- Errors must be actionable and localized.
- Disabled states must preserve accessibility labels and explain unavailable actions when needed.
- Avoid state branches that duplicate entire screens when a smaller state component is enough.

## Navigation

Use `go_router` or the repo's approved routing system.

Before changing routes, identify:

- owning router file or feature route module
- parent/shell route
- route parameters
- redirects or auth gates
- deep-link expectations
- return-data expectations

Do not use raw `Navigator.push` or string paths unless the existing repo pattern explicitly does.
Do not use navigation to pass complex feature state that belongs in repositories, query params, or route params.

## Forms

- Use existing form field components and validation patterns.
- Keep validation messages localized.
- Preserve keyboard type, autofill hints, input action, and focus order.
- Show errors near the field and in a screen-reader-friendly way.
- Verify keyboard inset behavior on compact devices.

## i18n

Visible production copy should come from ARB/l10n or the repo's localization layer.

Rules:

- use `context.l10n` or the repo extension in feature code
- pass localized strings into shared `app_ui` widgets
- avoid app localization dependencies inside reusable UI packages
- use ICU plural/select syntax for counts and variants
- use directional layout APIs for start/end spacing and alignment
- do not copy imperfect text from generated images or Pencil placeholders unless the packet approved it as final copy

If approved copy is missing, use the UX-copy skill before implementing user-visible text.
