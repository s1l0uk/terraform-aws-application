//App Secific
variable "name" {
  description = "app name to be deployed"
  default     = "flask-api"
}

variable "aws_region" {
  description = "region we are operating in"
  default     = "eu-west-1"
}

variable "vpc_id" {
  description = "vpc to use"
  default     = ""
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
  default     = null
}

variable "route_table_ids" {
  description = "A list of subnets to deploy into"
  default     = null
}

variable "s3_ecr_access" {
  description = "A list of subnets to deploy into"
  default     = null
}

variable "security_group_ids" {
  description = "A list of Security groups to amend for endpoints"
  default     = null
}
variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}
