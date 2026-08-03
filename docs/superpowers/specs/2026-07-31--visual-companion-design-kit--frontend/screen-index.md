# Visual Companion Design Kit — Screen Index

The implementation-shaping intents in this index were approved on 2026-07-31.

| ID | Screen / State | User goal | Priority | Source / trigger | Primary reference | Intent | Approval | Notes |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| S0 | Shared shell: waiting + connection states | Know whether the Companion is ready without distracting from the artifact | P0 | keyed root; WebSocket lifecycle | Approved copy deck + current frame/helper behavior | `semantic-guidance` | approved | Compact header; status stays live-announced; no footer without choices |
| S1 | Diagram exemplar: payment processing flow | Trace the main path, retry loop, dead-letter branch, and trust boundary | P0 | `architecture-data-flow.html` | Packet register contract; four `baseline-diagram-*` captures are problem evidence | packet = `semantic-guidance`; captures = `reference-only` | approved | Desktop left-to-right; narrow top-to-bottom; non-interactive and no footer |
| S2 | Product mockup exemplar: retry-policy change review | Inspect evidence, proposed change, guardrails, and choose approve or reject | P0 | new fragment; `experience` intent | Packet register contract; no durable current screenshot exists | `semantic-guidance` | approved | Clearly label `Simulated product surface`; use only `data-choice` for actions |
| S3 | Editorial exemplar: export-flow decision synthesis | Read the conclusion first, then evidence, open questions, and deferred items | P0 | upgraded `carry-forward-summary.html` | Packet register contract; four `baseline-editorial-*` captures are problem evidence | packet = `semantic-guidance`; captures = `reference-only` | approved | Read-only exemplar; terminal owns continuation; no fake choices or footer |
| S4 | Choice states: empty, focus-visible, selected | Understand and operate a real choice with keyboard and screen-reader semantics | P0 | focus or activation on `[data-choice]` | `baseline-comparison-{unselected,focus-visible,selected}.png` | `semantic-guidance` for state clarity only | approved | Palette, radii, and shadow are not binding; state synchronization is |
| S5 | Interactive disconnect + recovery | Understand why a choice is unavailable and how to recover | P0 | connection loss while choices exist | Approved copy deck + helper behavior | `semantic-guidance` | approved | Footer: `Connection lost. Reconnect before choosing an option.`; non-interactive artifacts keep no footer |
| S6 | Narrow and dark variants | Preserve meaning, order, contrast, and touch/keyboard access | P0 | `<640px`; `prefers-color-scheme: dark` | Foundation and per-register responsive rules in parent packet | `semantic-guidance` | approved | Minimum supported audit width 320px; retained captures use 390 × 844 |

## Deferred

- Restyling the remaining comparison, ranked-alternative, or annotation examples.
- New registers, a generic diagram DSL, browser-native confirmation, or a
  persistent theme/configuration editor.
- Generated image references. None are needed for this packet.

## Post-implementation visual truth

After implementation, the required runtime captures named in the parent packet
become candidate `visual-truth`. That intent mode is approved; the actual images
must still be inspected and accepted before they become binding visual evidence.
