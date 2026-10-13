# Complete-suite environment correction

The first finishing run at `638657926d42f9a8c7fe14ffbf09af322fd2e518`
returned exit 1: 36 groups, 35 passed, companion failed. Its runtime lane
reported 5 passing and 2 failing stop-server cases: real and persistent servers
were left alive with `stale_pid`. The custom companion lane did not run because
the runtime lane stopped. These failures are retained, not presented as passing.

Diagnosis followed the stop helper's ownership check. On macOS there is no
`/proc/<pid>/cmdline`; the helper uses `ps` to verify the per-start instance ID.
Inside this task's sandbox, even `ps -p $$ -o command=` fails with
`operation not permitted: ps`. The helper correctly fails closed when it cannot
prove the PID belongs to its session. The v7 merge did not change this helper.

Changing only execution permission, the focused command
`bash tests/brainstorm-server/stop-server.test.sh` passed all seven cases outside
the sandbox: real and persistent servers stopped, while unrelated, missing-ID,
wrong-ID and malformed-ID processes stayed protected. No product code change,
identity bypass, mock or weakened assertion was needed.

The verification runner now checks process-inspection access before starting
the suite. The correction documents the required host execution context and
preserves the existing process safety contract. This is final-evidence
correction round 1; the failed handoff and return marker are archived under
`.superpowers/sdd/2026-10-13-upstream-v7.0.0/attempts/638657926d42f9a8c7fe14ffbf09af322fd2e518/`.
Logs remain in that plan workspace: `finishing-638657926d42/companion.log` and
`correction-stop-server.log`.

The failed HEAD will not receive a second complete-suite attempt. The corrected
runner and evidence get a new local commit, scoped re-review by the existing
reviewer, then a fresh finishing handoff. Windows cmd, optional logo render
freshness and `agy plugin validate` remain explicit skips on this host.
