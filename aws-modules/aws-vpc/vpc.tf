resource "aws_vpc" "main" {
  #checkov:skip=CKV2_AWS_11:No VPC flow log for this lab
  #checkov:skip=CKV2_AWS_12:No egress restriction for this lab
  #checkov:skip=CKV2_AWS_28:No WAF for this lab
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, { Name = "${var.name}-vpc" })
}

resource "aws_subnet" "main" {
  #checkov:skip=CKV_AWS_130:Direct SSH acces for a lab without bastion/vpn
  for_each = {
    for idx, cidr in var.azs_list: idx => cidr
  }

  vpc_id = aws_vpc.main.id
  cidr_block = var.azs_cidr[each.key]
  availability_zone = format("%s%s", var.region, each.value)
  map_public_ip_on_launch = true
  tags = merge(var.tags, { Name = "${var.name}-subnet" })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, { Name = "${var.name}-igw" })
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.tags, { Name = "${var.name}-route" })
}

resource "aws_route_table_association" "main" {
  count = length(var.azs_list)
  subnet_id = aws_subnet.main[count.index].id
  route_table_id = aws_route_table.main.id
}
