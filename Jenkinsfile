pipeline {
    agent any

    environment {
        KEY_FILE = credentials('projectkey')         
        DEPLOY_USER = 'ubuntu'
        AWS_HOST = '54.237.188.236'
        AZURE_HOST = 'http://52.170.136.209/'                   
        TARGET_PATH = '/var/www/html/index.html'
    }

    stages {
        stage('Verify AWS Connection') {
            steps {
                sh '''
                echo "Verifying SSH access to AWS..."
                ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" $DEPLOY_USER@$AWS_HOST echo 'AWS Connected'
                '''
            }
        }

        stage('Deploy to AWS') {
            steps {
                sh '''
                echo "Copying index.html to AWS..."
                scp -i "$KEY_FILE" index.html $DEPLOY_USER@$AWS_HOST:/tmp/index.html

                echo "Deploying to AWS web root..."
                ssh -i "$KEY_FILE" $DEPLOY_USER@$AWS_HOST "sudo mv /tmp/index.html $TARGET_PATH && sudo chown www-data:www-data $TARGET_PATH && sudo systemctl restart nginx"
                '''
            }
        }

        stage('Verify Azure Connection') {
            steps {
                sh '''
                echo "Verifying SSH access to Azure..."
                ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" $DEPLOY_USER@$AZURE_HOST echo 'Azure Connected'
                '''
            }
        }

        stage('Deploy to Azure') {
            steps {
                sh '''
                echo "Copying index.html to Azure..."
                scp -i "$KEY_FILE" index.html 'kartheek'@$AZURE_HOST:/tmp/index.html

                echo "Deploying to Azure web root..."
                ssh -i "$KEY_FILE" 'kartheek'@$AZURE_HOST "sudo mv /tmp/index.html $TARGET_PATH && sudo chown www-data:www-data $TARGET_PATH && sudo systemctl restart nginx"
                '''
            }
        }
    }

    post {
        failure {
            echo 'Deployment failed. Check the logs for more details.'
        }
        success {
            echo 'Multicloud Deployment succeeded on both AWS and Azure!'
        }
    }
}
