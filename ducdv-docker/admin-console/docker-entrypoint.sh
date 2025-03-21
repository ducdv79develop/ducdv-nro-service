#!/bin/sh
set -e

echo "🌍 Starting Nginx..."

echo "Using API_HOST=${API_HOST}, API_PORT=${API_PORT}"

envsubst '$API_HOST $API_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
exec nginx -g "daemon off;"
