# --- Build Stage ---
FROM maven:3.9.6-eclipse-temurin-22 AS build

# Set the working directory
WORKDIR /app

# Clone the Prebid Server Java repository
RUN git clone https://github.com/prebid/prebid-server-java.git .

# Build the project and create the executable JAR
RUN mvn clean package -Dmaven.test.skip=true

# --- Run Stage ---
FROM eclipse-temurin:22-jre-jammy

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/prebid-server.jar .

# Copy the sample configuration file
COPY --from=build /app/sample/configs/prebid-config.yaml .

# Expose the port the application runs on
EXPOSE 8080

# Set the entrypoint to run the application
ENTRYPOINT ["java", "-jar", "prebid-server.jar", "--spring.config.additional-location=prebid-config.yaml"]
