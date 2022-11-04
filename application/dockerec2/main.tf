data "template_file" "user_data_api" {
  template = file("${path.module}/user_data.tpl")
  vars = {
    api_version = ""
    path = ""
  }
}

module "asg" {
  source = "../asg"
}

module "ecr" {
  source = "../ecr"
}