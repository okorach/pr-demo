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

cd comp-maven; ./build.sh $*; cd -

cd comp-dotnet; ./build.sh $*; cd -

cd comp-gradle; ./build.sh $*; cd -