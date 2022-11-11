//App Secific
variable "name" {
  description = "app name to be deployed"
}

variable "aws_region" {
  description = "region we are operating in"
}

variable "vpc_id" {
  description = "vpc to use"
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
}

variable "route_table_ids" {
  description = "A list of subnets to deploy into"
}

variable "s3_ecr_access" {
  description = "s3 access policy"
  default = null
}

variable "security_group_ids" {
  description = "A list of Security groups to amend for endpoints"
}
variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}

