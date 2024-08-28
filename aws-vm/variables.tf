variable "name" {
  default = "lab-vm"
}

# eu-central-1
# eu-central-1a
# eu-central-1b
# eu-central-1c

variable "region" {
  default = "eu-central-1" # Frankfurt
}

variable "mainaz" {
  default = "eu-central-1a"
}

variable "tags" {
  type = map(string)
  default = {
    env = "lab"
  }
}

# export TF_VAR_sshpubkey=$(cat ~/.ssh/id_ed25519.pub)
variable "sshpubkey" {
  type = string
}
