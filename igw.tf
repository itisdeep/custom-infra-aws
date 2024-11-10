resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${aws_vpc.this.id}_igw"
  }
}