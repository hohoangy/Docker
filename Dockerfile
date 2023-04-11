#
# Build stage
#
FROM maven:3.8.6-amazoncorretto-17 AS build
COPY src /src
COPY pom.xml ./
RUN mvn -f ./pom.xml clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-jdk-alpine
VOLUME /tmp
ARG JAR_FILE=target/*.jar
COPY --from=build ./target/hellodocker-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]