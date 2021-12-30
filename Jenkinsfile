pipeline {
    agent {label 'windows-local'}

    parameters {
        choice(name: 'environment', choices: ['dev','stage','prod'], description: 'which environment to deploy to?')
        booleanParam(name: 'initBackend', defaultValue: '', description: 'initialization required for backend infra?')
        booleanParam(name: 'initMain', defaultValue: '', description: 'initialization required for main infra?')
        booleanParam(name: 'runDestroy', defaultValue: '', description: 'Destroy main and backend infra?')
        booleanParam(name: 'applyBackendinfra', defaultValue: '', description: 'Destroy main infra?')
        booleanParam(name: 'destroy_backend', defaultValue: '', description: 'Destroy backend infra?')
        booleanParam(name: 'createWS', defaultValue: '', description: 'Create new workspace?')
    }

    stages {
        stage ('Init backend'){
            when { 
                allOf {
                    expression {params.initBackend == true}
                    expression {params.runDestroy == false}
                }
            }
            steps {
                script {
                    dir ('backend') {
                        bat 'terraform init -reconfigure'
                    }
                }
            }
        }

        stage ('Plan and Apply backend') {
            when { allOf { 
                expression {params.runDestroy == false}
                expression {params.applyBackendinfra == true}
            }}
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        dir ('backend') {
                            bat "terraform plan -var access_key=${tfuser} -var secret_key=${tfpass} --var-file=backend.tfvars"
                            bat "terraform apply -var access_key=${tfuser} -var secret_key=${tfpass} --var-file=backend.tfvars -auto-approve"
                        }
                    }
                }
            }
        }


        stage ('Create workspaces') {
            when { expression {params.runDestroy == false}}
            steps {
                script {
                    if (params.createWS == true) {
                        bat "terraform workspace new ${params.environment}"
                        bat "terraform workspace list"
                    } else {
                        bat "terraform workspace select ${env}"
                    }
                }
            }
        }

        stage ('Init main'){
            when { 
                allOf {
                    expression {params.initMain == true}
                    expression {params.runDestroy == false}
                }
            }
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        bat "terraform workspace new ${params.environment}"
                        bat "terraform init -backend-config=access_key=${tfuser} -backend-config=secret_key=${tfpass} -reconfigure"
                    }
                }
            }
        }

        stage ('Plan and apply main infra') {
            when { allOf {
                expression {params.runDestroy == false}
                expression {params.destroy_backend == false}
                }
            }
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        bat "terraform plan -var access_key=${tfuser} -var secret_key=${tfpass} --var-file=${params.environment}.tfvars"
                        bat "terraform apply -var access_key=${tfuser} -var secret_key=${tfpass} --var-file=${params.environment}.tfvars -auto-approve"
                    }
                }
            }
        }

        stage ('Destroy all') {
            when { expression {params.runDestroy == true}}
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        bat "terraform destroy -var access_key=${tfuser} -var secret_key=${tfpass} --var-file=${params.environment}\\${params.environment}.tfvars -auto-approve"
                        if (params.destroy_backend == true) {
                            dir (params.environment) {
                                bat "terraform destroy -var access_key=${tfuser} -var secret_key=${tfpass} --var-file=${params.environment}.tfvars -auto-approve"
                            }
                        }
                    }                    
                }
            }
        }


    } //stages closure
}// pipeline closure