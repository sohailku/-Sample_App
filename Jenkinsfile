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
                                docker build -t  meshuaib/ionic-fastlane$commitId  .
                            
                                
                            """, returnStatus: true)
                        }
                    }
                }  
                }
                }
               stage ('Tests'){
                steps {
                script {
                    img = docker.image("meshuaib/ionic-fastlane$commitId")
                    img.inside('-u root') {
                        try{
                        git credentialsId: 'gitaccess', poll: false, url: "https://github.com/meshuaib/sampleionic.git", branch: "develop"
                        sh "fastlane test"
                        }catch(e){
                        println("Error in test execution")
                        
                        }

                    }
               }
               
           }
                }
                        }
                        }

