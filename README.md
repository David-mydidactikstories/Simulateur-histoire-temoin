# Témoin — rencontres avec le passé

Un personnage historique répond en direct aux questions d'une classe. Conçu pour être **projeté en classe et piloté par l'enseignant**, pas pour un usage individuel au casque.

Premier témoin livré : **Jehan, paysan en Brie, an 1347**. Quatre autres sont dans la liste, grisés : Jules César, un Viking, Léonard de Vinci, Napoléon.

## Lancer

1. Coller la clé Gemini dans `cle-api.txt`.
2. Double-cliquer `DEMARRER.command`.

---

## Les trois partis pris qui viennent du contexte classe

### Appuyer pour parler

Les autres simulateurs écoutent en continu. Ici, **le micro ne s'ouvre que pendant l'appui sur le bouton**. Dans une salle de trente élèves, un micro ouvert en permanence fait interrompre le témoin toutes les dix secondes par une chaise, un rire, un commentaire de voisin.

L'enseignant maintient le bouton pendant que l'élève pose sa question, puis relâche. Raccourci : barre d'espace. Techniquement, le flux micro reste ouvert mais l'audio n'est transmis que pendant l'appui (`if(!session || !micOuvert) return;`) — ce qui évite de redemander l'autorisation micro à chaque question.

Appuyer pendant que le témoin parle **lui coupe la parole**, comme dans une vraie conversation.

### Le personnage ne met jamais fin à la séance

Dans les simulateurs managériaux, une provocation fait raccrocher le personnage. Ici ce serait catastrophique : couper l'échange devant une classe parce qu'un élève a fait le malin ruinerait le cours. **L'outil de raccrochage a été retiré du code.** Le témoin esquive avec dignité, ne fait jamais la morale, et c'est l'enseignant qui décide quand ça s'arrête.

### Les sous-titres sont l'élément principal

Le son d'un vidéoprojecteur est souvent mauvais et le fond de classe n'entend pas. Ce que dit le témoin s'affiche en très grand au centre de l'écran, pas dans un panneau latéral. Le fil complet de la séance est en dessous, repliable.

Une **saisie clavier** est disponible en secours : si le micro est bloqué sur la machine de l'école, l'enseignant tape la question et la séance continue normalement.

---

## Le mur du temps

C'est le cœur du dispositif, dans `REGLES_COMMUNES`.

Le témoin ne sait rien de ce qui suit son époque. Surtout, il ne dit **jamais** « je ne connais pas, c'est après mon temps » — cette phrase le ferait sortir de son siècle. Il réagit comme un homme réel devant un mot inconnu : il le répète de travers, essaie de le rattacher à ce qu'il connaît, demande ce que c'est. Ces moments sont les plus marquants pour une classe.

Il ignore aussi qu'il est dans un autre temps : il prend les élèves pour des étrangers aux manières bizarres.

Et il ne sait pas tout de sa propre époque. Il ne sait pas lire, ne connaît pas les dates. La consigne lui interdit d'inventer un nom propre, une date ou un chiffre précis pour faire plaisir : « Ça, je ne saurais dire » est une réponse attendue et instructive.

## La voix

Deux réglages, et le second compte plus que le premier.

**Le timbre** — champ `voix`. Trente voix sont disponibles, listées en commentaire dans le fichier avec leur caractère. Jehan utilise **Algenib** (rocailleuse), pour un homme qui travaille dehors depuis vingt-cinq ans. Autres pistes crédibles pour lui : `Gacrux` (mûre), `Sulafat` (chaleureuse), `Enceladus` (soufflée).

**Les indications de jeu** — champ `miseEnVoix`. C'est ce qui enlève vraiment l'effet « robot ». Le modèle suit des directives de comédien : débit lent, silences avant de répondre, hésitations, souffle sur les sujets pénibles, rire discret quand quelque chose l'amuse. Une même voix passe du lecteur de texte à l'homme qui parle selon ce qu'on écrit là.

### Essayer une voix en dix secondes

Ajoute `?voix=` à l'adresse, sans rien modifier dans le fichier :

```
http://localhost:3000/?voix=Gacrux
http://localhost:3000/?voix=Sulafat
```

La voix utilisée s'affiche sur l'écran de séance, à côté du niveau de classe, et part dans les analytics — de quoi comparer sur plusieurs essais.

## Le risque d'invention

Un personnage joué par une IA affirme des choses fausses avec aplomb. Deux parades dans ce simulateur :

**Un anonyme d'abord.** Jehan incarne une condition, pas une personne : son quotidien est très documenté et il n'y a pas de biographie à contredire. Les grandes figures poseront un problème différent — elles affirment des faits vérifiables — et demanderont chacune une fiche de faits validés.

**La fiche de séance fait office de garde-fou.** Un second passage relit tout ce que le témoin a dit et signale ce qui est douteux, inexact ou anachronique, pour que l'enseignant rectifie au cours suivant. Le fact-check est un outil de l'enseignant, il n'interrompt jamais l'échange.

## La fiche de séance

Générée en fin de séance, imprimable (`Cmd + P` produit une version noir sur blanc) :

- les questions posées par la classe, reformulées
- les notions d'histoire réellement abordées
- **à vérifier** : les affirmations douteuses du témoin
- trois pistes pour prolonger en classe

Quand rien n'est à signaler, la fiche le dit — en rappelant que ça ne vaut pas validation historique.

## Ajouter un témoin

Copier un bloc de `PERSONNAGES` en haut de `public/index.html` et passer `actif: true`.

| Champ | Rôle |
|---|---|
| `annee` | injecté dans le mur du temps (`{{ANNEE}}`) |
| `icone` | icône [Lucide](https://lucide.dev) — pas de portrait, volontairement : un faux visage historique induirait en erreur |
| `voix` | masculines `Charon`, `Puck`, `Fenrir` · féminines `Kore`, `Aoede`, `Leda` |
| `contexte` | affiché à l'enseignant pendant la séance, pas au personnage |
| `amorces` | questions de démarrage suggérées à la classe |
| `instruction` | le personnage. `{{NIVEAU}}` y est remplacé par le registre de classe |

Pour une figure célèbre, ajouter dans `instruction` une section de faits vérifiés et une consigne explicite de ne rien affirmer au-delà.

## Les trois niveaux de classe

Ils règlent le vocabulaire, la longueur des réponses et le traitement des réalités dures — mortalité infantile, servage, violence, place des femmes. Le parti pris est le même partout : **factuel et sobre**. Le fait brut, sans détail sordide et sans euphémisme. En primaire il est dit en une phrase puis on passe ; en secondaire supérieur, le témoin assume pleinement les mentalités de son temps sans jamais devenir un homme moderne.

## À vérifier au premier essai réel

L'appuyer-pour-parler et le micro n'ont pu être validés que statiquement : leur comportement réel se juge au premier test en conditions. À regarder en priorité : que le témoin ne soit plus interrompu par le bruit ambiant, et que l'appui pendant qu'il parle lui coupe bien la parole.

## Analytics

| Événement | Données |
|---|---|
| `seance_ouverte` | `personnage`, `niveau` |
| `seance_demarree` | `personnage`, `niveau` |
| `seance_terminee` | `personnage`, `niveau`, `resultat`, `duree_s`, `echanges`, `a_verifier` |

`a_verifier` compte les affirmations signalées dans la fiche : c'est l'indicateur à surveiller pour savoir si un personnage dérive.
