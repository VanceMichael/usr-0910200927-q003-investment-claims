FROM eclipse-temurin:21-jdk-alpine AS build
RUN wget -qO /tmp/maven.tar.gz https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.9.11/apache-maven-3.9.11-bin.tar.gz && tar -xzf /tmp/maven.tar.gz -C /opt && ln -s /opt/apache-maven-3.9.11/bin/mvn /usr/local/bin/mvn && rm /tmp/maven.tar.gz
WORKDIR /src
COPY pom.xml ./
COPY src ./src
COPY contracts ./contracts
RUN mvn -q test package

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
RUN addgroup -S app && adduser -S app -G app && mkdir /data && chown app:app /data
COPY --from=build /src/target/investment-claim-reconciler-0.1.0.jar /app/service.jar
USER app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/service.jar"]
