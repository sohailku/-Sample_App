pipeline
{
environment {
BUILDTYPE = ‘Release’
BRANCH = ‘main’

REPO = "https://github.com/meshuaib/sampleionic.git"
}
agent {
node {
label ‘android’
}
}

stage(‘Clone the Library’) {
steps{ 
clonelib()
git branch: “${BRANCH}”, credentialsId: ‘gitaccess’, url: “${REPO}” 
}
}

stage(‘Build’) {
steps{
script {
if (BUILDTYPE == ‘Release’) { 
buildRelease()
} else {
buildDebug()
}
}
}
}
