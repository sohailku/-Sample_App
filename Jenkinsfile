pipeline {
    agent none
    stages {
        stage ('build') {
            agent { label 'andriod' }
            steps {
                echo 'linux build'
            }
        }
        stage ('build docker') {
            agent { label 'docker' }
            steps {
                echo 'docker build'
            }
        }
    }
}
