FROM openjdk:8
EXPOSE 8082
ADD target/mycartqa.jar mycartqa.jar
ENTRYPOINT ["java", "-jar", "/mycartqa.jar"]