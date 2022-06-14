# VPC 생성
resource "aws_vpc" "VPC_test-2" {
  cidr_block = "193.18.0.0/16"

  tags = {
    Name = "VPC Test-2"
  }
}