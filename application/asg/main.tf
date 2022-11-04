resource "aws_launch_configuration" "lc_web_app" {
  lifecycle {
    create_before_destroy = true
  }

  image_id        = var.ami_id
  instance_type   = "t2.micro"
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
  min_size            = 1
  max_size            = 2
  desired_capacity    = 2
  min_elb_capacity    = 1

  launch_configuration = aws_launch_configuration.lc_web_app.name
  # tags = var.tags
}
