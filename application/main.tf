data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2" {
  source = "./methods/ec2"
  count = var.deploy_method == "ec2" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
  code_source = var.web_site_code_sources[count.index]
  security_group_ids = var.security_group_ids
  loadbalancer = var.loadbalancer
  ami_id = data.aws_ami.ubuntu_ami.id
}

module "ecs" {
  source = "./methods/ecs"
  count = var.deploy_method == "ecs" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
  capacity_provider = "ECS"
  loadbalancer = var.loadbalancer
  container_cpu = var.cpu
  container_memory = var.memory
  container_environment = var.environment_variables
  vpc_id = var.vpc_id
  health_check_path = var.health_check_path
  host_port = var.host_port
  container_port = var.container_port
  security_group_ids = var.security_group_ids
  region = var.region
  code_source = var.web_site_code_sources[count.index]
}

module "dockerec2" {
  source = "./methods/dockerec2"
  count = var.deploy_method == "dockerec2" ? length(var.web_site_code_sources) : 0
  name = var.name
  subnet_ids = var.subnet_ids
  code_source = var.web_site_code_sources[count.index]
  security_group_ids = var.security_group_ids
  loadbalancer = var.loadbalancer
  region = var.region
  container_port = var.container_port
  container_environment = var.environment_variables
  vpc_id = var.vpc_id
  health_check_path = var.health_check_path
  host_port = var.host_port
  ami_id = data.aws_ami.ubuntu_ami.id
}

module "fargate" {
  source = "./methods/ecs"
  count = var.deploy_method == "fargate" ? length(var.web_site_code_sources) : 0
  name = var.name
  capacity_provider = "FARGATE_SPOT"
  subnet_ids = var.subnet_ids
  loadbalancer = var.loadbalancer
  container_cpu = var.cpu
  container_memory = var.memory
  container_environment = var.environment_variables
  vpc_id = var.vpc_id
  health_check_path = var.health_check_path
  host_port = var.host_port
  container_port = var.container_port
  security_group_ids = var.security_group_ids
  region = var.region
  code_source = var.web_site_code_sources[count.index]
}

module "s3" {
  source = "./methods/s3"
  count = var.deploy_method == "s3" ? length(var.web_site_code_sources) : 0
  name = var.name
  code_source = var.web_site_code_sources[count.index]
}

//Lambda handles many in other module
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
