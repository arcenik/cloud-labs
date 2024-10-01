resource "aws_lb" "main" {
  name               = var.name
  tags               = merge(var.tags, { Name = "${var.name}-lb" })

  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.main.id]

  subnets = var.subnet_ids
}

resource "aws_lb_target_group" "main" {
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
  tags = merge(var.tags, { Name = "${var.name}-lb-sg" })
  vpc_id = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = var.lb_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = var.backend_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
