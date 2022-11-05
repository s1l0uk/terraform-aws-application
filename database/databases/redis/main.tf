resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "${var.name}-redis-subnet-${var.environment}"
  subnet_ids = var.subnets.*.id
}

resource "aws_elasticache_replication_group" "redis_replication_group" {
  replication_group_id          = "${var.name}-redis-${var.environment}"
  node_type                     = "cache.t3.micro"
  replication_group_description = "A redis pipe for ${var.name} caching"
  automatic_failover_enabled    = true
  subnet_group_name             = aws_elasticache_subnet_group.redis_subnet_group.name
  number_cache_clusters         = 2
  parameter_group_name          = "default.redis6.x"
  port                          = 6379
  security_group_ids            = [var.db_securitygroup]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.name}-db-subnet-${var.environment}"
  subnet_ids = var.subnets.*.id
}

resource "aws_s3_bucket" "asset-bucket" {
  bucket = "${var.name}-${var.environment}-asset-bucket"
}

resource "aws_db_instance" "database" {
  identifier                = "${var.name}-mysql-${var.environment}"
  name                      = "cftd"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t3.micro"
  allocated_storage         = 5
  username                  = "admin"
  password                  = var.db_password
  vpc_security_group_ids    = [var.db_securitygroup]
  parameter_group_name      = "default.mysql5.7"
  db_subnet_group_name      = aws_db_subnet_group.db_subnet_group.name
  skip_final_snapshot       = true
  final_snapshot_identifier = "boo"
}

output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.database.address
  sensitive   = true
}

output "redis_url" {
  value = "redis://${aws_elasticache_replication_group.redis_replication_group.primary_endpoint_address}:6379"
}
