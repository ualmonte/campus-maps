pipeline {
    agent any
    environment {
        DOCKERHUB_USER = 'ulisesalmonte'
        IMAGE_NAME = 'ulisesalmonte/campus-maps'
        IMAGE_TAG = 'v1'
    }
    stages {
        stage('Checkout'){
            steps{
                git branch : 'main', url : 'https://github.com/ualmonte/campus-maps.git'
            }
        }
        
        stage('Build Docker Image'){
            steps {
                script {
                    dockerImage = docker.build("${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        
        stage('Push to DockerHub'){
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/','dockerhub-creds'){
                        def image = docker.build("ulisesalmonte/campus-maps:v1")
                        image.push()
                    }
                }
            }
        }
        
    stage('Deploy to Kubernetes') {
        steps {
            withCredentials([file(credentialsId: 'kubernetesconfig-id', variable: 'KUBECONFIG')]) {
            sh '''
                sed -i 's|IMAGE_TAG|ulisesalmonte/campus-maps:v1|' campus-maps-deployment.yaml
                kubectl apply -f campus-maps-deployment.yaml
                kubectl apply -f campus-maps-service.yaml
            '''
            }
        }
    }


        
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}

