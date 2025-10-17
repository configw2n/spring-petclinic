FROM openjdk:17-orcacle
#CMD ["./mvnw", "clean", "package"]
ARG JAR_FILE_PATH=target/*.jar
COPY ${JAR_FILE_PATH} srping-petclinic.jar
ENTRYPOINT {"java", "-jar", "spring-petclinic.jar"}
