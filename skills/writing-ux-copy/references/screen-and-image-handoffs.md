# Writing copy for screens, flows and image prompts

Use the sections that match the requested deliverable.

## Workflow for a screen or flow

1. Get context: screen/state, user goal, stress level, locale, product terms, component length, translation, and variables.
2. Inventory copy states: default, loading, empty, success, pending, warning, validation, error, permission, destructive confirmation, and read-only.
3. Write a copy deck:

| State | Element | Final copy | Purpose | i18n / variables | Notes |
| --- | --- | --- | --- | --- | --- |
| warning | heading | `Date de début dans le passé` | Name the risk | final French copy needs accents | Approved |

4. Review every line: purposeful, concise, conversational, and clear.
5. Add acceptance criteria: approved strings or copy deck path, stable terminology, i18n keys/variables, formatting rules, and states to verify.

## ChatGPT Images Prompt Copy

Before a ChatGPT Images prompt is complete, audit every `Example Visible Text`, warning, empty state, CTA, table label, and dialog string.

Rules:
- Put production-quality visible copy in the final target locale.
- Quote exact visible strings; do not ask the image model to improvise copy.
- Keep technical semantics in `State Semantics`, not in visible UI text.
- Choose terms for this audience using the same evidence as for implemented screens.
- Do not use ASCII-only substitutions when the UI locale needs accents.

Example:

| Weak prompt text | Better visible UI text |
| --- | --- |
| `Gateway rechargera l'etat serveur apres activation.` | `L'état se mettra à jour après l'activation.` |
| `Customer Service marquera le backfill comme requis après activation.` | `Après l’activation, il restera des données à compléter.` |

Use accents in final French copy.

## Screen or flow handoff

For a full handoff, include the following.

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
