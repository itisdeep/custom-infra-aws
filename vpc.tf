resource "aws_vpc" "this" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
        Name = "${var.app_name}-${var.env}-vpc"
    }
}