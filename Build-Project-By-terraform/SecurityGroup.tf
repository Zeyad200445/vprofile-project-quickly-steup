resource "aws_security_group" "Security-group-Loadbalnacer" {
  name        = "loadbalancer-SG"
  description = "Security-group-Loadbalnacer"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name    = "loadbalancer-SG"
    MangeBY = "Terraform"
    project = var.ProjectName
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_for_lb" {
  security_group_id = aws_security_group.Security-group-Loadbalnacer.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_lb" {
  security_group_id = aws_security_group.Security-group-Loadbalnacer.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_lb" {
  security_group_id = aws_security_group.Security-group-Loadbalnacer.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}









resource "aws_security_group" "Security-group-BastionHost" {
  name        = "BastionHost-SG"
  description = "Security-group-BastionHost"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name    = "BastionHost-SG"
    MangeBY = "Terraform"
    project = var.ProjectName
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_SSH_for_Bstion" {
  security_group_id = aws_security_group.Security-group-BastionHost.id
  cidr_ipv4         = var.MYIP
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_Bstion" {
  security_group_id = aws_security_group.Security-group-BastionHost.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_Bstion" {
  security_group_id = aws_security_group.Security-group-BastionHost.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}









resource "aws_security_group" "Security-group-Beanstalk" {
  name        = "Beanstalk-SG"
  description = "Security-group-Beanstalk"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name    = "Beanstalk-SG"
    MangeBY = "Terraform"
    project = var.ProjectName
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_SSH_for_MYIP_beans" {
  security_group_id = aws_security_group.Security-group-Beanstalk.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}
resource "aws_vpc_security_group_ingress_rule" "allow_LB_for_calling-beanstalk" {
  security_group_id            = aws_security_group.Security-group-Beanstalk.id
  referenced_security_group_id = aws_security_group.Security-group-Loadbalnacer.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_beans" {
  security_group_id = aws_security_group.Security-group-Beanstalk.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_beans" {
  security_group_id = aws_security_group.Security-group-Beanstalk.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}










resource "aws_security_group" "Security-group-Backend-Service" {
  name        = "Backend-Service-SG"
  description = "Security-group-Backend-Service"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name    = "Backend-Service-SG"
    MangeBY = "Terraform"
    project = var.ProjectName
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_SSH_for_BationHost" {
  security_group_id            = aws_security_group.Security-group-Backend-Service.id
  referenced_security_group_id = aws_security_group.Security-group-BastionHost.id
  from_port                    = 3306
  ip_protocol                  = "tcp"
  to_port                      = 3306
}
resource "aws_vpc_security_group_ingress_rule" "allow_all_connect_from_beans" {
  security_group_id            = aws_security_group.Security-group-Backend-Service.id
  referenced_security_group_id = aws_security_group.Security-group-Beanstalk.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 65535
}
resource "aws_vpc_security_group_ingress_rule" "allow_all_connect_from_backend-services" {
  security_group_id            = aws_security_group.Security-group-Backend-Service.id
  referenced_security_group_id = aws_security_group.Security-group-Backend-Service.id
  from_port                    = 0
  ip_protocol                  = "tcp"
  to_port                      = 65535
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_backend-services" {
  security_group_id = aws_security_group.Security-group-Backend-Service.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6_backend-services" {
  security_group_id = aws_security_group.Security-group-Backend-Service.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}



moved {
  from = aws_vpc_security_group_ingress_rule.allow_SSH_for_MYIP_Bstion
  to   = aws_vpc_security_group_ingress_rule.allow_SSH_for_Bstion
}