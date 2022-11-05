variable "name" {
  description = "app name to be deployed"
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

variable "code_source" {
  description = "app name to be deployed"
  default     = null
}

variable "capacity_provider" {
  default     = "FARGATE_SPOT"
  description = "Which capacity provider to use, FARGATE_SPOT for example"
}

variable "loadbalancer" {
  description = "The Loadbalancer ID to attach to"
}
variable "container_cpu" {
  description = "The Containers CPU"
  default     = 2
}
variable "container_memory" {
  description = "The Containers Memory allocation"
  default     = 1000
}
variable "desired_count" {
  description = "number of containers to deploy"
  default     = 2
}
variable "protocol" {
  description = "Container protocol"
  default     = "http"
}
variable "container_environment" {
  description = "Environment Variables to deploy with"
}
variable "vpc_id" {
  description = "The ID for the VPC that should be used"
}
variable "health_check_path" {
  description = "The path that should be used to for the load balancer to health check against"
}
variable "host_port" {
  description = "The Host port to be used"
}
variable "container_port" {
  description = "The port the app will run on inside the host"
}
variable "security_group_ids" {
  description = "A list of security groups to apply to the container"
}

variable "region" {
  description = "Which region should be operated in"
}
