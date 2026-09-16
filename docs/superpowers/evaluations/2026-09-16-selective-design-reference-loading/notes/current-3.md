# Ajustement Credipark — décision de refinement

## Sources réellement consultées

- `brief.md` et `micro-task.md`, en entier.
- `context/AGENTS.md` (progressive disclosure, contraintes critiques), `context/PRODUCT.md` (utilisateurs, principes, accessibilité), `context/gateway/AGENTS.md` (Angular 7/Nebular et source de vérité serveur), `context/gateway/PRODUCT.md` (contexte opérateur, personnalité, anti-références), `context/gateway/DESIGN.md` (Overview, Typography, Layout, Components, Do/Don’t), `FRONTEND-ANCHORING.md` (customer/loyalty et vérification), `DESIGN-EVIDENCE.md` (runtime sample, limites).
- Sources du dialogue : HTML, TypeScript (`ngOnInit`, états, preview/submit/reload), SCSS, tests, `copy.json`, et inspection de `user-baseline.png`.
- Référence figée `frontend-direction/SKILL.md` (Standalone brief, Design loop, Boundaries), puis `design-source-priority.md` (autorité), `brownfield-ui-extraction-template.md` (contraintes/libertés), `task-to-layout.md` (information et relations), `frontend-review-checklist.md` (états et vérification).

## Direction proposée

Conserver un dialogue blanc, dense, Open Sans, avec en-tête et pied fixes et corps défilant. Réorganiser son corps en trois blocs continus : **Contexte**, **Ajustement**, **Justification et confirmation**. Le prochain choix doit être lisible ainsi : « pour quel client/parking, quel effet, avec quelle preuve, puis quelle action ».

1. **Contexte compact à deux niveaux.** Première ligne : client et compte; seconde : parking et solde actuel. Supprimer le faux statut « Actif » quand le compte est inconnu; afficher simplement « Compte indisponible ». Coût : quatre métriques ne tiennent plus sur une seule ligne, mais les noms longs gagnent de la place et aucune éligibilité n’est inventée.
2. **Effet regroupé.** Placer Sens et Montant côte à côte, puis une bande de résultat juste dessous : `Solde actuel 8,20 cp → Effet −2,50 cp → Solde après aperçu 5,70 cp`. Avant réponse serveur, la dernière valeur reste `À prévisualiser`; l’effet signé peut venir de la saisie valide. Coût : une ligne verticale de plus; elle évite de chercher le signe et le résultat dans deux zones.
3. **Preuves dans l’ordre de saisie.** Parking, Motif, Note, avertissement, puis confirmation, avec erreur immédiatement sous le contrôle concerné. Les six motifs restent identiques. Coût : la note descend légèrement, compensé par des espacements de 12–16 px plutôt que de nouvelles cartes.
4. **Pied d’action stable.** `Fermer` discret à gauche; `Prévisualiser` secondaire et `Enregistrer l’ajustement` primaire à droite. `Recharger le solde` apparaît dans le message d’échec/conflit, au voisinage de sa cause. À 390 px, boutons pleine largeur dans l’ordre Enregistrer, Prévisualiser, Fermer. Coût : le rechargement n’est plus toujours visible; il devient mieux associé à la récupération.

## Comportement et proposition

Restent contractuels : montant positif à deux décimales, signe déterminé par crédit/débit, parking/motif/note/confirmation requis, aperçu optionnel, valeurs serveur, invalidation de l’aperçu après édition, blocage invalide/occupé, conservation des saisies en échec, idempotence, fermeture puis rechargement parent, tous états d’erreur.

**Proposition comportementale à valider :** masquer l’action de rechargement hors échec/conflit. Tout le reste est une modification de hiérarchie, libellé ou disposition.

## Vérifications représentatives

Contrôler 1536×1024, 1280×720 et 390×844 : corps seul défilant, pied accessible, noms longs sans chevauchement. Parcourir clavier/focus, erreurs requises, aperçu prêt puis invalidé par édition, chargement, conflit, interdit, panne service et succès; vérifier que les saisies survivent aux échecs et qu’aucun solde local n’est recalculé. Ceci est une décision pré-prototype : aucune preuve rendue ni approbation n’est revendiquée.
