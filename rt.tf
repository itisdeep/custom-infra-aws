resource "aws_route_table" "public1" {
  vpc_id = aws_vpc.devvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.app_name}-pub-rt"
  }
}

resource "aws_route_table_association" "public_rt_assn"{
  count = length(aws_subnet.public_subnet.*.id)
  subnet_id = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id = aws_route_table.public1.id
}

resource "aws_route_table" "private1" {
  count = var.create_nat_gw ? 1 : 0
  vpc_id = aws_vpc.devvpc.id

    tags = {
    Name = "${var.app_name}-pvt-rt"
  }
}

  resource aws_route "route" {
    count = length(aws_route_table.private1)
    route_table_id = element(aws_route_table.private1.*.id,count.index)
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.natgtw.*.id,count.index)
    depends_on = [aws_route_table.private1]
  }

resource "aws_route_table_association" "private_rt_assn"{
  count = length(aws_subnet.private_subnet.*.id)
  subnet_id = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id = element(aws_route_table.private1.*.id,count.index)
}