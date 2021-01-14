pipeline
{
environment {
         PATH='/usr/local/bin:/usr/bin:/bin'
      
REPO = 'https://github.com/meshuaib/sampleionic.git'
}
agent {
node {
label 'andriod'
}
}
stages{
stage('Clone the Library') {
steps{ 
  checkout([$class: 'GitSCM',branches: [[name: '*/test']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url:"${REPO}"]]])
}
}
      stage('Running Tests') {
      steps {
        dir('platforms/android'){
        sh "fastlane test"
        }
      }
    }
  stage ('Fastlane deploy'){
  steps {
    dir ('platforms/android'){
    sh "fastlane deploy"
    }
  }
}

}
}
