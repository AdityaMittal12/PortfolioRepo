pipeline {
    agent any

    stages {

        stage("Clone") {
            steps {
                echo "Cloning code from GitHub"
                git url: "https://github.com/AdityaMittal12/PortfolioRepo.git",
                    branch: "slave",
                    credentialsId: "github-creds-chai"
            }
        }

        stage("Build Image") {
            steps {
                echo "Building Docker image"
                sh "docker build -t portfolio-img ."
            }
        }

        stage("Push to Docker Hub") {
            steps {
                echo "Pushing image to Docker Hub"
                withCredentials([usernamePassword(credentialsId: 'dockerhubCred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "sudo docker login -u ${DOCKER_USER} -p ${DOCKER_PASS}"
                    sh "sudo docker tag portfolio-img adityam18/portfolio-img:latest"
                    sh "sudo docker push adityam18/portfolio-img:latest"
                }
            }
        }

        stage("Deploy to Kubernetes") {
            steps {
                echo "Deploying to Kubernetes"
                sh "kubectl apply -f k8s/"
                sh "kubectl rollout restart deployment portfolio-deployment"
            }
        }
    }
}