buildDir = "build"
pylintReport = "${buildDir}/pylint-report.out"
banditReport = "${buildDir}/bandit-report.json"
flake8Report = "${buildDir}/flake8-report.out"
coverageReport = "${buildDir}/coverage.xml"

coverageTool = 'coverage'
pylintTool = 'pylint'
flake8Tool = 'flake8'
banditTool = 'bandit'

// rm -rf -- ${buildDir:?"."}/* .coverage */__pycache__ */*.pyc # mediatools/__pycache__  testpytest/__pycache__ testunittest/__pycache__

pipeline {
  agent any
  stages {
    stage('Run tests') {
      steps {
        dir(${buildDir})
        script {
          sh "${coverageTool} run -m pytest"
          sh "${coverage} xml -o ${coverageReport}"
        }
      }
    }
    stage('Run 3rd party linters') {
      steps {
        script {
          sh "${pylintTool} *.py */*.py -r n --msg-template=\"{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}\" > ${pylintReport}"
          sh "${flake8Tool} --ignore=W503,E128,C901,W504,E302,E265,E741,W291,W293,W391 --max-line-length=150 . > ${flake8Report}"
          sh "${banditTool} -f json --skip B311,B303 -r . -x .vscode,./testpytest,./testunittest > ${banditReport}"
        }
      }
    }
    stage('SonarQube LTS analysis') {
      steps {
        withSonarQubeEnv('SQ LTS') {
          script {
            def scannerHome = tool 'SonarScanner';
            sh "${scannerHome}/bin/sonar-scanner"
          }
        }
      }
    }
    stage("SonarQube LTS Quality Gate") {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          script {
            def qg = waitForQualityGate() // Reuse taskId previously collected by withSonarQubeEnv
            if (qg.status != 'OK') {
              echo "Quality gate failed: ${qg.status}, proceeding anyway"
            }
          }
        }
      }
    }
    stage('SonarQube LATEST analysis') {
      steps {
        withSonarQubeEnv('SQ Latest') {
          script {
            def scannerHome = tool 'SonarScanner';
            sh "${scannerHome}/bin/sonar-scanner"
          }
        }
      }
    }
    stage("SonarQube LATEST Quality Gate") {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          script {
            def qg = waitForQualityGate()
            if (qg.status != 'OK') {
              echo "Quality gate failed: ${qg.status}, proceeding anyway"
            }
          }
        }
      }
    }
  }
}