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
      sh "env"
    }
  }
  
       stage('Approve Update') {
            steps {
                script {
                    if( params.BRANCH != 'develop' ){
                        timeout(time: 3, unit: 'DAYS') {
                            input(message: 'Update Image?', parameters: [
                                [$class: 'TextParameterDefinition', defaultValue: params.BRANCH, description: '', name: 'env'],
                            ])
                        }
                    } else {
                        echo "Environment ${params.environment} does not require an approval"
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
