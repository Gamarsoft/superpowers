# Décision de conception — ajustement manuel Credipark

## Sources réellement consultées

- `brief.md` et `micro-task.md`, intégralement.
- `context/AGENTS.md` : *Progressive Disclosure*, *Working approach*, *Critical Constraints*.
- `context/PRODUCT.md` : *Users*, *Product Purpose*, *Capabilities and Constraints*, *Brand Commitments*, *Product Principles*, *Accessibility & Inclusion*.
- `context/gateway/AGENTS.md` : *Frontend (Angular v7 + Nebular)*, *Frontend Context*, *Verification*, *When editing*, *Design Context*.
- `context/gateway/PRODUCT.md` : toutes les sections.
- `context/gateway/DESIGN.md` : frontmatter, *Overview*, *Colors*, *Typography*, *Layout*, *Elevation & Depth*, *Shapes*, *Components*, *Do’s and Don’ts*.
- `source/copy.json`, le HTML, SCSS, TypeScript et les tests du composant, intégralement ; `source/user-baseline.png` inspectée visuellement.

## Refinement proposé

Conserver un dialogue blanc compact, mais le structurer comme une décision auditée en trois blocs continus : **Contexte**, **Écriture**, **Justification et confirmation**. Sur desktop, le contexte devient une bande à trois valeurs — client, compte, solde — tandis que le statut n’est affiché que si le serveur l’a réellement fourni. Le formulaire reste sur deux colonnes pour montant/sens, puis pleine largeur. Le pied fixe contient « Fermer », « Prévisualiser » et l’action primaire ; « Recharger le solde » reste dans le message d’échec ou de conflit, au plus près de sa cause.

Choix conséquents et coûts :

1. Réunir montant et sens dans un groupe « Écriture », avec une ligne persistante **Effet : +/− X cp** sous les deux contrôles. Cela rend le signe vérifiable avant action, au prix d’une ligne verticale supplémentaire.
2. Après une prévisualisation acceptée, afficher côte à côte **Solde actuel → Solde après enregistrement**, valeurs serveur, juste avant les actions. Cela clarifie l’impact, mais requiert un état vide/chargement/conflit stable et l’invalidation immédiate dès toute édition.
3. Rapprocher motif, note et confirmation sous « Justification et confirmation » ; placer chaque erreur sous son champ et un résumé d’erreurs focalisable en tête du bloc après tentative invalide. Le résumé duplique brièvement les erreurs, coût acceptable pour le clavier et les dialogues longs.
4. À 390 px, empiler toutes les valeurs et actions : action primaire pleine largeur en premier visuellement, puis prévisualisation et fermeture ; garder le pied visible et le corps seul défilable. Cela réduit la vue simultanée du formulaire. À 1280×720, compacter les espacements et limiter la note à trois lignes initiales pour éviter que la confirmation disparaisse sous le pli.

## Contrat conservé et changement proposé

Restent du comportement métier : montant positif à deux décimales, signe issu crédit/débit, parking/motif/note/confirmation obligatoires, six motifs, prévisualisation facultative pour enregistrer, valeurs renvoyées par le serveur, aucune mutation locale du solde, conservation des saisies en échec, blocage invalide/occupé, même identité d’idempotence si les données ne changent pas, et rechargement par fermeture puis demande au parent.

Changement proposé : supprimer l’affichage affirmatif « Actif » lorsque l’état n’est pas fourni ; déplacer « Recharger le solde » dans les états qui le justifient. Ce sont des changements de présentation/action disponible, à valider produit avant implémentation.

## Vérifications représentatives

Tester clavier et focus après soumission invalide ; libellés/erreurs associés ; édition invalidant la prévisualisation ; sauvegarde possible sans aperçu ; états chargement, conflit, interdit et service indisponible sans perte de saisie ; noms client/parking longs ; codes support ; défilement et pied à 1536×1024, 1280×720 et 390×844 ; contraste et focus visibles ; absence d’« Actif » déduit d’un compte inconnu.
