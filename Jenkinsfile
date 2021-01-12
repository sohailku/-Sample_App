pipeline
{
environment {
BUILDTYPE = 'Release'
BRANCH = 'main'
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
git branch: "${BRANCH}", credentialsId: gitaccess, url: 'https://github.com/meshuaib/sampleionic.git'
}
}
}
}
