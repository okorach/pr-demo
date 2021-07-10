#!/bin/bash

# Load common environment

mvn clean install -P coverage-per-test \
   -Dmaven.test.failure.ignore=true \
   sonar:sonar \
   -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN \
   -Dsonar.exclusions=pom.xml \
   -Dsonar.projectKey="demo:github-comp-maven" -Dsonar.projectName="GitHub project - Maven" \
   $*

exit $?
