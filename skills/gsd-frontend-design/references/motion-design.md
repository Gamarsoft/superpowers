# Motion Design

Use motion sparingly and only when it helps the user understand change.

## Brownfield defaults

- Preserve the current interaction feel unless the packet explicitly changes it.
- Prefer minimal transitions over new motion systems.
- Avoid adding new libraries just for motion in an implementation slice.

## Good uses of motion

- clarifying expand and collapse
- easing overlay entry and exit
- communicating loading or progress states
- helping mobile disclosure feel intentional

## Bad uses of motion

- decorative motion unrelated to task progress
- long or bouncy transitions in dense operator UI
- motion that hides performance or state bugs

## Implementation guidance

- keep durations short and consistent
- avoid motion on every interactive element
- respect reduced-motion preferences when motion is introduced
- when in doubt, choose the simpler option
