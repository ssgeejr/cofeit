#!/bin/bash

echo "Creating Application home ..."
mkdir -p /opt/apps/cofeit

echo "Creating docker registry home ..."
mkdir /opt/apps/cofeit/registry

echo "Creating Postgres data home ..."
mkdir /opt/apps/cofeit/postgresql
mkdir /opt/apps/cofeit/postgresql/data

echo "Creating SonarQube home ..."
mkdir /opt/apps/cofeit/sonarqube
mkdir /opt/apps/cofeit/sonarqube/conf
mkdir /opt/apps/cofeit/sonarqube/data
mkdir /opt/apps/cofeit/sonarqube/extensions
mkdir /opt/apps/cofeit/sonarqube/lib
mkdir /opt/apps/cofeit/sonarqube/lib/bundled-plugins

echo "Creating Jenkins home ..."
mkdir /opt/apps/cofeit/jenkins_home


echo "Setting ownership and permission ..."
chown -R cicdops:devops /opt/apps/cofeit


chmod 775 /opt
chgrp devops /opt
chgrp devops /opt/apps
chown -R cicdops:devops /opt/apps/cofeit
chown 1000:1000 /opt/apps/cofeit/jenkins_home
