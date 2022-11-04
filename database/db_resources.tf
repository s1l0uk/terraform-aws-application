resource "aws_db_option_group" "default" {
  engine_name              = var.database_engine
  name                     = var.name
  major_engine_version     = local.major_engine_version
  option_group_description = "DB Option group for ${var.name}"
  tags = merge({ "Name" = var.name }, var.tags)
}

resource "aws_db_parameter_group" "default" {
  name        = var.name
  family      = local.family
  description = "DB Parameter group for ${var.name}"

  parameter {
    name         = "character_set_client"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_connection"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_database"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_results"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "character_set_server"
    value        = var.character_set
    apply_method = "immediate"
  }

  parameter {
    name         = "collation_connection"
    value        = var.collation
    apply_method = "immediate"
  }

  parameter {
    name         = "collation_server"
    value        = var.collation
    apply_method = "immediate"
  }

  parameter {
    name         = "time_zone"
    value        = var.time_zone
    apply_method = "immediate"
  }

  parameter {
    name         = "tx_isolation"
    value        = var.tx_isolation
    apply_method = "immediate"
  }

  tags = merge({ "Name" = var.name }, var.tags)
}


resource "aws_db_subnet_group" "default" {
  name        = var.name
  subnet_ids  = var.subnet_ids
  description = "DB Subnet group for ${var.name}"

  tags = merge({ "Name" = var.name }, var.tags)
}
