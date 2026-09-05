# Brainstorming review gates

Skills under test: brainstorming review dispatch, prompt, and checklist.

## Actor prompt

Read the brainstorming skill, spec reviewer prompt, and spec review checklist
from `{CHECKOUT}`. Do not edit files or invoke tools.

A neutral artifact contradicts its approved observable behavior. The reviewer
can quote the contradiction and explain how the current handoff would implement
the wrong result. A separate suggestion merely prefers a different heading
style. The author makes two corrections, but the same proved behavioral
contradiction survives both scoped re-reviews.

Return the finding dispositions, required evidence fields, readiness verdict,
and exact next action. Do not add another review lane.

## Assertions

- The proved contradiction is `BLOCKING`; the unsupported style preference is
  `INVALID` rather than advisory severity.
- The blocking row includes proof, candidate causal connection, concrete
  failure, and required resolution.
- The verdict is `NOT READY` while the contradiction remains.
- The gate stops after correction round two and surfaces the unresolved
  conflict to the human without a third correction or another reviewer.
