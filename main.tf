//Gets the base if we don't have one!

locals {
  code_sources = [
    for repo in var.code_sources :
    length(regexall("://", repo)) == 0 ? repo : split(".", split("/", repo)[length(split("/", repo)) - 1])[0]
  ]
  website_code_sources = [
    for repo in var.website_code_sources :
    length(regexall("://", repo)) == 0 ? repo : split("/", repo)[length(split("/", repo)) - 1]
  ]
  code_base_to_checkout = compact([
    for repo in concat(var.code_sources, var.website_code_sources) :
    length(regexall("://", repo)) > 0 ? repo : null
  ])
  environment_variables = merge(var.environment_variables, try(
  { SQLALCHEMY_DATABASE_URI = module.database[0].connection_string }, {}
  ))
}

resource "null_resource" "git_clone" {
  count = length(local.code_base_to_checkout)
  provisioner "local-exec" {
    command = "git clone ${local.code_base_to_checkout[count.index]} || cd ${split("/", local.code_base_to_checkout[count.index])[length(split("/", local.code_base_to_checkout[count.index])) - 1]}; git pull"
  }
}

resource "null_resource" "app_build" {
  count = var.build_command != "" ? length(local.website_code_sources) : 0
  provisioner "local-exec" {
    working_dir = local.website_code_sources[count.index]
    command = var.build_command
  }
  depends_on = [ null_resource.git_clone ]
}
module "vpc" {
  source                         = "git::https://github.com/s1l0uk/terraform-aws-vpc-network.git"
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

module "route53" {
  source = "./application/resources/route53"
  count  = var.create_dns ? 1 : 0
  hostname = var.hostname
}

module "database" {
  source = "./database"
  count  = var.database_engine != null ? 1 : 0
  name   = var.app_name
  subnet_ids = var.data_subnet_ids == null ? [
    for sub in module.vpc[0].Subnets : sub.id
    if length(regexall("data", sub.tags_all.Name)) > 0
  ] : var.data_subnet_ids
  security_group_ids = [aws_security_group.database[0].id]
  tags               = var.tags
  database_engine    = var.database_engine
  engine_version   = var.database_version
  availability_zones = var.availability_zones
  instance_type = var.database_instance_type
}

module "lambda_app" {
  source = "./lambda"
  count  = var.lambda_app_language != null ? 1 : 0
  name   = "${var.app_name}-lambda"
  code_sources = local.code_sources
  entry_point = var.entry_point
  subnet_ids = var.subnet_ids == null ? [
    for sub in module.vpc[0].Subnets : sub.id
    if length(regexall("mid", sub.tags_all.Name)) > 0
  ] : var.data_subnet_ids
  security_group_ids = [aws_security_group.webapp[0].id]
  tags               = var.tags
  language           = var.lambda_app_language
  availability_zones = var.availability_zones
  environment_variables = local.environment_variables
}

module "app" {
  source = "./application"
  region = var.aws_region
  name   = var.app_name
  lambda_app_language = var.lambda_app_language
  subnet_ids = var.data_subnet_ids == null ? [
    for sub in module.vpc[0].Subnets : sub.id
    if length(regexall("mid", sub.tags_all.Name)) > 0
  ] : var.subnet_ids
  security_group_ids    = var.deploy_method == "s3" ? [ "nosgrequiredfors3" ]  : [aws_security_group.webapp[0].id]
  tags                  = var.tags
  deploy_method         = var.deploy_method
  availability_zones    = var.availability_zones
  loadbalancer          = length(aws_lb.elb_app) > 0 ? aws_lb.elb_app[0].arn : aws_elb.elb_app[0].id
  host_port             = var.host_port
  container_port        = var.app_port
  web_site_code_sources = local.website_code_sources
  hostname             = var.hostname
  protocol             = var.protocol
  route_table_ids      = var.route_table_ids != [] ? var.route_table_ids : [ for rt in module.vpc[0].RouteTablePrivateInternet : rt.id ]
  vpc_id = var.vpc_id == null ? module.vpc[0].VPC_ID : var.vpc_id
  environment_variables = local.environment_variables
  acm_certificate = var.enable_ssl ? module.ssl_certificate[0].arn : null
}
