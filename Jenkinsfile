pipeline {
  agent none
   
   stages {
     stage('Checkout') {
       agent { 
    node { 
      label 'docker' 
    }
     
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
                                docker build -t  meshuaib/ionic-fastlane2 .
                            
                                
                            """, returnStatus: true)
                        }
                    }
                }  
                }
                }
               stage ('Tests')  {
                 agent {
                 
                   docker {
                        image 'openjdk:8' }
                  steps { 
                  sh "java -version"
                
               }
                        }
                        }
}

   }
}
