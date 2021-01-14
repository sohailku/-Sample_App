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
               stage ('Tests'){
            steps {
                script {
                    img = docker.image("meshuaib/ionic-fastlane:$commitId ")
                    img.inside('-u root') {
                        try{
                        git credentialsId: 'gitaccess', poll: false, url: "https://github.com/meshuaib/sampleionic.git", branch: "develop"
                        sh "chmod 777 -R ."
                        sh "npm install -g grunt-cli"
                        sh "npm config set registry <custom docker registry>"
                        sh "npm set strict-ssl false"
                        sh "cd <project_folder> && npm install"
                        sh "npm install webdriver-manager"
                        sh "npm install protactor"
                        sh "./node_modules/protractor/bin/webdriver-manager update"
                        sh "npm install chromedriver"
                        sh "apt-get upgrade -y google-chrome-stable"
                        sh "npm run e2e" //running tests from e2e script defined in package.json
                        sh "rm -rf *" //clean workspace
                        }catch(e){
                        println("Error in test execution")
                        sh "rm -rf *"
                        }

                    }
               }
               
           }
                }
                        }
                        }

