variable "name" {
  description = "app name to be deployed"
  default     = "flask-api"
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
