pipeline
{
environment {
BUILDTYPE = ‘Release’
BRANCH = ‘main’
BRANCH_ANDROIDKIT = ‘main’
REPO = 'https://github.com/meshuaib/sampleionic.git'
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
git branch: “${BRANCH}”, credentialsId: gitaccess, url: 'https://github.com/meshuaib/sampleionic.git
}
}
}
}
