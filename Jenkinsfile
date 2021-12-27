pipeline {
    agent {label 'windows-local'}
    stages {
        stage ('check'){
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