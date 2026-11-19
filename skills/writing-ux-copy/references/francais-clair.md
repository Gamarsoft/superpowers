# Français clair pour les textes d’interface

Une personne qui découvre l’écran doit pouvoir y trouver l’information dont elle a besoin, la comprendre et s’en servir. Cette fiche adapte à la rédaction d’interface le skill `redaction-francais` du dépôt `camille-hdl/skills` et sa fiche typographique. [Source de l’adaptation](https://github.com/camille-hdl/skills/blob/9fbb6ffcc6005f2c1361922b0509bf5f8f91018b/skills/redaction-francais/SKILL.md) · [Fiche typographique d’origine](https://github.com/camille-hdl/skills/blob/9fbb6ffcc6005f2c1361922b0509bf5f8f91018b/skills/redaction-francais/references/typographie.md)

## Choisir ce que la personne doit savoir

Lisez le titre, le bouton et le message dans l’ordre où la personne les rencontre. Quelle question lui reste-t-il ? Commencez par la réponse qui change sa décision. Gardez une condition, une exception ou une échéance à côté du fait qu’elle limite. Si le texte existant répond déjà à la question avec les mots du public, gardez-le. [DITP, simplifier le langage](https://www.modernisation.gouv.fr/simplifier-la-vie-des-usagers-et-des-agents/simplifier-le-langage-et-les-documents-administratifs) · [ISO 24495-1, présentation des principes](https://www.iso.org/fr/standard/78907.html)

Précisez ce que l’action a réellement produit. Une possibilité s’exprime avec « vous pouvez ». Un aperçu décrit l’effet d’un choix à venir. Un résultat annonce un fait acquis. Quand plusieurs personnes ou lieux interviennent, nommez celui qui doit encore agir et ce qui reste possible dans l’intervalle.

## Écrire comme on parlerait au public de l’écran

- **Rapprochez le sujet du verbe.** Transformez une suite de noms en une action. « Déclencher la mise en fonctionnement du minuteur » devient « Démarrer le minuteur ». Quand l’auteur d’une action est inconnu ou sans importance, une phrase au passif peut être plus exacte.
- **Donnez un seul sens à chaque mot.** Conservez un terme métier reconnu par le public et employez-le pour la même chose tout au long du parcours. Pour un calque ou un nom de service interne, cherchez le geste ou l’objet que la personne reconnaîtra.
- **Levez les ambiguïtés.** Lorsque « elle », « son » ou « ce dernier » peut désigner deux personnes ou deux objets, répétez le nom utile. Placez « si », « avant », « après » ou « tant que » près de l’action concernée. Une phrase longue mérite une seconde lecture. La couper est utile si la condition reste attachée à la bonne action.
- **Adressez-vous à la bonne personne.** Reprenez le tutoiement ou le vouvoiement du produit. Si le sujet est une personne dont le genre est inconnu, une tournure comme « {prenom} peut participer » évite un accord incertain. Conservez les variables de traduction à l’identique.

Ces choix s’appuient sur les recommandations de langage clair de Canada.ca concernant les termes familiers, l’ordre des informations et la voix active. [Guide de rédaction du contenu de Canada.ca](https://conception.canada.ca/guide-redaction/)

## Adapter la phrase au geste

| Texte | Question à résoudre |
| --- | --- |
| Bouton ou lien | Que va ouvrir ou changer ce geste ? Gardez une forme cohérente entre actions de même nature. L’infinitif convient souvent au bouton (« Écouter un extrait »), l’impératif à une consigne adressée à la personne (« Choisissez une piste »). |
| Aide à la saisie | Quelle précision manque au libellé ? Donnez le format ou un exemple seulement s’il aide à répondre. Le libellé et le nom accessible doivent aussi avoir un sens hors contexte. |
| Erreur | Qu’est-il arrivé et comment la personne peut-elle avancer ? Indiquez la correction possible dans ses mots. Une cause, un recours ou un délai doit être vérifié. |
| Confirmation | Que restera-t-il après ce choix ? Avant le geste, nommez la conséquence qui mérite de s’arrêter. Après le geste, indiquez le résultat acquis. |

L’OQLF précise les emplois de l’impératif et de l’infinitif. Les exemples de DesignGouv illustrent les liens entre intitulé, aide et correction. [OQLF, impératif et infinitif](https://vitrinelinguistique.oqlf.gouv.qc.ca/24208/la-grammaire/le-verbe/modes/imperatif/distinction-entre-limperatif-et-linfinitif) · [DesignGouv, formulaires compréhensibles](https://design.numerique.gouv.fr/outils/checklist-forms/)

## Respecter la variante régionale

Suivez la langue, la région et la charte du produit. Pour les nombres, monnaies, dates, heures et pluriels, utilisez le formateur de langue déjà prévu dans le projet. Préservez les valeurs, la devise et le fuseau de l’événement. Une forme en toutes lettres comme « 8 novembre » évite une date numérique ambiguë. Les accents portent aussi sur les capitales, comme dans « Écouter ».

Pour une question en `fr-FR`, on écrit couramment « Continuer ? » avec une espace fine insécable avant le point d’interrogation. Au Québec (`fr-CA`), l’OQLF privilégie « Continuer? » et admet l’espace fine lorsqu’elle est disponible. Gardez les conventions du public concerné pour les autres variantes. Les URL, identifiants, exemples de saisie et éléments de code gardent leur syntaxe exacte. [OQLF, espacements et symboles](https://vitrinelinguistique.oqlf.gouv.qc.ca/22039/la-typographie/espacement/espacement-avant-et-apres-les-signes-de-ponctuation-et-les-symboles) · [Conventions typographiques France et Québec](https://github.com/camille-hdl/skills/blob/9fbb6ffcc6005f2c1361922b0509bf5f8f91018b/skills/redaction-francais/references/typographie.md)

## Vérifier la compréhension

Relisez l’écran avec ses valeurs réelles ou des données de test représentatives. La personne peut-elle dire qui fait quoi, ce qui a changé et ce qu’elle peut encore décider ? Pour un geste important, demandez à une personne du public de reformuler le message ou de choisir le prochain geste. Une revue éditoriale ou un score de lisibilité donne une indication. La réponse d’un lecteur permet de constater ce qu’il a compris. [Normes d’accessibilité Canada, évaluation d’une communication](https://accessibilite.canada.ca/normes-et-guides-techniques/base-de-donnees-des-normes-et-des-guides-techniques/can-asc-312025-langage-clair/11-evaluation)
