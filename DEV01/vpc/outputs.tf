output "AWS-info-VPC" {
  description = "INFO VPC"
  value = [
    "ARN VPC         : ", aws_vpc.vpc-example.arn,
    "ID VPC          : ", aws_vpc.vpc-example.id,
    "Tag Name VPC    : ", aws_vpc.vpc-example.tags.Name
  ]
}