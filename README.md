# prebid-server-java-walkthrough
A short walk through with scripts to help you get Prebid Server Java up and running. 

## Assumptions

- Mac OS
- Java v22
- Maven v3.9.6



## Directions

1. Install sdk man for managing the Java runtime.

```
curl -s "https://get.sdkman.io" | bash
```

2. Install Java v22

```
sdk install java 22.0.1-amzn
```

3. Make sure the Java v22 is the default Java runtime.

```
sdk default java 22.0.1-amzn
```

4. Install Maven v3.9.6

```
sdk install maven 3.9.6
```

5. Clone the Prebid Server Java repository.

```
git clone https://github.com/prebid/prebid-server-java.git
```

6. Navigate to the Prebid Server Java repository.

``` 
cd prebid-server-java
```

7. Build the Prebid Server Java project.

```
mvn clean package -Dmaven.test.skip=true
```

8. Run the Prebid Server Java project.

```
java -jar target/prebid-server.jar --spring.config.additional-location=sample/configs/prebid-config.yaml
```

9. Use CURL / Postman to test the Prebid Server Java project.

```
curl 'http://0.0.0.0:8080/status'
```