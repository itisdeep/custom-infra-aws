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
}

variable "public_subnet_count" {
    description = "Please enter the desired number of public subnets. Within the available number in the region."
}

variable "private_subnet_count" {
    description = "Please enter the desired number of private subnets. Within the available number in the region."
}

variable "create_nat_gw" {
    description = "is nat gateway require to be created for private subnets?"
    default = false
}

variable "newbits" {
    type = number
    description = "newbits is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20"
    default = 8
}