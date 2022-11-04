resource "aws_elb" "elb_app" {
  name = var.app_name

  subnets         = var.subnet_ids != null ? var.subnet_ids : [for sub in module.vpc[0].PublicSubnets : sub.id]
  security_groups = [aws_security_group.loadbalancer.id]

  listener {
    instance_port     = var.app_port
    instance_protocol = "http"
    lb_port           = var.app_port
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.app_port}/status"
    interval            = 5
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 5
  connection_draining         = true
  connection_draining_timeout = 60
}
