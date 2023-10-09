# Use a base image with Java and Tomcat pre-installed
FROM maven:3.8.4-openjdk-11 AS builder

WORKDIR /ai-cv-generator-backend

COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the WAR file to the Tomcat webapps directory
COPY ai-cv-generator-backend/ ./ai-cv-generator-backend


RUN mvn package -DskipTests

FROM openjdk:17
WORKDIR /ai-cv-generator-backend
ADD /ai-cv-generator-backend/target/*.jar acgbackend
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "acgbackend"]