FROM eclipse-temurin:17-jre-alpine
WORKDIR /opt/app
COPY src/main/resources/application.properties application.properties
COPY target/orders-app.jar orders-app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "orders-app.jar"]