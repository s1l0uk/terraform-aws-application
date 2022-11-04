//Gets the base if we don't have one!

module "vpc" {
  source = "../aws-vpc-network"
  # source = "git::https://github.com/s1l0uk/terraform-aws-vpc-network.git"
  count                          = var.vpc_id == null ? 1 : 0
  name                           = var.app_name
  network_cidr_range             = var.network_cidr_range
  tiers                          = var.tiers
  network_bits                   = var.network_bits
  enable_private_internet_access = var.enable_private_internet_access
  availability_zones             = var.availability_zones
  tags                           = var.tags
  region                         = var.aws_region
}

module "database" {
  source = "./database"
  count  = var.database_engine != null ? 1 : 0
  name   = var.app_name
  subnet_ids = var.data_subnet_ids == null ? [
    for sub in module.vpc[0].Subnets : sub.id
    if length(regexall("data", sub.tags_all.Name)) > 0
  ] : var.data_subnet_ids
  security_group_ids = [aws_security_group.database.id]
  tags               = var.tags
  database_version   = var.database_version
  database_engine    = var.database_engine
  availability_zones = var.availability_zones
}

module "lambda_app" {
  source = "./lambda"
  count  = var.lambda_app_language != null ? 1 : 0
  name   = "${var.app_name}-lambda"
  subnet_ids = var.subnet_ids == null ? [
    for sub in module.vpc[0].Subnets : sub.id
    if length(regexall("mid", sub.tags_all.Name)) > 0
  ] : var.data_subnet_ids
  security_group_ids = [aws_security_group.webapp.id]
  tags               = var.tags
  language           = var.lambda_app_language
  availability_zones = var.availability_zones
}

module "app" {
  source = "./application"
  name   = var.app_name
  subnet_ids = var.data_subnet_ids == null ? [
    for sub in module.vpc[0].Subnets : sub.id
    if length(regexall("mid", sub.tags_all.Name)) > 0
  ] : var.subnet_ids
  security_group_ids = [aws_security_group.webapp.id]
  tags               = var.tags
  deploy_method      = var.deploy_method
  availability_zones = var.availability_zones
}
