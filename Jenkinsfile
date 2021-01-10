pipeline {
   agent any
      environment {
         PATH='/usr/local/bin:/usr/bin:/bin'
      }
   stages {
      stage('NPM Setup') {
      steps {
         sh 'npm install'
      }
   }


   stage('Android Build') {
   steps {
      sh 'ionic cordova build android --release'
   }
  }

     stage('APK Sign') {
   steps {
      sh 'jarsigner -storepass test@123 -keystore keys/helloWorld.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk alias_name'
   }
   }
      stage('Android RUN') {
   steps {
      sh 'ionic cordova run android --release'
   }
  }


   stage('Stage Web Build') {
      steps {
        sh 'npm run build --prod'
    }
  }

stage( 'Stage Fastlane test') {
    steps { 
        sh "pwd"
        dir ('platforms/android') {
            sh "pwd"
            sh "fastlane test"
        }
        sh "pwd"
        
    }
}
   
   stage('Publish Android Fastlane') {
     steps {
    echo "Publish Android API Action"
    sh "pwd"
        dir ('platforms/android') {
            sh "fastlane deploy"
   }
  }

 }
}
}