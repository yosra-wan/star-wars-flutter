pipeline {
    agent any
    environment {
        FLUTTER_HOME = "${WORKSPACE}/flutter"
        ANDROID_HOME = "/home/ubuntu/android-sdk" // Set this to the correct path
        PATH = "$PATH:${FLUTTER_HOME}/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"
    }

    stages {
        stage('GIT PULL') {
            steps {
                catchError {
                    checkout([$class: 'GitSCM', branches: [[name: 'yosra']], userRemoteConfigs: [[url: 'https://github.com/yosra-wan/star-wars-flutter.git']]])
                }
            }
        }

        stage('SETUP FLUTTER') {
            steps {
                catchError {
                    // Download Flutter SDK
                    sh "git clone https://github.com/flutter/flutter.git -b stable ${FLUTTER_HOME}"
                    
                    // Set ANDROID_HOME for the current session
                    sh "export ANDROID_HOME=${ANDROID_HOME}"
                    
                    // Ensure the Flutter binary is executable
                    sh "chmod +x ${FLUTTER_HOME}/bin/flutter"
                    
                    // Upgrade Flutter to the latest stable version
                    sh "${FLUTTER_HOME}/bin/flutter upgrade"
                    
                    // Verify Flutter version
                    sh "${FLUTTER_HOME}/bin/flutter --version"
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

        stage('BUILD APK') {
            steps {
                catchError {
                    // Build the APK
                    sh "${FLUTTER_HOME}/bin/flutter build apk"
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
