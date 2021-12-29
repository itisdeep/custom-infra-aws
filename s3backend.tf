terraform {
  backend "s3" {}
}

data "terraform_remote_state" "dev-state" {
  backend = "s3"
  config {
    bucket         = "s3-backend-${var.app_name}-${var.env}"
    key            = "terraform.tfstate"
    region         = "${var.region}"
    dynamodb_table = "${var.env}-terraform_state"
  }
}