output "aws_alb_target_group_arn" {
  value = aws_lb_target_group.main.arn
}

output "host_port" {
  value = var.host_port
}
