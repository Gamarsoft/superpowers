---
name: pencil-design-flutter-material
description: Use when approved Pencil `.pen` boards, worksets, screenshots, or frontend direction packets must guide Flutter mobile UI implementation with Material 3, ThemeData, app_ui packages, widget/golden tests, device screenshots, Bloc/Cubit, go_router, or ARB/l10n.
---

# Pencil Design for Flutter + Material 3

## Overview

Translate approved Pencil evidence into idiomatic Flutter UI.
Use this adapter with `pencil-design-core`; the core skill governs `.pen` discipline, and this skill governs Flutter implementation shape.

This adapter is Flutter-specific, not app-specific. Keep product facts, brand decisions, and business rules in the target repo's `PRODUCT.md`, `DESIGN.md`, `AGENTS.md`, specs, and frontend direction packets.

## Core Rules

1. Load `pencil-design-core` first.
2. Map Pencil components to existing Flutter widgets and `app_ui` primitives before creating new widgets.
3. Use `ThemeData`, `ColorScheme`, `TextTheme`, and `ThemeExtension`; do not hardcode visual constants in feature screens.
4. Translate Pencil layout intent into Flutter constraints, scrolling, and adaptive structure, not pixel-perfect absolute positioning.
5. Keep feature screens thin; reusable visual primitives belong in the shared UI package when the pattern repeats.
6. Keep presentation state in Bloc/Cubit or the repo's approved state-management layer.
7. Use `go_router` or the repo's approved routing system; do not add ad hoc `Navigator` flows.
8. Use ARB/l10n or the repo's localization layer for visible production copy.
9. Verify native mobile behavior with analysis, widget/golden tests, accessibility checks, and simulator/device screenshots.
10. Do not emit React, Tailwind, HTML, CSS, Angular, or web dashboard assumptions.

## Required Workflow

1. Read the frontend direction packet, `screen-index.md`, `pencil-workset.md`, and relevant `.pen` boards.
2. Read repo instructions, `PRODUCT.md`, `DESIGN.md`, and Flutter package docs when present.
3. Inspect the Flutter app and shared UI package before proposing implementation.
4. Identify existing widgets, tokens, typography, spacing, radius, elevation, icons, motion, routes, states, and l10n conventions.
5. Classify each board or retained screenshot as `visual-truth`, `semantic-guidance`, or `reference-only`.
6. Build a Flutter implementation contract before editing code:
   - target app/package and target screen/widget
   - existing `app_ui` primitives to reuse
   - new shared components or tokens, only if reusable
   - feature package responsibilities
   - routing impact
   - Bloc/Cubit or approved state impact
   - l10n keys and copy source
   - accessibility and text-scaling checks
   - widget, golden, and simulator/device verification
7. Implement with existing primitives first.
8. Promote a visual pattern to `app_ui` only when it is reusable across screens or required by the design system.
9. Verify with the repo's Flutter commands and mobile evidence, not browser proof unless the target is Flutter Web.

## Translation Checklist

- What real Flutter widget or `app_ui` primitive already matches the Pencil component?
- Which Material role owns each color, text style, elevation, radius, and state treatment?
- Which values are semantic tokens and which are board-specific artifacts that should not become code?
- Which layout parts must scroll, flex, wrap, pin, or collapse on compact devices?
- Which boards are visual truth versus semantic guidance?
- Which visible strings need ARB/l10n keys?
- Which states need Bloc/Cubit coverage: initial, loading, empty, error, validation, disabled, selected, success?
- Which route or shell owns the screen?
- Which widget/golden/device evidence proves the approved intent?
- Which accessibility checks cover semantics, focus, tap targets, contrast, and text scaling?

## Reference Loading Guide

- Read `references/flutter-widget-translation.md` when mapping Pencil frames/components to Flutter widget trees.
- Read `references/app-ui-package-boundaries.md` before adding or changing shared widgets, tokens, or theme extensions.
- Read `references/material-3-theme-and-tokens.md` before translating colors, typography, spacing, radius, elevation, or component styling.
- Read `references/responsive-adaptive-mobile.md` for compact/large phone, tablet, landscape, safe-area, and scroll behavior.
- Read `references/state-navigation-i18n.md` when a board implies state, navigation, routing, forms, or visible copy.
- Read `references/accessibility-and-text-scaling.md` before considering native mobile UI complete.
- Read `references/golden-and-device-verification.md` for Flutter-native evidence and completion gates.

When the target repo uses VGV Flutter skills, load the relevant VGV skill for the implementation surface:
`vgv-material-theming`, `vgv-ui-package`, `vgv-bloc`, `vgv-navigation`, `vgv-internationalization`, `vgv-testing`, or `vgv-accessibility`.

## Common Mistakes

| Mistake | Better approach |
|---|---|
| Converting Pencil frames to one giant `Stack` | Use `Column`, `Row`, `CustomScrollView`, slivers, `LayoutBuilder`, `Expanded`, `Flexible`, `Wrap`, and constraints |
| Hardcoding `Color(0x...)`, `TextStyle`, radii, spacing, or shadows in feature widgets | Use `Theme.of(context)`, `ColorScheme`, `TextTheme`, `ThemeExtension`, and existing `app_ui` tokens |
| Rebuilding buttons/cards/fields in a feature screen | Reuse or extend shared `app_ui` primitives |
| Treating a phone board as a fixed canvas size | Preserve hierarchy while adapting to safe areas, text scaling, device width, keyboard, and orientation |
| Copying web navigation or dashboard density into mobile | Use native mobile navigation, sheets, tabs, progressive disclosure, and `go_router` conventions |
| Hardcoding English or French strings in Dart | Add or reuse ARB/l10n keys and pass localized strings into reusable widgets |
| Verifying native Flutter work only in a browser | Use widget tests, goldens, simulator/device screenshots, and accessibility checks |
| Ignoring board intent | Implement visual parity only for approved `visual-truth`; preserve behavior/content only for `semantic-guidance` |
