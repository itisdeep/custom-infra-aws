output "private_subnet_cidr" {
    value = aws_subnet.private_subnet[*].cidr_block
}

output "public_subnet_cidr" {
    value = aws_subnet.public_subnet[*].cidr_block
}

output "nat_eips" {
    value = aws_eip.this[*].public_ip
}

output "vpc_id" {
    value = aws_vpc.this.id
}

output "private_subnet_ids" {
    value = aws_subnet.private_subnet[*].vpc_id
}

output "public_subnet_ids" {
    value = aws_subnet.public_subnet[*].id
}