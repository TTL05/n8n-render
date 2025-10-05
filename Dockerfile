FROM n8nio/n8n:latest

# Copier le package.json dans le conteneur
COPY package.json /home/node/

# Installer les community nodes via npm
RUN npm install --prefix /home/node

# Définir le dossier de travail
WORKDIR /home/node/.n8n

# Exposer le port n8n
EXPOSE 5678
