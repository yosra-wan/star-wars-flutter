pipeline {
    agent any
    environment {
        FLUTTER_HOME = "${WORKSPACE}/flutter"
        PATH = "$PATH:${FLUTTER_HOME}/bin"
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
                    
                    // Ensure the Flutter binary is executable
                    sh "chmod +x ${FLUTTER_HOME}/bin/flutter"
                    
                    // Upgrade Flutter to the latest stable version
                    sh "${FLUTTER_HOME}/bin/flutter upgrade"
                    
                    // Print the path for verification
                    echo "Flutter binary path: ${FLUTTER_HOME}/bin/flutter"
                }
            }
        }

        stage('FLUTTER VERSION') {
            steps {
                catchError {
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

        stage('BUILD WEB') {
            steps {
                catchError {
                    sh "${FLUTTER_HOME}/bin/flutter build web"
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
                catchError {
                    sh "${FLUTTER_HOME}/bin/flutter build apk"
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }
    }
}
