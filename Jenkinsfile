pipeline {
    agent any

    stages {
      

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
           

            // Unzip the Gradle wrapper (if needed)
            powershell 'Expand-Archive -Path gradle-wrapper.zip -DestinationPath android/gradle/wrapper/ -Force'

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




        stage('DISTRIBUTE') {
            steps {
                script {
                    // Distribute the APK file using App Center
                    appCenter apiToken: 'e006642d7a561fc195994cfd88529b418c07a6fa',
                              ownerName: 'Yosr Ayadi',
                              appName: 'Poppin Road Cinema',
                              pathToApp: 'build/app/outputs/flutter-apk/app-release.apk',
                              distributionGroups: 'Cinema'
                }
            }
        }
    }
}
