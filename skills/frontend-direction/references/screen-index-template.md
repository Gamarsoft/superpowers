# Screen and State Index Template

Default: `docs/superpowers/specs/YYYY-MM-DD--{slug}--frontend/screen-index.md`.
Keep IDs aligned with `packet.json.states` and current reference IDs. Include implementation-shaping entry, outcome, dialog, error, loading, empty, permission and responsive states; omit irrelevant route inventories.

```markdown
# Screen and state index

| State ID | User task / priority | Setup or trigger | Viewport/platform | Expected behavior / acceptance | Current reference IDs | Verification and exact evidence revision |
| --- | --- | --- | --- | --- | --- | --- |
| success | Inspect detail / P0 | Open /; open detail | Desktop 1280×900 | Identity dominates; pager stays visible while rows scroll | desktop-v3 | Exercised on v3; page 1→2 and keyboard focus checked |
| error | Recover failed request / P0 | Open /?state=error | Desktop and narrow | Only failed region shows error; retry preserves other data | [] | Source-inspected on v3; runtime retry not yet exercised |
```

Use concrete conditions and expected outcomes, including long content, boundaries and keyboard/focus behavior where relevant. State exactly what was checked on the final source, inherited from earlier versions, source-inspected, or not exercised. Do not turn authored fixture coverage into claimed runtime proof. A state without a screenshot can use a reproducible prototype trigger; record remaining verification and production integration separately.
