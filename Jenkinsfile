pipeline {
    agent {label 'portfolio'}

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
                 sh '''
                export KUBECONFIG=/home/ec2-user/.kube/config

                # Ensure Minikube is running
                minikube status || minikube start --driver=docker

                # Set correct context
                kubectl config use-context minikube

                # Apply manifests
                kubectl apply -f k8s/
                kubectl rollout restart deployment portfolio-deployment
                '''
                }
            }
    }
}