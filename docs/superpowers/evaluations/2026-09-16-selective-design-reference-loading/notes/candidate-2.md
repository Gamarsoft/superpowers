# Ajustement Credipark — décision de conception

## Sources effectivement consultées

- `brief.md`; `context/AGENTS.md` (contraintes critiques); `context/gateway/AGENTS.md` (Frontend Context, Design Context); `context/PRODUCT.md` (Users, Product Principles, Accessibility); `context/gateway/PRODUCT.md` (Users, Brand Personality, Product Principles); `context/gateway/DESIGN.md` (Overview, Typography, Layout, Components); `FRONTEND-ANCHORING.md` (Reuse decisions); `DESIGN-EVIDENCE.md` (Runtime sample, Remaining issues).
- HTML, SCSS, TypeScript, tests, `copy.json` et `user-baseline.png`: résumé, formulaire, actions, invalidation de prévisualisation, erreurs et conservation des données.
- `frontend-direction`: *Scoped Design Authority*, *Brownfield Inspection Notes*, *From the task to the layout*, *Select design knowledge*. Références appliquées: *Refactoring UI* — Visual Hierarchy, Spacing & Sizing, Typography, Layout & Composition; *Design of Everyday Things* — Two Gulfs, Signifiers, Mappings, Constraints, Feedback, Conceptual Models, Human Error.

## Direction retenue

Conserver une seule carte modale blanche, compacte, Open Sans, avec actions bleues familières. Organiser le contenu selon la décision opérateur: **contexte vérifié → effet saisi → preuves → confirmation → action**.

1. **Résumé à deux niveaux.** Première ligne: client et compte; seconde: solde disponible et parking. Supprimer l’affirmation visuelle « Actif » lorsque le compte est inconnu. Les libellés restent discrets, les valeurs sombres et enveloppables. Coût: deux rangées, mais les longs noms ne compriment plus quatre colonnes et aucun statut n’est déduit.
2. **Montant et sens forment un bloc “Effet”.** Conserver les deux contrôles côte à côte sur grand écran; placer immédiatement dessous une ligne persistante « Mouvement: +2,50 cp / Solde actuel: 8,20 cp ». Après prévisualisation serveur, cette ligne devient une comparaison alignée « 8,20 → 10,70 cp », explicitement marquée « prévisualisation ». Coût: une ligne verticale supplémentaire; gain attendu à vérifier: la relation contrôle-effet est lisible sans confondre calcul local et résultat serveur.
3. **Preuves groupées sans cartes imbriquées.** Parking, motif et note suivent sous un intertitre « Justification auditée »; la note garde quatre lignes. La confirmation reste le dernier élément du groupe, proche d’« Enregistrer ». Coût: le parking n’est plus répété dans le bandeau bleu; en échange, la source d’attribution est visible avec les autres preuves.
4. **Pied fixe hiérarchisé.** À droite: `Fermer`, `Prévisualiser`, puis `Enregistrer l’ajustement` rempli. `Recharger le solde` devient un lien contextuel dans les états conflit/échec, pas une action permanente concurrente. À 390 px, actions pleine largeur: enregistrer, prévisualiser, fermer; corps seul défilant. Coût: recharger demande un état pertinent; la hiérarchie réduit la concurrence de quatre actions.
5. **Retour au point de décision.** Erreurs de champ restent sous le champ; conflit/interdit/service apparaît au-dessus du bloc Effet avec code support et travail conservé. Chargement désactive les actions et garde leur libellé. Coût: le message peut déplacer le formulaire; il reste toutefois dans le contexte qu’il faut corriger.

## Contrat et proposition

Restent métier: montant positif à deux décimales, signe porté par crédit/débit, six motifs, parking/note/confirmation requis, prévisualisation facultative pour enregistrer, invalidation après édition, valeurs serveur, états et reprise/idempotence/rechargement du brief. Les points 1–3 et 5 changent la présentation. Retirer « Actif » pour un compte inconnu corrige l’affichage sans créer d’éligibilité. **Changement comportemental proposé:** rendre `Recharger le solde` contextuel; sans validation produit, le conserver au pied.

## Vérifications représentatives à réaliser

À 1536×1024, 1280×720 et 390×844: noms longs, défilement et pied accessible; ordre clavier/focus visible; erreurs liées aux champs; états valide/invalide/prêt/chargement/conflit/interdit/service; édition effaçant la prévisualisation; échec conservant les saisies; aperçu et enregistrement affichant uniquement les valeurs serveur. Cette note ne constitue ni preuve rendue ni approbation.
