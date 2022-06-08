

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# output "caller_arn" {
#   value = data.aws_caller_identity.current.arn
# }

# output "caller_user" {
#   value = data.aws_caller_identity.current.user_id
# }

output "vpc_id" {
  value = aws_default_vpc.default_vpc.id
}

# output "security_group_id" {
#   value = aws_default_security_group.default.id
# }

# output "security_group_vpc_id" {
#   value = aws_default_security_group.default.vpc_id
# }