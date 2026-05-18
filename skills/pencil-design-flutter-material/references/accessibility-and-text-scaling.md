# Accessibility And Text Scaling

Use this before considering Flutter mobile UI complete.

## Minimum Checks

- semantic labels for icon-only controls and meaningful images
- decorative images excluded from semantics
- visible focus behavior where keyboard/switch access applies
- tap targets large enough for mobile use
- color is not the only status or error signal
- contrast meets the target level in the packet or repo standard
- text scales without clipping or losing critical actions
- motion respects reduced-motion settings where animations are added

## Flutter Patterns

- Prefer Material controls over bare gesture handlers.
- Use `InkWell`, `IconButton`, `FilledButton`, `TextButton`, or shared controls instead of raw `GestureDetector` for tappable UI.
- Wrap unfamiliar icon-only controls with `Tooltip` or `Semantics(label:)`.
- Use `Semantics(header: true)` for meaningful section headers when appropriate.
- Use `MergeSemantics` for compound controls that should read as one item.
- Avoid `ExcludeSemantics` unless the content is decorative or duplicated elsewhere.

## Text Scaling Rules

- Do not use `TextScaler.noScaling` for production UI unless the repo has an explicit, justified exception.
- Avoid fixed-height containers around text.
- Avoid clipping critical labels.
- Let text wrap where comprehension matters.
- Use flexible layout for buttons and chips with translated labels.
- Verify empty/error/helper text at larger scales.

## Directionality

- Use directional spacing and alignment where copy or layout may localize:
  - `EdgeInsetsDirectional`
  - `AlignmentDirectional`
  - `PositionedDirectional`
  - start/end labels instead of left/right assumptions

## Accessibility Test Evidence

When the repo supports it, add widget tests using Flutter accessibility guidelines for:

- tap target size
- labeled tap targets
- text contrast
- semantic traversal where relevant

For manual simulator/device review, record:

- target device
- text scale setting
- screen reader or semantics check used, when applicable
- any waivers and follow-up work
