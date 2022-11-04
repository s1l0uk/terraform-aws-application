resource "aws_launch_configuration" "lc_web_app" {
  lifecycle {
    create_before_destroy = true
  }

  image_id        = data.aws_ami.ubuntu_ami.id
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.app-web.id]
  user_data       = data.template_file.user_data_api.rendered
}

resource "aws_autoscaling_group" "asg_web_app" {
  lifecycle {
    create_before_destroy = true
  }

  name                = aws_launch_configuration.lc_web_app.name
  load_balancers      = [aws_elb.elb_app.name]
  vpc_zone_identifier = [aws_subnet.private_az1.id, aws_subnet.private_az2.id, aws_subnet.private_az3.id]
  min_size            = 1
  max_size            = 2
  desired_capacity    = 2
  min_elb_capacity    = 1

  launch_configuration = aws_launch_configuration.lc_web_app.name

  depends_on = [ aws_nat_gateway.nat ]

  tags {
    key                 = "Name"
    value               = var.app_name
    propagate_at_launch = true
  }
}
