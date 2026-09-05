# Initial evidence audit: NOT READY

The first five `available-role-dispatch` actors reported successful role
markers, but their ephemeral JSONL transcripts retained only an empty `wait`
event and the actors' own final JSON. They did not retain the operational
`spawn_agent` calls, exact role/fresh-context arguments, child identities, or
child marker messages. Those self-reported samples were rejected before
publication and moved under `rejected-ephemeral/`.

The audit also found noncanonical assertion IDs/counts and inconsistent
simulated event counters. Those are traceability follow-ups rather than semantic
failures; final publication uses an explicit controller counting rule and does
not infer dispatches from actor-authored counters.

Other evidence passed: finishing return baseline 0/5 and candidate 5/5,
brainstorming and Java 5/5, exact revision/manifests, unchanged live skill files
from `73f2f42` through `a309775`, verified smoke bundle/commit graph/report-only
range, byte-matching review packages, 9/9 integration replay, and 10/10 full
fixture replay.

Verdict: **AUDIT NOT READY** until five persistent typed-role probes retain
their parent and child operational transcripts.
