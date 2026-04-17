# Responsive Breakpoints

## Goal

Map multiple Pencil boards or variants into mobile-first responsive behavior.

## Practical guidance

- treat the smallest board as the base layout
- add overrides only when the structure meaningfully changes
- prefer component resilience over many one-off breakpoint hacks
- preserve information priority across breakpoints

## Common board-to-breakpoint reasoning

| Board width | Common interpretation |
|---|---|
| 320–430 | mobile/base |
| ~768 | tablet |
| ~1024 | small desktop / landscape tablet |
| ~1280+ | desktop |

Typical Tailwind breakpoints:

| Board width | Tailwind interpretation |
|---|---|
| 320–430 | base / no prefix |
| 768 | `md:` |
| 1024 | `lg:` |
| 1280 | `xl:` |
| 1536+ | `2xl:` |

## Common responsive patterns

| Pencil variation | React/Tailwind pattern |
|---|---|
| one column mobile, multi-column desktop | `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3` |
| stacked mobile, side-by-side desktop | `flex flex-col lg:flex-row` |
| hidden mobile, visible desktop | `hidden lg:block` |
| visible mobile, hidden desktop | `block lg:hidden` |
| tighter mobile padding, roomier desktop | `p-4 md:p-6 lg:p-8` |
| small mobile text, larger desktop text | `text-sm md:text-base lg:text-lg` |

## Layout-difference heuristics

When comparing multiple boards, look for:

- direction changes: vertical on mobile, horizontal on desktop
- column-count changes
- visibility changes
- typography scale changes
- padding and gap shifts
- whether a dense table becomes cards or stacked rows on narrow screens

## Container query note

When the same component must respond to its container rather than the viewport, prefer container queries if the repo already uses them.
That is usually better than duplicating the component for sidebar and main-content contexts.

## Anti-patterns

| Wrong | Better |
|---|---|
| generating `w-[375px]` from a mobile board | `w-full` with layout constraints |
| generating `w-[1440px]` from a desktop board | `max-w-*` container sizing |
| building separate mobile and desktop components with duplicate logic | one responsive component with breakpoint overrides |
| ignoring the smallest board and starting from desktop | mobile-first base, then widen |
