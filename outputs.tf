output "private_subnet_cidr" {
    value = aws_subnet.private_subnet[*].cidr_block
}

output "public_subnet_cidr" {
    value = aws_subnet.public_subnet[*].cidr_block
}

output "nat_eips" {
    value = aws_eip.nat_eip[*].public_ip
}