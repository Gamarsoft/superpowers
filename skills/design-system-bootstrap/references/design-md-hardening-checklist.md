# DESIGN.md hardening checklist

Use this before finalizing `.stitch/DESIGN.md`.

## Boundary and continuity

- [ ] The file names one product surface only.
- [ ] The Stitch project name and ID are recorded.
- [ ] Reuse vs new-project decision is explicit.
- [ ] Contradictory legacy or redesign areas are excluded or clearly marked.

## Source quality

- [ ] Anchor screens are listed in `.stitch/bootstrap-report.md`.
- [ ] The anchor set covers shell, dense content, detail, form/edit, overlays, and key states where applicable.
- [ ] Repo-native sources were checked for tokens, theme files, or shared primitives.
- [ ] Major inferred sections are clearly marked.

## Design system quality

- [ ] Color roles include exact hex codes.
- [ ] Typography rules describe family, weight, hierarchy, and tone.
- [ ] Layout principles describe spacing rhythm and page density.
- [ ] Geometry describes corner style and shape language.
- [ ] Depth and elevation patterns are described.
- [ ] App shell and navigation behavior are captured.
- [ ] Core components are covered: buttons, inputs, cards/containers, tables/lists, badges/tags, modals/drawers.
- [ ] State behavior is covered: empty, loading, error, validation, success, permission when relevant.
- [ ] Responsive behavior is covered when the product is responsive.
- [ ] Motion and interaction tone are covered when visible and meaningful.
- [ ] Content tone is captured if the UI language has a distinct voice.

## Brownfield implementation fitness

- [ ] The file preserves current product language instead of proposing a redesign by default.
- [ ] Verified repo conventions override purely visual guesses.
- [ ] `Must preserve`, `May flex`, and `Explicit no-go` sections exist.
- [ ] The file is specific enough that `frontend-direction` can generate new screens without making up a new aesthetic.

## Ready signal

- [ ] `.stitch/DESIGN.md` is ready for reuse.
- [ ] `.stitch/bootstrap-report.md` lists refresh triggers and remaining gaps, if any.
