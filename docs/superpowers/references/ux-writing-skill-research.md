Here are the best references I found, split into **existing agent skills** and **established UX/product-writing guidance**.

## Existing UX writing / copy skills worth studying

| Reference                             | Why it is useful                                                                                                                                                                                                                                                                  | What I would borrow                                                                                                     |
| ------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **Anthropic `ux-copy` skill**         | Very compact and directly focused on UX copy: CTAs, error messages, empty states, confirmation dialogs, tooltips, loading states, onboarding, localization notes. It asks for context, user state, tone, and constraints. ([GitHub][1])                                           | Good minimal structure, especially the “recommended copy / alternatives / rationale / localization notes” output.       |
| **content-designer/ux-writing-skill** | Much more complete. It is explicitly positioned for Claude, Codex, and Cursor, and covers interface copy, voice/tone, accessibility, quality standards, references, templates, and pattern examples. ([GitHub][2])                                                                | Best base for a serious Codex skill. I would borrow its four standards: **Purposeful, Concise, Conversational, Clear**. |
| **gokulkrishh `/ux-writing` skill**   | Strong compact implementation: gather context, diagnose issues, write/rewrite in a table, check consistency, verify. It includes practical patterns for errors, forms, CTAs, empty states, confirmations, onboarding, permissions, emails, and accessibility text. ([GitHub][3])  | Good workflow for Codex: **context → diagnose → rewrite → consistency check → verify**.                                 |
| **ok-skills `/clarify`**              | Focuses on unclear UX copy, error messages, labels, and instructions. It explicitly asks for audience technical level, user mental state, action, constraints, and the “one thing users need to know.” ([GitHub][4])                                                              | Useful for review mode, especially when improving feature specs rather than writing new copy from scratch.              |
| **Anthropic `skills` repo**           | Good for understanding skill packaging patterns. It states that skills are self-contained folders with a `SKILL.md` file containing instructions and metadata. ([GitHub][5])                                                                                                      | Good reference for skill architecture and examples, not UX-writing guidance itself.                                     |
| **OpenAI `skills` / Codex docs**      | Official Codex guidance says a skill is a directory with `SKILL.md`, optional scripts/references/assets, and required `name` and `description`. Codex uses the description for implicit triggering, so the description must be precise and front-loaded. ([OpenAI Developers][6]) | Use this for Codex-specific format, scope, install location, and triggering behavior.                                   |

My take: the **Anthropic `ux-copy` skill** is a good lightweight example, but for your use case — improving **feature specs** — I would combine the **content-designer skill’s depth** with the **gokulkrishh skill’s workflow** and the **ok-skills clarify skill’s review mindset**.

## Established product-writing guidance to ground the skill

| Source                                          | Core guidance to encode in the skill                                                                                                                                                                                                                 |
| ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Material Design / Material 3 content design** | Use clear, concise UI text, sentence-style capitalization, and component-specific writing rules. This is useful for labels, buttons, headings, menus, and UI consistency. ([Material Design][7])                                                     |
| **Apple Human Interface Guidelines — Writing**  | Use simple, plain language; write with accessibility and localization in mind; avoid jargon and gendered terminology. ([Apple Developer][8])                                                                                                         |
| **GOV.UK Content Design**                       | Start from a real user need, written from the user’s perspective and in the user’s language. Content should help users complete a task, not justify a solution. ([GOV.UK][9])                                                                        |
| **GOV.UK Writing for the Web**                  | Publish only what users need to complete their task. Good content is specific, informative, clear, to the point, uses short sentences, subheadings, and simple vocabulary. ([GOV.UK][10])                                                            |
| **Microsoft Error Message Guidelines**          | Error messages should explain what happened, why, the result for the user, and what they can do next. Avoid jargon, blame, uppercase, exclamation points, and vague generic errors. ([Microsoft Learn][11])                                          |
| **WCAG / W3C WAI**                              | Errors must be identified in text; labels or instructions must identify expected input; known correction suggestions should be provided when possible. ([W3C][12])                                                                                   |
| **W3C WAI forms guidance**                      | Error copy should reference the related field label, describe the error clearly, explain how to fix it, and help users navigate back to the field. ([W3C][13])                                                                                       |
| **Shopify Polaris**                             | Error messages should explain what is wrong and what the merchant needs to do, be specific, avoid jargon like “invalid,” and give detailed next steps. Empty states should provide guidance and a clear next step. ([polaris-react.shopify.com][14]) |
| **Atlassian Design System**                     | Error messages should tell people what problem occurred and what to do next. Empty states are treated as a design/content pattern, not just “no data” text. ([Atlassian Design][15])                                                                 |
| **IBM Carbon**                                  | Tone adapts to context: error messages should be economical and direct; onboarding can be more explanatory. Notifications should include a user action for errors when possible. ([carbondesignsystem.com][16])                                      |
| **Nielsen Norman Group**                        | Error messages should use human-readable language, avoid technical jargon, and avoid obscure codes unless needed for diagnostics. ([Nielsen Norman Group][17])                                                                                       |

