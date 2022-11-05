module "ecr" {
  source = "../../resources/ecr"
}

resource "aws_ecs_cluster" "cluster" {
  name               = "${var.name}-cluster"
  capacity_providers = [var.capacity_provider == "" ? "FARGATE_SPOT" : var.capacity_provider]
  tags = {
    Name = "${var.name}-cluster}"
  }
}

module "container" {
  source                      = "../../resources/containers"
  name                        = var.name
  container_image             = var.code_source
  service_desired_count       = var.desired_count
  protocol                    = var.protocol
  region                      = var.region
  ecs_service_security_groups = var.security_group_ids
  container_port              = var.container_port
  host_port                   = var.host_port
  container_memory            = var.container_memory
  ecr_repository_url          = module.ecr.aws_ecr_repository_url
  aws_ecs_cluster             = aws_ecs_cluster.cluster.id
  health_check_path           = var.health_check_path
  vpc_id                      = var.vpc_id
  subnets                     = var.subnet_ids
  container_cpu               = var.container_cpu
  aws_lb                      = var.loadbalancer
  container_environment       = var.container_environment
  code_source                 = var.code_source
}
