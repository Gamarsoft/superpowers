# Copie française — rapprochement

## Deck de copie

**Normal**

- Titre : `Vérifier le rapprochement`
- Colonnes : `Valeurs actuelles` / `Valeurs proposées`
- Aide : `Comparez les valeurs avant d’enregistrer.`
- Case requise : `Je confirme avoir vérifié les valeurs actuelles et proposées.`
- Validation : `Confirmez la vérification pour continuer.`
- Action : `Enregistrer le rapprochement`

**Succès**

- `Rapprochement enregistré`
- `Les valeurs proposées sont maintenant enregistrées.`

**Échec**

- `Échec de l’enregistrement`
- `Le rapprochement n’a pas été enregistré. Réessayez ou créez un ticket d’assistance avec le numéro d’incident {incidentNumber}.`
- Action : `Réessayer sans modifier`

**Incertain**

- `Résultat de l’enregistrement inconnu`
- `Nous ne pouvons pas confirmer si le rapprochement a été enregistré. Vérifiez l’état actuel, puis réessayez sans modifier les valeurs si nécessaire.`
- Action : `Réessayer sans modifier`

## Handoff d’implémentation

Conserver le panneau côte à côte approuvé et sa case obligatoire. Désactiver l’action principale tant qu’elle n’est pas cochée; associer la validation à la case et y déplacer le focus après une tentative invalide.

Utiliser des clés distinctes par état, sans concaténer les phrases. `{incidentNumber}` est une variable sémantique, affichée et copiable uniquement après un échec. Ne pas afficher `incidentNumber` après un succès, qui ne demande aucune action d’assistance. Réserver le statut HTTP, `correlationId` et l’identité de nouvelle tentative à la console d’incident des ingénieurs.

L’état incertain ne doit suggérer ni succès ni échec. La nouvelle tentative conserve exactement les valeurs comparées et confirmées. Vérifier les quatre états, le clavier, le focus, le nom accessible de la case et l’expansion des traductions.
