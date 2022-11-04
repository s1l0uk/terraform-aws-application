module "ec2" {
  source = "./ec2"
  count = var.deploy_method == "ec2" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
}

module "ecs" {
  source = "./ec2"
  count = var.deploy_method == "ec2" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
}

module "dockerec2" {
  source = "./dockerec2"
  count = var.deploy_method == "dockerec2" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
}

module "fargate" {
  source = "./fargate"
  count = var.deploy_method == "dockerec2" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
}

module "lambda" {
  source = "../lambda"
  count = var.deploy_method == "lambda" ? 1 : 0
  name = var.name
  code_sources = var.web_site_code_sources
  entry_point = var.entry_point
  security_group_ids = var.security_group_ids
  tags               = var.tags
  language           = var.lambda_app_language
  availability_zones = var.availability_zones
  subnet_ids = var.subnet_ids
}

module "s3" {
  source = "./s3"
  count = var.deploy_method == "s3" ? 1 : 0
  name = var.name
  subnet_ids = var.subnet_ids
}
