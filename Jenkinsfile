stage('Deploy to AWS') {
    steps {
        withCredentials([file(credentialsId: 'projectkey', variable: 'KEY_FILE')]) {
            sh '''
            echo "Verifying connection to EC2 host..."
            ssh -o StrictHostKeyChecking=accept-new -i "$KEY_FILE" ubuntu@44.204.156.107 "echo 'Connection successful!'"

            echo "Transferring index.html via SCP..."
            scp -i "$KEY_FILE" index.html ubuntu@44.204.156.107:/tmp/index.html
            '''
        }
    }
}

