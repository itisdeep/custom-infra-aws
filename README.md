# custom-infra-aws
custom aws infra using terraform

To create a customized infrastructure using user provided number of subnets, cidr range, region etc. 

## Required input variables
*region : aws region to deploy the infra
*env: Environment name dev/prod etc
*app_name : App name
*private_subnet_cound : Number of private subnets to deploy
*public_subnet_count : Number of public subnets to deploy
*create_nat_gw : `true` if nat gateway is needed `default: false`
*vpc_cidr : VPC Cidr range
*newbits: "newbits is the number of additional bits with which to extend the prefix. For example, if given a prefix ending in /16 and a newbits value of 4, the resulting subnet address will have length /20" `default : 8`