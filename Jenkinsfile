// Jenkinsfile
pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://your-repository-url.git'  // Replace with your Git repo URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-html-app")
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    docker.image("my-html-app").run("-d -p 8080:80")
                }
            }
        }
    }
}
