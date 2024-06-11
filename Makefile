# import:

## paris
import: import-compteurs-paris import-metadata-paris prepare

## bordeaux
import-bordeaux: import-compteurs-bordeaux prepare

full-dev-bordeaux: import-bordeaux dev

import-compteurs-paris:
	- wget "https://parisdata.opendatasoft.com/api/v2/catalog/datasets/comptage-velo-donnees-compteurs/exports/csv?rows=-1&select=id_compteur%2Csum_counts%2Cdate&timezone=UTC" -O public/compteurs.csv
import-metadata-paris: 
	- wget "https://parisdata.opendatasoft.com/api/v2/catalog/datasets/comptage-velo-compteurs/exports/csv" -O public/metadata.csv

import-compteurs-bordeaux-old:
	- wget "https://opendata.bordeaux-metropole.fr/api/explore/v2.1/catalog/datasets/pc_captv_p_histo_heure/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&csv_separator=%3B&refine=type%3A%22BOUCLE%22" -O public/compteurs-old.csv
	- ./scripts/rename-header-compteurs-csv.sh

import-compteurs-bordeaux:
	-# wget "https://opendata.bordeaux-metropole.fr/api/explore/v2.1/catalog/datasets/pc_velo_p/exports/csv?lang=fr&qv1=(datedebut%3A%5B2024-06-08T22%3A00%3A00Z%20TO%202024-06-11T21%3A59%3A59Z%5D)&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B" -O public/compteurs.csv
	- wget "https://opendata.bordeaux-metropole.fr/api/explore/v2.1/catalog/datasets/pc_velo_p/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&delimiter=%3B" -O public/compteurs.csv
	- ./scripts/rename-header-compteurs-csv.sh

import-metadata-bordeaux: 
	- echo "import metadata : nothing to do, file in cache"


prepare: 
	- yarn prep

dev:
	- yarn dev