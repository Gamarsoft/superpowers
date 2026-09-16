# Frontend design source review

Reviewed 2026-09-16 for the approved frontend design knowledge proposal. This is source assessment, not a claim that a helper was executed or its effect benchmarked. Behavioral results live in the evaluation report.

## Reviewed revisions

| Source | Immutable revision | Material inspected | License |
| --- | --- | --- | --- |
| [wondelai/skills](https://github.com/wondelai/skills/tree/c172996495bed0fcd26896a9416b2093fd7073f0) | `c172996495bed0fcd26896a9416b2093fd7073f0` | `design-everyday-things/SKILL.md`, `refactoring-ui/SKILL.md`, root license | MIT, copyright 2025 Wondel.ai sp. z o.o. |
| [Vercel Web Interface Guidelines](https://github.com/vercel-labs/web-interface-guidelines/tree/e3d624baaf29dc1fc645aff3e38f03e564d2d6b1) | `e3d624baaf29dc1fc645aff3e38f03e564d2d6b1` | Actual `command.md` and root license | MIT, copyright 2025 Vercel Labs |
| [ibelick/ui-skills](https://github.com/ibelick/ui-skills/tree/c5bcd86450b3582ba25204c622b9213b07464938) | `c5bcd86450b3582ba25204c622b9213b07464938` | `skills/fixing-accessibility/SKILL.md`, root license | MIT, copyright 2026 Julien Thibeaut |
| DashPark installed Impeccable | 4.3.1, local file identities below | Entry point, operational guidance and relevant critique excerpts | No copied upstream prose proposed; installed optional reference only. Reassess license before vendoring it. |

Root licenses were retrieved at the same commits as their source files. Preserve applicable copyright and permission notices with retained adaptations. Do not treat a skill author's adaptation as an official publication by the book's author. No book content was retrieved or copied.

Impeccable file SHA-256 identities:

- `SKILL.md`: `38c2e839e130008b6da814ab9c16f3fcbbedfdf721a9638eebd31a9e65341a7a`
- `reference/operate.md`: `a9d2203acd45ca33a13d5c68b02b23ed512425ac15f0e8438318ed124b43729d`
- `reference/critique.md`: `cb8caddbb3919e5bf7f252143b519fb16db28a244642d937b186cb89962d9201`

These identify the reviewed installation, not the latest upstream release. Resolve the actual installed interface when invoking a helper. No binary/context loader or critique command was run for this assessment.

## Candidate value and corrections

| Source | Useful subject to evaluation | Do not transfer unchanged |
| --- | --- | --- |
| Design of Everyday Things adaptation | Discovering actions, understanding outcomes, mapping controls to effects and recovery | Self-assigned perfection scores, universal time-to-discover tests, absolute claims that more constraints always help. |
| Refactoring UI adaptation | Relative emphasis, proximity, deliberate scales and semantic color | Ordinary 18px text treated as large text; one spacing scale for all projects; automatic expansion of whitespace or assumptions that density is bad. |
| Installed Impeccable | Operational task focus, familiar controls, selective hierarchy and critique knowledge | Skeletons or nonmodal alternatives as unconditional requirements; fixed visible-choice limits; taking over workflow or design memory when only a reference is needed. |
| Vercel actual guidelines | Labels, semantics, visible focus, long content, asynchronous state and numeric readability | Requiring custom key handlers on native buttons; URL persistence for every UI state; React syntax/libraries, title-case copy, blanket autocomplete settings or numerical virtualization thresholds. |
| Fixing accessibility | Focus/dialog/form checks and small fixes within scope | Treating every composite-widget member as a Tab stop; assuming aria-label is the only valid name; treating a static audit as proof of assistive-technology behavior. |

Use evidence to select corrections. The presence of a questionable upstream rule is not proof that our current skill reproduces it, and does not by itself justify new behavioral instructions.

## Authoritative accessibility checks

The [W3C contrast guidance](https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html) distinguishes regular and large text: 18pt regular or 14pt bold qualifies as large, approximately 24px or 18.67px. At AA, ordinary text needs 4.5:1 and qualifying large text needs 3:1, subject to the criterion's exceptions. An 18px regular balance value is not large text merely because it is visually prominent.

The [WAI tabs pattern](https://www.w3.org/WAI/ARIA/apg/patterns/tabs/) separates entry into the tab group from arrow-key movement within it. Its [modal dialog pattern](https://www.w3.org/WAI/ARIA/apg/patterns/dialog-modal/) covers containment, initial focus and return to a logical location. APG is implementation guidance; source conformance is not a full accessibility certification. Exercise the actual widget and record any assistive-technology checks that were not run.

Accessed 2026-09-16. Keep links and access date with these normative checks; reconsider them when updating the maintained references. Source updates should be reviewed, never silently fetched into the rule set on each design task.

## Adoption boundary

The current workflow retains control of scope, approval, packet identity and review. `writing-ux-copy` retains copy and localization decisions. Build focused references only after baseline evidence shows the decision they improve. Knowledge consultation is not an Impeccable execution claim, and missing optional tooling must not block the core workflow.

Applicable source copyright and permission notices are retained in [design-knowledge-NOTICE.txt](design-knowledge-NOTICE.txt).
