# VPC 생성
resource "aws_vpc" "VPC_test-1" {
  cidr_block = "193.17.0.0/16"

  tags = {
    Name = "VPC Test-1"
  }
}