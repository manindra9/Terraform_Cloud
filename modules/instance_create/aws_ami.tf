data "aws_ami" "centos" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ami-centos-7*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["285398391915"]
}

