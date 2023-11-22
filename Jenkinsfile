pipeline {
    agent any

    environment {
        FLUTTER_CHANNEL = 'stable'
        FLUTTER_VERSION = '2.0.1'  // Update with your desired Flutter version
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Check out the code from your Git repository
                    git 'https://github.com/yosra-wan/star-wars-flutter.git'
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Flutter and Dart dependencies
                    sh "git clone -b ${FLUTTER_CHANNEL} https://github.com/flutter/flutter.git"
                    sh "./flutter/bin/flutter --version"
                    sh "./flutter/bin/flutter pub get"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run your Flutter tests
                    sh "./flutter/bin/flutter test"
                }
            }
        }

        stage('Build APK') {
            steps {
                script {
                    // Build your Flutter APK
                    sh "./flutter/bin/flutter build apk"
                }
            }
        }

        stage('Publish APK') {
            steps {
                script {
                    // Publish the APK to your desired location (e.g., Google Play, Firebase App Distribution)
                    // You may use additional plugins or scripts for this step
                }
            }
        }
    }

 
}
