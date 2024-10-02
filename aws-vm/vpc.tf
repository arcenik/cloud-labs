resource "aws_vpc" "main" {
  #checkov:skip=CKV2_AWS_11:No VPC flow log for this lab
  #checkov:skip=CKV2_AWS_12:No egress restriction for this lab
  cidr_block = "10.0.0.0/16"
  tags = merge(var.tags, { Name = "${var.name}-test1-vpc" })
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.0.0/24"
  availability_zone = var.mainaz
  map_public_ip_on_launch = false
  tags = merge(var.tags, { Name = "${var.name}-test1-subnet" })
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, { Name = "${var.name}-test1-igw" })
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  tags = merge(var.tags, { Name = "${var.name}-test1-route" })
}

resource "aws_route_table_association" "main" {
  subnet_id = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}
