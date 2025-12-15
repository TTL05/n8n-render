FROM n8nio/n8n:latest

LABEL maintainer="FREELANCEWAAR"
LABEL description="Instance N8N pour FREELANCEWAAR"

USER node
WORKDIR /home/node

EXPOSE 5678

CMD ["n8n"]
