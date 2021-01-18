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
       stage ('gradle') {
        steps {
            sh "pwd"
            dir ('platforms/android') {
                sh "ls -la"
                sh "./gradlew clean"}
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
                                docker build -t  meshuaib/ionic-fastlanedev .
                            
                                
                            """, returnStatus: true)
                        }
                    }
                }  
                }
                }
                stage ('RUN') {
                      agent { docker { image 'meshuaib/ionic-fastlanedev' 
                        args '-u root' } }
    
        
            steps {
                sh '''cd /app/platforms/android/gradlew clean
                    /root/.rbenv/shims/fastlane test'''
                     }
                
            }
        }
    }

                
