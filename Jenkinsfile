pipeline {
    agent none
    stages {
        stage('编译') {
            agent {
                docker {
                    image 'maven:3-alpine'
                    args '-v /root/.m2:/root/.m2'
                    }
                }
            steps {
                sh 'mvn clean install -Dmaven.test.skip=true'
            }
        }

        stage('部署') {
            agent any
            steps {
                sh 'cd ..'
                sh 'ls'
                sh 'pwd'
                sh 'bash start.sh'
            }
        }
    }
}