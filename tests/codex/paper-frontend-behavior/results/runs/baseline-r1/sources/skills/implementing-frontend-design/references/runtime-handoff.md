# Implementation runtime for independent review

Put this block in the existing task or reviewer input. It describes the
implementation being reviewed; prototype launch notes do not replace it.
Keep all seven labeled fields in the dispatch. Mark an unknown value as pending
and resolve it before runtime review; the readiness check names how the reviewer
will know the intended build and target state are ready.

```text
Implementation under review:
- Checkout/build: <absolute path; commit plus dirty-source snapshot/diff identity or immutable build ID>
- Start command and working directory: <actual application command; absolute cwd>
- Base URL and target route: <reachable implementation route, or native app/device target>
- Readiness check: <how to establish that this build is serving and ready>
- Authentication and fixture/state setup: <reproducible steps for a fresh context; credential reference, no secrets>
- Required viewports/platforms: <sizes and relevant states from acceptance>
- Server owner/lifetime: <responsible session/process; how it stays available through review>
```

The reviewer reads project instructions, confirms the served implementation
matches the recorded source/build, and establishes state independently. For a
dirty checkout, a commit alone is insufficient. Use a verified launch from that
checkout with its recorded edits or traceable build provenance. A responsive
port, matching URL or fresh screenshot does not establish source identity.

If a running server's source is unknown, identify it or launch the reviewed
checkout separately; do not stop an unrelated server. Keep the review server
available until recapture completes. If source identity, authentication or
required state cannot be established, record the missing gate and use
`REQUEST_CHANGES` or `ESCALATE`. A fixture bypass demonstrates only its documented
scope. Preserve the existing fresh-context and independent-recapture rules.
