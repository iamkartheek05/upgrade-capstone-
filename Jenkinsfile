pipeline {
  agent any

  stages {
    stage('Pull HTML Files') {
      steps {
        git url: 'https://github.com/iamkartheek05/upgrade-capstone-.git', branch: 'main'
      }
    }

    stage('Deploy to AWS') {
      steps {
        sh '''
        scp -i ~/.ssh/project_key.pem index-aws.html ubuntu@44.204.156.107:/tmp/index.html
        ssh -i ~/.ssh/project_key.pem ubuntu@44.204.156.107 "sudo mv /tmp/index.html /var/www/html/index.html && sudo systemctl restart nginx"
        '''
      }
    }

    stage('Deploy to Azure') {
      steps {
        sh '''
        scp -i ~/.ssh/project_key.pem index-azure.html kartheek@172.190.71.26:/tmp/index.html
        ssh -i ~/.ssh/project_key.pem kartheek@172.190.71.26 "sudo mv /tmp/index.html /var/www/html/index.html && sudo systemctl restart nginx"
        '''
      }
    }
  }
}
