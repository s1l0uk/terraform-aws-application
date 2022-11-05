//App Secific
variable "name" {
  description = "app name to be deployed"
  default     = null
}

variable "region" {
  description = "region to be deployed in"
  default     = null
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
  default     = null
}

variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}

variable "security_group_ids" {
  description = "Security groups to apply to the instance"
  default     = null
}

variable "lambda_app_language" {
  description = "Lambda environment to deploy your app"
  default     = "python3.5"
}

variable "deploy_method" {
  description = "Method to deploy the application"
  default     = null
}

variable "ami_id" {
  description = "AMI to deploy"
  default     = null
}

variable "availability_zones" {
  description = "AZs to ensure the app is present in"
  default     = ["a", "b", "c"]
}

variable "web_site_code_sources" {
  description = "Where to fetch the code from"
  type = list(any)
  default     = null
}

variable "entry_point" {
  description = "How to run the application"
  default     = "app:app"
}

variable "enable_cloudfront" {
  description = "Toggle to enable Cloudfront"
  default     = false
}

variable "enable_acm" {
  description = "Toggle to enable ACM"
  default     = false
}

variable "enable_route53" {
  description = "Toggle to enable Route53"
  default     = false
}

variable "vpc_id" {
  description = "VPC to deploy into"
  default     = null
}


variable "environment_variables" {
  description = "Environment variables to deploy with"
  default     = null
}

variable "memory" {
  description = "How Much Memory should be allocated"
  default = 1000
}

variable "cpu" {
  description = "How Much CPU should be allocated"
  default = 2
}

variable "loadbalancer" {
  description = "The loadbalancer to use with this deploy"
}

variable "health_check_path" {
  description = "The loadbalancer health check path"
  default = "/"
}

variable "host_port" {
  description = "The host port"
}

variable "container_port" {
  description = "The Container port"
}
