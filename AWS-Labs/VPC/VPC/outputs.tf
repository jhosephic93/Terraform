output "AWS-Resource-VPC" {
  description       = "INFORMATION VPC"
  value             = aws_vpc.my-vpc.id
}

output "ID-SubnetPublic-1a" {
  description       = "ID Subnet Public 1a"
  value             = aws_subnet.subnet-public-1a.id
}

output "ID-SubnetPublic-1b" {
  description       = "ID Subnet Public 1b"
  value             = aws_subnet.subnet-public-1b.id
}

output "ID-Security-Group" {
  description       = "ID Security Group"
  value             = aws_security_group.my-security-group.id
}