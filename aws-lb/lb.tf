locals {
  port = 80
  lb_port = 8000
  protocol = "HTTP"
}

module "lb" {
  source = "../aws-modules/aws-lb"

  name = local.name
  tags = local.tags

  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.subnet_ids

  lb_port = local.lb_port
  protocol = local.protocol

  backend_port = local.port

  health_check  = {
    enabled             = true
    port                = local.port
    timeout             = 4
    interval            = 5
    protocol            = local.protocol
    path                = "/"
    matcher             = "200"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

}

output "lb_dns_name" {
  value = module.lb.lb_dns_name
}

output "lb_http_url" {
  value = format("http://%s:%s/", module.lb.lb_dns_name, local.lb_port)
}
