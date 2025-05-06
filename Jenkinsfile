pipeline {
    agent any

    environment {
        DOCKER_USER = credentials('docker-username') // Jenkins credentials ID for DockerHub username
        DOCKER_PASS = credentials('docker-password') // Jenkins credentials ID for DockerHub password
        IMAGE_NAME = "${DOCKER_USER}/indexapi"
        CONTAINER_NAME = "indexapi-container"
        PORT = "3001" // You can change this to any unused port
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME% ."
            }
        }

        stage('Docker Login and Push') {
            steps {
                bat "echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin"
                bat "docker push %IMAGE_NAME%"
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove existing container if it exists
                    bat "docker rm -f %CONTAINER_NAME% || echo No container to remove"
                    
                    // Run the new container on defined PORT
                    bat """
                        docker run -d -p %PORT%:80 --name %CONTAINER_NAME% %IMAGE_NAME%
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed."
        }
        failure {
            echo "Pipeline failed. Please check the logs above."
        }
    }
}
