//DB Secific
variable "name" {
  description = "app name to be deployed"
  default     = "flask-api"
}

variable "db_port" {
  description = "Database port to be used"
  default     = "443"
}

variable "subnet_ids" {
  description = "A list of subnets to deploy into"
  default     = null
}

variable "vpc_id" {
  description = "ID for VPC if not provided one will be created"
  default     = null
}

variable "security_group_ids" {
  description = "A list of sgs to deploy with"
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


variable "database_engine" {
  description = "If a DB is required, which engine should be used for RDS"
  default     = "mysql"
}

variable "engine_version" {
  description = "If a DB is required, which engine should be used for RDS"
  default     = "5.7"
}

variable "db_subnet_group" {
  description = "The DB subnet object"
  default     = null
}

variable "parameter_group" {
  description = "The DB paramter group object"
  default     = null
}

variable "option_group" {
  description = "The DB Option group object"
  default     = null
}

variable "major_engine_version" {
  description = "The Major DB version"
  default     = "5"
}

variable "instance_class" {
  description = "The Size of the database instance"
  default     = "t1.micro"
}

variable "allocated_storage" {
  description = "The Disk size for the database"
  default     = 50
}

variable "username" {
  description = "The username for the database"
  default     = "root"
}

variable "password" {
  description = "Any prefered password for the database to use"
  default     = ""
}

variable "maintenance_window" {
  description = "Control the maintenance window for your Database"
  default     = null
}

variable "backup_window" {
  description = "Control the automated backup policy for your database"
  default     = null
}

variable "apply_immediately" {
  description = "Toggle the immediate apply"
  default     = true
}

variable "port" {
  description = "Change the database port"
  default     = "3306"
}

variable "storage_type" {
  description = "Change the storage type of the Database instance"
  default     = ""
}

variable "iops" {
  description = "Reserve IOPS for your database instance"
  default     = null
}

variable "ca_cert_identifier" {
  description = "Control is a CA should be used in SSL transations"
  default     = null
}

variable "monitoring_interval" {
  description = ""
  default     = null
}

variable "monitoring_role_arn" {
  description = ""
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = ""
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = ""
  default     = null
}

variable "publicly_accessible" {
  description = ""
  default     = null
}

variable "auto_minor_version_upgrade" {
  description = ""
  default     = null
}

variable "allow_major_version_upgrade" {
  description = ""
  default     = true
}

variable "backup_retention_period" {
  description = ""
  default     = 7
}

variable "storage_encrypted" {
  description = ""
  default     = true
}

variable "kms_key_id" {
  description = ""
  default     = null
}

variable "deletion_protection" {
  description = ""
  default     = null
}

variable "final_snapshot_identifier" {
  description = ""
  default     = null
}

variable "skip_final_snapshot" {
  description = ""
  default     = null
}

variable "snapshot_identifier" {
  description = ""
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  description = ""
  default     = null
}

variable "performance_insights_enabled" {
  description = "Enable Performance insights?"
  default     = false
}

