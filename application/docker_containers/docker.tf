locals {
  ecr_address = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
}

resource "null_resource" "docker" {
  count = var.image_path == "" ? 0 : 1
  provisioner "local-exec" {
    working_dir = path.module
    command     = "aws ecr get-login-password --region ${data.aws_region.current.name} | docker login --username AWS --password-stdin ${local.ecr_address}; docker build -t ${module.ecr.aws_ecr_repository_url}:latest ${path.cwd}/${var.image_path}/. && docker push ${module.ecr.aws_ecr_repository_url}:latest"
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "token" {}
