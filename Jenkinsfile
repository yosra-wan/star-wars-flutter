pipeline {
    agent any
    environment {
        PATH = "$PATH:${WORKSPACE}/flutter/bin"
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
                    // Determine the path to the Flutter binary
                    def flutterPath = "${WORKSPACE}/flutter/bin/flutter"
                    
                    // Ensure the Flutter binary is executable
                    sh "chmod +x ${flutterPath}"
                    
                    // Print the path for verification
                    echo "Flutter binary path: ${flutterPath}"
                }
            }
        }

        stage('BUILD WEB') {
            steps {
                script {
                    // Run flutter build web
                    sh "${WORKSPACE}/flutter/bin/flutter build web"
                }
            }
            post {
                success {
                    // Archive the web build artifacts
                    archiveArtifacts artifacts: 'build/web/**', allowEmptyArchive: true
                }
            }
        }

        stage('BUILD APK') {
            steps {
                script {
                    // Build the APK
                    sh "${WORKSPACE}/flutter/bin/flutter build apk"
                }
            }
            post {
                success {
                    // Archive the APK build artifacts
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }

        // Uncomment the following stage if you want to distribute the APK using App Center
        // stage('DISTRIBUTE') {
        //     steps {
        //         script {
        //             // Distribute the APK file using App Center
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
