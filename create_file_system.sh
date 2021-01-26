#!/bin/bash

user=cicdops
group=devops
cofeitdir=/opt/apps/cofeit


echo "Creating Application home ..."
mkdir -p ${cofeitdir}

echo "Creating docker registry home ..."
mkdir ${cofeitdir}/registry

echo "Creating Postgres data home ..."
mkdir ${cofeitdir}/postgresql
mkdir ${cofeitdir}/postgresql/data

echo "Creating SonarQube home ..."
mkdir ${cofeitdir}/sonarqube
mkdir ${cofeitdir}/sonarqube/conf
mkdir ${cofeitdir}/sonarqube/data
mkdir ${cofeitdir}/sonarqube/extensions
mkdir ${cofeitdir}/sonarqube/lib
mkdir ${cofeitdir}/sonarqube/lib/bundled-plugins

echo "Creating Jenkins home ..."
mkdir ${cofeitdir}/jenkins_home


echo "Setting ownership and permission ..."
chown -R ${user}:${group} ${cofeitdir}


chmod 775 /opt
chgrp ${group} /opt
chgrp ${group} /opt/apps
chown -R ${user}:${group} ${cofeitdir}
chown 1000:1000 ${cofeitdir}/jenkins_home
