FROM java:8
VOLUME /tmp
ADD springtest-0.0.1-SNAPSHOT.jar springtest.jar
RUN bash -c 'touch /springtest.jar'
ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom","-jar","/springtest.jar"]
EXPOSE 8000