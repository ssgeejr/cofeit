FROM jenkins/jenkins:lts
USER root
RUN apt-get update && apt-get install -y default-jdk maven apt-utils
RUN curl -fsSL https://get.docker.com/ | sh
COPY settings.xml /etc/maven/settings.xml
RUN usermod -aG docker jenkins
USER jenkins
