resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devvpc.id

  tags = {
    Name = "${aws_vpc.devvpc.id}_igw"
  }
}