data "aws_vpc" "vpc" {
  id = var.vpc_id == null ? module.vpc[0].VPC_ID : var.vpc_id
}
data "aws_caller_identity" "current" {}
