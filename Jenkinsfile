pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        script {
          sh "docker build -t mouner0x/webapp:v${build_number} ."
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
            sh "echo $PASS | docker login -u $USER --password-stdin"
            sh "docker push mouner0x/webapp:v${build_number}"

            sh "kubectl apply -f Deployment.yml"
            sh "kubectl apply -f svc.yml"

            sh "kubectl set image deployment/deploy-app webapp=mouner0x/webapp:v${build_number}"
            sh "kubectl rollout status deployment/deploy-app"
          }
        }
      }
    }
  }
}
