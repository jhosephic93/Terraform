#------------------------------------------------------------------------------
# AWS ECR VARIABLES
#------------------------------------------------------------------------------
variable "project_name" {
  type = string
  description = "Name of the Project."
}

variable "environment" {
  type = string
  description = "The environment to deploy to"
}

variable "name" {
  type = string
  description = "Name of the repository."
}

variable "image_tag_mutability" {
  type = string
  description = "The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE."
}

variable "scan_on_push" {
  type = bool
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
}

variable "additional_tags" {
  type = map(string)
  description = "A map of tags to assign to the resource."
  default = {}
}

variable "expiration_after_days" {
  type = number
  description = "Delete images older than X days."
  default = 0
}