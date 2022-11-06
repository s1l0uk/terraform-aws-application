//App Secific
variable "name" {
  description = "app name to be deployed"
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
}

variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}

variable "code_source" {
  description = "app name to be deployed"
}

variable "instance_type" {
  description = "Instance size to use"
  default     = "t2.micro"
}

variable "security_group_ids" {
  description = "A list of security groups to apply to the container"
}

variable "user_data" {
  description = "which User data file should be templated for deployment"
  default     = ""
}
variable "loadbalancer" {
  description = "The Loadbalancer ID to attach to"
}
variable "ami_id" {
  description = "AMI to deploy on"
}

variable "max_capacity" {
  description = "How many instances should be in the ASG"
  default     = 3
}

variable "min_capacity" {
  description = "How few instances should be in the ASG at all times"
  default     = 1
}

