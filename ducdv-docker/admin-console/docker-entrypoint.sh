#!/bin/sh
set -e

echo "🌍 Starting Nginx..."

mkdir -p /var/log/nginx/admin-console
touch /var/log/nginx/admin-console/access.log
touch /var/log/nginx/admin-console/error.log

chown -R nginx:nginx /var/log/nginx/admin-console
chmod -R 755 /var/log/nginx/admin-console

echo "Using API_HOST=${API_HOST}, API_PORT=${API_PORT}"

envsubst '$API_HOST $API_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
exec nginx -g "daemon off;"
