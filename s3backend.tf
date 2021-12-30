terraform {
  backend "s3" {
    bucket = "s3-backend-myapp"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform_state"
  }
}