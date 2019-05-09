FROM java:8
WORKDIR /www/wwwroot/springboot
VOLUME /tmp
#ADD target/springtest-0.0.1-SNAPSHOT.jar springtest.jar
#RUN bash -c 'touch /springtest.jar'
#ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/springtest.jar"]
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","springtest.jar"]
EXPOSE 8000