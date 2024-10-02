resource "aws_lb" "main" {
  #checkov:skip=CKV_AWS_91:No access log for lab
  #checkov:skip=CKV_AWS_150:No delete protection for lab
  #checkov:skip=CKV2_AWS_20:Simple HTTP lab
  #checkov:skip=CKV2_AWS_28:No WAF for this lab
  name               = var.name
  tags               = merge(var.tags, { Name = "${var.name}-lb" })

  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.main.id]

  drop_invalid_header_fields = true

  subnets = var.subnet_ids
}

resource "aws_lb_target_group" "main" {
  #checkov:skip=CKV_AWS_378:Simple HTTP lab
  name     = var.name
  port     = var.backend_port
  protocol = var.protocol
  vpc_id   = var.vpc_id

  health_check {
    enabled             = var.health_check.enabled
    port                = var.health_check.port
    timeout             = var.health_check.timeout
    interval            = var.health_check.interval
    protocol            = var.health_check.protocol
    path                = var.health_check.path
    matcher             = var.health_check.matcher
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }
}

resource "aws_lb_listener" "main" {
  #checkov:skip=CKV_AWS_2:Simple HTTP lab
  #checkov:skip=CKV_AWS_103:Simple HTTP lab
  load_balancer_arn = aws_lb.main.arn
  port              = var.lb_port
  protocol          = var.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_security_group" "main" {
  name = format("%s-lb-sg", var.name)
  description = "LB SG"
  tags = merge(var.tags, { Name = "${var.name}-lb-sg" })
  vpc_id = var.vpc_id

  ingress {
    description = "Open ingress ${var.lb_port} from internet"
    from_port   = var.lb_port
    to_port     = var.lb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Open egress ${var.backend_port} to instances"
    from_port   = var.backend_port
    to_port     = var.backend_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
