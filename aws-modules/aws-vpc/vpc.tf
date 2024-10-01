resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, { Name = "${var.name}-vpc" })
}

resource "aws_subnet" "main" {
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
