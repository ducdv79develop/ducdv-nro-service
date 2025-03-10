FROM maven:3.9.6-eclipse-temurin-17 AS runtime

WORKDIR /app

# Copy toàn bộ source code vào container
COPY ducdv-nro-java-server /app

# Cấp quyền thực thi cho script start
COPY ducdv-docker/java-server/docker-entrypoint.sh /app/docker-entrypoint.sh
RUN chmod +x /app/docker-entrypoint.sh

# Expose cổng để ứng dụng chạy
EXPOSE ${SERVER_PORT}

# Chạy ứng dụng Spring Boot
ENTRYPOINT ["/app/docker-entrypoint.sh"]
