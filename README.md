# cofeit

Basic CICD Pipeline (with example) using the following components: 

* jenkins
* sonarqube
* nexus
* docker-registry

The entire system will be started from a single compose file 

Configuration order is important 

## Pre-Configuration
You can put your software anywhere you want it, for this example we will be storing everything under `/opt/apps/cofeit` and we will be running everything as the user cicdops with a group of devops

*As root*


```
mkdir -p /opt/apps/cofeit

mkdir /opt/apps/cofeit/postgresql
mkdir /opt/apps/cofeit/postgresql/data

mkdir /opt/apps/cofeit/sonarqube
mkdir /opt/apps/cofeit/sonarqube/conf
mkdir /opt/apps/cofeit/sonarqube/data
mkdir /opt/apps/cofeit/sonarqube/extensions
mkdir /opt/apps/cofeit/sonarqube/lib
mkdir /opt/apps/cofeit/sonarqube/lib/bundled-plugins

mkdir /opt/apps/cofeit/jenkins_home

chown -R cicdops:devops /opt/apps/cofeit

chmod 775 /opt
chgrp devops /opt
chgrp devops /opt/apps
chown -R cicdops:devops /opt/apps/cofeit
chown 1000:1000 /opt/apps/cofeit/jenkins_home
```

stop the docker engine `systemctl stop docker`
and add the following (or create) to `/etc/docker/daemon.json`

```
{ "insecure-registries":["localhost:5000"] }
```

## docker-registry

After setting up the registry, you can test if the test was successful by executing: 

```
docker pull hello-world
docker tag hello-world localhost:5000/hello-world
docker push localhost:5000/hello-world
```

Now test to see if the push registered

`curl -ik http://localhost:5000/v2/_catalog`


## sonarqube 



## nexus



## jenkins 



## Registry UI's 

https://github.com/atcol/docker-registry-ui


# Notes & comments

https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.5/data-operating-system/content/test_the_local_docker_registry.html
