pipeline {
    agent any

    environment {
        DOCKER_USER = credentials('docker_username') // Jenkins credentials ID
        DOCKER_PASS = credentials('docker-password') // Jenkins credentials ID
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/JashodaKumawat123/indexapp.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_USER%/indexapp:latest .'
            }
        }

        stage('Docker Login and Push') {
            steps {
                bat """
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    docker push %DOCKER_USER%/indexapp:latest
                """
            }
        }

        stage('Run Docker Container') {
            steps {
                bat """
                    docker rm -f indexapp-container || echo "No container to remove"
                    docker run -d -p 3000:80 --name indexapp-container %DOCKER_USER%/indexapp:latest
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
