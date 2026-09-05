# Behavior run: baseline-finishing-return-v2

- Variant: baseline @ `d9a937091926ace90db0da318fb34b78adbbb8e8`
- Harness: Codex exec fresh process, codex-cli 0.153.0
- Model: gpt-5.6-sol (high)

| Scenario | Passed | Samples | Pass rate | Raw evidence |
| --- | ---: | ---: | ---: | --- |
| finishing-evidence | 0 | 5 | 0.0% | [01](raw/finishing-evidence-01.json), [02](raw/finishing-evidence-02.json), [03](raw/finishing-evidence-03.json), [04](raw/finishing-evidence-04.json), [05](raw/finishing-evidence-05.json) |

All five baseline actors lacked the producer-return identity, archive/resume,
preserved final-evidence count, refreshed new-HEAD review, and failed-HEAD
non-retry contract. Because the baseline scored 0/5 rather than 4/5, the
conditional expansion to ten samples did not apply.
