output "private_subnet_cidr" {
    value = aws_subnet.private_subnet[*].cidr_block
}

output "public_subnet_cidr" {
    value = aws_subnet.private_subnet[*].cidr_block
}