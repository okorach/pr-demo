#!/bin/bash
buildDir="build"

pylintReport="$buildDir/pylint-report.out"
banditReport="$buildDir/bandit-report.json"
flake8Report="$buildDir/flake8-report.out"
coverageReport="$buildDir/coverage.xml"

[ ! -d $buildDir ] && mkdir $buildDir
rm -rf -- ${buildDir:?"."}/* .coverage */__pycache__ */*.pyc # mediatools/__pycache__  testpytest/__pycache__ testunittest/__pycache__

echo "Running tests"
coverage run -m pytest
coverage xml -o $coverageReport

echo "Running pylint"
rm -f $pylintReport
pylint *.py */*.py -r n --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" > $pylintReport

echo "Running flake8"
rm -f $flake8Report
flake8 --ignore=W503,E128,C901,W504,E302,E265,E741,W291,W293,W391 --max-line-length=150 . > $flake8Report

echo "Running bandit"
rm -f $banditReport
bandit -f json --skip B311,B303,B101 -r . -x .vscode,./testpytest,./testunittest > $banditReport

echo "Running: sonar-scanner \
  -Dsonar.python.flake8.reportPaths=$flake8Report \
  -Dsonar.python.pylint.reportPaths=$pylintReport \
  -Dsonar.python.bandit.reportPaths=$banditReport \
  -Dsonar.python.coverage.reportPaths=$coverageReport \
  $*"

sonar-scanner \
  -Dsonar.python.flake8.reportPaths=$flake8Report \
  -Dsonar.python.pylint.reportPaths=$pylintReport \
  -Dsonar.python.bandit.reportPaths=$banditReport \
  -Dsonar.python.coverage.reportPaths=$coverageReport \
  $*

sonar-scanner -Dproject.settings=sonar-project.comp2.properties \
  -Dsonar.python.flake8.reportPaths=$flake8Report \
  -Dsonar.python.pylint.reportPaths=$pylintReport \
  -Dsonar.python.bandit.reportPaths=$banditReport \
  -Dsonar.python.coverage.reportPaths=$coverageReport \
  $*
