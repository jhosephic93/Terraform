module "VPC" {
  source            = "./vpc"
  CIDR_VPC          = var.CIDR_VPC
  NAME_TAG_VPC      = var.NAME_TAG_VPC
}