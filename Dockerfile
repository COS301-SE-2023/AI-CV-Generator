# Use a base image with Java and Tomcat pre-installed
FROM tomcat:9.0-jre11-slim

# Copy the WAR file to the Tomcat webapps directory
COPY ai-cv-generator-backend/target/ai-cv-generator-backend-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
