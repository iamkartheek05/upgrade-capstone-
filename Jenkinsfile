pipeline {
    agent any

    environment {
        DEPLOY_USER = 'ubuntu'
        DEPLOY_HOST = '44.204.156.107'
        TARGET_PATH = '/tmp/index.html'
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
                    echo "Verifying SSH connection to EC2..."
                    ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" $DEPLOY_USER@$DEPLOY_HOST "echo 'Connection OK'"

                    echo "Deploying file via SCP..."
                    scp -i "$KEY_FILE" index.html $DEPLOY_USER@$DEPLOY_HOST:$TARGET_PATH
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment succeeded!'
        }
        failure {
            echo '❌ Deployment failed. Check logs.'
        }
    }
}


