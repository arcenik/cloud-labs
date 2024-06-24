variable "name" {
  default = "lab-01"
}

# switzerlandnorth
# switzerlandnorth-az1
# switzerlandnorth-az2
# switzerlandnorth-az3

variable "region" {
  default = "switzerlandnorth"
}

variable "mainaz" {
  default = "switzerlandnorth-az1"
}

variable "tags" {
  type = map(string)
  default = {
    env = "lab"
  }
}
