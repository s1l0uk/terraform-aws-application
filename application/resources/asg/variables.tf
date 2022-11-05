//App Secific
variable "name" {
  description = "app name to be deployed"
}

variable "instance_type" {
  description = "Which instance size to use in the fleet"
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
}

variable "security_group_ids" {
  description = "A list of Security groups to attach on deploy"
}

variable "ami_id" {
  description = "AMI ID to run your application on"
  default     = null
}

variable "user_data" {
  description = "Userdata object to be used in launch config from template"
}

variable "max_capacity" {
  description = "How many instances should be in the ASG"
  default = 3
}

variable "desired_capacity" {
  description = "How many instances should be in the ASG to start"
  default = 2
}

variable "min_capacity" {
  description = "How few instances should be in the ASG at all times"
  default = 1
}

variable "loadbalancer" {
  description = "loadbalancer ID to attach the service to"
}

variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}
