FROM openjdk:8
EXPOSE 8082
ADD target/mycartqa-1.0-SNAPSHOT.jar mycartqa-1.0-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/mycartqa-1.0-SNAPSHOT.jar"]