#!/bin/bash

docker build -t myjenkins:latest -f jenkins_docker/Dockerfile jenkins_docker/
docker volume create jenkins-volume
docker run -d --name myjenkins -p 8080:8080 -p 50000:50000 -v jenkins-volume:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock myjenkins:latest
while [[ -z "`curl localhost:8080 | grep Authentication | grep required`" ]]; do sleep 5; done
echo "==========> Your jenkins administrative password is:"
cat $( docker volume inspect jenkins-volume | grep Mountpoint | cut -d '"' -f4 )/secrets/initialAdminPassword
useradd jenkins
usermod -aG docker jenkins
service docker restart
