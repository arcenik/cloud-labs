resource "aws_autoscaling_group" "main" {
  name = var.name

  desired_capacity   = var.desired_capacity
  min_size           = var.min_capacity
  max_size           = var.max_capacity

  vpc_zone_identifier = [for id in var.subnet_ids: id]

  target_group_arns = var.target_group_arns

  default_instance_warmup = var.instance_warmup
  default_cooldown = var.cooldown

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.main.id
        version = "$Latest"
      }
    }
  }

}

resource "aws_launch_template" "main" {
  name = var.name
  tags = var.tags

  image_id      = var.image_id
  instance_type = var.instance_type

  key_name = var.key_name

  vpc_security_group_ids = [ resource.aws_security_group.main.id ]

  user_data = var.user_data
}

resource "aws_security_group" "main" {
  name        = var.name
  description = format("Security Group for ASG %s", var.name)
  vpc_id      = var.vpc_id

  tags = merge(var.tags, { Name = "${var.name}-asg-sg" })
}

resource "aws_security_group_rule" "ssh" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "in_http" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "out_ping" {
  type = "egress"
  from_port = 8
  to_port = 8
  protocol = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "out_http" {
  type = "egress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}

resource "aws_security_group_rule" "out_https" {
  type = "egress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = resource.aws_security_group.main.id
}
