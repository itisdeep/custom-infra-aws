resource aws_eip "nat_eip" {
    count = var.create_nat_gw ? 1 : 0
    vpc = true

    tags = {
        Name = "${var.app_name}_nat_eip_${count.index}"
    }
}

resource aws_nat_gateway "natgtw" {
    count = var.create_nat_gw ? 1 : 0
    allocation_id = element(aws_eip.nat_eip.*.id,count.index)
    subnet_id = element(aws_subnet.public_subnet.*.id,count.index)

    tags = {
        Name = "${var.app_name} nat gateway"
    }
}