## What this means for your Codex skill

I would make your UX Writing skill enforce this hierarchy:

```text
Product-specific voice and terminology
↓
Your design system / content style guide
↓
Platform conventions, for example web, iOS, Android, CLI
↓
Accessibility and localization requirements
↓
General UX writing best practices
```

And I would make it review feature specs through these checks:

```text
1. Does the spec define the user goal?
2. Does it identify all UI states?
3. Does each state have copy?
4. Are errors specific and recoverable?
5. Are CTAs action-oriented?
6. Are destructive actions explicit?
7. Are empty states useful?
8. Are labels visible and meaningful?
9. Is terminology consistent?
10. Is the copy accessible and localizable?
11. Are i18n keys and variables safe?
12. Are copy-related acceptance criteria included?
```

For your specific use case, the skill should not just “make the copy nicer.” It should produce:

```text
- UX writing summary
- Copy audit table
- Missing UI states
- Final copy deck
- i18n / accessibility notes
- Acceptance criteria additions
```

That makes it much more useful inside Codex because it can improve a feature spec before implementation, not only rewrite isolated strings.

[1]: https://raw.githubusercontent.com/anthropics/knowledge-work-plugins/refs/heads/main/design/skills/ux-copy/SKILL.md "raw.githubusercontent.com"
[2]: https://github.com/content-designer/ux-writing-skill "GitHub - content-designer/ux-writing-skill: Agent Skill for systematic UX writing — scale content quality through AI-powered design system enforcement. Works with Claude and Codex. · GitHub"
[3]: https://raw.githubusercontent.com/gokulkrishh/skills/main/skills/ux-writing/SKILL.md "raw.githubusercontent.com"
[4]: https://github.com/mxyhi/ok-skills/blob/main/impeccable/clarify/SKILL.md "ok-skills/impeccable/clarify/SKILL.md at main · mxyhi/ok-skills · GitHub"
[5]: https://github.com/anthropics/skills "GitHub - anthropics/skills: Public repository for Agent Skills · GitHub"
[6]: https://developers.openai.com/codex/skills "Agent Skills – Codex | OpenAI Developers"
[7]: https://m3.material.io/foundations/content-design/style-guide?utm_source=chatgpt.com "Style guide – Material Design 3"
[8]: https://developer.apple.com/design/human-interface-guidelines/writing?utm_source=chatgpt.com "Writing | Apple Developer Documentation"

[9]: https://www.gov.uk/guidance/content-design/user-needs " Content design: planning, writing and managing content - User needs - Guidance - GOV.UK
"
[10]: https://www.gov.uk/guidance/content-design/writing-for-gov-uk " Content design: planning, writing and managing content - Writing for GOV.UK - Guidance - GOV.UK
"
[11]: https://learn.microsoft.com/en-us/windows/win32/debug/error-message-guidelines "Error Message Guidelines - Win32 apps | Microsoft Learn"
[12]: https://www.w3.org/WAI/WCAG22/Understanding/error-identification.html?utm_source=chatgpt.com "Understanding Success Criterion 3.3.1: Error Identification"
[13]: https://www.w3.org/WAI/tutorials/forms/notifications/?utm_source=chatgpt.com "User Notification | Web Accessibility Initiative (WAI)"
[14]: https://polaris-react.shopify.com/content/error-messages?utm_source=chatgpt.com "Error messages — Shopify Polaris React"
[15]: https://atlassian.design/content/designing-messages/writing-error-messages?utm_source=chatgpt.com "Overview - Error messages"
[16]: https://carbondesignsystem.com/guidelines/content/overview/?utm_source=chatgpt.com "Content guidelines"
[17]: https://www.nngroup.com/articles/error-message-guidelines/?utm_source=chatgpt.com "Error-Message Guidelines"
