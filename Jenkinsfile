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
           checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url: 'https://github.com/meshuaib/sampleionic.git']]])
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
         stage('Docker Remove Image') {
      steps {
        sh "docker rmi meshuaib/ionic-fastlane:$commitId"
      }
    }
                stage ('Fastlane Test') {
                steps {
                  script {
                    // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerContainer('meshuaib/ionic-fastlane:$commitId') {
    // some block
    sh "fastlane test"
}
                }
                }
             }

   }
}
