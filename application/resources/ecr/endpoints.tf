resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.s3"
 vpc_endpoint_type = "Gateway"
 route_table_ids = var.route_table_ids
 policy = var.s3_ecr_access
}

resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  vpc_id       = var.vpc_id
 private_dns_enabled = true
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
 vpc_endpoint_type = "Interface"
 security_group_ids = var.security_group_ids
 subnet_ids = var.subnet_ids
}

resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"
 vpc_endpoint_type = "Interface"
 private_dns_enabled = true
 security_group_ids = var.security_group_ids
 subnet_ids = var.subnet_ids
}

resource "aws_vpc_endpoint" "ecs-agent" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ecs-agent"
 vpc_endpoint_type = "Interface"
 private_dns_enabled = true
 security_group_ids = var.security_group_ids
 subnet_ids = var.subnet_ids
}

resource "aws_vpc_endpoint" "ecs-telemetry" {
  vpc_id       = var.vpc_id
  service_name = "com.amazonaws.${var.aws_region}.ecs-telemetry"
 vpc_endpoint_type = "Interface"
 private_dns_enabled = true
 security_group_ids = var.security_group_ids
 subnet_ids = var.subnet_ids
}
