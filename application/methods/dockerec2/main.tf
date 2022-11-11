locals {
  ecr_address = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
}

data "template_file" "user_data" {
  template = var.user_data == "" ? file("${path.module}/user_data.tpl") : file(var.user_data)
  vars = {
    registry = var.aws_ecr_repository_url
    api_version = "latest"
    app_name        = var.name
    host_port = var.host_port
    app_port = var.container_port
    environment_variables = jsonencode(var.container_environment)
    region = var.region

  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "token" {}

resource "null_resource" "docker" {
  provisioner "local-exec" {
    working_dir = path.module
    command     = "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${local.ecr_address}; docker build -t ${var.aws_ecr_repository_url}:latest ${path.cwd}/${var.code_source}/. && docker push ${var.aws_ecr_repository_url}:latest"
  }
}

module "asg" {
  source             = "../../resources/asg"
  vpc_zone_identifier = var.subnet_ids
  security_groups = var.security_group_ids
  instance_type      = var.instance_type
  load_balancers = [ var.loadbalancer ]
  user_data          = base64encode(data.template_file.user_data.rendered)
  min_size           = var.min_capacity
  max_size           = var.max_capacity
  name               = var.name
  image_id = var.ami_id
  # create_iam_instance_profile = true
  # iam_role_name               = var.name
  # iam_role_description        = "IAM role for ${var.name} ASG"
  # iam_role_tags = var.tags
  # iam_role_policies = {
  #   AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  # }
}

