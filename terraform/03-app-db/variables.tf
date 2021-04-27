variable "secret_message" {
  type    = string
  default = ""
}

variable "namespace" {
  type    = string
  default = "secret"
}

variable "stage" {
  type    = string
  default = "dev"
}

variable "name" {
  type    = string
  default = "api"
}

variable "region" {
  type    = string
  default = "us-east-2"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}