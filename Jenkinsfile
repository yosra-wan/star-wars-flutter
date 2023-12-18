pipeline {
    agent any
    
    environment {
        PATH = "$PATH:${WORKSPACE}/flutter/bin"
        FLUTTER_PATH = "${WORKSPACE}/flutter/bin/flutter"
        ANDROID_HOME = "/home/ubuntu/android-sdk" // Set this to the correct path
        GRADLEW_PATH = "${WORKSPACE}/flutter/bin/flutter"
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
                    
                    // Change to the Flutter project directory
                    dir("${WORKSPACE}/flutter") {
                        // Run the Flutter Gradle Wrapper build
                        sh "${FLUTTER_PATH} build apk"
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
