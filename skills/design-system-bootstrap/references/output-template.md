# Output template

Use this structure unless the repo already has a better established format.

## `.stitch/DESIGN.md`

```markdown
# Design System: [Surface Name]

**Project ID:** [projects/...]  
**Project Title:** [Stitch project title]  
**Surface Boundary:** [what this file covers and what it excludes]  
**Bootstrap Status:** [verified | mixed | degraded]  
**Last Refreshed:** [YYYY-MM-DD]

## 1. Visual Theme & Atmosphere
[Describe the overall mood, density, and product character.]

## 2. Color Palette & Roles
- **[Role Name]** — [descriptive name] (`#HEX`) — [functional role]
- **[Role Name]** — [descriptive name] (`#HEX`) — [functional role]

## 3. Typography & Hierarchy
[Font families, weight patterns, heading/body hierarchy, density, tone.]

## 4. Layout System
[Whitespace strategy, grid habits, content density, page rhythm, alignment rules.]

## 5. Geometry & Shape
[Corner language, pill vs squared behavior, icon/container shape tendencies.]

## 6. Depth & Elevation
[Shadow usage, layering, border reliance, contrast approach.]

## 7. App Shell & Navigation
[Global nav patterns, page headers, tabs, breadcrumbs, action placement.]

## 8. Component Stylings
### Buttons
[Primary, secondary, destructive, ghost/link styles and their roles.]

### Inputs & Forms
[Field styling, labels, helper text, validation appearance, spacing.]

### Containers, Tables & Lists
[Cards, panels, tables, row density, list rhythm, selection states.]

### Badges, Tags & Status
[Semantics and color mapping for statuses.]

### Modals, Drawers & Overlays
[Shape, layering, dismissal patterns, action hierarchy.]

## 9. States & Feedback
[Empty, loading, error, success, validation, permission, inline feedback.]

## 10. Responsive Behavior
[Breakpoint behavior, collapsing patterns, narrow-layout priorities.]

## 11. Motion & Interaction Tone
[Hover/focus/press behavior, animation restraint, transitions.]

## 12. Content Tone
[Utility tone, verbosity, button copy style, status-message style.]

## 13. Must Preserve
- [binding continuity rule]
- [binding continuity rule]

## 14. May Flex
- [areas where new screens can adapt]
- [areas where new screens can adapt]

## 15. Explicit No-Go
- [anti-pattern or drift to avoid]
- [anti-pattern or drift to avoid]

## 16. Source Map
### Anchor Screens
- [screen title] — [screenId or path] — [why it was selected]

### Repo Sources
- [token/theme/component file]

### Notes
- [verified vs inferred notes]
```

## `.stitch/bootstrap-report.md`

```markdown
# Design System Bootstrap Report

**Surface:** [surface name]  
**Decision:** [reused existing Stitch project | created new Stitch project | degraded bootstrap]  
**Stitch Project:** [title]  
**Project ID:** [projects/...]  
**Last Refreshed:** [YYYY-MM-DD]

## Why this surface
[Short explanation of the chosen boundary.]

## Anchor screens
| Screen | ID or path | Coverage | Why it matters | Stability |
|---|---|---|---|---|
| Dashboard | ... | shell, dense content | ... | stable |

## Repo-native sources consulted
- [theme/token/component file]
- [storybook path]

## Verified facts
- [facts confirmed by repo or strong Stitch evidence]

## Inferred facts
- [reasonable inference that still needs confirmation]

## Gaps
- [missing screens, states, or token sources]

## Refresh triggers
- [what should cause the file to be refreshed]

## Next step
- Use this file as first-class input for `frontend-direction`.
```
