resource "aws_route_table" "public1" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = aws_subnet.public_subnet[*].cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }

#   route {
#     ipv6_cidr_block        = "::/0"
#     egress_only_gateway_id = aws_egress_only_internet_gateway.igw.id
#   }

  tags = {
    Name = "myapp-pub-rt"
  }
}