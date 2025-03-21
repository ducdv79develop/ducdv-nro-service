#!/bin/sh
set -e

echo "📦 Installing dependencies..."
cd /app
npm install

echo "⚙️  Building Vue app..."
npm run build

echo "⚙️  Building Vue app Success!!!"
