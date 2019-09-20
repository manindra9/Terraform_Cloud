
variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "192.168.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  default = "192.168.11.0/24"
}
