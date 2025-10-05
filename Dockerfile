FROM n8nio/n8n:latest
# Installer les community nodes
RUN n8n install n8n-nodes-html-extract
RUN n8n install n8n-nodes-chatgpt
RUN n8n install n8n-nodes-mcp

# Définir le dossier de travail
WORKDIR /home/node/.n8n

# Exposer le port n8n
EXPOSE 5678
