//App Secific
variable "aws_region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "app_name" {
  description = "app name to be deployed"
  default     = "flask-api"
}

variable "app_port" {
  description = "app port to be served"
  default     = 80
}

variable "host_port" {
  description = "app port to be served"
  default     = 80
}

variable "db_port" {
  description = "Database port to be used"
  default     = 3306
}

variable "vpc_id" {
  description = "ID for VPC if not provided one will be created"
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

variable "availability_zones" {
  description = "[Optional] A list of Availability zones to operate in."
  default     = ["a", "b", "c"]
  type        = list(string)
}

variable "website_code_sources" {
  description = "List of sources to take code for deploy from"
  type = list(string)
}

// App vars
variable "instance_type" {
  description = "Instance type"
  default     = "t1.micro"
}

variable "api_version" {
  description = "build version from containers"
  default     = "latest"
}

variable "deploy_method" {
  description = "How to deploy your application"
  default     = "ec2"
}

// Lambda App
variable "lambda_app_language" {
  description = "The environment for lambda to run your app"
  default     = "python37"
}

// DB Variables
variable "database_engine" {
  description = "If a DB is required, which engine should be used for RDS"
  default     = "mysql"
}

variable "database_version" {
  description = "If a DB is required, which version of the selected engine should run"
  default     = "5.7"
}

variable "data_subnet_ids" {
  description = "If subnets are already created declare them here or let the VPC module handle them"
  default     = null
}

// VPC vars
variable "network_cidr_range" {
  description = "[Optional] The Primary Region to run operations and build within."
  type        = string
  default     = "10.0.0.0/16"
}

variable "tiers" {
  description = "[Optional] How many uniform tiers to create, use 'public' to create a public tier."
  default     = ["public", "data", "mid"]
  type        = list(string)
}

variable "network_bits" {
  description = "[Optional] The number of network bits to be allocated"
  default     = 8
}

variable "enable_private_internet_access" {
  description = "[Optional] Should non-public instance be able to access the Internet via a NAT instance."
  type        = bool
  default     = true
}

variable "code_sources" {
  description = "Sources to install each lambda app from"
  type        = list
  default     = null
}

variable "entry_point" {
  description = "Entry point for Lambda functions"
  default     = "lambda_handler:lambda_handler"
}
