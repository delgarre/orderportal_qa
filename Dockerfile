FROM openjdk:8
EXPOSE 8082
ADD target/orderportal_qa.jar orderportal_qa.jar
ENTRYPOINT ["java", "-jar", "/orderportal_qa.jar"]