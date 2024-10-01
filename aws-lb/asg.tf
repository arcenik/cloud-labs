locals {
  ec2_type = "t4g.nano"
  ec2_arch = "arm64"
  ami_name_template = "debian-12-arm64-20*"

  # ec2_type = "t3a.nano"
  # ec2_arch = "x86_64"
  # ami_name_template = "debian-12-amd64-20*"

  capacity = {
    min = 1
    desired = 2
    max = 3
  }
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

variable "sshpubkey" {
  description = "Use environment variable: export TF_VAR_sshpubkey=$(cat ~/.ssh/id_ed25519.pub)"
  type = string
  nullable = false
}

module "asg" {
  source = "../aws-modules/aws-asg"

  name = local.name
  tags = local.tags

  image_id = data.aws_ami.debian12_arm64.image_id
  instance_type = local.ec2_type

  min_capacity = local.capacity.min
  desired_capacity = local.capacity.desired
  max_capacity = local.capacity.max

  cooldown = 5
  instance_warmup = 0

  vpc_id = module.vpc.vpc_id

  key_name = resource.aws_key_pair.key1.key_name
  subnet_ids = module.vpc.subnet_ids

  user_data = base64encode(file("httpdemo.sh"))

  target_group_arns = [module.lb.target_group_arn]
}

resource "aws_key_pair" "key1" {
  key_name   = "${local.name}-key1"
  public_key = var.sshpubkey

  tags = local.tags
}
