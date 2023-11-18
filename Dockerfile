FROM node:20.6.1-alpine3.18 AS build

# Set working directory
WORKDIR /compteurs

# Install dependencies
ADD package.json .
ADD yarn.lock .
RUN yarn install

# Download counters data
RUN mkdir public \
 && wget "https://opendata.bordeaux-metropole.fr/api/explore/v2.1/catalog/datasets/pc_captv_p_histo_heure/exports/csv?lang=fr&timezone=Europe%2FBerlin&use_labels=true&csv_separator=%3B&refine=type%3A%22BOUCLE%22" -O public/compteurs.csv

# Rename headers
ADD scripts/rename-header-compteurs-csv.sh scripts/
RUN apk add sed # The default alpine sed can't handle hexadecimal characters
RUN ./scripts/rename-header-compteurs-csv.sh

# Prepare the data
ADD prepare.js .
ADD public/metadata.csv public/
RUN mkdir public/data \
 && yarn prep

# Add source code
ADD . .

# Build the pages
ENV NODE_OPTIONS=--openssl-legacy-provider
RUN yarn build

# Clean up the out directory
RUN rm out/compteurs.csv

####
FROM nginx:1.25.2-alpine

COPY --from=build /compteurs/out/ /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf
