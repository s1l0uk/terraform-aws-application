resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.s3"
 vpc_endpoint_type = "Gateway"
 route_table_ids = [aws_route_table.private[0].id]
 policy = data.aws_iam_policy_document.s3_ecr_access.json

}


resource "aws_vpc_endpoint" "ecr-dkr-endpoint" {
  vpc_id       = aws_vpc.main.id
 private_dns_enabled = true
  service_name = "com.amazonaws.${var.aws_region}.ecr.dkr"
 vpc_endpoint_type = "Interface"
 security_group_ids = [aws_security_group.ecs_task.id]
 subnet_ids = "${aws_subnet.private.*.id}"

}

resource "aws_vpc_endpoint" "ecr-api-endpoint" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecr.api"
 vpc_endpoint_type = "Interface"
 private_dns_enabled = true
 security_group_ids = [aws_security_group.ecs_task.id]
 subnet_ids = "${aws_subnet.private.*.id}"
}
resource "aws_vpc_endpoint" "ecs-agent" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecs-agent"
 vpc_endpoint_type = "Interface"
 private_dns_enabled = true
 security_group_ids = [aws_security_group.ecs_task.id]
 subnet_ids = "${aws_subnet.private.*.id}"


}
resource "aws_vpc_endpoint" "ecs-telemetry" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.aws_region}.ecs-telemetry"
 vpc_endpoint_type = "Interface"
 private_dns_enabled = true
 security_group_ids = [aws_security_group.ecs_task.id]
 subnet_ids = "${aws_subnet.private.*.id}"

}
