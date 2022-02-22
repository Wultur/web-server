pipeline {
    agent any
    environment {
        nginx = ''
        apache =''
    }
    
    stages {
        stage('Pull code from GitHub') {
            steps {
                checkout scm
            }
        }
        stage("Build nginx docker image") {
            steps {
                script {
                    nginx = docker.build("wultur/nginx:v${env.BUILD_NUMBER}", "./docker/nginx --no-cache")
                }
            }
        }
        stage("Build apache docker image") {
            steps {
                script {
                    apache = docker.build("wultur/apache:v${env.BUILD_NUMBER}", "./docker/apache  --no-cache")
                }
            }
        }
        stage("Pushing images to Docker Hub") {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub') {
                        nginx.push()
                        apache.push()
                    }
                }
            }
        }
        stage("Cleaning up unnecessary images") {
            steps {
                sh "docker rmi wultur/nginx:v${env.BUILD_NUMBER}"
                sh "docker rmi wultur/apache:v${env.BUILD_NUMBER}"
            }
        }
        stage("Execute deployment using Asible") {
            steps {
                ansiblePlaybook credentialsId: 'ec2-ssh-private-key', disableHostKeyChecking: true, installation: 'ansible', inventory: 'hosts', playbook: 'playbook.yml'
            }
        }
    }
    post {
        // Clean after build
        always {
            cleanWs()
        }
    }
}