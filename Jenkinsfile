pipeline {
    agent any
    environment {
        // Define your Docker Hub credentials and image name here
        DOCKER_IMAGE = 'aamdsam/wordpress-aam:latest' // Image name
        KUBE_CONTEXT = 'your-kube-context'  // Kube context if you have multiple clusters
        KUBERNETES_NAMESPACE = 'default'  // Replace with your namespace
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/aamdsam/wp-aam.git'
            }
        }
        // stage('Build Docker Image') {
        //     steps {
        //         script {
        //             // Build Docker image
        //             sh '''
        //                 docker build -t $DOCKER_IMAGE .
        //             '''
        //         }
        //     }
        // }
        // stage('Docker Push') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'dockerhub_aam', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        //         sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
        //         sh 'docker push $DOCKER_IMAGE'
        //         }
        //     }
        // }
        stage('Deploy again to Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes using kubectl
                    sh '''
                        kubectl delete -f k8s/wp-deployment.yaml -n $KUBERNETES_NAMESPACE
                        kubectl delete -f k8s/mysql-deployment.yaml -n $KUBERNETES_NAMESPACE
                        
                        kubectl apply -f k8s/wp-deployment.yaml -n $KUBERNETES_NAMESPACE
                        kubectl apply -f k8s/mysql-deployment.yaml -n $KUBERNETES_NAMESPACE
                        kubectl apply -f k8s/secret.yaml -n $KUBERNETES_NAMESPACE
                        kubectl apply -f k8s/pvc.yaml -n $KUBERNETES_NAMESPACE
                        kubectl apply -f k8s/service.yaml -n $KUBERNETES_NAMESPACE
                        kubectl apply -f k8s/ingress.yaml -n $KUBERNETES_NAMESPACE
                    '''
                }
            }
        }
        stage('rollout restart  Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes using kubectl
                    sh '''
                        kubectl rollout restart deployment/aam-wp-deployment -n $KUBERNETES_NAMESPACE
                        kubectl rollout restart deployment/aam-mysql-deployment -n $KUBERNETES_NAMESPACE
                    '''
                }
            }
        }
    }
    post {
        always {
            // sh 'docker rmi $DOCKER_IMAGE'
            echo "All done!"
        }
    }
}
