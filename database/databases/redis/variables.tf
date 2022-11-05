variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
}

variable "subnets" {
  description = "List of subnet IDs"
}

variable "db_password" {
  description = "password for DB"
}

variable "db_securitygroup" {
  description = "sg for DB"
}
