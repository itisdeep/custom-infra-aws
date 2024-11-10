# custom-infra-aws
custom aws infra using terraform

To create a customized infrastructure using user provided number of subnets, cidr range, region etc. 

## Required input variables
**region** : aws region to deploy the infra

**env**: Environment name dev/prod etc

**app_name** : App name

**private_subnet_cound** : Number of private subnets to deploy

**public_subnet_count** : Number of public subnets to deploy

**create_nat_gw** : `true` if nat gateway is needed `default: false`

**vpc_cidr** : VPC Cidr range

**newbits** : "newbits is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20" `default : 8`

## Outputs
*private_subnet_cidr*

*public_subnet_cidr*

*nat_eips*

*vpc_id*

*private_subnet_ids*

*public_subnet_ids*

## Usage
```
module "network" {
    source = "git::https://github.com/itisdeep/custom-infra-aws.git"

    env = var.env
    app_name = var.app_name
    region = var.region
    private_subnet_count = var.private_subnet_count
    public_subnet_count = var.public_subnet_count
    create_nat_gw = var.create_nat_gw
    vpc_cidr = var.vpc_cidr
    newbits = var.newbits  # Default 8 
}
```
