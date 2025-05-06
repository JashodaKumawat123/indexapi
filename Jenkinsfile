pipeline {
    agent any
    
    environment {
        // Define the credentials for DockerHub login
        DOCKER_USER = credentials('docker_username')  // docker_username is the credential ID
        DOCKER_PASS = credentials('docker-password')  // docker-password is the credential ID
        
        IMAGE_NAME = "your-dockerhub-username/indexapi" // Replace with your DockerHub username
        CONTAINER_NAME = "indexapi-container"
        PORT = "3000"  // Adjust port if needed
    }
    
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Docker Login and Push') {
            steps {
                script {
                    // Docker login using credentials stored in Jenkins
                    bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                    bat "docker push ${IMAGE_NAME}:latest"
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Stop and remove any existing container
                    bat "docker rm -f ${CONTAINER_NAME} || echo 'No container to remove'"
                    
                    // Run a new container
                    bat "docker run -d -p ${PORT}:80 --name ${CONTAINER_NAME} ${IMAGE_NAME}:latest"
                }
            }
        }
    }
    
    post {
        always {
            echo 'Pipeline completed.'
        }
        failure {
            echo 'Pipeline failed. Please check the logs above.'
        }
    }
}
