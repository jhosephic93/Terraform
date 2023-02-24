data "aws_iam_user" "my-user" {
  user_name     = "michaelt.inga"
}

data "aws_vpc" "My-VPC-Data" {
  id            = "vpc-0fc055f81a7508e98"
}

data "aws_vpcs" "All-VPCS" {}

data "aws_vpc" "List-VPCS" {
  count         = length(data.aws_vpcs.All-VPCS.ids)
  id            = tolist(data.aws_vpcs.All-VPCS.ids)[count.index]
}

data "aws_vpc" "Selection" {
  filter {
    name        = "tag:Name"
    values      = ["VPC-LAB"]
  }
}