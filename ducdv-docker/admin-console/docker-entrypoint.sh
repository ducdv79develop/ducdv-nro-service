#!/bin/sh
set -e

echo "📦 Installing dependencies..."
cd /app
npm install

echo "⚙️  Building Vue app..."
npm run build

echo "🚀 Updating Nginx content..."
rm -rf /usr/share/nginx/html/*
cp -r /app/dist/* /usr/share/nginx/html/

echo "🌍 Starting Nginx..."
envsubst '$NGINX_PORT $API_HOST $API_PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf
exec nginx -g "daemon off;"
