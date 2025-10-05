FROM n8nio/n8n:latest

USER root

# Créer un dossier pour les custom nodes
RUN mkdir -p /home/node/.n8n/custom

# Copier le package.json
COPY package.json /home/node/.n8n/custom/

# Installer les community nodes
WORKDIR /home/node/.n8n/custom
RUN npm install --production

# Donner les permissions
RUN chown -R node:node /home/node/.n8n

USER node

EXPOSE 5678