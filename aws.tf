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
  # ami           = "ami-830c94e3"
  instance_type = "t2.micro"
#  subnet_id = "subnet-0658db61e915a5afe"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

resource "aws_key_pair" "TEST" {
  key_name = "TEST"
}
