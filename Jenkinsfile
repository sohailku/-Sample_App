pipeline {
    agent {
        docker { image 'ubuntu:latest' }
    }
    stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
