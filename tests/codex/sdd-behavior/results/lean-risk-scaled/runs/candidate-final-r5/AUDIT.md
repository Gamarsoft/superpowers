# Independent audit: candidate-final-r5

**Verdict:** READY

| Class | Finding |
| --- | --- |
| `BLOCKING` | None. |
| `FOLLOW_UP` | None. |
| `INVALID` | Earlier package and revision defects apply only to the four explicitly rejected trees. Canonical evidence does not reference them. |

## Verified evidence

- Candidate revision resolves exactly to
  `7f4ff8c478e64fbd39c8a71f54fd142407d3df47`.
- Package checksum is
  `402f3fdf5b0385a56660c509ebae3ab9af5783d878d326e1b1b399d8a19fc0af`.
- Package provenance matches byte-for-byte: 128 candidate non-metadata files,
  14 candidate metadata files, and 13 metadata files from official
  `openai/plugins` commit
  `1e285826e604f66f7208f7ac4dba0fe8341d1f57`.
- The archive contains no `.codex/agents`.
- All five samples contain one parent and two generic children.
- All ten `spawn_agent` calls omit `agent_type` and use
  `fork_turns: "none"`.
- No child dispatched another agent or used an unavailable typed role.
- Parent prompt ciphertext matches each child's received ciphertext. Returned
  markers cover every required implementation and review field and match
  parent-observed results.
- Each transcript exactly equals its actor output. Each raw actor projection
  also equals the actor output.
- Every actor contains the same five required assertion IDs, in order, with
  all assertions passing.
- Counts match tool evidence: two dispatches, one review, zero fixes, and zero
  human stops per sample.
- All ten event paths resolve, are non-ignored, and stay outside rejected
  trees.
- The scorer reports 5/5.
- Scorer contracts, package contracts, lean-delivery contracts, and
  `git diff --check` pass.

**FALLBACK AUDIT READY**
