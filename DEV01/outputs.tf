/*
output "Valor-variable-ambiente" {
  description = "Environment value"
  value = var.ambiente
}

output "Valor-variable-nombre-proyecto" {
    value = var.nombre-proyecto
}

output "Valor-cidr-block-vpc" {
  value = "${var.CIDR_VPC}"
}

output "Valor-port-ssh" {
  value = var.puerto-ssh
}

output "Valor-Resolve-DNS" {
  value = ["Resolver DNS de AWS", var.Resolve-DNS]
}

output "Valor-subnets-privates-individual" {
  value = [var.CIDR-subnets-privates[0], var.CIDR-subnets-privates[1]]
}

output "Valor-subnets-privates-all" {
  value = var.CIDR-subnets-privates[*]
}

output "Valor-subnet-priva" {
  value = ["id-from-vpc = ${var.subnets-privates.vpc}",
           "bloque-cidr = ${var.subnets-privates.cidr}",
           "id-zone     = ${var.subnets-privates.zone}"]
}

output "Information-my-user" {
  value = data.aws_iam_user.my-user.arn
}

output "INFO-VPC-MODULE" {
  value = module.VPC.AWS-info-VPC
}

output "ID-VPC-Default" {
  value = data.aws_vpc.My-VPC-Data
}

output "ID-ALL-VPCS" {
  value = data.aws_vpcs.All-VPCS.ids
}

output "List-VPCS" {
  value = data.aws_vpc.List-VPCS
}
*/
output "VPC-Select" {
  value = ["Bloque CIDR: ${data.aws_vpc.Selection.cidr_block}",
           "DNS Hostname: ${data.aws_vpc.Selection.enable_dns_hostnames}",
           "VPC ID: ${data.aws_vpc.Selection.id}"]
}