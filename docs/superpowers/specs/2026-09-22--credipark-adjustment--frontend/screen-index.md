# Screen and state index

Final revision: `b2-operator-copy-approved-2026-09-22`. Verification below distinguishes final checks from inherited evidence. All outcomes are synthetic.

| State | Setup | Viewport | Expected behavior | References | Verification | Evidence |
| --- | --- | --- | --- | --- | --- | --- |
| ready | Reload or select Prêt à enregistrer; success response | Desktop1280×720 / narrow390×844 | Identity, input and review are clear; footer reachable; no diagnostic jargon. | desktop-ready, narrow-ready | exercised | Final approved bytes; recaptured at finalization |
| preview | Ready → Prévisualiser | Narrow390×844 | Show131.00 after simulated response; current128.50 unchanged. | narrow-preview | exercised | Final bytes; pending and result observed |
| pending | Ready → preview or save | Desktop/narrow | Disable form/actions/fixture switching; communicate progress. |  | exercised | Final bytes; preview/save pending observed |
| save | Ready → Enregistrer, success response | Desktop | Synthetic success closes; parent says update balance; real integration must refresh. |  | exercised | Final copy revision; success and reopen observed |
| uncertain | Select Interruption → Enregistrer | Desktop | Do not assert failure; retain input and explain retry without edits. |  | exercised | Final copy revision; exact warning observed |
| empty | Select Vide → Prévisualiser | Desktop/narrow | Required errors reachable, first invalid focused, save unavailable. |  | source-inspected | Runtime exercised on earlier B2; final wording/reference checks only |
| overdraw | Ready → Débit,200 → Prévisualiser | Desktop | Refuse debit above balance; preserve input, suggest reduce/reload. |  | source-inspected | Earlier B2 runtime refusal; final recovery wording source-inspected |
| forbidden | Ready → Accès interdit → save | Desktop/narrow | Explain missing rights and contact responsible person; retain fields. |  | source-inspected | Final copy inspected; no fresh runtime permission check |
| preview-error | Interruption → Prévisualiser | Narrow | Preview unavailable; retain input; do not describe it as a save. |  | source-inspected | Earlier B2 preview-error runtime verified; retained final wording |
| long | Select Libellés longs | Desktop/narrow | Long names wrap; review exposes full parking name; controls reachable. |  | source-inspected | Earlier B2 rendered mobile verified; no fresh final long capture |
| no-account | Select Sans compte | Desktop/narrow | Unknown balance/status never presented as active known state. |  | source-inspected | Fixture inspected; production rules remain authoritative |
| edit-retry | Preview then edit amount; uncertain save then retry unchanged | Desktop/narrow | Edit clears preview; unchanged retry keeps identity; edited request changes it. |  | source-inspected | Earlier B2 invalidation/direct-save runtime; identity code inherited from B |
| keyboard | Tab/radio arrows/Escape; reopen | Desktop/narrow | Logical focus and visible indicator; idle close returns to launcher. |  | source-inspected | Earlier B2 Escape/reopen runtime; final reopen observed, not full keyboard audit |
