FROM maven:3.8.4-openjdk-17 as build
COPY src /spring-mvc/src
COPY pom.xml /spring-mvc

WORKDIR /spring-mvc
RUN mvn clean package -DskipTests

FROM openjdk:17-slim
COPY --from=build /spring-mvc/target/*.war /spring-mvc/app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/spring-mvc/app.war"]