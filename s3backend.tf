terraform {
  backend "s3" {
    bucket = "s3-backend-myapp-dev"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "dev-terraform_state"
  }
}