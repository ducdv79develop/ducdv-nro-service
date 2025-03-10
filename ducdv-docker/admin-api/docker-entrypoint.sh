#!/bin/sh
set -e

echo "Running Maven build admin-api..."
mvn clean install -DskipTests

echo "Starting admin-api..."
exec java -jar target/admin-api-1.0-RELEASE.jar
