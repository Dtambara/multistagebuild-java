FROM maven:3.9.9-eclipse-temurin-17-focal AS builder

WORKDIR /build
COPY ./helloWorld /build

RUN mvn clean package

FROM alpine/java:17-jre

WORKDIR /app
COPY --from=builder /build/target/*.jar /app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar", "-Ddebug", "-Xmx128m"]