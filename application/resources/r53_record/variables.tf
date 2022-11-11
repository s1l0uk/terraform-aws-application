//App Secific
variable "hostname" {
  description = "hostname to be registered"
}
variable "instance_zone_name" {
  description = "record under the domain"
}
variable "instance_zone_id" {
  description = "Zone ID for the LB or CF dist to apply to"
}
variable "dns_zone_id" {
  description = "Zone ID for the zone to apply to"
}
