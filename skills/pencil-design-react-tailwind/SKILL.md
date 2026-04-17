---
name: pencil-design-react-tailwind
description: Detailed optional adapter for translating Pencil work into React + semantic-token Tailwind + reusable component systems.
---

# Pencil Design for React + Tailwind

Use this skill with `pencil-design-core` only when the actual target repo is React / Tailwind.

This adapter intentionally preserves the richer React/Tailwind detail from the original online skill, but keeps it isolated so it does not leak into Angular/Nebular brownfield work.

For GSD-facing workflows, use Pencil CLI interactive mode to inspect the approved `.pen` evidence.
Do not use Pencil MCP in this workflow.

## Use this skill when

- a `.pen` file must be translated into React-oriented implementation guidance
- the repo already uses a semantic token layer with Tailwind-like utilities
- reusable React components are the target output
- responsive artboards or variants need to become mobile-first component behavior

## Do not use this skill when

- the repo is Angular + Nebular
- the task is only `.pen` authoring with no React/Tailwind code target
- the repo does not actually use a semantic utility or reusable React component model

## Core rules

1. load `pencil-design-core` first
2. read variables before generating classes
3. map reusable Pencil components to reusable React components
4. use semantic token classes instead of raw arbitrary values whenever the repo provides them
5. generate mobile-first structure, then responsive overrides
6. verify against screenshots and layout checks, not only the node tree

## Recommended workflow

1. read the packet and relevant `.pen` files
2. inventory reusable components
3. inventory variables/tokens
4. use Pencil CLI interactive mode for deterministic reads, exports, and bounded edits
5. inspect responsive boards or variants
6. map patterns to reusable React components
7. map tokens to semantic class usage
8. generate code guidance that stays consistent with the repo’s conventions
9. verify against the design evidence

## Read order

1. `references/design-to-code-workflow.md`
2. `references/tokens-and-theme.md`
3. `references/tailwind-shadcn-mapping.md`
4. `references/responsive-breakpoints.md`
