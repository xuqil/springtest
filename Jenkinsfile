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

        stage('构建镜像'){
            agent any
            steps {
                sh 'docker build -t springboot:1.1 . '
            }
        }

        stage('部署'){
            agent any
            steps {
                echo 'stop spring'
                sh 'docker stop spring-test'
                sh 'docker rm spring-test'
                echo 'start spring'
                sh 'docker run --name spring-test -d -p 8000:8000 springboot:1.1'
            }
        }
    }
}