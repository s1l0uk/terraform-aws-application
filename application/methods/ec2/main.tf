data "template_file" "user_data" {
  template = var.user_data == "" ? file("${path.module}/user_data.tpl") : file(var.user_data)
  vars = {
    api_version = "latest"
    app_source  = var.code_source
  }
}

module "asg" {
  source             = "../../resources/asg"
  subnet_ids         = var.subnet_ids
  security_group_ids = var.security_group_ids
  instance_type      = var.instance_type
  name               = var.name
  loadbalancer       = var.loadbalancer
  user_data          = data.template_file.user_data
  ami_id             = var.ami_id
}
