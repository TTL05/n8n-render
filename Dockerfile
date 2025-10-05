FROM n8nio/n8n:latest

USER root

# Copier le package.json
COPY package.json /usr/local/lib/node_modules/n8n/

# Installer les community nodes DANS le dossier de n8n
WORKDIR /usr/local/lib/node_modules/n8n
RUN npm install --legacy-peer-deps

# Vérifier l'installation
RUN ls -la node_modules/ | grep n8n-nodes

USER node

EXPOSE 5678