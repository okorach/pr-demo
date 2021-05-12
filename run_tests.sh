#!/bin/bash
buildDir="build"
coverageReport="$buildDir/coverage.xml"

[ ! -d $buildDir ] && mkdir $buildDir

echo "Running tests"
coverage run -m pytest
coverage xml -o $coverageReport
