data "template_file" "user_data" {
  template = var.user_data == "" ? file("${path.module}/user_data.tpl") : file(var.user_data)
  vars = {
    api_version = "latest"
    app_source  = var.code_source
  }
}

module "asg" {
  source             = "../../resources/asg"
  vpc_zone_identifier = var.subnet_ids
  security_groups = var.security_group_ids
  instance_type      = var.instance_type
  load_balancers = [ var.loadbalancer ]
  user_data          = base64encode(data.template_file.user_data.rendered)
  name               = var.name
  min_size           = var.min_capacity
  max_size           = var.max_capacity
  image_id = var.ami_id
}

