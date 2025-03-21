FROM node:lts-alpine
WORKDIR /app

COPY ducdv-nro-admin-console/package*.json ./
COPY ducdv-nro-admin-console/. .

COPY ducdv-docker/admin-console-builder/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/docker-entrypoint.sh"]
