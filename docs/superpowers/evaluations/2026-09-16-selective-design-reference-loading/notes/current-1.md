# Ajustement Credipark — note de décision

## Direction proposée

Conserver un dialogue blanc Nebular, dense et familier, mais l’organiser selon la décision réelle du directeur : **qui et quel solde**, **quel effet**, **quelles preuves**, puis **quelle action**.

1. **Réduire le contexte à une bande compacte de deux zones.** À gauche : client et compte; à droite : solde disponible, avec retour à la ligne pour les noms longs. Retirer le statut « Actif » : la capture montre qu’il peut être affiché sans compte, donc il communique une autorité non établie. Coût : moins de symétrie qu’une grille à quatre colonnes, mais aucune fausse assurance.
2. **Faire du sens et du montant un même groupe.** Présenter Crédit/Débit en contrôle segmenté sémantique, puis montant et une seule ligne d’effet, par exemple « Effet : −2,50 cp ». Le solde projeté reste absent avant une prévisualisation serveur acceptée. Coût : un contrôle segmenté demande une vérification clavier/focus et une implémentation compatible Angular 7; des radios natives stylées sont le repli sûr.
3. **Grouper l’évidence auditée.** Parking, motif, note et confirmation suivent sous un intertitre « Justification de l’ajustement ». Le parking n’est affiché qu’une fois dans le champ; l’aide auditée devient une phrase près de la confirmation. Les six motifs restent inchangés. Coût : la suppression des rappels réduit la redondance, donc l’intitulé de section et les labels doivent rester visibles.
4. **Rendre le pied de dialogue stable et hiérarchisé.** À gauche, « Recharger le solde » en action discrète; à droite, Fermer, Prévisualiser, puis le bouton bleu « Enregistrer l’ajustement ». À 1280×720, garder le pied sur une ligne et le corps défilable; à 390×844, empiler les actions pleine largeur, avec Enregistrer en premier dans l’ordre visuel sans casser l’ordre de tabulation. Coût : le mobile consomme de la hauteur; limiter les espacements, pas les libellés.
5. **Placer le retour près de l’action et préserver la saisie.** Une prévisualisation réussie affiche l’effet signé et le solde serveur projeté au-dessus du pied. Conflit, interdit et panne utilisent une alerte persistante avec code support; l’édition invalide immédiatement l’aperçu. Les contrôles restent désactivés pendant l’attente et l’erreur ne vide aucun champ.

## Autorité et comportement

Restent des règles métier : montant positif à deux décimales, signe dérivé de Crédit/Débit, quatre preuves requises, prévisualisation facultative pour enregistrer, résultats serveur seuls, même identité d’idempotence si les données ne changent pas, recharge par fermeture et demande au parent. Les changements proposés concernent uniquement hiérarchie, regroupement et libellés. Modifier l’éligibilité, exiger la prévisualisation ou calculer localement un solde serait une nouvelle décision produit.

## Contrôles représentatifs

Vérifier 1536×1024, 1280×720 et 390×844 : noms longs, erreurs multilignes, défilement sans pied masqué; tabulation, focus visible, radios et confirmation; invalid/ready/busy/conflict/forbidden/service-failure; aperçu invalidé après édition; saisie conservée après échec; aucun solde projeté local.

## Sources réellement lues

- `brief.md` et `micro-task.md`, intégralement.
- `frontend-direction/SKILL.md` : entrée, boucle, limites; références `design-source-priority.md`, `brownfield-ui-extraction-template.md`, `task-to-layout.md`, intégralement.
- `context/AGENTS.md` : contexte et contraintes; `context/PRODUCT.md` : utilisateurs, principes, accessibilité.
- `context/gateway/AGENTS.md` : Frontend, Frontend Context, Design Context; `PRODUCT.md` : utilisateurs, contraintes, personnalité, principes; `DESIGN.md` : Overview, Typography, Layout, Components, Do/Don't.
- HTML, SCSS, TypeScript et spec du dialogue; `copy.json`; `user-baseline.png`; `live-observations.md`.
