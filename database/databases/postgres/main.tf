resource "aws_db_instance" "postgres_database" {
  identifier = var.name
  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  engine                = "postgres"
  engine_version = var.engine_version
  instance_class = var.instance_class
  name                  = var.name
  snapshot_identifier = var.snapshot_identifier
  publicly_accessible   = var.publicly_accessible
  multi_az              = length(var.availability_zones) > 1 ? true : false
  username = var.username
  password = var.password == "" ? "RANDOM_STRING" : var.password
  storage_encrypted = var.storage_encrypted
  skip_final_snapshot = var.skip_final_snapshot
  db_subnet_group_name   = var.db_subnet_group.name
  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  performance_insights_enabled = var.performance_insights_enabled == "yes" ? true : false
  vpc_security_group_ids = var.security_group_ids
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  copy_tags_to_snapshot = var.copy_tags_to_snapshot
  maintenance_window      = var.maintenance_window

  tags = merge({ "Name" = var.name }, var.tags)
  lifecycle {
    ignore_changes = [password]
  }
}
  # option_group_name      = var.option_group.name
  # parameter_group_name   = var.parameter_group.name
  # db_subnet_group_name   = var.subnet_group.default.name
  # apply_immediately = var.apply_immediately
  # port = var.port
  # iops = var.iops
  # kms_key_id = var.kms_key_id
  # deletion_protection = var.deletion_protection
  # final_snapshot_identifier = var.final_snapshot_identifier
  # enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  # monitoring_interval = var.monitoring_interval
  # monitoring_role_arn = var.monitoring_role_arn
  # iam_database_authentication_enabled = var.iam_database_authentication_enabled
  # ca_cert_identifier = var.ca_cert_identifier
