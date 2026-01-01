terraform {     
  backend "remote" {
    organization = "myrrhsolutions" 

    workspaces { 
      name = "aws-infra-kp-proj1-poc" 
    } 
  }
}