resource "aws_launch_configuration" "lc_web_app" {
  lifecycle {
    create_before_destroy = true
  }

  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = var.security_group_ids
  user_data       = var.user_data.rendered
}

resource "aws_autoscaling_group" "asg_web_app" {
  lifecycle {
    create_before_destroy = true
  }

  name                = aws_launch_configuration.lc_web_app.name
  load_balancers      = [var.loadbalancer]
  vpc_zone_identifier = var.subnet_ids
  min_size            = var.min_capacity
  max_size            = var.max_capacity
  desired_capacity    = var.desired_capacity
  min_elb_capacity    = 1

  launch_configuration = aws_launch_configuration.lc_web_app.name
  tags = [ for k, v in var.tags :
    {
          "key"                 = k
          "value"               = v
          "propagate_at_launch" = true
    }
  ]
}
