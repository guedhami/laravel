pipeline {

  environment {
    registry = "1http://137.117.170.206:8080/aks/jenkins-agent-pod"
    dockerImage = ""
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git 'github.com/guedhami/laravel.git'
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage('Push Image') {
      steps{
        script {
          docker.withRegistry( "" ) {
            dockerImage.push()
          }
        }
      }
    }

    stage('Deploy App') {
      steps {
        script {
          kubernetesDeploy(configs: "aks/jenkins-agent-pod.yaml", kubeconfigId: "mykubeconfig")
        }
      }
    }

  }

}