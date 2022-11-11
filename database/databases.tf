module "mysql" {
  source          = "./databases/mysql"
  count           = var.database_engine == "mysql" ? 1 : 0
  name            = var.name
  subnet_ids      = var.subnet_ids
  option_group    = aws_db_option_group.default
  parameter_group = aws_db_parameter_group.default
  db_subnet_group = aws_db_subnet_group.default
  security_group_ids = var.security_group_ids
  instance_class = var.instance_type
  database_engine    = var.database_engine
  engine_version   = var.engine_version
}

module "postgres" {
  source          = "./databases/postgres"
  count           = var.database_engine == "postgres" ? 1 : 0
  name            = var.name
  subnet_ids      = var.subnet_ids
  option_group    = aws_db_option_group.default
  parameter_group = aws_db_parameter_group.default
  db_subnet_group = aws_db_subnet_group.default
  security_group_ids = var.security_group_ids
  instance_class = var.instance_type
  database_engine    = var.database_engine
  engine_version   = var.engine_version
}

output "connection_string" {
  description = "A Connection URI for the DB"
  value = var.database_engine == "mysql" ? module.mysql[0].connection_string : module.postgres[0].connection_string

}
