variable "region" {
    description = "enter aws region"
}

variable "app_name" {
    description = "application name"
}

variable "env" {
    description = "environment name. e.g. dev, stg, prod"
}

variable "az_number" {
    default = {
        "0" = "a"
        "1" = "b"
        "2" = "c"
        "3" = "d"
        "4" = "e"
        "5" = "f"
    }
}

variable "vpc_cidr" {
    description = "Please enter the required cidr block for VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_count" {
    description = "Please enter the desired number of public subnets. Within the available number in the region."
}

variable "private_subnet_count" {
    description = "Please enter the desired number of private subnets. Within the available number in the region."
}

variable "secret_key" {
    description = "Please enter secret Key"
    type = string
}

variable "access_key" {
    description = "Please enter access Key"
    type = string
}