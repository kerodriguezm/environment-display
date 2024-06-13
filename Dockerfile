FROM maven:3.8.5-openjdk-17-slim AS build

WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:17-jdk-slim

WORKDIR /app
COPY --from=build /app/target/env-display-1.0-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
