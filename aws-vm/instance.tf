locals {

  # https://aws.amazon.com/marketplace/seller-profile?id=4d4d4e5f-c474-49f2-8b18-94de9d43e2c0
  debian_12_amd64 = "ami-042e6fdb154c830c5"
  debian_12_arm64 = "ami-04bd057ffbd865312"

}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "test1" {
  key_name   = "${var.name}-test-key"
  public_key = var.sshpubkey

  tags = var.tags
}

resource "aws_instance" "test1" {
  subnet_id = aws_subnet.main.id
  ami           = local.debian_12_amd64
  instance_type = "t3.micro"
  key_name      = aws_key_pair.test1.key_name

  tags = merge(var.tags, { Name = "${var.name}-test1-vm" })
}

resource "aws_security_group_rule" "ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_vpc.main.default_security_group_id
}

output "ec2_instance_public_ip" {
  value = aws_instance.test1.public_ip
}
