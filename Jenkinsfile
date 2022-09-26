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
        GenericTrigger(
            genericVariables: [
                [key: 'actor', value: '$.repository.owner.name'],
                [key: 'branch', value: '$.ref']
            ],
            token: 'ansible-1',
            printContributedVariables: true,
            printPostContent: false,
            silentResponse: false,
            regexpFilterText: '$branch',
            regexpFilterExpression: 'refs/heads/' + BRANCH_NAME

        )
 }

stages {
  stage('checkout code') {
    steps {
      git 'https://github.com/gkdevops/ansible-code.git'
    }
  }
  
  stage('Approval Step') {
    steps {
                input {
                message "Ready to deploy?"
                ok "Yes"
                parameters {
                    string(name: "DEPLOY_ENV", defaultValue: "production")
                }
            }
    }
  }
 
  stage('deploy ansible') {
    steps {
        ansiblePlaybook colorized: true, installation: 'ANSIBLE29', playbook: 'playbooks/helloworld.yml'
    }
  } 
}
}
