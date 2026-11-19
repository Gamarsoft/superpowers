---
name: writing-ux-copy
description: Use when a feature introduces user-facing text or when writing, auditing, or approving UI copy, microcopy, French interface wording (libellés, messages d’erreur), CTAs, error messages, empty states, confirmations, helper text, i18n strings, or visible text in frontend specs, packets, and ChatGPT Images prompts.
---

# Writing UX Copy

## Overview

User-visible copy is part of the product contract. Approve labels, messages, prompts, and generated-image visible text before UI work relies on them.

For one label, tooltip or status message, return the exact words to paste into the interface, in the requested language. Use the people, places, objects and controls from this screen. For a full screen, flow, implementation handoff or image prompt, also read the [screen and image guidance](references/screen-and-image-handoffs.md).

## Core Rule

Do not let agents, image models, or code invent user-facing words from technical semantics. Write state-level copy in the user's language, then carry it into specs, packets, ChatGPT Images prompts, i18n files, and verification.

## Source Order

Use terms this audience knows from its work, an approved glossary or translation, or established screens. For a name found only in code or a new mockup, describe its observable effect in words the reader uses. Then check design-system, platform, accessibility and locale conventions.

Read the heading, controls and message together. A check tells people what they can do. A preview says what would change. A confirmation says what changed. When another party still has to confirm, say what may still be possible there. Mention a next step when one is available.

## Français clair dans l’interface

Nommez qui agit et choisissez un verbe courant (« vérifier » pour « procéder à la vérification »). Gardez une idée par phrase, les mots métier connus du public et le ton du produit. Après une vérification, dites ce que la personne peut faire. Si deux boutons se ressemblent, dites ce qu’elle retrouvera après chaque geste.

Lisez le titre puis le message. Si le titre annonce déjà l’enregistrement d’une demande, précisez qui doit encore la confirmer et ce qui reste possible jusque-là. Conservez les conditions et les échéances connues. Le lecteur peut-il dire ce qui a changé, où, et ce qu’il peut encore faire ?

Pour toute rédaction ou relecture destinée à un public francophone, même pour un seul bouton, appliquez la [référence de français clair](references/francais-clair.md). Prenez le vocabulaire et les faits dans le produit en cours.

## Keep copy useful to its audience

For each proposed label, helper, status detail or diagnostic value, identify the user's decision, action, outcome or recovery step it supports. When preparing a copy deck, record that purpose there. Remove a repeated explanation or an indicator with no supported purpose, such as a character count when no limit or task depends on it. A returned API field is not by itself a reason to display it.

For nontechnical task interfaces, express the outcome and next action in product language. Keep audit flags, transport codes and retry identities in diagnostics. If a verified support procedure requires the user to copy an incident reference, show the actual available reference at that recovery step. An engineer's search console alone does not establish that operator handoff; record it as unresolved instead of inventing a reference or a copy action. In an engineering diagnostic interface, the same codes can be necessary task content.

Simplification preserves required information, confirmations, uncertainty and recovery. Retain the approved interaction structure: a copy pass does not add a confirmation screen or remove an approved review panel. Evaluate repeated information by its checking/comparison purpose, not by a blanket ban on repetition. Keep source consultation, observed usability and measured performance as separate evidence.

## Pattern Rules

| Pattern | Required shape |
| --- | --- |
| CTA | Verb + outcome: `Save changes`, not `Submit` |
| Error | What happened and its effect. Give the cause when known and a recovery step when available. |
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
