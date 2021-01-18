PROJECT_NAME = "sampleionic"
CLEAN = true                          // Do a clean build and sign
INFO_PLIST = "${PROJECT_NAME}/${PROJECT_NAME}-Info.plist"
VERSION = "1.0.0"
SHORT_VERSION = "1.0"
BUNDLE_ID = "org.feedhenry.dart.ionic"
OUTPUT_FILE_NAME="${PROJECT_NAME}-${BUILD_CONFIG}.ipa".replace(" ", "").toLowerCase()
SDK = "iphoneos"

if (BUILD_CONFIG.toLowerCase() == "debug") {
    OSX_BUILD_CONFIG = "Debug"
} else if(BUILD_CONFIG.toLowerCase() == "release" || BUILD_CONFIG.toLowerCase() == "distribution") {
    OSX_BUILD_CONFIG = "Release"
}

node(platform) {
    stage("Checkout") {
        checkout scm
    }

    stage("Prepare") {
        writeFile file: 'www/fhconfig.json', text: params.FH_CONFIG_CONTENT
        sh 'npm install --production'
        sh "cordova platform rm ${platform}"
        sh "cordova platform add ${platform}"
        sh "cordova prepare ${platform}"
        sh 'rm -rf node_modules'
    }

    stage("Build") {
        if (platform == 'android') {
            if (BUILD_CONFIG == 'debug') {
               sh "cordova build ${platform} --debug"
            } else {
               sh "cordova build ${platform} --release"
            }
        } else {
            xcodeBuild(
                cleanBeforeBuild: CLEAN,
                src: "./platforms/${platform}",
                schema: "${PROJECT_NAME}",
                workspace: "${PROJECT_NAME}",
                buildDir: "build",
                sdk: "${SDK}",
                version: "${VERSION}",
                shortVersion: "${SHORT_VERSION}",
                bundleId: "${BUNDLE_ID}",
                infoPlistPath: "${INFO_PLIST}",
                xcodeBuildArgs: 'ENABLE_BITCODE=NO OTHER_CFLAGS="-fstack-protector -fstack-protector-all"',
                autoSign: false,
                config: "${OSX_BUILD_CONFIG}"
            )
        }
    }

    stage("Sign") {
        if (platform == 'android') {
            if (BUILD_CONFIG == 'release') {
                signAndroidApks (
                    keyStoreId: "${params.BUILD_CREDENTIAL_ID}",
                    keyAlias: "${params.BUILD_CREDENTIAL_ALIAS}",
                    apksToSign: "platforms/android/**/*-unsigned.apk",
                    // uncomment the following line to output the signed APK to a separate directory as described above
                    // signedApkMapping: [ $class: UnsignedApkBuilderDirMapping ],
                    // uncomment the following line to output the signed APK as a sibling of the unsigned APK, as described above, or just omit signedApkMapping
                    // you can override these within the script if necessary
                    // androidHome: '/usr/local/Cellar/android-sdk'
                )
            } else {
                println('Debug Build - Using default developer signing key')
            }
        }
        if (platform == 'ios') {
            codeSign(
                profileId: "${CODE_SIGN_PROFILE_ID}",
                clean: CLEAN,
                verify: true,
                ipaName: OUTPUT_FILE_NAME,
                appPath: "platforms/${platform}/build/${OSX_BUILD_CONFIG}-${SDK}/${PROJECT_NAME}.app"
            )
        }
    }

    stage("Archive") {
        if (platform == 'android') {
            archiveArtifacts artifacts: "platforms/android/build/outputs/apk/android-${BUILD_CONFIG}.apk", excludes: 'platforms/android/build/outputs/apk/*-unaligned.apk'
        }
        if (platform == 'ios') {
            archiveArtifacts artifacts: "platforms/${platform}/build/${OSX_BUILD_CONFIG}-${SDK}/${OUTPUT_FILE_NAME}"
        }
    }
}
