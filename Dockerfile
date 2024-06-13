# Stage 1: Build the application
FROM gradle:7.4.2-jdk17 AS build

# Set working directory
WORKDIR /app

# Copy project files to the container
COPY . .

# Build the project
RUN gradle clean build

# List files in the build directory for debugging purposes
RUN ls -la /app/build/libs

# Stage 2: Create the final image
FROM openjdk:17-alpine
# Set working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=build /app/build/libs/*.jar /app/analisys.jar

EXPOSE 8080

# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "/app/analisys.jar"]