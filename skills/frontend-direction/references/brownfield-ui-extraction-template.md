# Brownfield UI Extraction Template

Use before visual exploration in brownfield work.

Default file:
`docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/brownfield-ui-extraction.md`

## Purpose

This artifact keeps agents from inventing. It captures the current product truth, names what should stay stable, and separates safe improvement from accidental redesign.

## Authoring Rules

- Use current runtime and source truth, not aspirational design language.
- Preserve what works before critiquing what does not.
- Distinguish `must preserve`, `may adapt`, and `safe to improve now`.
- Keep the scope local to the current slice.

## Template

```markdown
# [Feature / Project Name] - Brownfield UI Extraction

## 1. Source Evidence
- Feature or workflow:
- Routes/screens reviewed:
- Code areas reviewed:
- Runtime screenshots/browser captures:
- Existing docs or anchoring:
- Missing evidence:

## 2. Preserve / Adapt / No-Gos
### Must preserve
- [shell / workflow / state / pattern]

### May adapt
- [useful but adaptable pattern]

### Explicit no-gos
- [redesign move that would overreach]

## 3. Foundations Present
- Color/theme source:
- Typography source:
- Spacing rhythm:
- Surfaces/elevation:
- Variables/token files:
- Known drift:

## 4. Shared Patterns And Components
| Pattern/component | Where it exists | Reuse call | Known issue |
| --- | --- | --- | --- |
| [header] | [...] | preserve | [...] |
| [table + filters] | [...] | preserve + adapt mobile | [...] |

## 5. Screen Family Notes
### [Screen family]
- User goal:
- Current layout shape:
- Density/hierarchy:
- Primary actions:
- Important states:
- Mobile reality:
- Strong points:
- Weak points:

## 6. Approved Reference Needs
- Candidate visual-truth source: approved images | retained screenshots/browser captures | current UI/degraded
- ChatGPT Images 2 prompts/images to create or approve, if useful:
- Screenshots/captures to retain:
- States still missing evidence:
```

## Quality Bar

A strong extraction artifact captures current product knowledge, makes boundaries explicit, identifies only relevant drift, gives optional image prompts a grounded starting point, and prevents accidental redesign.
