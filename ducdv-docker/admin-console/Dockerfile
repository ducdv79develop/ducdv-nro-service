FROM node:lts AS build-stage
WORKDIR /app

COPY ducdv-nro-admin-console /app
RUN npm install
RUN npm run build

FROM nginx:alpine
WORKDIR /etc/nginx
COPY ducdv-docker/admin-console/nginx.conf /etc/nginx/nginx.conf.template

COPY --from=build-stage /app/dist /usr/share/nginx/html

CMD envsubst '$NGINX_PORT $API_HOST $API_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf && \
    nginx -g "daemon off;"
