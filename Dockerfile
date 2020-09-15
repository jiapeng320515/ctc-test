FROM chinamobile.com/devops-tool/openjdk:8

MAINTAINER isaacwei <isaacwei@gmail.com>

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TZ=Asia/Shanghai

RUN mkdir /home/app

WORKDIR /home/app

COPY target/demo-0.0.1-SNAPSHOT.jar /home/app/demo.jar

EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:/dev/./urandom", "-jar","/home/app/demo.jar"]