# Retained end-to-end SDD smoke

This is the successful final synthetic smoke for the lean, risk-scaled delivery
flow. Unlike the rejected earlier narrative-only attempt, its repository,
commit graph, plans, reports, ledger, briefs, and exact review packages are
retained here.

The smoke exercised live skill revision
`73f2f42edbf498ddf641b1f4f96c704ee7d7f9ca`. The final behavior manifest is
bound to evidence revision `a309775583ba0dbefd9bc0d9c21286e748f631d1`;
the intervening commits changed only the self-hosting plan, its contract test,
and this finishing-evidence scenario. `git diff` reports no changes to live
skills, prompts, role definitions, or packaging files across those revisions.

## Reproduce the repository

The Git bundle contains the complete fixture history and `sdd-smoke-base` tag:

```bash
git bundle verify smoke-repo.bundle
git clone smoke-repo.bundle /tmp/superpowers-smoke-replay
git -C /tmp/superpowers-smoke-replay log --oneline --decorate
```

The successful history is:

- fixture base and `sdd-smoke-base`:
  `232c6391d64a6e59c820c402113b149c891bfb7e`
- pre-implementation planning correction:
  `ebbf4dc1e78a5437f4ff3f78ce23afec4ca57e5c`
- Tasks 1-3 ordinary checkpoint:
  `370cd9b93a7d6617e62e92b4200de970d7e96dde`
- Task 4 deliberately defective review candidate:
  `fc5a33187e00b288e9e4625fbb36dbbcc6347abc`
- Task 4 correction and Implementation HEAD:
  `c4a4126bc61f889f3561647a9f4d385a8e8b38ce`
- report-only finishing commit:
  `4eb169381911d345e7e5b45c1951ba1e7745b0d6`

## Observed path

1. Initial preflight stopped before dispatch because Task 2 contradicted the
   approved lowercase contract.
2. The plan owner corrected the plan. A fresh holistic reviewer returned READY
   after verifying the declared spec and base ref resolve.
3. Tasks 1-3 formed one ordinary batch. Each focused test went RED then GREEN;
   the three-label integration ran 3 tests. One checkpoint reviewer accepted
   the exact range without rerunning tests.
4. Task 4 ran alone. Its four focused tests passed, but the candidate retained
   only idempotency-key membership and recomputed duplicate balances.
5. The mandatory reviewer used a causal probe: later duplicate inputs returned
   `8999` instead of stored `750`, and `900` instead of stored `100`. It returned
   NOT READY.
6. Correction round 1 returned to the original implementer. Three new
   regressions first failed; the corrected key-to-balance registry then passed
   all 6 focused tests. The same reviewer returned READY on the scoped range.
7. SDD ran the affected four-module integration once: 9 tests passed. A fresh
   final integration reviewer returned READY at the clean exact implementation
   HEAD.
8. SDD wrote the plan-scoped execution report without running the complete
   suite. Finishing validated it, ran the discovery suite exactly once at that
   HEAD (10 tests, OK), and committed only the durable report path.

## Bounded counts

- work-unit implementation dispatches: 2
- checkpoint/task review gates: 2
- correction rounds: 1
- scoped re-reviews: 1
- final integration reviews: 1
- complete-suite runs before finishing: 0
- complete-suite runs in finishing: 1
- producer returns: 0
- human stops: 0

The separate behavior scenarios exercise the two-round breaker and finishing
return transitions; this success smoke intentionally exercises one correction
and the no-return finishing path.

## Retained artifacts

`smoke-artifacts/` contains the corrected spec and plan, full ledger, generated
task briefs, append-only implementer reports, every exact review package, and
the completed execution report. `controller-trace.json` records the ordered
dispatches, revisions, verdicts, commands, and counts. The report-only commit in
the bundle contains exactly:

`docs/superpowers/execution-reports/implementation-plan-c4a4126bc61f.md`

The controller removed no evidence before copying these artifacts. The original
temporary repository may be deleted only after the bundle and copied artifacts
pass their integrity checks.
