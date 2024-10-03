variable "name" {
  type = string
  default = "lab-vm"
}

# switzerlandnorth
# switzerlandnorth-az1
# switzerlandnorth-az2
# switzerlandnorth-az3

variable "region" {
  type = string
  default = "switzerlandnorth"
}

variable "tags" {
  type = map(string)
  default = {
    env = "lab"
  }
}
