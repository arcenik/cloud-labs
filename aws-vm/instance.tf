locals {
  ec2_type = "t4g.nano"
  ec2_arch = "arm64"
  ami_name_template = "debian-12-arm64-20*"

  # ec2_type = "t3a.nano"
  # ec2_arch = "x86_64"
  # ami_name_template = "debian-12-amd64-20*"
}

data "aws_ami" "debian12_arm64" {
  owners = ["136693071363"] # from https://wiki.debian.org/Cloud/AmazonEC2Image/Bookworm
  most_recent = true

  filter {
    name = "name"
    values = [local.ami_name_template]
  }

  filter {
    name   = "architecture"
    values = [local.ec2_arch]
  }
}

resource "aws_key_pair" "test1" {
  key_name   = "${var.name}-test-key"
  public_key = var.sshpubkey

  tags = var.tags
}

resource "aws_instance" "test1" {
  #checkov:skip=CKV2_AWS_41:No IAM role for this simple lab
  subnet_id = aws_subnet.main.id
  ami           = data.aws_ami.debian12_arm64.image_id
  instance_type = local.ec2_type
  key_name      = aws_key_pair.test1.key_name
  ebs_optimized = true
  monitoring    = true

  #checkov:skip=CKV_AWS_88:Single instance without VPN/Jump host
  associate_public_ip_address = true

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  root_block_device {
    encrypted = true
  }

  tags = merge(var.tags, { Name = "${var.name}-test1-vm" })
}

resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  description       = "SSH Access"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #checkov:skip=CKV_AWS_24:Single instance without VPN/Jump host
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_vpc.main.default_security_group_id
}

output "ec2_instance_public_ip" {
  value = aws_instance.test1.public_ip
}
