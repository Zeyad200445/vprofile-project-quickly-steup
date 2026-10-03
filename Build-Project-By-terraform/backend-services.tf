resource "aws_db_subnet_group" "vprofile-rds-subentgroup" {
  name       = "vprofile-rds-subentgroup"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_elasticache_subnet_group" "vprofile-memcache-subentgroup" {
  name       = "vprofile-memcache-subentgroup"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1], module.vpc.private_subnets[2]]

  tags = {
    Name = "My memcache subnet group"
  }
}




resource "aws_db_instance" "vprofile-DB" {
  allocated_storage      = 10
  db_name                = var.dbname
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = var.dbuser
  password               = var.dbpass
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.vprofile-rds-subentgroup.name
  vpc_security_group_ids = [aws_security_group.Security-group-Backend-Service.id]
}


resource "aws_elasticache_cluster" "memcache" {
  cluster_id           = "memcache"
  engine               = "memcached"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.vprofile-memcache-subentgroup.name
  security_group_ids   = [aws_security_group.Security-group-Backend-Service.id]
}



resource "aws_mq_broker" "rabbitmq" {
  broker_name = "rabbitmq"


  auto_minor_version_upgrade = true
  engine_type                = "ActiveMQ"
  engine_version             = "5.18"
  host_instance_type         = "mq.t3.micro"
  security_groups            = [aws_security_group.Security-group-Backend-Service.id]
  subnet_ids                 = [module.vpc.private_subnets[0]]

  user {
    username = var.rmquser
    password = var.rmqpass
  }
}
