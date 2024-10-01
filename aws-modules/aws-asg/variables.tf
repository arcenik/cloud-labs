variable "name" {
  description = "Base name for resources"
  type = string
  nullable = false
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "image_id" {
  description = "id of the ami image"
  type = string
  nullable = false
}

variable "instance_type" {
  description = "ec2 instance type (see https://aws.amazon.com/ec2/instance-types/)"
  type = string
  nullable = false
}

variable "desired_capacity" {
  type = number
  default = 1
}

variable "min_capacity" {
  type = number
  default = 1
}

variable "max_capacity" {
  type = number
  default = 1
}

variable "vpc_id" {
  type = string
  nullable = false
}

variable "key_name" {
  description = "ssh key name"
  type = string
  nullable = false
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside."
  type = list(string)
  nullable = false
}

variable "user_data" {
  type = string
  default = "L2Jpbi9iYXNoIC1jICdlY2hvIG5vdGhpbmcgdG8gZG8nCg==" # "/bin/bash -c 'echo nothing to do'"
}

variable "target_group_arns" {
  description = "Set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing."
  type = list(string)
  nullable = false
}

variable "instance_warmup" {
  description = "The duration of the default instance warmup, in seconds."
  type = number
  default = 0
}

variable "cooldown" {
  description = "Time between a scaling activity and the succeeding scaling activity."
  type = number
  default = 300
}
