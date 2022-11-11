//App Secific
variable "domain_name" {
  description = "certificate host name"
}

variable "enable_wildcard" {
  description = "Should a san be created"
  default     = false
}

variable "zone_id" {
  description = "Route 53 ZoneId to register against and validate certificates"
  default     = false
}

variable "tags" {
  description = "[Optional] Extra Tags to add to your stack."
  type        = map
  default = {
    enviroment = "alpha"
  }
}
