---
name: writing-ux-copy
description: Use when writing, auditing, or approving UI copy, microcopy, error messages, empty states, CTAs, confirmations, helper text, i18n strings, UX writing, or ChatGPT Images prompt visible text for frontend specs, packets, image prompts, or implementation.
---

# Writing UX Copy

## Overview

User-visible copy is part of the product contract. Approve labels, messages, prompts, and generated-image visible text before UI work relies on them.

## Core Rule

Do not let agents, image models, or code invent user-facing words from technical semantics. Write state-level copy in the user's language, then carry it into specs, packets, ChatGPT Images prompts, i18n files, and verification.

## Source Order

Product terminology and existing i18n win first, then current UI patterns, design-system content rules, platform conventions, accessibility/localization, and general UX writing heuristics.

If a technical term or backend service name is not already product-visible, avoid exposing it in UI copy. Translate the user effect instead.

## Workflow

1. Get context: screen/state, user goal, stress level, locale, product terms, component length, translation, and variables.
2. Inventory copy states: default, loading, empty, success, pending, warning, validation, error, permission, destructive confirmation, and read-only.
3. Write a copy deck:

| State | Element | Final copy | Purpose | i18n / variables | Notes |
| --- | --- | --- | --- | --- | --- |
| warning | heading | `Date de début dans le passé` | Name the risk | final French copy needs accents | Approved |

4. Review every line: purposeful, concise, conversational, and clear.
5. Add acceptance criteria: approved strings or copy deck path, stable terminology, i18n keys/variables, formatting rules, and states to verify.

## Pattern Rules

| Pattern | Required shape |
| --- | --- |
| CTA | Verb + outcome: `Save changes`, not `Submit` |
| Error | What happened + consequence + recovery. |
| Empty state | What is empty + why it matters + next action |
| Confirmation | Consequence in title/body + specific confirm/cancel labels |
| Permission | What is visible, what is blocked, who can act. |
| Loading / pending | What is happening now; no false completion promise. |
| Tooltip | Explain non-obvious behavior; never repeat the label. |

## i18n And Accessibility Checks

- Use correct accents, punctuation, and sentence case.
- Do not concatenate translated fragments.
- Use semantic variables such as `{startDate}`, not `{value}`.
- State plural, date, time, currency, and number formatting rules.
- Keep labels visible; placeholders are examples, not instructions.
- Add accessible names for icon-only controls.
- Leave room for translation expansion and truncation.

## ChatGPT Images Prompt Copy

Before a ChatGPT Images prompt is complete, audit every `Example Visible Text`, warning, empty state, CTA, table label, and dialog string.

Rules:
- Put production-quality visible copy in the final target locale.
- Quote exact visible strings; do not ask the image model to improvise copy.
- Keep technical semantics in `State Semantics`, not in visible UI text.
- If `backfill`, `ruleset`, or a backend service name is internal, replace it with the operator-facing effect unless the product already uses that term.
- Do not use ASCII-only substitutions when the UI locale needs accents.

Example:

| Weak prompt text | Better visible UI text |
| --- | --- |
| `Gateway rechargera l'etat serveur apres activation.` | `L'état se mettra à jour après l'activation.` |
| `Customer Service marquera le backfill comme requis.` | `Une reprise des données sera à traiter après l'activation.` |

Use accents in final French copy.

## Output

Return:

- UX writing summary
- missing copy states
- copy deck
- i18n and accessibility notes
- acceptance criteria additions

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Reviewing only layout states | Review the words in every state too. |
| Leaving backend terms in UI | Name the user-visible consequence. |
| Letting image prompts contain rough copy | Finalize prompt visible text before generation. |
| Using vague CTAs | Name the outcome. |
| Deferring copy to implementation | Approve copy before UI code or visual-truth images depend on it. |
