module "ecr" {
  source = "../ecr"
}

resource "aws_ecs_cluster" "cluster" {
  name               = "${var.name}-cluster"
  capacity_providers = ["FARGATE_SPOT"]
  tags = {
    Name        = "${var.name}-cluster}"
    Environment = var.environment
  }
}

module "container" {
  source = "../containers"
}
