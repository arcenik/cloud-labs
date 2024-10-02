resource "aws_autoscaling_group" "main" {
  name = var.name

  desired_capacity   = var.desired_capacity
  min_size           = var.min_capacity
  max_size           = var.max_capacity

  vpc_zone_identifier = [for id in var.subnet_ids: id]

  target_group_arns = var.target_group_arns

  default_instance_warmup = var.instance_warmup
  default_cooldown = var.cooldown

  launch_template {
    id      = aws_launch_template.main.id
    version = aws_launch_template.main.latest_version
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

}

resource "aws_launch_template" "main" {
  name = var.name
  tags = var.tags

  image_id      = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name

  metadata_options {
    http_endpoint = "enabled"
    http_tokens = "required"
  }

  vpc_security_group_ids = [ resource.aws_security_group.main.id ]

  user_data = var.user_data
}

resource "aws_security_group" "main" {
  #checkov:skip=CKV2_AWS_5:False positive, used in aws_launch_template
  name        = var.name
  description = format("Security Group for ASG %s", var.name)
  vpc_id      = var.vpc_id

  tags = merge(var.tags, { Name = "${var.name}-asg-sg" })
}

resource "aws_security_group_rule" "ssh" {
  #checkov:skip=CKV_AWS_24:For lab without bastion/vpn
  type = "ingress"
  description = "SSH access"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "in_http" {
  #checkov:skip=CKV_AWS_260:For lab without bastion/vpn
  type = "ingress"
  description = "HTTP access"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "out_ping" {
  type = "egress"
  description = "Ping output"
  from_port = 8
  to_port = 8
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "out_http" {
  type = "egress"
  description = "HTTP output"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "out_https" {
  type = "egress"
  description = "HTTPS output"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}
