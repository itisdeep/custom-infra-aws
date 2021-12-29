def isplan

pipeline {
    agent {label 'windows-local'}

    parameters {
        choice(name: 'environment', choices: ['dev','stage','prod'], description: 'which environment to deploy to?')
        booleanParam(name: 'init_backend', defaultValue: false, description: 'initialization required for backend infra?')
        booleanParam(name: 'init_main', defaultValue: false, description: 'initialization required for main infra?')
        booleanParam(name: 'destroy', defaultValue, false, description: 'Destroy main and backend infra?')
    }

    stages {
        stage ('Init backend'){
            when { 
                allOf {
                    expression {params.init_backend == true}
                    expression {params.destroy == false}
                }
            }
            steps {
                script {
                    dir (params.environment) {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage ('Init main'){
            when { 
                allOf {
                    expression {params.init_main == true}
                    expression {params.destroy == false}
                }
            }
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        sh "terraform init -backend-config=access_key=${tfuser} -backend-config=secret_key=${tfpass}"
                    }
                }
            }
        }

        stage ('plan') {
            steps {
                script {
                    sh "terraform plan --var-file=${params.environment}/${params.environment}.tfvars"
                    dir (params.environment) {
                        sh "terraform plan --var-file=${params.environment}.tfvars"
                    }
                }
            }
        }


    } //stages closure
}// pipeline closure