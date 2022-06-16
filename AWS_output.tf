data "aws_caller_identity" "current" {}

output "SSH_FQDN" {
  value = format("%s%s", "ssh -i \"TEST.pem\" ec2-user@", aws_instance.app_server.public_dns)
}

output "SSH_IP" {
  value = format("%s%s", "ssh -i \"TEST.pem\" ec2-user@", aws_instance.app_server.public_ip)
}

output "FQDN" {
  value = aws_instance.app_server.public_dns
}

output "IP" {
  value = aws_instance.app_server.public_ip
}


output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# output "caller_arn" {
#   value = data.aws_caller_identity.current.arn
# }

# output "caller_user" {
#   value = data.aws_caller_identity.current.user_id
# }

# output "vpc_id" {
#   value = aws_default_vpc.default_vpc.id
# }

# output "security_group_id" {
#   value = aws_default_security_group.default.id
# }

# output "security_group_vpc_id" {
#   value = aws_default_security_group.default.vpc_id
# }