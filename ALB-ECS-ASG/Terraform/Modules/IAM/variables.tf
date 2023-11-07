#------------------------------------------------------------------------------
# AWS ECS VARIABLES
#------------------------------------------------------------------------------
variable "project_name" {
  type = string
  description = "Name of the Project."
}

variable "environment" {
  type = string
  description = "The environment to deploy to"
}

variable "additional_tags" {
  type = map(string)
  description = "A map of tags to assign to the resource."
  default = {}
}

variable "s3_bucket_assets" {
  description = "The name of the S3 bucket to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}

variable "dynamodb_table" {
  description = "The name of the Dynamodb table to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}

variable "code_deploy_resources" {
  description = "The Code Deploy applications and deployment groups to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}

variable "ecr_repositories" {
  description = "The ECR repositories to which grant IAM access"
  type        = list(string)
  default     = ["*"]
}