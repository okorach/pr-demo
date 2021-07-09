#!/bin/bash
./run_tests.sh

./run_linters.sh

echo "Running: \
sonar-scanner -Dproject.settings=sonar-project.person.properties $* 
"
sonar-scanner -Dproject.settings=sonar-project.person.properties $*

echo "Running: \
sonar-scanner -Dproject.settings=sonar-project.fruits.properties $* \
"
sonar-scanner -Dproject.settings=sonar-project.fruits.properties $*

./dotnet-build.sh