resource "aws_db_instance" "default" {
  engine                 = "mysql"
  option_group_name      = var.option_group.name
  parameter_group_name   = var.parameter_group.name
  db_subnet_group_name   = var.db_subnet_group.name
  vpc_security_group_ids = var.security_group_ids
  identifier = var.name
  engine_version = var.engine_version
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  username = var.username
  password = var.password == "" ? "RANDOM_STRING" : var.password
  maintenance_window = var.maintenance_window
  backup_window = var.backup_window
  apply_immediately = var.apply_immediately
  multi_az = length(var.availability_zones) > 1 ? true : false
  port = var.port
  name = var.name
  storage_type = var.storage_type
  iops = var.iops
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  allow_major_version_upgrade = var.allow_major_version_upgrade
  backup_retention_period = var.backup_retention_period
  storage_encrypted = var.storage_encrypted
  kms_key_id = var.kms_key_id
  deletion_protection = var.deletion_protection
  final_snapshot_identifier = var.final_snapshot_identifier
  skip_final_snapshot = var.skip_final_snapshot
  snapshot_identifier = var.snapshot_identifier
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  monitoring_interval = var.monitoring_interval
  monitoring_role_arn = var.monitoring_role_arn
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  publicly_accessible = var.publicly_accessible
  ca_cert_identifier = var.ca_cert_identifier
  tags = merge({ "Name" = var.name }, var.tags)
  lifecycle {
    ignore_changes = [password]
  }
}

locals {
  version_elements       = split(".", var.engine_version)
  major_version_elements = [local.version_elements[0], local.version_elements[1]]
  major_engine_version   = var.major_engine_version == "" ? join(".", local.major_version_elements) : var.major_engine_version
  family = "mysql${local.major_engine_version}"
}
