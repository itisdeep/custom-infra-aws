pipeline {
    stages {
        stage {
            steps {
                script {
                    withCredentials ([usernamePassword(credentialId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        println tfuser
                        println tfpass
                    }
                }
            }
        }
    }
}