FROM node:lts-alpine as build-stage
WORKDIR /app

COPY ducdv-nro-admin-console/package*.json ./
RUN npm install
COPY ducdv-nro-admin-console/. .

FROM nginx:stable-alpine as production-stage
WORKDIR /etc/nginx
COPY ducdv-docker/admin-console/nginx.conf /etc/nginx/nginx.conf.template

COPY --from=build-stage /app /app
COPY ducdv-docker/admin-console/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE ${NGINX_PORT}
ENTRYPOINT ["docker-entrypoint.sh"]
