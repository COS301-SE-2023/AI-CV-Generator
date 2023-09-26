# Use a base image with Java and Tomcat pre-installed
FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /ai-cv-generator-backend

COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the WAR file to the Tomcat webapps directory
COPY ai-cv-generator-backend/target/ai-cv-generator-backend-0.0.1-SNAPSHOT.war ./ai-cv-generator-backend/src


RUN mvn package -DskipTests
# Expose port 8080

FROM openjdk:11-jre-slim
WORKDIR /ai-cv-generator-backend
COPY --from=builder /ai-cv-generator-backend/target/*.war app.war
EXPOSE 8080

# RUN mvn spring-boot:run
# Start Tomcat
CMD ["mvn", "spring-boot:run"]
