pipeline {
    agent any

    environment {
        DOCKER_USER = credentials('docker_username') // Docker Hub username credential ID
        DOCKER_PASS = credentials('docker-password') // Docker Hub password credential ID
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/JashodaKumawat123/indexapi.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_USER%/indexapi:latest ."
            }
        }

        stage('Docker Login and Push') {
            steps {
                bat """
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    docker push %DOCKER_USER%/indexapi:latest
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat """
                    docker rm -f indexapi-container || echo "No container to remove"
                    docker run -d -p 3000:80 --name indexapi-container %DOCKER_USER%/indexapi:latest
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline completed.'
        }
    }
}
