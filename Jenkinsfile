pipeline {
    agent none
    stages {
        stage ('build') {
            agent { label 'docker' }
            steps {
                echo 'linux build'
            }
        }
    }
}
