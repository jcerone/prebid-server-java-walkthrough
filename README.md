# Prebid Server Java Walkthrough

Welcome to the Prebid Server Java Walkthrough! This guide provides a comprehensive set of instructions to help you get Prebid Server Java up and running on your local machine. Whether you prefer a manual setup, an automated script, or Docker, we've got you covered.

## What is Prebid Server?

Prebid Server is an open-source solution that enables server-to-server header bidding, a programmatic advertising technique that allows publishers to simultaneously collect bids from multiple ad exchanges. By moving the auction to the server-side, Prebid Server reduces latency and improves the user experience on web pages and mobile apps.

This walkthrough focuses on the Java implementation of Prebid Server.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup Methods](#setup-methods)
  - [1. Manual Setup](#1-manual-setup)
  - [2. Automated Script Setup](#2-automated-script-setup)
  - [3. Docker Setup](#3-docker-setup)
- [Testing Your Setup](#testing-your-setup)
- [Available Endpoints](#available-endpoints)

## Prerequisites

Before you begin, make sure you have the following tools installed on your system:

- **Git:** For cloning the repository.
- **cURL:** For testing the server endpoints.
- **Docker:** (Optional) If you choose the Docker-based setup.

## Setup Methods

Choose one of the following methods to set up Prebid Server Java.

---

### 1. Manual Setup

This method walks you through the traditional process of setting up the server step-by-step.

#### **Assumptions**
- You are using a macOS or Linux-based system.
- You have `sdkman` for managing Java and Maven versions.

#### **Directions**

1.  **Install sdkman** for managing Java runtimes:
    ```bash
    curl -s "https://get.sdkman.io" | bash
    ```

2.  **Install Java v22**:
    ```bash
    sdk install java 22.0.1-amzn
    ```

3.  **Set Java v22 as the default**:
    ```bash
    sdk default java 22.0.1-amzn
    ```

4.  **Install Maven v3.9.6**:
    ```bash
    sdk install maven 3.9.6
    ```

5.  **Clone the Prebid Server Java repository**:
    ```bash
    git clone https://github.com/prebid/prebid-server-java.git
    ```

6.  **Navigate to the repository directory**:
    ```bash
    cd prebid-server-java
    ```

7.  **Build the project**:
    ```bash
    mvn clean package -Dmaven.test.skip=true
    ```

8.  **Run the server**:
    ```bash
    java -jar target/prebid-server.jar --spring.config.additional-location=sample/configs/prebid-config.yaml
    ```

---

### 2. Automated Script Setup

For a faster and more convenient setup, you can use the provided shell script to automate the entire process.

1.  **Make the script executable**:
    ```bash
    chmod +x setup.sh
    ```

2.  **Run the script**:
    ```bash
    ./setup.sh
    ```

The script will handle everything from installing dependencies to building and running the server.

---

### 3. Docker Setup

Containerize the application with Docker for a portable and isolated environment. This is the recommended approach for a hassle-free setup.

1.  **Build and run the container using Docker Compose**:
    ```bash
    docker-compose up --build
    ```

This command will build the Docker image and start the Prebid Server container. The server will be accessible at `http://localhost:8080`.

To stop the server, press `Ctrl+C`.

## Testing Your Setup

Once the server is running, you can test its status by sending a request to the `/status` endpoint:

```bash
curl 'http://0.0.0.0:8080/status'
```

If the server is running correctly, you should receive a response indicating its status.

## Available Endpoints

Here are some of the key endpoints you can use for testing and integration:

-   `/info/bidders`: Shows a list of available bidders.
-   `/info/bidders/{bidder-name}`: Shows the configuration for a specific bidder (e.g., `/info/bidders/appnexus`).
-   `/openrtb2/auction`: The primary endpoint for sending bid requests and receiving bid responses.
-   `/cookie_sync`: Used for synchronizing user cookies with bidders.
-   `/status`: Provides the current status of the Prebid Server.
