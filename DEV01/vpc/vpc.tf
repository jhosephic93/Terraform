resource "aws_vpc" "vpc-example" {
  cidr_block              = var.CIDR_VPC
  instance_tenancy        = "default"
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags = {
    "Name"                = var.NAME_TAG_VPC
  }
}