resource "aws_instance" "web" {
  ami           = "${data.aws_ami.centos.id}"
  instance_type = "t2.micro"
  subnet_id   = local.subnet_id
  
  tags = {
    Name = "HelloWorld"
  }
}
