pipeline {
    agent {label 'portfolio'}

    stages {
        stage("clone") {
            steps {
                echo "code is cloning from Github!"
                git (
                    url : "https://github.com/AdityaMittal12/PortfolioRepo.git" , 
                    branch:"slave",
                    credentialsId: "github-creds-chai"
                    )
                echo "code cloned successfully!"
            }
        }
        stage ("Build & Deploy") {
            steps {
                echo "Building and Deploying the portfolio site"
                sh "sudo docker rm -f portfolio-cont || true"
                sh "sudo docker compose down"
                sh "sudo docker compose up --build -d" 
                sh "sudo docker image prune -f"
                echo "portfolio site deployed"
            }
        }
        stage ("Push to Docker Hub"){
            steps { 
                echo "Pushing image to Docker Hub"
                withCredentials([usernamePassword(credentialsId: 'dockerhubCred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]){
                sh "sudo docker login -u ${env.DOCKER_USER} -p ${env.DOCKER_PASS}" 
                sh "sudo docker image tag portfolio-img:latest adityam18/portfolio-img:latest"
                sh "sudo docker push adityam18/portfolio-img:latest"
                }
            }
        }
    }
}
