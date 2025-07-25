pipeline {
  agent any

  environment {
    KEY_ID = credentials('projectkey')
  }

  stages {
    stage('Deploy to AWS') {
      steps {
        sh '''
        chmod 400 "$KEY_ID"

        scp -i "$KEY_ID" index-aws.html ubuntu@44.204.156.107:/tmp/index.html
        ssh -i "$KEY_ID" ubuntu@44.204.156.107 'sudo mv /tmp/index.html /var/www/html/index.html && sudo systemctl restart nginx'
        '''
      }
    }
  }
}
