resource "aws_security_group" "database" {
  count       = var.database_engine == null || var.deploy_method == "" ? 0 : 1
  name        = "${var.app_name}-db"
  description = "${var.app_name}-app-db"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = var.deploy_method == "" ? [ "nosgrequiredfors3" ]  : [aws_security_group.webapp[0].id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "webapp" {
  count = var.deploy_method == "" ? 0 : 1
  name        = var.app_name
  description = "${var.app_name}-app-web"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.loadbalancer[0].id]
  }

  ingress {
    from_port       = var.host_port
    to_port         = var.host_port
    protocol        = "tcp"
    security_groups = [aws_security_group.loadbalancer[0].id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "loadbalancer" {
  count = var.deploy_method == "" ? 0 : 1
  name        = "${var.app_name}-elb"
  description = "${var.app_name}-elb"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.enable_ssl ? [443] : []
    content {
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
