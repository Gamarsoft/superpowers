# Ajustement Credipark — décision de conception

## Sources effectivement lues

- `brief.md` et `micro-task.md`.
- `context/AGENTS.md` : **Progressive Disclosure**, **Working approach**, **Critical Constraints** ; `context/PRODUCT.md` : **Users**, **Capabilities and Constraints**, **Brand Commitments**, **Product Principles**, **Accessibility & Inclusion**.
- `context/gateway/AGENTS.md` : **Project Overview**, **Tooling constraints**, **Frontend (Angular v7 + Nebular)**, **Frontend Context** ; `context/gateway/PRODUCT.md` : **Users**, **Product Purpose**, **Capabilities and Constraints**, **Brand Personality**, **Anti-references**, **Product Principles**, **Accessibility & Inclusion** ; `context/gateway/DESIGN.md` : **Overview**, **Colors**, **Typography**, **Layout**, **Shapes**, **Components**, **Do’s and Don’ts**.
- Source complet : composant HTML/SCSS/TypeScript, tests, `copy.json`, et capture `user-baseline.png`.
- Références figées : `frontend-direction/SKILL.md` (**Choose the entry and scope**, **Design loop**, **Boundaries and continuation**) ; `design-source-priority.md` (**Scoped Design Authority**) ; `brownfield-ui-extraction-template.md` (**Evidence**, **Constraints and anchors**, **Problems and design freedom**, **Boundaries**) ; `task-to-layout.md` (**Establish the information model**, **Choose visual relationships**, **Connect the choice to evidence**) ; `writing-ux-copy/SKILL.md` (**Source Order**, **Workflow**, **Pattern Rules**, **i18n And Accessibility Checks**).

## Direction proposée

Retenir un dialogue blanc compact, Open Sans, actions bleues, dont le parcours visuel est : **contexte faisant autorité → effet de l’écriture → preuves obligatoires → confirmation → action**.

1. **Contexte en bandeau à trois données : client, compte, solde disponible.** Supprimer le statut « Actif » lorsque le compte est indisponible : cette donnée ne prouve aucun statut. Les noms longs passent sur plusieurs lignes sans troncature. Coût : bandeau plus haut sur petit écran.
2. **Associer sens et montant dans un même bloc “Effet”.** Présenter Crédit/Débit comme deux choix explicites, le montant positif en `cp`, puis une ligne calculée « Effet sur le solde : −12,30 cp ». Après prévisualisation serveur, afficher solde actuel → variation → solde après écriture dans ce bloc. Coût : davantage de hauteur ; le résultat projeté reste absent tant que le serveur ne l’a pas fourni.
3. **Regrouper parking, motif et note sous “Justification auditée”.** Parking et motif partagent une ligne sur grand écran ; la note occupe toute la largeur. Les six motifs restent inchangés. Coût : à 390 px, tout repasse sur une colonne et nécessite du défilement.
4. **Ancrer confirmation et action primaire dans le pied.** La case reste juste au-dessus des boutons ; « Enregistrer l’ajustement » est l’unique action pleine bleue. « Prévisualiser » reste secondaire et facultative ; fermer et recharger sont tertiaires. Coût : pied plus dense à 1280×720, donc corps défilant avec pied fixe et focus jamais masqué.
5. **Retour d’état au plus près de l’effet.** Validation sous le champ concerné ; conflit, interdiction ou panne dans un résumé `role="alert"` conservant toutes les saisies, avec code support et « Recharger le solde » seulement quand pertinent. Coût : les erreurs longues augmentent la hauteur avant le formulaire.

## Contrat et vérifications

Restent métier : montant positif à deux décimales, signe issu du sens, parking/motif/note/confirmation obligatoires, prévisualisation facultative, valeurs serveur, invalidation après édition, blocage invalide/occupé, identité d’idempotence stable sans modification, fermeture/rechargement parent, et tous les états prescrits. Changements proposés : composition, libellé « Effet sur le solde », choix Crédit/Débit visibles, retrait du statut non prouvé.

Vérifier au prototype : 1536×1024, 1280×720, 390×844 ; noms longs, erreurs longues ; ordre Tab, focus visible, annonces d’erreur ; états valide/invalide/prêt/occupé/conflit/interdit/panne ; conservation des saisies et invalidation de la prévisualisation. Aucune preuve rendue ni approbation n’est revendiquée ici.
