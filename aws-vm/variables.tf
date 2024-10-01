variable "name" {
  default = "lab-vm"
  type = string
}

variable "mainaz" {
  default = "eu-central-1a" # Frankfurt
  type = string
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
