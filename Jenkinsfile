// pipeline {
//     agent any

//     environment {
//         DOCKER_USERNAME = credentials('docker_username')  // Jenkins credentials ID for Docker username
//         DOCKER_PASSWORD = credentials('docker-password')  // Jenkins credentials ID for Docker password
//     }

//     stages {
//         stage('Checkout') {
//             steps {
//                 // Checkout the repository to get the latest code
//                 checkout scm
//             }
//         }

//         stage('Docker Login') {
//             steps {
//                 // Login to Docker using the credentials
//                 bat """
//                     echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
//                 """
//             }
//         }

//         stage('Build Docker Image') {
//             steps {
//                 // Build the Docker image with the repository name and tag
//                 bat """
//                     docker build -t %DOCKER_USERNAME%/indexapi:latest .
//                 """
//             }
//         }

//         stage('Push Docker Image') {
//             steps {
//                 // Push the built Docker image to DockerHub
//                 bat """
//                     docker push %DOCKER_USERNAME%/indexapi:latest
//                 """
//             }
//         }
//     }

//     post {
//         always {
//             // Print a message once the pipeline is completed
//             echo 'Pipeline completed.'
//         }
//     }
// }

pipeline {
    agent any

    environment {
        DOCKER_USERNAME = credentials('docker_username')  // Jenkins credentials ID for Docker username
        DOCKER_PASSWORD = credentials('docker-password')  // Jenkins credentials ID for Docker password
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository to get the latest code
                checkout scm
            }
        }

        stage('Docker Login') {
            steps {
                // Login to Docker using the credentials
                bat """
                    echo %DOCKER_PASSWORD% | docker login -u %DOCKER_USERNAME% --password-stdin
                """
            }
        }

        stage('Build Docker Image with Docker Compose') {
            steps {
                // Build the Docker image using Docker Compose
                bat """
                    docker-compose -f docker-compose.yml build
                """
            }
        }

        stage('Push Docker Image with Docker Compose') {
            steps {
                // Push the image using Docker Compose
                bat """
                    docker-compose -f docker-compose.yml push
                """
            }
        }
    }

    post {
        always {
            // Print a message once the pipeline is completed
            echo 'Pipeline completed.'
        }
    }
}

