pipeline {
    agent any
    
    environment {
        PATH = "$PATH:${WORKSPACE}/flutter/bin"
        FLUTTER_PATH = "${WORKSPACE}/flutter/bin/flutter"
        ANDROID_HOME = "/home/ubuntu/android-sdk"
        GRADLEW_PATH = "${WORKSPACE}/flutter/android/gradlew"
    }    
    
    stages {
        stage('GIT PULL') {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: 'yosra']], userRemoteConfigs: [[url: 'https://github.com/yosra-wan/star-wars-flutter.git']]])
                }
            }
        }

        stage('SETUP FLUTTER') {
            steps {
                script {
                    sh "chmod +x ${FLUTTER_PATH}"
                    echo "Flutter binary path: ${FLUTTER_PATH}"
                }
            }
        }

               stage('FLUTTER PACKAGES') {
            steps {
                catchError {
                    // Clean before fetching packages
                    sh "${FLUTTER_HOME}/bin/flutter clean"
                    
                    // Get Flutter packages
                    sh "${FLUTTER_HOME}/bin/flutter pub get"
                }
            }
        }

        stage('VERIFY ANDROID SDK') {
            steps {
                catchError {
                    // Verify the Android SDK components
                    sh "${ANDROID_HOME}/tools/bin/sdkmanager --list"
                }
            }
        }

        stage('BUILD WEB') {
            steps {
                script {
                    sh "${FLUTTER_PATH} build web"
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/web/**', allowEmptyArchive: true
                }
            }
        }

        stage('BUILD APK') {
            steps {
                script {
                    // Set ANDROID_HOME for the current session
                    sh "export ANDROID_HOME=${ANDROID_HOME}"
                    
                    // Ensure the Flutter binary is executable
                    sh "chmod +x ${FLUTTER_PATH}"
                    
                    // Change to the Android project directory
                    dir("${WORKSPACE}/flutter/android") {
                        // Run the Gradle Wrapper build
                        sh "./gradlew build"
                    }
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }

        // ... (other stages)
    }
}
