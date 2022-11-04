//App Secific
variable "name" {
  description = "app name to be deployed"
  default     = "flask-api"
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
  default     = null
}

variable "security_group_ids" {
  description = "A list of Security groups to attach on deploy"
  default     = null
}

variable "ami_id" {
  description = "AMI ID to run your application on"
  default     = null
}

variable "user_data" {
  description = "Userdata object to be used in launch config from template"
  default     = null
}

variable "loadbalancer" {
  description = "loadbalancer ID to attach the service to"
  default     = null
}

variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}
