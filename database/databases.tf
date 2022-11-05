module "mysql" {
  source          = "./databases/mysql"
  count           = var.database_engine == "mysql" ? 1 : 0
  name            = var.name
  subnet_ids      = var.subnet_ids
  option_group    = aws_db_option_group.default
  parameter_group = aws_db_parameter_group.default
  db_subnet_group = aws_db_subnet_group.default
}

module "postgres" {
  source          = "./databases/postgres"
  count           = var.database_engine == "postgres" ? 1 : 0
  name            = var.name
  subnet_ids      = var.subnet_ids
  option_group    = aws_db_option_group.default
  parameter_group = aws_db_parameter_group.default
  db_subnet_group = aws_db_subnet_group.default
}
