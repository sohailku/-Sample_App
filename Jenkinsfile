pipeline
{
environment {
BUILDTYPE = 'Release'
BRANCH = '*/main'
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
  checkout([$class: 'GitSCM',branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url:"${REPO}"]]])
}
}
 
}
}
