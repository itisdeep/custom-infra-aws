def isBackendPlan
def isMainPlan

pipeline {
    agent {label 'windows-local'}

    parameters {
        choice(name: 'environment', choices: ['dev','stage','prod'], description: 'which environment to deploy to?')
        booleanParam(name: 'initBackend', defaultValue: '', description: 'initialization required for backend infra?')
        booleanParam(name: 'initMain', defaultValue: '', description: 'initialization required for main infra?')
        booleanParam(name: 'runDestroy', defaultValue: '', description: 'Destroy main and backend infra?')
    }

    stages {
        stage ('Init backend and plan'){
            when { 
                allOf {
                    expression {params.initBackend == true}
                    expression {params.runDestroy == false}
                }
            }
            steps {
                script {
                    dir (params.environment) {
                        bat 'terraform init'
                        bat "terraform plan --var-file=${params.environment}.tfvars"
                        isBackendPlan = 'SUCCESS'
                    }
                }
            }
        }

        stage ('Init main and plan'){
            when { 
                allOf {
                    expression {params.initMain == true}
                    expression {params.runDestroy == false}
                }
            }
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        bat "terraform init -backend-config=access_key=${tfuser} -backend-config=secret_key=${tfpass}"
                        bat "terraform plan --var-file=${params.environment}\\${params.environment}.tfvars"
                        isMainPlan = 'SUCCESS'
                    }
                }
            }
        }

        stage ('Apply') {
            steps {
                script {
                    dir (params.environment) {
                        if (isMainPlan == 'SUCCESS') {
                            bat "terraform apply --var-file=${params.environment}.tfvars -auto-approve"
                        }
                    }
                    if (isBackendPlan == 'SUCCESS') {
                        bat "terraform apply --var-file=${params.environment}\\${params.environment}.tfvars -auto-approve"
                    }
                }
            }
        }


    } //stages closure
}// pipeline closure