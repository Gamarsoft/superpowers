# Behavior run: candidate-final-r4-paired

- Variant: candidate @ `a309775583ba0dbefd9bc0d9c21286e748f631d1`
- Matched baseline: `baseline-finishing-return-v2` @ `d9a937091926ace90db0da318fb34b78adbbb8e8`
- Harness: Codex exec fresh process, codex-cli 0.153.0
- Model: gpt-5.6-sol (high)

| Scenario | Baseline | Candidate | Samples | Raw evidence |
| --- | ---: | ---: | ---: | --- |
| finishing-evidence | 0/5 | 5/5 | 5 | [01](raw/finishing-evidence-01.json), [02](raw/finishing-evidence-02.json), [03](raw/finishing-evidence-03.json), [04](raw/finishing-evidence-04.json), [05](raw/finishing-evidence-05.json) |

Every candidate actor preserved return identity and correction count, archived
the rejected attempt, refreshed evidence/review at a new HEAD, refused a second
suite run for the failed HEAD, and stopped before correction round three.
