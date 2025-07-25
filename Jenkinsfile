pipeline {
    agent any

    environment {
        DEPLOY_USER = 'ubuntu'
        DEPLOY_HOST = '44.204.156.107'
        TARGET_PATH = '/tmp/index.html'
        DEPLOY_KEY = credentials('projectkey')
    }

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }

        stage('Deploy to AWS') {
            steps {
                withEnv(["DEPLOY_KEY=${DEPLOY_KEY}"]) {
                    sh '''
                    echo "Verifying connection to EC2 host..."
                    ssh -i "$DEPLOY_KEY" $DEPLOY_USER@$DEPLOY_HOST "echo 'Connection successful!'"

                    echo "Deploying index.html via secure SCP..."
                    scp -i "$DEPLOY_KEY" index.html $DEPLOY_USER@$DEPLOY_HOST:$TARGET_PATH
                    '''
                }
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully!'
        }
        failure {
            echo '❌ Deployment failed. Check logs for errors.'
        }
    }
}

