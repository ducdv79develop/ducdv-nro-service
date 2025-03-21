FROM nginx:stable-alpine

WORKDIR /etc/nginx

COPY ducdv-docker/admin-console/nginx.conf /etc/nginx/nginx.conf.template
COPY ducdv-docker/admin-console/docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE ${NGINX_PORT}

ENTRYPOINT ["/bin/sh", "-c", "/docker-entrypoint.sh"]
