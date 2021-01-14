stage ('fastlane test')
docker.inside('meshuaib/ionic-fastlane') {
  sh 'bundle exec fastlane test'
}


    image = stage('docker build') {
        docker.build('fostery-build', '--build-arg user=`whoami` --build-arg UID=`id -u` --build-arg GID=`id -g` .')
    }

    image.inside("--env GRADLE_USER_HOME=${pwd()}/gradle_home") {
        dir('browser') {
            stage('bootstrap') {
                sh './bootstrap.sh'
            }



pipeline {
  agent { 
    node { 
      label 'andriod' 
    }
   }
   stages {
     stage('Checkout') {
       steps {
         script {
           checkout([$class: 'GitSCM', branches: [[name: '*/develop']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url: 'https://github.com/meshuaib/sampleionic.git']]])
         }
       }
     }
               stage ('Build & Push Image') {
                steps {
                script {
                    //dockerUrl = "hub.docker.com"
                    commitId = sh(script: 'git rev-parse --verify --short HEAD', returnStdout: true).trim()
                    withCredentials([usernamePassword(
                        credentialsId: "dockerhub",
                        usernameVariable: "USERNAME",
                        passwordVariable: "PASSWORD"
                    )
                    ]) {
                        ansiColor('xterm') {
                            exitCode = sh(script: """
                                docker login -u $USERNAME -p $PASSWORD
                                docker build -t  meshuaib/ionic-fastlane:$commitId .
                            
                                
                            """, returnStatus: true)
                        }
                    }
                }  
                }
                }
               stage ('fastlane test') {
                 steps {
                   scripts {
                     img = docker.image('meshuaib/ionic-fastlane:$commitId')
                     img.inside ('-u root') {
                                 try{
                                   sh "fastlane test"
                    }
                 }
                 }       
                 }
                       }
                                 

  stage ('Tests'){
            steps {
                script {
                    img = docker.image("<image from Dockerfile in this project>")
                    img.inside('-u root') {
                      try{
                        sh "fastlane test"
                        }
                        }
                        }
                        }
                        }
                        }
                        }

