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
                    if( params.BRANCH_NAME == 'master' ){
                        timeout(time: 3, unit: 'DAYS') {
                            input(message: 'Update Image?', parameters: [
                                [$class: 'TextParameterDefinition', defaultValue: params.BRANCH_NAME, description: '', name: 'env'],
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
      withCredentials([string(credentialsId: 'vault-credentials', variable: 'vault-password')]) {
        sh "echo '$vault-password' > vault-password.txt ; ansible-playbook playbooks/vault-1.yml --vault-password vault-password"
      }
    }
  } 
}
}
