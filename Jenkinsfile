pipeline{
agent any

env.BRANCH="${params.branch}"

env.GIT_CREDENTIALS_ID="gitaccess"
env.GIT_REPO_URL="https://github.com/meshuaib/sampleionic.git"

env.DOCKER_IMAGE_NAME="meshuaib/ionic-fastlane "
env.DOCKER_IMAGE_TAG="latest"
env.BUILD_NODE="android"

timestampedNode(env.BUILD_NODE) {
    stage('Checkout') {
	echo 'Before Checkout'
        gitCheckoutBranch("${env.main}")
        // requires last changes plugin
        lastChanges()
    }

    stage('Build base img') {
        buildBaseImage()
    }

    stage('Npm install') {
        env.dockerWrapper = prepareDockerWrapper()
        installDependencies(env.dockerWrapper)
    }

    stage ('Cordova prepare'){
        cordovaPrepareAndroid(env.dockerWrapper)
    }

    stage ('Ionic build'){
        ionicBuild(env.dockerWrapper)
    }
}

def gitCheckoutBranch(maine){
  checkout([
    $class: 'GitSCM',
    branches: [[name: "*/${main}"]],
    doGenerateSubmoduleConfigurations: false,
    extensions: [],
    submoduleCfg: [],
    userRemoteConfigs: [[ credentialsId: env.GIT_CREDENTIALS_ID, url: env.GIT_REPO_URL ]]
  ])
}

def prepareDockerWrapper(){
    def gradleCacheDir = "gradle_caches"
    echo ">> Creating docker wrapper"
    def dockerWrapper = "docker run -v \$(pwd)/${gradleCacheDir}:/root/.gradle/caches -v \$(pwd):/app ${env.DOCKER_NAME}:${env.DOCKER_TAG}"
    return dockerWrapper;
}

def installDependencies(dockerWrapper){
    echo ">> Install dependencies"
    sh "${dockerWrapper} bash -c 'npm i'"
}

def cordovaPrepareAndroid(dockerWrapper){
    echo ">> Prepare Android"
    sh "${dockerWrapper} bash -c 'cordova prepare android | xargs echo'"
}

def ionicBuild(dockerWrapper){
    echo ">> Cordova build android"
    sh "${dockerWrapper} bash -c 'ionic cordova build android'"
}

def timestampedNode(String label = "master", Closure body) {
  node(label) {
    def message = ""
    try {
        wrap([$class: 'AnsiColorBuildWrapper', 'colorMapName': 'XTerm']) {
          wrap([$class: 'TimestamperBuildWrapper']) {
              body.call();
          }
        }
    } catch (err) {
        wrap([$class: 'BuildUser']) {
            echo "CURRENT ERROR: ${err}"
            currentBuild.result = "FAILED"
        }
    } finally {
        wrap([$class: 'BuildUser']) {
            currentBuild.result = currentBuild.result ?: 'SUCCESS'
        }
    }
  }
}

def buildBaseImage(){
  sh "bash ./devops/build-dkr-img.sh"
}
}
