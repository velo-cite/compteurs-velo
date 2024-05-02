Ce petit site récupère les données ouvertes des compteurs de passages à vélo de la métropole de Bordeaux pour en faire une présentation synthétique.

En particulier on peut :

- Comparer les principaux compteurs
- Pour un compteur donné, voir les chiffre par heure de la veille, par jour du dernier mois, ou par semaine sur l’année en cours

## Origine du projet

Ce projet est librement inspiré et adapté du dépot [velos-paris](https://github.com/Tristramg/velos-paris) de @Tristramg qui permet de consulter les données des compteurs parisiens.

## Obtenir les données

Des capteur (« boucles ») sont installées au sein du goudron un peu partout dans la métropole. Cette boucle détecte le passage d’un vélo et remonte la donnée qui est exposée sur le portail OpenData de la Métropole.

Contrairement aux données de Paris, un seul jeu de données est disponible. La liste unique des compteurs a été réalisée à la main et devra être complétée à l'avenir si de nouveaux compteurs sont ajoutés.

Le jeu de données contient les données de comptage (une mesure par heure et par compteur) :
`wget "https://opendata.bordeaux-metropole.fr/api/explore/v2.1/catalog/datasets/pc_velo_p/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B" -O public/compteurs.csv`

L'import est scripté via une commande make : `make import-compteurs-bordeaux`

La liste des capteurs est elle configurée et gitée dans le projet.
`cat public/metadata.csv`

## Lancer le projet

C’est un projet [Next.js](https://nextjs.org/) et [Vega-Lite](https://vega.github.io/) pour dessiner les graphes.

La carte utilise [Mapbox](https://mapbox.com) et un _token_ est nécessaire.
Obtenez-en un et modifiez `.env.local.example` en le sauvegardant sous `.env.local`.

Vous aurez besoin d’une installation de [Node.js](https://nodejs.org/)

```bash
yarn install
```

Afin de ne pas dépendre d’une base de données, les données sont préparées et intégrées statique à chaque page.

Pour corriger les entêtes du csv de données, un script a été mis en place pour coller aux entêtes de l'open data parisien.

```bash
./scripts/rename-header-compteurs-csv.sh
```

Pour préparer les données :

```bash
yarn prep
```

Et enfin pour lancer le projet :

```bash
yarn dev
```

Ouvrez [http://localhost:3000](http://localhost:3000) dans votre navigateur pour voir le résultat.

## Déployer le projet

Afin de maintenir le site à jour, il faut reconstruire le site chaque jour avec l’arrivée de nouvelles données (entre 10 et 11h du matin).

Téléchargez les données

Exécutez :

```bash
yarn prep
yarn build
yarn export
```

Le repertoire `out` contiendra les fichier statiques à transférer sur le serveur web (celui-ci doit juste servir les fichiers. Il n’y a pas besoin d’avoir la moindre installation locale).
