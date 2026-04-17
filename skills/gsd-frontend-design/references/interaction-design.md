# Interaction Design

Design interaction states completely and conservatively.

## Required states

Most interactive elements need these states when relevant:

- default
- hover
- focus
- active
- disabled
- loading
- error
- success

Do not design only the happy path.

## Focus and keyboard use

- Never remove focus visibility without a replacement.
- Keep focus treatment consistent across buttons, inputs, menus, and icon actions.
- In brownfield work, improve weak focus states rather than introducing an unrelated new pattern.

## Forms

- Visible labels beat placeholder-only scanning.
- Keep validation timing and messaging predictable.
- In settings pages, group by operator intent when the packet allows it.
- Preserve fixed footer save actions when they are part of the current pattern.

## Dense operational actions

On high-throughput screens:

- preserve quick access to the most important actions
- do not bury critical status or assignments behind too many taps
- make progressive disclosure explicit on mobile rather than compressing desktop tables blindly

## Overlays and dialogs

- keep titles, consequence copy, and button labels explicit
- use destructive language only when the action is truly destructive
- ensure close, cancel, and confirm paths are predictable

## Accessibility

- keyboard paths should remain usable after refactors
- icon-only actions need accessible names
- loading and disabled states should remain understandable
- error messages should identify what happened and how to recover
