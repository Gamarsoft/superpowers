# Behavior run: candidate-final-r4

- Variant: candidate @ `a309775583ba0dbefd9bc0d9c21286e748f631d1`
- Live skill revision exercised by the retained smoke: `73f2f42edbf498ddf641b1f4f96c704ee7d7f9ca`
- Harness: Codex exec fresh process, codex-cli 0.153.0
- Model: gpt-5.6-sol (high)

No live skill, prompt, role, or packaging file changed between the smoke's
skill revision and this evidence revision. These are candidate-only invariant
checks, not synthetic before/after improvement claims.

| Scenario | Passed | Samples | Pass rate | Raw evidence |
| --- | ---: | ---: | ---: | --- |
| available-role-dispatch | 5 | 5 | 100.0% | [01](raw/available-role-dispatch-01.json), [02](raw/available-role-dispatch-02.json), [03](raw/available-role-dispatch-03.json), [04](raw/available-role-dispatch-04.json), [05](raw/available-role-dispatch-05.json) |
| brainstorming-review-gates | 5 | 5 | 100.0% | [01](raw/brainstorming-review-gates-01.json), [02](raw/brainstorming-review-gates-02.json), [03](raw/brainstorming-review-gates-03.json), [04](raw/brainstorming-review-gates-04.json), [05](raw/brainstorming-review-gates-05.json) |
| java-profile-taxonomy | 5 | 5 | 100.0% | [01](raw/java-profile-taxonomy-01.json), [02](raw/java-profile-taxonomy-02.json), [03](raw/java-profile-taxonomy-03.json), [04](raw/java-profile-taxonomy-04.json), [05](raw/java-profile-taxonomy-05.json) |

All five clean runtime probes successfully dispatched both `sp_implementer`
and `sp_reviewer` with fresh context and returned their marker values. The
brainstorming and Java samples retained the shared four-disposition taxonomy
and bounded readiness behavior in every repetition.

The no-fallback result is scoped to those five probes, where both exact roles
were advertised. The retained smoke correctly used generic fallback when its
long-lived parent session exposed a stale role inventory. Controller counts
record only tool-observed actions: each typed-role sample has two dispatches
and one review dispatch; prose-only simulations have zero executed events.
