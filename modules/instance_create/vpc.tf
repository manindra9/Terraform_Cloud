# Creating VPC
resource "aws_vpc" "terraform" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "test-vpc"
  }
}

# Creating Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id = "${aws_vpc.terraform.id}"
  cidr_block = "${var.public_subnet_cidr}"
  availability_zone = "us-east-2a"

  tags = {
    Name = "Web Public Subnet"
  }
}

# Creating IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.terraform.id}"

  tags = {
    Name = "VPC IGW"
  }
}

resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.terraform.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "Public Subnet RT"
  }
}

# Route table to the public Subnet
resource "aws_route_table_association" "web-public-rt" {
  subnet_id = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}



# Security group for public subnet
resource "aws_security_group" "sgweb" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  vpc_id="${aws_vpc.terraform.id}"

  tags = {
    Name = "Web Server SG"
  }
}

resource "aws_security_group_rule" "allow_all" {
    type = "egress"
    to_port = 0
    protocol = "-1"
    prefix_list_ids = ["10.1.0.0/16"]
    from_port = 0
    security_group_id = "${aws_security_group.sgweb.id}"
}

locals {

sec_group = "${aws_security_group.sgweb.id}"
subnet_id = "${aws_subnet.public-subnet.id}"


}
