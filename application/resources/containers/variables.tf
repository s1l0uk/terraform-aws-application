variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "region" {
  description = "the AWS region in which resources are created"
}

variable "ecr_repository_url" {
  description = "Register repository URL"
}

variable "vpc_id" {
  description = "VPC to deploy in"
}

variable "subnets" {
  description = "List of subnet IDs"
}

variable "ecs_service_security_groups" {
  description = "Comma separated list of security groups"
}

variable "container_port" {
  description = "Port of container"
}

variable "host_port" {
  description = "Port of host"
}

variable "container_cpu" {
  description = "The number of cpu units used by the task"
  default     = 2
}

variable "container_memory" {
  description = "The amount (in MiB) of memory used by the task"
  default     = 1000
}

variable "container_image" {
  description = "Docker image to be launched"
}

variable "aws_lb" {
  description = "Load Balancer to attach to"
}

variable "aws_ecs_cluster" {
  description = "ECS Cluster to deploy on"
}

variable "service_desired_count" {
  description = "Number of services running in parallel"
  default     = 2
}

variable "health_check_path" {
  description = "Path that Loadbalancer should check for status"
}

variable "protocol" {
  description = "The protocol of the application"
}

variable "container_environment" {
  description = "The container environmnent variables"
  type        = list(any)
}

variable "ssl_arn" {
  description = "Which SSL certificate to load"
  default     = null
}

variable "code_source" {
  description = "Path to the Containers Context to build from local source"
}
