# VPC 생성
resource "aws_vpc" "VPC_test" {
  cidr_block = "193.17.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC Test"
  }
}

# Internet gateway 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_test.id

  tags = {
    Name = "Internet Gateway"
  }
}

# EIP(Elastic IP) 생성
resource "aws_eip" "eip" {
  vpc = true
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.app_server.id
  allocation_id = aws_eip.eip.id
}

# network acl
resource "aws_default_network_acl" "vpc_network_acl" {
    default_network_acl_id = aws_vpc.VPC_test.default_network_acl_id
    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 22
        to_port    = 22
    }
    egress {
        protocol   = "-1"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }
    tags = {
        Name = "network acl"
    }
}

# security group
resource "aws_default_security_group" "default_sg" {
    vpc_id = aws_vpc.VPC_test.id

    ingress {
        protocol    = "tcp"
        from_port = 0
        to_port   = 65535
        cidr_blocks = [aws_vpc.VPC_test.cidr_block]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "default_sg"
        Description = "default security group"
    }
}

# 
resource "aws_security_group" "manual_sg" {
    name        = "manual_sg"
    description = "manual security group"
    vpc_id      = aws_vpc.VPC_test.id

    ingress {
        description = "For Inhouse ingress"
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = [
            aws_vpc.VPC_test.cidr_block,
            # 자신의 IP 실제로는, 회사 VPN 대역을 넣어주면 된다.
            "1.217.140.27/32",
            "58.123.58.231/32"
        ]
    }

    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "inhouse_sg"
    }
}