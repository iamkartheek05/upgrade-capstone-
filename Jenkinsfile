pipeline {
    agent any

    environment {
        DEPLOY_USER = 'ubuntu'
        DEPLOY_HOST = '44.204.156.107'
        TARGET_PATH = '/var/www/html/index.html'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Deploy to AWS') {
            steps {
                withCredentials([file(credentialsId: 'projectkey', variable: 'KEY_FILE')]) {
                    sh '''
                    echo "Verifying SSH access..."
                    ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" $DEPLOY_USER@$DEPLOY_HOST "echo 'EC2 accessible'"

                    echo "Copying index.html to EC2..."
                    scp -i "$KEY_FILE" index.html $DEPLOY_USER@$DEPLOY_HOST:/tmp/index.html

                    echo "Moving index.html to web server root..."
                    ssh -i "$KEY_FILE" $DEPLOY_USER@$DEPLOY_HOST << EOF
                      sudo mv /tmp/index.html $TARGET_PATH
                      sudo chown www-data:www-data $TARGET_PATH
                      sudo systemctl restart nginx
                    EOF

                    echo "🌐 Deployment complete. Check site at http://$DEPLOY_HOST"
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment succeeded!'
        }
        failure {
            echo 'Deployment failed. Review pipeline logs.'
        }
    }
}
