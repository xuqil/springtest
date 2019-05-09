pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock -v /usr/bin/docker:/usr/bin/docker'
        }
    }
    stages {
        stage('编译') {
            steps {
                sh 'mvn clean install -Dmaven.test.skip=true'
            }
        }
        stage('构建镜像'){
            steps {
                sh 'docker build -t springboot:1.1 . '
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }

    }
}