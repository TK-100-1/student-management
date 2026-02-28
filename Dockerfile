# ===== Stage 1: Build =====
FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app

# Copy toàn bộ project vào container
COPY . .

# Build project (tạo file jar)
RUN mvn clean package -DskipTests


# ===== Stage 2: Run =====
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy file jar từ stage build
COPY --from=build /app/target/*.jar app.jar

# Mở port 8080
EXPOSE 8080

# Chạy ứng dụng
ENTRYPOINT ["java", "-jar", "app.jar"]