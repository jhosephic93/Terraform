module "VPC" {
  source = "./VPC"
  classb_vpc_cidr_block  = var.classb_vpc_cidr_block
  APID                   = var.APID
  ASSETID                = var.ASSETID
  COID                   = var.COID
  ENV                    = var.ENV
  SIDP                   = var.SIDP
  aws-zona-1a            = var.aws-zona-1a
  aws-zona-1b            = var.aws-zona-1b
}