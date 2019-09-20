
module "infra_create" {
  source = "./modules/instance_create"
}

#auto_scaling
#variable "vpc_id" {}

#data "aws_vpc" "terraform" {
#  id = "${var.vpc_id}"
#}


