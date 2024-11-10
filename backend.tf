terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "myrrhsolutions"

    workspaces {
      prefix = "myrrhsol-eks-"
    }
  }
}