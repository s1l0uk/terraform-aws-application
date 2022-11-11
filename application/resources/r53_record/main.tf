resource "aws_route53_record" "record" {
  zone_id = var.dns_zone_id
  name    = var.hostname
  type    = "A"

  alias {
    name                   = var.instance_zone_name
    zone_id                = var.instance_zone_id
    evaluate_target_health = false
  }
}
