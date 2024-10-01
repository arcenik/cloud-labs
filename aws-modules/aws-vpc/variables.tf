variable "name" {
  description = "base name for resources"
  type = string
  nullable = false
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "region" {
  type = string
  nullable = false
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  nullable = false
  type = string
  default = "10.0.0.0/16"
}

variable "azs_list" {
  description = "List of availability zones to use (only AZ suffix)"
  type = list(string)
  default = [ "a" ]
}

variable "azs_cidr" {
  description = "List of availability zones CIDRs"
  type = list(string)
  default = [ "10.0.0.0/8" ]
}
