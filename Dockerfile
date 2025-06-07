# Dockerfile

FROM openjdk:17-oracle
WORKDIR /home/petclinic/

# Copy in the built Spring Boot jar
COPY target/spring-petclinic-3.2.0-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
