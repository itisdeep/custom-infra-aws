resource aws_eip "this" {
    count = var.create_nat_gw ? 1 : 0
    domain = "vpc"

    tags = {
        Name = "${var.app_name}_nat_eip_${count.index}"
    }
}

resource aws_nat_gateway "natgtw" {
    count = var.create_nat_gw ? 1 : 0
    allocation_id = element(aws_eip.this.*.id,count.index)
    subnet_id = element(aws_subnet.public_subnet.*.id,count.index)

    tags = {
        Name = "${var.app_name} nat gateway"
    }
}