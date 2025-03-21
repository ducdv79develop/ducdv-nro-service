FROM maven:3.9.6-eclipse-temurin-17 AS runtime

WORKDIR /app

# Copy toàn bộ source code vào container
COPY ducdv-nro-admin-api /app

# Cấp quyền thực thi cho script start
COPY ducdv-docker/admin-api/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Expose cổng để ứng dụng chạy
EXPOSE ${API_SERVER_PORT}

# Chạy ứng dụng Spring Boot
ENTRYPOINT ["/bin/sh", "-c", "/docker-entrypoint.sh"]
