# Sử dụng OpenJDK 17
FROM openjdk:17-jdk-slim

# Đặt thư mục làm việc trong container
WORKDIR /app

# Copy file JAR từ thư mục target vào container
COPY target/ducdv-nro-service.jar app.jar

# Expose cổng để ứng dụng chạy
EXPOSE ${SERVER_PORT}

# Chạy ứng dụng Spring Boot
CMD ["sh", "-c", "java -jar app.jar"]
