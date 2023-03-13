sed -i "s/Geo Point/coordinates/" public/metadata.csv
sed -i "s/gid/id/" public/metadata.csv
sed -i "s/libelle/name/" public/metadata.csv
sed -i "s/ident/id/" public/metadata.csv
sed -i "s/zone/channel_id/" public/metadata.csv
sed -i "s/comptage_5m/counter/" public/metadata.csv
sed -i "s/cdate/installation_date/" public/metadata.csv
# sed -i "s/^/;/" public/metadata.csv

# Paris : 
# coordinates;id_compteur;nom_compteur;id;name;channel_id;channel_name;counter;installation_date

# Bordeaux : 
# GeoShape;geopoint;gid;libelle;ident;type;zone;comptage_5m;cdate;mdate
