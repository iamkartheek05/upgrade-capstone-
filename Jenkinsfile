pipeline {
    agent any

    environment {
        DEPLOY_KEY_ID = 'projectkey'
        AWS_USER = 'ubuntu'
        AWS_HOST = '44.204.156.107'
        AZURE_USER = 'kartheek'
        AZURE_HOST = '172.190.71.26'
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
                withCredentials([file(credentialsId: DEPLOY_KEY_ID, variable: 'KEY_FILE')]) {
                    sh '''
                    echo "Verifying SSH access to AWS..."
                    ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" $AWS_USER@$AWS_HOST "echo 'AWS Connected'"

                    echo "Copying index.html to AWS..."
                    scp -i "$KEY_FILE" index.html $AWS_USER@$AWS_HOST:/tmp/index.html

                    echo "Moving file to web root and restarting Nginx on AWS..."
                    ssh -i "$KEY_FILE" $AWS_USER@$AWS_HOST << EOF
                      sudo mv /tmp/index.html $TARGET_PATH
                      sudo chown www-data:www-data $TARGET_PATH
                      sudo systemctl restart nginx
                    EOF
                    '''
                }
            }
        }

        stage('Deploy to Azure') {
            steps {
                withCredentials([file(credentialsId: DEPLOY_KEY_ID, variable: 'KEY_FILE')]) {
                    sh '''
                    echo "Verifying SSH access to Azure..."
                    ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" $AZURE_USER@$AZURE_HOST "echo 'Azure Connected'"

                    echo "Copying index.html to Azure..."
                    scp -i "$KEY_FILE" index.html $AZURE_USER@$AZURE_HOST:/tmp/index.html

                    echo "Moving file to web root and restarting Nginx on Azure..."
                    ssh -i "$KEY_FILE" $AZURE_USER@$AZURE_HOST << EOF
                      sudo mv /tmp/index.html $TARGET_PATH
                      sudo chown www-data:www-data $TARGET_PATH
                      sudo systemctl restart nginx
                    EOF
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment to AWS and Azure completed successfully!'
        }
        failure {
            echo 'Deployment failed. Check the logs for more details.'
        }
    }
}
