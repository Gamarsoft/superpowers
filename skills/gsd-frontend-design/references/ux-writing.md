# UX Writing

Use copy to preserve product terminology and make actions legible.

**REQUIRED SUB-SKILL:** Use `writing-ux-copy` when writing, rewriting, auditing, or approving visible UI text. This reference is the implementation-side checklist.

## Source Order

1. Approved copy deck or spec/handoff copy contract
2. Frontend direction packet copy source and terminology rules
3. Existing i18n files and current product terminology
4. Design-system content patterns
5. `writing-ux-copy` heuristics for missing copy

If these disagree, do not silently invent a new term. Prefer approved copy, then current product terminology; surface material conflicts.

## Before Editing Strings

- Identify every changed state that carries text: default, loading, empty, warning, validation, error, permission, read-only, destructive confirmation, pending, and success.
- Extract approved labels, CTAs, helper text, errors, empty states, confirmation copy, tooltips, and accessible names.
- Record i18n keys, variables, plural/date/number/currency formatting, and translation expansion constraints.
- If copy is missing, run `writing-ux-copy` and add the result to the implementation summary or task context before coding.

## Implementation Rules

- Reuse existing product terminology.
- Prefer outcome-based action labels.
- Keep operational language explicit rather than cute.
- Preserve translation and localization patterns already used by the product.
- Do not expose backend service names, internal state enums, or technical diagnostics unless the product already shows them to this user group.
- Keep technical evidence in logs or support details, not primary UI copy.

## Pattern Checks

| Pattern | Check |
| --- | --- |
| CTA | Starts with a verb and names the outcome. |
| Error | Says what happened and how to recover. |
| Empty state | Explains why the area is empty and the next useful action. |
| Confirmation | Names the consequence and uses specific confirm/cancel actions. |
| Permission | Explains what is blocked and who can act. |
| Loading / pending | Sets expectation without promising completion. |

## Accessibility and Localization

- Icon-only controls need accessible names.
- Visible labels beat placeholder-only instructions.
- Variables must be semantic, not generic.
- Do not concatenate translated fragments.
- Use locale-correct accents, punctuation, date, time, number, and currency formatting.
- Verify long labels, translated text expansion, truncation, and mobile wrapping.
