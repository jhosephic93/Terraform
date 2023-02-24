variable "AWS_REGION" {
  description       = "AWS REGION"
  type              = string
}

variable "CIDR_VPC" {
  description       = "CIDR_VPC"
  type              = string
}

variable "NAME_TAG_VPC" {
  description       = "NAME VPC"
  type              = string
}


variable "nombre-proyecto" {
  description   = "Nombre del proyecto para el cual se trabaja"
  type          = string
  default       = "Project"
}
variable "ambiente" {
  description   = "Nombre del ambiente de despliegue"
  type          = string
  default       = ""
}

variable "puerto-ssh" {
  description   = "Port ingress SSH"
  type          = number
}

variable "Resolve-DNS" {
  description   = "Enable DNS Hostname"
  type          = bool
}

variable "CIDR-subnets-privates" {
  description   = "CIDR from Subnets privates"
  type          = list
  default       = []
}

variable "subnets-privates" {
  description   = "Mapa definicion subnet private"
  type          = map(string)
  default       = {
    vpc         = "vpc-98228777402",
    cidr        = "10.0.10.0/24",
    zone        = "us-east-1a",
    name        = "subnet-private-1a",
    map_ip      = "true"
  }
}