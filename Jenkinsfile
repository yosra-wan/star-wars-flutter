pipeline {
    agent any
    environment {
        FLUTTER_HOME = "${WORKSPACE}/flutter"
        PATH = "$PATH:${FLUTTER_HOME}/bin"
    }

    stages {
        stage('GIT PULL') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'yosra']], userRemoteConfigs: [[url: 'https://github.com/yosra-wan/star-wars-flutter.git']]])
            }
        }

        stage('SETUP FLUTTER') {
            steps {
                script {
                    // Download Flutter SDK
                    sh "git clone https://github.com/flutter/flutter.git ${FLUTTER_HOME}"
                    
                    // Determine the path to the Flutter binary
                    def flutterPath = "${FLUTTER_HOME}/bin/flutter"
                    
                    // Ensure the Flutter binary is executable
                    sh "chmod +x ${flutterPath}"
                    
                    // Print the path for verification
                    echo "Flutter binary path: ${flutterPath}"
                }
            }
        }

        stage('FLUTTER VERSION') {
            steps {
                script {
                    // Verify Flutter version
                    sh "${FLUTTER_HOME}/bin/flutter --version"
                }
            }
        }

        stage('FLUTTER PACKAGES') {
            steps {
                script {
                    // Get Flutter packages
                    sh "${FLUTTER_HOME}/bin/flutter pub get"
                }
            }
        }

        stage('BUILD WEB') {
            steps {
                script {
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
                script {
                    sh "${FLUTTER_HOME}/bin/flutter build apk"
                }
            }
            post {
                success {
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }

        // Uncomment the following stage if you want to distribute the APK using App Center
        // stage('DISTRIBUTE') {
        //     steps {
        //         script {
        //             sh '''
        //             appCenter distribute \
        //                 --app "Yosr Ayadi/Poppin Road Cinema" \
        //                 --file build/app/outputs/flutter-apk/app-release.apk \
        //                 --groups "Cinema" \
        //                 --token "e006642d7a561fc195994cfd88529b418c07a6fa"
        //             '''
        //         }
        //     }
        // }
    }
}
