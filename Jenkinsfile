pipeline {
    agent {label 'windows-local'}

    parameters {
        choice(name: 'environment', choices: ['dev','stage','prod'], description: 'which environment to deploy to?')
        booleanParam(name: 'initBackend', defaultValue: '', description: 'initialization required for backend infra?')
        booleanParam(name: 'initMain', defaultValue: '', description: 'initialization required for main infra?')
        booleanParam(name: 'runDestroy', defaultValue: '', description: 'Destroy main and backend infra?')
        booleanParam(name: 'applyBackedinfra', defaultValue: '', description: 'Destroy main and backend infra?')
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
                        bat "terraform init -backend-config=access_key=${tfuser} -backend-config=secret_key=${tfpass}"
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
                        bat "$Env:TF_VAR_access_key = \"${tfuser}\"; $Env:TF_VAR_secret_key = \"${tfpass}\""
                        dir (params.environment) {
                            bat "terraform plan --var-file=${params.environment}.tfvars"
                            bat "terraform apply --var-file=${params.environment}.tfvars -auto-approve"
                        }
                    }
                }
            }
        }

        stage ('Plan and apply main infra') {
            when { expression {params.runDestroy == false}}
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        bat "$Env:TF_VAR_access_key = \"${tfuser}\"; $Env:TF_VAR_secret_key = \"${tfpass}\""
                        bat "terraform plan --var-file=${params.environment}\\${params.environment}.tfvars"
                        bat "terraform apply --var-file=${params.environment}\\${params.environment}.tfvars -auto-approve"
                    }
                }
            }
        }

        stage ('Destroy all') {
            when { expression {params.runDestroy == true}}
            steps {
                script {
                    withCredentials ([usernamePassword(credentialsId: 'tfadminuser', usernameVariable: 'tfuser', passwordVariable: 'tfpass')]) {
                        dir (params.environment) {
                            bat "terraform destroy --var-file=${params.environment}.tfvars -auto-approve"
                        }
                        bat "terraform destroy --var-file=${params.environment}\\${params.environment}.tfvars -auto-approve"
                    }                    
                }
            }
        }


    } //stages closure
}// pipeline closure