resource "aws_elb" "elb_app" {
  count                          = var.deploy_method != "s3"  ? 1 : 0
  name = var.app_name

  subnets         = var.subnet_ids != null ? var.subnet_ids : [for sub in module.vpc[0].PublicSubnets : sub.id]
  security_groups = [aws_security_group.loadbalancer[0].id]

  listener {
    instance_port     = var.app_port
    instance_protocol = var.protocol
    lb_port           = var.app_port
    lb_protocol       = var.protocol
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${upper(var.protocol)}:${var.app_port}${var.health_check_path}"
    interval            = 5
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 5
  connection_draining         = true
  connection_draining_timeout = 60
}
