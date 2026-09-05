# Independent evidence audit: REJECTED

The schema scorer printed 40/40, but an independent review rejected this run as
the final evidence record. The actor responses remain immutable here.

Blocking findings:

- cadence responses describe two unit reviews plus final integration review,
  while their stored `review_count` is two;
- scope-pressure responses contain two distinct `FOLLOW_UP` findings, while
  their dispositions collapse those occurrences;
- most nonzero counters lack corresponding controller actions in `event_trace`;
- no-subagent responses summarize, rather than reproduce, the complete binding
  execution-report handoff; and
- one finishing response uses a seven-character report suffix despite the
  finishing contract's twelve-character minimum.

`candidate-final-r1` preserves the valid actor responses with corrected derived
traces and replaces the incomplete fallback and finishing samples with fresh
actors. Do not cite this run's nominal schema score as passing evidence.
