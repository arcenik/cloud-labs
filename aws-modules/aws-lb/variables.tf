variable "name" {
  description = "base name for resources"
  type = string
  nullable = false
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
  nullable = false
}

variable "subnet_ids" {
  type = list(string)
  nullable = false
}

variable "lb_type" {
  type = string
  default = "application"
}

variable "lb_internal" {
  type = bool
  default = false
}

variable "lb_port" {
  type = number
}

variable "backend_port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "health_check" {
  # type = map(string)
  type = object({
    enabled = bool
    port = number
    timeout = number
    interval = number
    protocol = string
    path = string
    matcher = string
    healthy_threshold = number
    unhealthy_threshold = number
  })
}
