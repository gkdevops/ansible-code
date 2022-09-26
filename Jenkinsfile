pipeline {

agent {
  label 'built-in'
}

options {
  ansiColor('xterm')
  buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '10')
  parallelsAlwaysFailFast()
  timestamps()
}

triggers {
  cron '00 2 * * *'
}

stages {
  stage('checkout code') {
    steps {
      git 'https://github.com/gkdevops/ansible-code.git'
    }
  }
  
  stage('deploy ansible') {
    steps {
        ansiblePlaybook colorized: true, installation: 'ANSIBLE29', playbook: 'playbooks/helloworld.yml'
    }
  } 
}
}
