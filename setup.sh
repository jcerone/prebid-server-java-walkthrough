#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# --- Introduction ---
echo "Welcome to the Prebid Server Java Automated Setup!"
echo "This script will guide you through the process of setting up and running the server."
echo "-----------------------------------------------------"

# --- Dependency Checks ---
echo "Checking for dependencies..."

if ! command_exists git; then
    echo "Error: Git is not installed. Please install Git and try again."
    exit 1
fi

if ! command_exists curl; then
    echo "Error: cURL is not installed. Please install cURL and try again."
    exit 1
fi

echo "All dependencies are satisfied."
echo "-----------------------------------------------------"

# --- SDKMAN, Java, and Maven Installation ---
echo "Setting up Java and Maven environment using sdkman..."

# Install sdkman if not already installed
if [ ! -d "$HOME/.sdkman" ]; then
    echo "Installing sdkman..."
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
else
    echo "sdkman is already installed."
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

# Install Java and Maven
echo "Installing Java and Maven..."
sdk install java 22.0.1-amzn
sdk install maven 3.9.6
sdk default java 22.0.1-amzn

echo "Java and Maven setup is complete."
echo "-----------------------------------------------------"

# --- Clone and Build Prebid Server ---
echo "Cloning the Prebid Server Java repository..."

if [ -d "prebid-server-java" ]; then
    echo "prebid-server-java directory already exists. Skipping clone."
else
    git clone https://github.com/prebid/prebid-server-java.git
fi

cd prebid-server-java

echo "Building the project with Maven... (This may take a few minutes)"
mvn clean package -Dmaven.test.skip=true

echo "Build complete."
echo "-----------------------------------------------------"

# --- Run Prebid Server ---
echo "Starting Prebid Server..."
java -jar target/prebid-server.jar --spring.config.additional-location=sample/configs/prebid-config.yaml &

# Give the server a moment to start
sleep 5

# --- Verification ---
echo "Verifying server status..."
if curl -s 'http://0.0.0.0:8080/status' > /dev/null; then
    echo "✅ Prebid Server is up and running!"
    echo "You can access it at http://0.0.0.0:8080"
else
    echo "❌ Failed to start Prebid Server. Please check the logs for errors."
fi

echo "-----------------------------------------------------"
echo "Setup is complete. Enjoy!"
