 #!/bin/bash
 #
 # Author:
 #        _                             _
 #       | |                           (_)
 #     __| | _ __    __ _  _ __   __ _  _  ___   ___
 #    / _` || '_ \  / _` || '__| / _` || |/ __| / _ \
 #   | (_| || |_) || (_| || |   | (_| || |\__ \| (_) |
 #    \__,_|| .__/  \__,_||_|    \__,_||_||___/ \___/
 #          | |
 #          |_|
 #
 # To configure:
 #
 # $ docker network create skynet
 #
 # $ docker volume create jenkins-data
 #
 # $ docker pull jenkins/jenkins
 #

 docker container run --name image_name --detach \
     --network skynet -u root \
     --volume jenkins-data:/var/jenkins_home \
     --volume /var/run/docker.sock:/var/run/docker.sock \
     --publish 8080:8080 --publish 50000:50000 jenkins/jenkins