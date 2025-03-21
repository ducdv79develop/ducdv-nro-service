#!/bin/sh
set -e

echo "Running Maven build application..."
mvn clean install -DskipTests

echo "Starting application..."
exec java -jar target/*.jar
