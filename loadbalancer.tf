module "ssl_certificate" {
  count = var.enable_ssl ? 1 : 0
  source = "./application/resources/acm"
  domain_name = "www.${var.hostname}"
  zone_id = module.route53[0].zone_id
  tags = var.tags
}

resource "aws_elb" "elb_app" {
  name = var.app_name
  count   = var.deploy_method == "s3" || var.deploy_method == "ec2" || var.deploy_method == "dockerec2" ? 1 : 0

  subnets         = var.subnet_ids != null ? var.subnet_ids : [for sub in module.vpc[0].PublicSubnets : sub.id]
  security_groups = [aws_security_group.loadbalancer[0].id]

  listener {
    instance_port     = var.host_port
    instance_protocol = var.protocol
    lb_port           = var.enable_ssl ? 443 : var.host_port
    lb_protocol       = var.enable_ssl ? "https" : var.protocol
    ssl_certificate_id = var.enable_ssl ? module.ssl_certificate.arn : null
  }

  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    enabled = true
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "${upper(var.protocol)}:${var.host_port}${var.health_check_path}"
    interval            = 5
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 5
  connection_draining         = true
  connection_draining_timeout = 60
}

resource "aws_lb" "elb_app" {
  count                          = var.deploy_method == "fargate" || var.deploy_method == "ecs" || var.deploy_method == "lambda"  ? 1 : 0
  name = var.app_name
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.loadbalancer[0].id]
  subnets         = var.subnet_ids != null ? var.subnet_ids : [for sub in module.vpc[0].PublicSubnets : sub.id]

  enable_deletion_protection = false

  tags = merge({
    Name        = var.app_name
  }, var.tags)
  access_logs {
    bucket  = aws_s3_bucket.alb_access_logs.bucket
    prefix  = "ALBLogs"
    enabled = true
  }
}

module "dns_record" {
  count = length(module.route53) > 0 ? 1 : 0
  source = "./application/resources/r53_record"
  hostname = "www"
  instance_zone_name = aws_lb.elb_app[0].dns_name
  instance_zone_id = aws_lb.elb_app[0].zone_id
  dns_zone_id = module.route53[0].zone_id
}
