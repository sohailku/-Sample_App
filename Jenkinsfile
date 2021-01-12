pipeline
{
environment {
BUILDTYPE = 'Release'
BRANCH = 'main'

REPO = "https://github.com/meshuaib/sampleionic.git"
}
agent {
node {
label ‘android’
}
}

stage( 'Clone the Library') {
steps{ 
         script {
           checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'gitaccess', url: 'https://github.com/meshuaib/sampleionic.git']]])
         }
}

stage(‘Build’) {
steps{
script {
if (BUILDTYPE == 'Release') { 
buildRelease()
} else {
buildDebug()
}
}
}
}
}
}
