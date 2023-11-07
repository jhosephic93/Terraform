output "Module-VPC" {
  value             = module.VPC.AWS-Resource-VPC
}

output "Module-ID-SubnetPublic-1a" {
  description       = "ID Subnet Public 1a"
  value             = module.VPC.ID-SubnetPublic-1a
}

output "Module-ID-SubnetPublic-1b" {
  description       = "ID Subnet Public 1b"
  value             = module.VPC.ID-SubnetPublic-1b
}

output "Module-ID-Security-Group" {
  description       = "ID Security Group"
  value             = module.VPC.ID-Security-Group
}