pipeline
{
environment {
BUILDTYPE = ‘Release’
BRANCH = ‘main’

REPO = ‘git@github.com:meshuaib/sampleionic.git’
}
agent {
node {
label ‘android’
}
}
stages{
stage(‘Cleaning the workspace’) {
steps {
sh “rm -rf ${WORKSPACE}/*”
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
