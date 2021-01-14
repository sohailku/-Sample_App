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
           checkout([$class: 'GitSCM', branches: [[name: '*/test']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url: 'https://github.com/meshuaib/sampleionic.git']]])
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
                                #docker build -t  meshuaib/ionic-fastlane:$commitId .
                                docker build -t  meshuaib/ionic-fastlaneci .
                                
                            """, returnStatus: true)
                        }
                    }
                }  
                }
                }
                stage ('Deploy') {
                steps {
                 
                  sh docker run -d --name test meshuaib/ionic-fastlaneci
                  sh docker exec -it test bash/sh 'fastlane test'
   
                  
    }
}
     
     }
             }
