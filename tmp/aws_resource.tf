terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  # region  = "us-west-2"
  region  = "ap-northeast-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0eb218869d3d2d7e7"
  instance_type = "t2.micro"
  key_name = "TEST"
  # key_name = aws_key_pair.TEST.key_name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# resource "aws_key_pair" "TEST" {
#   key_name = "TEST1"
#   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCQDrZjSwZW+H7mfgDxmBIaXtoWuCUvgpnXfBYOR7+da8xJc8gv51xF5qgYJE1n38IHD7rAZD3cxpq4nD9XMZ+Dg8K0ngK6Zqi88bf3BR62g8CQ1zjCUpCtrmMffgt9Fd4mTLXhW6GOi1pSOekyEgu7K/ewO/CcQVvGvPxVp7BgMxDlvQbaVuJ+sDoyLnv20NEnkLxLr9NILtdP3bpT25c8altuZ68mLH/HCjYxyyL5X/bse0cbgjPkk69+8CQMpbR6C3HdXzt1TnPwmFtjpVHiHfAqlK3aoeI5vwoBIDuXEoQxYldSrTiG+u0BAk2k57ZMkQZ3sVNBkwNK5UXb9yaf"
# }

resource "aws_default_vpc" "default_vpc" {
  
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_default_vpc.default_vpc.id
  
  ingress {
    # protocol  = -1
    protocol  = "tcp"
    # self      = true
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 22
    to_port   = 22
  }

  egress {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}
