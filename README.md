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

edit `/etc/sysctl.conf` and add the following two lines (if they do not already exist)

```
vm.max_map_count=262144
fs.file-max=65536
```

Now to prevent having to restart your machine, also execute the same command from the CLI: 

`sysctl -w vm.max_map_count=262144`

check that the value stuck by using `sysctl vm.max_map_count`


Now we need to setup some folders and folder permissions 

*Note* If you want to take teh shortest distance between two points, review/edit the create_file_system.sh
Once you are happy with it, you can run it with `./create_file_system.sh`

```
mkdir -p /opt/apps/cofeit

mkdir /opt/apps/cofeit/registry 

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


## NOTE REQUIRED IF YOU ARE CONNECTING VIA THE DOCKER NETWOKR ONLY
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
This one is pretty much hands-off ... start it and go.  You can connect to it over http://<IP>:9000 

If using an AWS PostGres DB, the following needs to be done
Create postgres DB to your needs
set user to postgres / <password>
Copy the Endpoint <AWS_RDS_POSTGRES_ENDPOINT>

start the postgres client with either option: 
docker run -it --rm --name psql postgres psql -h  <AWS_RDS_POSTGRES_ENDPOINT> -U postgres

docker run -it --rm --name psql postgres /bin/bash
psql -h  <AWS_RDS_POSTGRES_ENDPOINT> -U postgres

enter: <password>

create user sonar with password '<sonar_password>';
grant role sonar to postgres;
create database sonar with owner sonar encoding 'UTF8';
exit

psql -h  <AWS_RDS_POSTGRES_ENDPOINT> -U sonar

enter: <sonar_password>

\c sonar

#once you start the container, execute \dt (Describe tables) until you see sonar creating the schemas
\dt 

TO start sonarqube with a standalone db

```
   sonar:
      image: sonarqube:8.6.0-community
      container_name: sonar
      ports:
         - "9000:9000"
      environment:
         - sonar.jdbc.url=jdbc:postgresql://<AWS_RDS_POSTGRES_ENDPOINT>:5432/sonar
         - sonar.jdbc.username=sonar
         - sonar.jdbc.password=<sonar_password>
      volumes:
         - /opt/apps/cofeit/sonarqube/conf
         - /opt/apps/cofeit/sonarqube/data
         - /opt/apps/cofeit/sonarqube/extensions
         - /opt/apps/cofeit/sonarqube/lib/bundled-plugins

```


## jenkins 

This is the one that will take some time to configure and execute, it takes some time. 


#Create a new job, the Git repo: 
https://github.com/ssgeejr/cofeit.git

#branch
*/main


#in the build [script] section add
cd webapp
mvn clean package
mvn sonar:sonar
cd docker
#docker build -t cofeit:${BUILD_NUMBER} .
docker build -t localhost:5000/cofeit:1 .
docker push localhost:5000/cofeit:1




## Sonarqube

Log in admin/admin  (reset password)

Enable anyone to analize: 
```
Configuration:
 - Security
  -Security
   - (uncheck) Force user authentication
```


## Registry UI's 
_NOT IMPLEMENTED_

https://github.com/atcol/docker-registry-ui


# Notes & comments

https://docs.cloudera.com/HDPDocuments/HDP3/HDP-3.1.5/data-operating-system/content/test_the_local_docker_registry.html
