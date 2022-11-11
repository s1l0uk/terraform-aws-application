output "elb_app" {
  value = try(aws_lb.elb_app[0].dns_name, "no elb")
}

output "elb_app_id" {
  value = try(aws_lb.elb_app[0].id, "no elb")
}
