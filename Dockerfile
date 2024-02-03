FROM eclipse-temurin:21-jdk-alpine as builder

# the target jar vesion
ARG TARGET_JAR_VERSION="0.0.1-SNAPSHOT"

# the target JAR file location
ARG JAR_FILE=build/libs/*-${TARGET_JAR_VERSION}.jar

COPY ${JAR_FILE} application.jar

RUN java -Djarmode=layertools -jar application.jar extract

FROM eclipse-temurin:21-jdk-alpine
COPY --from=builder dependencies/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder application/ ./

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
