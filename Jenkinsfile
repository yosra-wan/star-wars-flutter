pipeline {
    agent any
 environment {
      PATH = "$PATH:/tmp/workspace/flutter/bin"
    }    
    stages {
        stage('Setup') {
            steps {
                print "${env.PATH}"
            }    
        }
        stage('GIT PULL') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: 'yosra']], userRemoteConfigs: [[url: 'https://github.com/yosra-wan/star-wars-flutter.git']]])
            }
        }

        stage('BUILD WEB') {
            steps {
                script {
                    // Run flutter build web
                    sh 'flutter build web'
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
                    sh 'flutter build apk'
                }
            }
            post {
                success {
                    // Archive the APK build artifacts
                    archiveArtifacts artifacts: 'build/app/outputs/flutter-apk/app-release.apk', allowEmptyArchive: true
                }
            }
        }

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
