#!/bin/sh
set -e

echo "Running Maven build application..."
mvn clean install -DskipTests

echo "Starting application..."
exec java -jar target/application-1.0-RELEASE.jar
