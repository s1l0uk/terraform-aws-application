resource "aws_route53_zone" "zone" {
  name     = var.hostname
}

resource "aws_route53_record" "nameservers" {
  allow_overwrite = true
  name            = var.hostname
  ttl             = 300
  type            = "NS"
  zone_id         = aws_route53_zone.zone.zone_id

  records = aws_route53_zone.zone.name_servers
}

output "zone_id" {
  description = "Zone ID of the Route53 Zone to assign records to"
  value = aws_route53_zone.zone.zone_id
}

output "zone_object" {
  description = "Zone object"
  value = aws_route53_zone.zone
}

output "nameservers" {
  description = "Name Servers record object"
  value = aws_route53_record.nameservers
}
